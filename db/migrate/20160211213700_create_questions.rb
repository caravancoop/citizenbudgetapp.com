class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :section_id

      t.string :title
      t.string :description
      t.integer :default_value # default_value needs to be cast before use
      t.integer :size
      t.integer :maxlength
      t.string :placeholder # no #placeholder in Drupal FAPI: http://drupal.org/project/elements
      t.integer :rows
      t.integer :cols
      t.boolean :required
      t.boolean :revenue
      t.string :widget
      t.string :extra
      t.string :embed
      t.decimal :unit_amount
      t.string :unit_name
      t.integer :position

      t.text :options, array: true, default: [] # nonbudgetary widgets still use options as labels for backwards compatibility
      t.text :labels, array: true, default: [] # labels are for display only

      t.timestamps null: false
    end
  end
end
