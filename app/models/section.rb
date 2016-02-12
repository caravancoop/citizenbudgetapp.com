class Section < ActiveRecord::Base
  GROUPS = %w(simulator custom other)

  belongs_to :questionnaire
  has_many :questions

  validates :group, presence: true
  validates :group, inclusion: { in: GROUPS, allow_blank: true }

  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  after_initialize :set_default_group
  after_save :touch_questionnaire # @see https://github.com/mongoid/mongoid/pull/2195

  scope :simulator, ->{ where(group: ['simulator', 'custom']) }
  scope :budgetary, ->{ where(group: 'simulator') }
  scope :nonbudgetary, ->{ where(group: 'other') }
  default_scope ->{ order(position: :asc) }

  # @return [String] the name to display in the administrative interface
  def name
    title? && title || I18n.t(:untitled)
  end

  # @return [Boolean] whether the "Read more" content is a URL
  def extra_url?
    extra? && extra[%r{\Ahttps?://\S+\z}]
  end

  # @return [Boolean] whether all questions are nonbudgetary questions
  def nonbudgetary?
    questions.all?(&:nonbudgetary?)
  end

  def position
    read_attribute(:position)
  end

  # @param text [String]
  def criterion_as_list=(text)
    self.criterion = text.split("\n").map(&:strip).reject(&:empty?)
  end

  def criterion_as_list
    criterion.join("\n")
  end

private

  def set_default_group
    self.group ||= 'simulator'
  end

  def touch_questionnaire
    questionnaire.touch
  end
end
