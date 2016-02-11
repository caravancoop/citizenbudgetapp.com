class Organization < ActiveRecord::Base
  has_many :admin_users
  has_many :questionnaires

  validates :name, presence: true
end
