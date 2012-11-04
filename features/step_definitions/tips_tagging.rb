Then /^I can create a new tip with tags on it$/ do
  step "I set the tip basic info"
  step "I can set tags on it"
  click_button "Create Tip"
end

When /^I can set tags on it$/ do
  @tag_list = ["tag 1", "tag 2", "tag 3"]
  fill_in "Tag list", with: @tag_list
end

When /^I should see the tag list in the recently created tip$/ do
  @tag_list.each do |tag|
    page.should have_selector ".tag", content: tag
  end
end