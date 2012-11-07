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

When /^some existing tips to search for$/ do
  create :tip, title: "search for me", content: "And for me"
  create :tip, title: "don't find me", content: "Please"
end

When /^I search for tips using some keywords$/ do
  visit "/"
  fill_in "q", with: "search for me"
  click_button "search"
end

Then /^I can see details about the tips found$/ do
  page.should have_selector ".tip", content: "search for me"
  page.should_not have_content "don't find me"
end