class AddSetsToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :sets, :jsonb
  end
end
