class AdminUser
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization, index: true

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates :email, presence: true
  # validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  ROLES = %w(superuser administrator)

  field :role, type: String
  field :locale, type: String

  validates :role, presence: true
  validates :organization_id, presence: true, unless: ->(a){a.role == 'superuser'}
  validates :role, inclusion: { in: ROLES }, allow_blank: true
  validates :locale, inclusion: { in: Locale.available_locales }, allow_blank: true

  before_save :set_locale

  # https://github.com/gregbell/active_admin/wiki/Your-First-Admin-Resource%3A-AdminUser
  after_create do |admin|
    admin.send_reset_password_instructions
  end

  def questionnaires
    if role == 'superuser'
      Questionnaire
    else
      organization && organization.questionnaires
    end
  end

  def password_required?
    new_record? ? false : super
  end

  def set_locale
    self.locale = nil if locale.blank?
  end
end
