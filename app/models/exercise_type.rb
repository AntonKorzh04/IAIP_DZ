class ExerciseType < ApplicationRecord
    belongs_to :user
    has_many :exercises
    validates_presence_of(:name)
end
