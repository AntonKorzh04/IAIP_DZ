class ChangeExerciseTypes < ActiveRecord::Migration[7.1]
  def change
    rename_column :exercise_types, :users_id, :user_id
  end
end
