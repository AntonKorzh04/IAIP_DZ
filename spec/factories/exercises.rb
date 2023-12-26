FactoryBot.define do
    factory :exercise do
        association :workout
        association :exercise_type

        comments { "Sample comments" }

        hash = {
            "0" => {
                "reps" => "8",
                "weight" => "80"
            }
        }

        sets { hash.values.to_json }
    end
end
