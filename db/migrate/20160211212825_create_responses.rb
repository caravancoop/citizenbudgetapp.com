class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :questionnaire_id

      t.datetime :initialized_at
      t.string :ip
      t.decimal :assessment

      # This is a honeypot field.
      t.string :comments

      # The social sharing feature requires email and name.
      t.string :email
      t.string :name

      t.timestamps null: false
    end
  end
end
