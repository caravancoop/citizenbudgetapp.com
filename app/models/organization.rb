class Organization
  include Mongoid::Document
  include Mongoid::Paranoia

  has_many :admin_users
  has_many :questionnaires

  field :name, type: String

  validates :name, presence: true
end
