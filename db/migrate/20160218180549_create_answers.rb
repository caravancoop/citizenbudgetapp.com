class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.jsonb :value

      t.integer :response_id
      t.integer :question_id

      t.timestamps
    end

    add_index :answers, :question_id
    add_index :answers, :response_id
  end
end
