class RenameQuestionsWidgetToWidgetType < ActiveRecord::Migration
  def change
    rename_column :questions, :widget, :widget_type
  end
end
