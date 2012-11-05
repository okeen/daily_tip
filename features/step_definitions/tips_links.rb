When /^I can create a new tip with links on it$/ do
  step "I set the tip basic info"
  step "I can set links on it"
  click_button "Create Tip"
end

Then /^I should see the links on the recently created tip$/ do
  @link_list.each do |link|
    page.should have_selector "a.tip_link", content: link
  end
end

When /^I can set links on it$/ do
  @link_list = %w(
    https://github.com/okeen/daily_tip
    https://github.com/Zorros/Fikket
  )

  click_link "Add Link"

  within( ".fields") do
    fill_in "Url", with: @link_list[0]
  end
end
