# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tip do
    title { Faker::Lorem.paragraph 1 }
    content { Faker::Lorem.paragraph }
    association :author, factory: :user

    trait :with_links do
      after do |tip|
        tip.links << FactoryGirl.create(:link)
      end
    end

    trait :with_tags do
      tag_list { Faker::Lorem.word }
    end

    trait :with_category do
      category { Category.all.sample }
    end

    factory :tip_with_links do
      with_links
    end

    factory :tip_with_tags do
      with_tags
    end

    factory :tip_with_category do
      with_category
    end
  end
end
