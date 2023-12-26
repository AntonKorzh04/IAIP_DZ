class Exercise < ApplicationRecord
    belongs_to :exercise_type
    belongs_to :workout
end
