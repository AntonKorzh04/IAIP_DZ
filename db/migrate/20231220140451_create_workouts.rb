class CreateWorkouts < ActiveRecord::Migration[7.1]
  def change
    create_table :workouts do |t|
      t.date :date
      t.integer :body_weight

      t.timestamps
    end
    add_reference :workouts, :users, foreign_key: true
  end
end
