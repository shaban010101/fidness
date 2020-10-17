FactoryBot.define do
  factory :user do
    username {'johnjohn'}
    sequence :email do |n|
      "person#{n}@example.com"
    end
    first_name { 'John'}
    last_name { 'Johm'}
    sex { 'Male'}
    time_zone { 'Europe/London' }
    password { 'Password123!'}
    type { 'Client' }
  end

  trait :trainer  do
    type { 'Trainer'}
  end
end