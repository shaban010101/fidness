FactoryBot.define do
  factory :answer do
    association :question
    answer { Faker::Lorem.word }
  end
end