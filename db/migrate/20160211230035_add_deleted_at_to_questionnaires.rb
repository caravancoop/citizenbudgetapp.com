class AddDeletedAtToQuestionnaires < ActiveRecord::Migration
  def change
    add_column :questionnaires, :deleted_at, :datetime
    add_index :questionnaires, :deleted_at
  end
end
