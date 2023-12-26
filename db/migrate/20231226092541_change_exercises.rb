class ChangeExercises < ActiveRecord::Migration[7.1]
  def change
    rename_column :exercises, :exercise_types_id, :exercise_type_id
    rename_column :exercises, :workouts_id, :workout_id
  end
end
