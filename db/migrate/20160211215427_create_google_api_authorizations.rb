class CreateGoogleApiAuthorizations < ActiveRecord::Migration
  def change
    create_table :google_api_authorizations do |t|
      t.integer :questionnaire_id
      t.jsonb :token, default: {}

      t.timestamps null: false
    end
  end
end
