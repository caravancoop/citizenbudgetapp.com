class AdminUser < ActiveRecord::Base
  ROLES = %w(superuser administrator)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  validates :email, presence: true
  # validates_presence_of :encrypted_password

  validates :role, presence: true
  validates :organization, presence: true, unless: ->(a){a.role == 'superuser'}
  validates :role, inclusion: { in: ROLES }, allow_blank: true
  validates :locale, inclusion: { in: Locale.available_locales }, allow_blank: true

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
end
