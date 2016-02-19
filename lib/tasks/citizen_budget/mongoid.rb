require 'mongoid'

ENV['MONGODB_ADDRESS'] ||= '127.0.0.1:27017'

Mongoid.load!(File.join(File.dirname(__FILE__), '/mongoid.yml'), :production)

class MongoOrganization
  include Mongoid::Document
  store_in collection: 'organizations'
  has_many :admin_users, class_name: 'MongoAdminUser'
  has_many :questionnaires, class_name: 'MongoQuestionnaire'
  field :name, type: String
end

class MongoAdminUser
  include Mongoid::Document
  store_in collection: 'admin_users'
  belongs_to :organization, class_name: 'MongoOrganization'

  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  field :remember_created_at, :type => Time
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  field :role, type: String
  field :locale, type: String
end

class MongoSection
  include Mongoid::Document
  embedded_in :questionnaire, class_name: 'MongoQuestionnaire'
  embeds_many :questions, store_as: 'questions', class_name: 'MongoQuestion'

  field :title, type: String
  field :description, type: String
  field :extra, type: String
  field :embed, type: String
  field :group, type: String
  field :position, type: Integer
end

class MongoQuestion
  include Mongoid::Document
  embedded_in :section, class_name: 'MongoSection'
  field :title, type: String
  field :description, type: String
  field :options, type: Array
  field :labels, type: Array
  field :default_value
  field :size, type: Integer
  field :maxlength, type: Integer
  field :placeholder, type: String
  field :rows, type: Integer
  field :cols, type: Integer
  field :required, type: Boolean
  field :revenue, type: Boolean
  field :widget, type: String
  field :extra, type: String
  field :embed, type: String
  field :unit_amount, type: Float
  field :unit_name, type: String
  field :position, type: Integer
  index position: 1
end

class MongoQuestionnaire
  include Mongoid::Document
  store_in collection: 'questionnaires'

  belongs_to :organization, class_name: 'MongoOrganization'
  embeds_many :sections, class_name: 'MongoSection'
  has_many :responses, class_name: 'MongoResponse'
  embeds_one :google_api_authorization, class_name: 'MongoGoogleApiAuthorization'

  field :title, type: String
  field :locale, type: String
  field :starts_at, type: Time
  field :ends_at, type: Time
  field :time_zone, type: String
  field :domain, type: String
  field :email_required, type: Boolean, default: true
  field :mode, type: String
  field :starting_balance, type: Integer
  field :maximum_deviation, type: Integer
  field :default_assessment, type: Integer
  field :assessment_period, type: String, default: 'month'
  field :tax_rate, type: Float
  field :tax_revenue, type: Integer
  field :change_required, type: Boolean
  field :logo, type: String
  field :title_image, type: String
  field :introduction, type: String
  field :instructions, type: String
  field :read_more, type: String
  field :content_before, type: String
  field :content_after, type: String
  field :description, type: String
  field :attribution, type: String
  field :stylesheet, type: String
  field :javascript, type: String
  field :reply_to, type: String
  field :thank_you_subject, type: String
  field :thank_you_template, type: String
  field :response_notice, type: String
  field :response_preamble, type: String
  field :response_body, type: String
  field :google_analytics, type: String
  field :google_analytics_profile, type: String
  field :twitter_screen_name, type: String
  field :twitter_text, type: String
  field :twitter_share_text, type: String
  field :facebook_app_id, type: String
  field :open_graph_title, type: String
  field :open_graph_description, type: String
  field :authorization_token, type: String
  field :logo_width, type: Integer
  field :logo_height, type: Integer
  field :title_image_width, type: Integer
  field :title_image_height, type: Integer
end

class MongoResponse
  include Mongoid::Document
  store_in collection: 'responses'
  belongs_to :questionnaire, class_name: 'MongoQuestionnaire'

  field :initialized_at, type: Time
  field :answers, type: Hash
  field :ip, type: String
  field :assessment, type: Float
  field :comments, type: String
  field :email, type: String
  field :name, type: String
end

class MongoGoogleApiAuthorization
  include Mongoid::Document
  embedded_in :questionnaire, class_name: 'MongoQuestionnaire'
  field :token, type: Hash, default: {}
end


# p MongoOrganization.all
# p MongoOrganization.first.admin_users
# p MongoOrganization.first.questionnaires
#
# p MongoAdminUser.all
# p MongoAdminUser.first.organization
#
# # p MongoSection.all
# # p MongoSection.first.questionnaire
# # p MongoSection.first.questions
#
# p MongoQuestionnaire.all
# p MongoQuestionnaire.first.organization
# p MongoQuestionnaire.first.sections
# p MongoQuestionnaire.first.responses
# p MongoQuestionnaire.first.google_api_authorization
#
# p MongoResponse.all
# p MongoResponse.first.questionnaire
