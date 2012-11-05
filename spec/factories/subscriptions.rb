# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    association :user, factory: :user
    state "active"
  end
end
