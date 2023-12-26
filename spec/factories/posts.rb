FactoryBot.define do
  factory :post do
    association :user
    association :workout
    
    date { "2023-12-25" }
  end
end
