# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    tip nil
    url "MyString"
    link_type "MyString"
    description "MyText"
  end
end
