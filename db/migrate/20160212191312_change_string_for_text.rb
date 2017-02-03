class ChangeStringForText < ActiveRecord::Migration
  def change
    change_column :questions, :description, :text
    change_column :questions, :embed, :text
    change_column :questions, :extra, :text

    change_column :questionnaires, :introduction, :text
    change_column :questionnaires, :thank_you_template, :text
  end
end
