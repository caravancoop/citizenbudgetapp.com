class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.integer :organization_id

      # Basic
      t.string :title
      t.string :locale
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :time_zone
      t.string :domain
      t.boolean :email_required, default: true

      # Mode
      t.string :mode
      t.integer :starting_balance
      t.integer :maximum_deviation
      t.integer :default_assessment
      t.string :assessment_period, default: 'month'
      t.decimal :tax_rate
      t.integer :tax_revenue
      t.boolean :change_required

      # Appearance
      t.string :logo
      t.string :title_image
      t.string :introduction
      t.string :instructions
      t.string :read_more
      t.string :content_before
      t.string :content_after
      t.string :description
      t.string :attribution
      t.string :stylesheet
      t.string :javascript

      # Thank-you email
      t.string :reply_to
      t.string :thank_you_subject
      t.string :thank_you_template

      # Individual response
      t.string :response_notice
      t.string :response_preamble
      t.string :response_body

      # Third-party integration
      t.string :google_analytics
      t.string :google_analytics_profile
      t.string :twitter_screen_name
      t.string :twitter_text
      t.string :twitter_share_text
      t.string :facebook_app_id
      t.string :open_graph_title
      t.string :open_graph_description
      t.string :authorization_token

      # Image uploaders
      t.integer :logo_width
      t.integer :logo_height
      t.integer :title_image_width
      t.integer :title_image_height

      t.timestamps null: false
    end
  end
end
