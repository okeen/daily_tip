Given /^a logged user$/ do
  @user = create :user, email: "user@daily_tip.dev"

  visit "/users/sign_in"
  fill_in "Email", with: "user@daily_tip.dev"
  fill_in "Password", with: "monkey"
  click_button "Sign in"

  page.should have_selector ".alert-success", content: "Signed in successfully"
end

Given /^some existing tips$/ do
  create :tip, author: @user, title: "Simple tip", content: "A simple tip content"
end

Then /^I can create a new tip$/ do
  step "I set the tip basic info"
  click_button "Create Tip"
end

Then /^I set the tip basic info$/ do
  click_link "Post a tip"
  fill_in "Title", with: "A cool tip"
  fill_in "Content", with: Faker::Lorem.paragraph
end

When /^I should see the recently created tip in the tips list page$/ do
  page.should have_selector ".alert-success", content: "Tip was succesfully created"
  click_link "Tips"

  page.should have_selector ".tip", content: "A cool tip"
end

Then /^I can see details about the tips$/ do
  click_link "Tips"
  @tip = Tip.last

  within "#tip_#{@tip.id}" do
    click_link "Show"
  end

  page.should have_content "Simple tip"
  page.should have_content "A simple tip content"
  page.should have_content "user@daily_tip.dev"
end