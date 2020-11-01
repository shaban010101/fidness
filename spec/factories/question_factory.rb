FactoryBot.define do
  factory :question do
    question { Faker::Lorem.word }
    options { Faker::Lorem.words }
    user_type { 'Trainer ' }
  end
end