class Workout < ApplicationRecord
    belongs_to :user
    has_many :posts
    has_many :exercises
end
