FactoryBot.define do
  factory :profile do
    short_description { Faker::Lorem.characters(number: 40) }
    long_description { Faker::Lorem.characters(number: 240) }
    price { 1000 }
    qualifications { Faker::Lorem.word }
  end
end