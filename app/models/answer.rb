class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :response

  validates :value :question, :response, presence: true
end
