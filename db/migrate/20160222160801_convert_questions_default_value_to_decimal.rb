class ConvertQuestionsDefaultValueToDecimal < ActiveRecord::Migration
  def change
    change_column :questions, :default_value, :decimal
  end
end
