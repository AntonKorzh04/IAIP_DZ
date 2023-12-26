FactoryBot.define do
    factory :exercise_type do
        association :user

        name { "Жим лежа" }
        description { "Описание упражнения" }
    end
end
