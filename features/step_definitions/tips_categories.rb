When /^I create a new tip and set a category on it$/ do
  step "I set the tip basic info"
  step "I can set a category on it"
  click_button "Create Tip"
end

When /^I can set a category on it$/ do
  select "Technology", from: "Category"
end

When /^I should see the category in the recently created tip$/ do
  page.should have_selector ".tip_category_link", content: "Technology"
end

Given /^some tagged tips with category "([^"]*)"$/ do |category_name|
  @category = Category.find_by_name category_name
  @tips_with_category = create_list :tip_with_category, 5, category: @category
end

When /^I click on the category "([^"]*)"$/ do |category|
  within "#categories" do
    click_link category
  end
end

Then /^I should see the tips having the category "([^"]*)"$/ do |category|
  @tips_with_category.each do |tip_with_category|
    page.should have_selector ".tip", content: tip_with_category.title
  end
end

Then /^I should see the category "([^"]*)" active$/ do |category_name|
  @category = Category.find_by_name category_name
  page.should have_selector "#category_#{@category.id}.category.active", content: @category.name
end