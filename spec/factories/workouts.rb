FactoryBot.define do
    factory :workout do
        association :user
        
        date { Date.today }
        body_weight { 80 }
    end
end
