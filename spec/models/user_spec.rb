require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:workouts).dependent(:destroy) }
  it { should have_many(:exercise_types).dependent(:destroy) }
  it { should have_many(:posts).dependent(:destroy) }
end
