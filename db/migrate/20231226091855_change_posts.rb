class ChangePosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :users_id, :user_id
    rename_column :posts, :workouts_id, :workout_id
  end
end
