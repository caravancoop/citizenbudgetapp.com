class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response

  validates :value, presence: true
end
