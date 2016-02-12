class Organization < ActiveRecord::Base
  acts_as_paranoid

  has_many :admin_users
  has_many :questionnaires

  validates :name, presence: true
end
