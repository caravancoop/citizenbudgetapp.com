class AddAssociationsIndexes < ActiveRecord::Migration
  def change
    add_index :admin_users, :organization_id
    add_index :questionnaires, :organization_id
    add_index :google_api_authorizations, :questionnaire_id
    add_index :questions, :section_id
    add_index :sections, :questionnaire_id
  end
end
