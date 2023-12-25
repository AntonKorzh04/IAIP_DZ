class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.jsonb :sets, array: true, default: []
      t.string :comments

      t.timestamps
    end
    add_reference :exercises, :exercise_types, foreign_key: true
    add_reference :exercises, :workouts, foreign_key: true
  end
end
