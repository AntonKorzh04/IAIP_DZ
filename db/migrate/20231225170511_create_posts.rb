class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.date :date

      t.timestamps
    end
    add_reference :posts, :users, foreign_key: true
    add_reference :posts, :workouts, foreign_key: true
  end
end
