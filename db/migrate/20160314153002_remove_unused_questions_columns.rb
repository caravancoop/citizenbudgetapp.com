class RemoveUnusedQuestionsColumns < ActiveRecord::Migration
  def change
    remove_column :questions, :maximum_units
    remove_column :questions, :minimum_units
    remove_column :questions, :step
  end
end
