class AddOtherIndexes < ActiveRecord::Migration
  def change
    add_index :questionnaires, :domain
    add_index :questions, :position
    add_index :sections, :position
  end
end
