FactoryBot.define do
  factory :user do
    username {'johnjohn'}
    email  {'johnjhon@gmail.com'}
    first_name { 'John'}
    last_name { 'Johm'}
    sex { 'Male'}
    time_zone { 'Europe/London' }
    password { 'Password123!'}
    type { 'Client' }
  end
end