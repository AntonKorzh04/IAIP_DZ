class CreateExerciseTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :exercise_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    add_reference :exercise_types, :users, foreign_key: true
  end
end
