Then /^I can create a new tip with tags on it$/ do
  step "I set the tip basic info"
  step "I can set tags on it"
  click_button "Create Tip"
end

When /^I can set tags on it$/ do
  @tag_list = %w(tag1 tag2, tag3)
  fill_in "Tag list", with: @tag_list
end

When /^I should see the tag list in the recently created tip$/ do
  @tag_list.each do |tag|
    page.should have_selector ".tag", content: tag
  end
end

When /^some tagged tips with "([^"]*)"$/ do |tag|
  @tips_with_tags = create_list :tip_with_tags, 5, tag_list: tag
end

Then /^I see the "([^"]*)" on tag cloud for the tips$/ do |tag|
  visit "/tips"
  within "#tag_cloud" do
    page.should have_selector "a", content: tag
  end
end

When /^I click on the tag "([^"]*)"$/ do |tag|
  within "#tag_cloud" do
    click_link tag
  end
end

Then /^I should see the tips having that tag "([^"]*)"$/ do |tag|
  @tips_with_tags.each do |tip_with_tag|
    page.should have_selector ".tip", content: tip_with_tag.title
    page.should have_selector ".tip", content: tag
  end
end