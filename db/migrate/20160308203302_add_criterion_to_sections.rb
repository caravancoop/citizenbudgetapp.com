class AddCriterionToSections < ActiveRecord::Migration
  def change
    add_column :sections, :criterion, :text, array: true, default: []
  end
end
