class AddMinimumUnitsMaximumUnitsAndStepAttributesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :minimum_units, :integer
    add_column :questions, :maximum_units, :integer
    add_column :questions, :step, :integer
  end
end
