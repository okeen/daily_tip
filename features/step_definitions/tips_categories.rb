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
  @category = Category.find_by_name category_name.downcase
  @tips = create_list :tip_with_category, 5, category: @category
end

Given /^some other tagged tips with category "([^"]*)"$/ do |category_name|
  @other_category = Category.find_by_name category_name.downcase
  @other_tips_with_category = create_list :tip_with_category, 5, category: @other_category
end

When /^I click on the category "([^"]*)"$/ do |category|
  within "#categories" do
    click_link category
  end
end

Then /^I should see the category "([^"]*)" active$/ do |category_name|
  @category = Category.find_by_name category_name
  page.should have_selector "#category_#{@category.id}.category.active", content: @category.name
end

When /^I go the "([^"]*)" subdomain$/ do |subdomain|
  Capybara.default_host = "#{subdomain.downcase}.example.com"
  Capybara.app_host = "http://#{subdomain.downcase}.example.com:7171"
  visit "/tips"
end

Then /^I should see the tips having the category "([^"]*)"$/ do |category|
  page.should have_selector ".tip", count: @tips.count
  @tips.each do |tip_with_category|
    page.should have_selector ".tip", content: tip_with_category.title
  end
end

When /^some existing tips with votes and category "([^"]*)"$/ do |category|
  with_category(category) { step "some existing tips with votes" }
end

When /^some existing tips to search and category "([^"]*)"$/ do |category|
  with_category(category) { step "some existing tips to search for" }
end

When /^some other tips to search with category "([^"]*)"$/ do |category_name|
  @other_category = Category.find_by_name category_name.downcase
  @other_tips_with_category = create_list :tip_with_category, 5, category: @other_category, title: "search for me"
end

def with_category(category)
  @category = Category.find_by_name category
  yield
  @tips.each{ |t| t.update_attributes category_id: @category.id }
end