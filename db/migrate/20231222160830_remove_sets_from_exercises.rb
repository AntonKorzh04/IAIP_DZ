class RemoveSetsFromExercises < ActiveRecord::Migration[7.1]
  def change
    remove_column :exercises, :sets, :jsonb
  end
end
