require 'mail'

class Questionnaire < ActiveRecord::Base
  include SpreadsheetExportable

  acts_as_paranoid

  MODES = %w(services taxes)
  ASSESSMENT_PERIODS = %w(month year)

  belongs_to :organization
  has_one :google_api_authorization
  has_many :sections, dependent: :destroy
  has_many :responses, dependent: :destroy

  mount_uploader :logo, ImageUploader
  mount_uploader :title_image, ImageUploader

  validates :title, :organization_id, :mode, presence: true
  validates :default_assessment, :tax_rate, presence: true, if: ->(q){q.mode == 'taxes'}
  validates :tax_revenue, presence: true, if: ->(q){q.mode == 'services' && q.tax_rate?}
  validates :mode, inclusion: { in: MODES }, allow_blank: true
  validates :locale, inclusion: { in: Locale.available_locales }, allow_blank: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }, allow_blank: true
  validates :starting_balance, numericality: { only_integer: true, allow_blank: true }
  validates :maximum_deviation, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_blank: true
  validates :default_assessment, :tax_revenue, numericality: { greater_than: 0, only_integer: true }, allow_blank: true
  validates :tax_rate, numericality: { greater_than: 0, less_than: 1 }, allow_blank: true
  validates :twitter_text, length: { maximum: 140 }, allow_blank: true
  validates :twitter_share_text, length: { maximum: 140 }, allow_blank: true
  validates :domain, uniqueness: true, allow_blank: true
  validates :reply_to, email: true, allow_blank: true
  validate :ends_at_must_be_greater_than_starts_at
  validate :domain_must_be_active
  validate :domain_must_not_be_blacklisted
  validate :reply_to_must_be_valid
  validate :mode_must_match_options

  before_validation :sanitize_domain
  before_create :set_authorization_token

  scope :current, -> { where.not(starts_at: nil).where.not(ends_at: nil).where('starts_at <= ?', Time.now).where('ends_at >= ?', Time.now) }
  scope :future, -> { where.not(starts_at: nil).where('starts_at > ?', Time.now) }
  scope :past, -> { where.not(ends_at: nil).where('ends_at < ?', Time.now) }
  scope :active, -> { where.not(ends_at: nil).where('ends_at >= ?', Time.now) }

  # @param [String] domain a domain name
  # @return [Enumerable] questionnaires whose domain name matches
  # @note No two active questionnaires should have the same domain.
  def self.by_domain(domain)
    where('domain = ? OR domain = ?', domain, sanitize_domain(domain))
  end

  # @param [String] domain a domain name
  # @return [Questionnaire,nil] a questionnaire whose domain name matches
  # @note No two active questionnaires should have the same domain.
  def self.find_by_domain(domain)
    domain && current.by_domain(domain).first
  end

  # @return [Integer] the number of responses by date in the local time zone
  def count_by_date
    # new Date() always parses the date into the current time zone. getTime()
    # returns the number of milliseconds since epoch. getTimezoneOffset()
    # returns the offset in minutes. In case we can't assume that MongoDB is
    # running in UTC, we add the local time zone offset.
    responses.map_reduce(%Q{
      function () {
        var date = new Date(this.created_at.getTime() + this.created_at.getTimezoneOffset() * 60000 + #{offset} * 1000);
        emit({year: date.getFullYear(), month: date.getMonth() + 1, day: date.getDate()}, 1);
      }
    }, %Q{
      function (key, values) {
        return Array.sum(values);
      }
    }).out(inline: true)
  end

  # @return [Integer] the median number of seconds to complete the questionnaire
  def time_to_complete
    times = responses.map{|response|
      response.created_at - response.initialized_at
    }.select{|time|
      time < 3600 # if longer than an hour, probably left tab open in background
    }.sort

    middle = times.size / 2

    if times.size.zero?
      0
    elsif times.size.odd?
      times[middle]
    else
      (times[middle - 1] + times[middle]) / 2.0
    end
  end

  # @return [Time] the consultation's start date in its time zone
  def local_starts_at
    if time_zone?
      starts_at.in_time_zone(time_zone)
    else
      starts_at
    end
  end

  # @return [Time] the consultation's end date in its time zone
  def local_ends_at
    if time_zone?
      ends_at.in_time_zone(time_zone)
    else
      ends_at
    end
  end

  # @return [Date] the consultation's start date in its time zone
  def starts_on
    starts_at && local_starts_at.to_date
  end

  # @return [Date] the consultation's end date in its time zone
  def ends_on
    ends_at && local_ends_at.to_date
  end

  # @return [Date] the current date in the consultation's time zone
  def today
    if time_zone?
      Time.now.in_time_zone(time_zone).to_date
    else
      Date.today
    end
  end

  # @return [Integer] the time zone offset in seconds
  # @note If the consultation crosses a clock shift, the offset will be
  #   incorrect for the final days of the consultation.
  def offset
    if starts_at? && time_zone?
      starts_at.in_time_zone(time_zone).utc_offset # respects DST
    else
      0
    end
  end

  # @return [Boolean] whether the questionnaire has a maximum deviation
  def maximum_deviation?
    super && maximum_deviation.nonzero?
  end

  # @return [Boolean] whether respondents must submit balanced budgets
  def balance?
    mode == 'services' && tax_rate.blank?
  end

  # @return [Boolean] whether to collect a property value assessment
  def assessment?
    default_assessment? && tax_rate?
  end

  # @return [Boolean] whether the consultation is currently running
  def current?
    starts_at? && ends_at? && starts_at <= Time.now && Time.now <= ends_at
  end

  # @return [Boolean] whether the consultation will start in the future
  def future?
    starts_at? && starts_at > Time.now
  end

  # @return [Boolean] whether the consultation started in the past
  def started?
    starts_at? && starts_at <= Time.now
  end

  # @return [Boolean] whether the consultation will end in the future
  def active?
    ends_at? && ends_at >= Time.now
  end

  # @return [Boolean] whether the consultation ended in the past
  def past?
    ends_at? && ends_at < Time.now
  end

  # @return [Float] the largest surplus possible
  def maximum_amount
    sum = 0
    sections.budgetary.each do |section|
      section.questions.budgetary.each do |question|
        sum += question.maximum_amount
      end
    end
    sum
  end

  # @return [Float] the largest deficit possible
  def minimum_amount
    sum = 0
    sections.budgetary.each do |section|
      section.questions.budgetary.each do |question|
        sum += question.minimum_amount
      end
    end
    sum
  end

  def cache_key
    if new_record?
      "#{model_key}/new"
    elsif current?
      "#{model_key}/#{id}-#{updated_at.utc.to_s(:number)}-current"
    else
      "#{model_key}/#{id}-#{updated_at.utc.to_s(:number)}"
    end
  end


private

  # Removes the protocol, "www" and trailing slash, if present.
  # @param [String] domain a domain name
  # @return [String] the domain without the protocol or trailing slash
  def self.sanitize_domain(domain)
    domain.sub(%r{\A(https?://)?(www\.)?}, '').sub(%r{/\z}, '')
  end

  def sanitize_domain
    if domain?
      self.domain = self.class.sanitize_domain(domain)
    end
  end

  def ends_at_must_be_greater_than_starts_at
    if starts_at? && ends_at? && starts_at > ends_at
      errors.add(:ends_at, I18n.t('errors.messages.ends_at_must_be_greater_than_starts_at'))
    end
  end

  def domain_must_be_active
    if domain? && !domain[/\A[a-z]+\.(citizenbudget|budgetcitoyen)\.com\z/] # @todo Remove hardcode.
      begin
        Socket.gethostbyname(domain)
      rescue SocketError
        errors.add(:domain, I18n.t('errors.messages.domain_must_be_active'))
      end
    end
  end

  def domain_must_not_be_blacklisted
    if domain?
      Locale.available_locales.each do |locale|
        if [I18n.t('app.host', locale: locale), I18n.t('app.domain', locale: locale)].include?(domain)
          errors.add(:domain, I18n.t('errors.messages.domain_must_not_be_blacklisted'))
        end
      end
    end
  end

  def reply_to_must_be_valid
    if reply_to?
      begin
        address = Mail::Address.new(Mail::Address.new(reply_to).address)
        unless address.domain && address.domain.split('.').size > 1
          errors.add(:reply_to, I18n.t('errors.messages.reply_to_must_be_valid'))
        end
      rescue Mail::Field::ParseError
        errors.add(:reply_to, I18n.t('errors.messages.reply_to_must_be_valid'))
      end
    end
  end

  def mode_must_match_options
    if maximum_deviation?
      if mode == 'taxes'
        errors.add(:mode, I18n.t('errors.messages.maximum_deviation_must_not_be_set_in_taxes_mode'))
      elsif tax_rate?
        errors.add(:mode, I18n.t('errors.messages.maximum_deviation_and_tax_rate_must_not_both_be_set'))
      end
    end
  end

  def set_authorization_token
    loop do
      self.authorization_token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
      break unless self.class.where(authorization_token: authorization_token).first
    end
  end
end
