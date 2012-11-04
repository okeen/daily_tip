# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tip do
    title Faker::Lorem.paragraph 1
    content Faker::Lorem.paragraph
    association :author, factory: :user
  end
end
