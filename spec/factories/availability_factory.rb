FactoryBot.define do
  factory :availability do
    available_at { Time.current + 1.day }
  end
end