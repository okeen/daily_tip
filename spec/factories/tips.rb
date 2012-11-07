# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tip do
    title Faker::Lorem.paragraph 1
    content Faker::Lorem.paragraph
    association :author, factory: :user

    trait :with_links do
      after do |tip|
        tip.links << FactoryGirl.create(:link)
      end
    end

    factory :tip_with_links do
      with_links
    end
  end
end
