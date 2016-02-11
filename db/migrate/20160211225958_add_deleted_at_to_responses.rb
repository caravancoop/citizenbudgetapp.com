class AddDeletedAtToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :deleted_at, :datetime
    add_index :responses, :deleted_at
  end
end
