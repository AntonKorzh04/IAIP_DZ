require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:posts) }
  it { should have_many(:exercises) }
end
