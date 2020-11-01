FactoryBot.define do
  factory :trainer do
    username {'johnjohn'}
    sequence :email do |n|
      "person#{n}#{n}@example.com"
    end
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sex { 'Male'}
    time_zone { 'Europe/London' }
    password { 'Password123!'}
    type { 'Trainer'}
  end
end