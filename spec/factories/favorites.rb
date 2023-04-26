FactoryBot.define do
  factory :favorite do
    association :comment
    association :user
  end
end