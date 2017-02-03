class Organization < ActiveRecord::Base
  acts_as_paranoid

  has_many :admin_users, dependent: :destroy
  has_many :questionnaires, dependent: :destroy

  validates :name, presence: true
end
