# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    association :tip, factory: :tip
    url { Faker::Internet.url }
    link_type "regular"
    description { Faker::Lorem.paragraph 1 }
  end
end
