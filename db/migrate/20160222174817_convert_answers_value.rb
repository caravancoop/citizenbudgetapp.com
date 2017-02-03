class ConvertAnswersValue < ActiveRecord::Migration
  def change
    remove_column :answers, :value
    add_column :answers, :value, :text, array: true, default: []
  end
end
