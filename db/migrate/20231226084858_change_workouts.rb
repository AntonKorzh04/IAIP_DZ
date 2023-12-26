class ChangeWorkouts < ActiveRecord::Migration[7.1]
  def change
    rename_column :workouts, :users_id, :user_id
  end
end
