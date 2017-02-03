class AddCriteriaToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :criteria, :string
  end
end
