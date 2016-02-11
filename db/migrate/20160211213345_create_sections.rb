class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.integer :questionnaire_id

      t.string :title
      t.string :description
      t.string :extra
      t.string :embed
      t.string :group
      t.integer :position

      t.timestamps null: false
    end
  end
end
