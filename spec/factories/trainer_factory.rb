FactoryBot.define do
  factory :trainer do
    username {'johnjohn'}
    sequence :email do |n|
      "person#{n}#{n}@example.com"
    end
    first_name { 'John'}
    last_name { 'Johm'}
    sex { 'Male'}
    time_zone { 'Europe/London' }
    password { 'Password123!'}
    type { 'Trainer'}
  end
end