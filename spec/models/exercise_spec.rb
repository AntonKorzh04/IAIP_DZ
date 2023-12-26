require 'rails_helper'

RSpec.describe Exercise, type: :model do
  it { should belong_to(:exercise_type) }
  it { should belong_to(:workout) }
end
