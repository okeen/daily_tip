# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    association :user, factory: :user
    state "active"
    tip_count 10
    tip_scope "all"

    trait :daily do
      period "daily"
    end

    trait :weekly do
      period "weekly"
    end

    factory :daily_subscription do
      daily
    end

    factory :weekly_subscription do
      weekly
    end
  end
end
