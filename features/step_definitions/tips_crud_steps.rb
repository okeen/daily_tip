Given /^a logged user$/ do
  @user = create :user, email: "user@daily_tip.dev"

  visit "/users/sign_in"
  fill_in "Email", with: "user@daily_tip.dev"
  fill_in "Password", with: "monkey"
  click_button "Sign in"

  page.should have_selector ".alert-success", content: "Signed in successfully"
end

Then /^I can create a new tip$/ do
  click_link "Post a tip"
  fill_in "Title", with: "A cool tip"
  fill_in "Content", with: Faker::Lorem.paragraph

  click_button "Create Tip"
end

When /^I should see the recently created tip in the tips list page$/ do
  page.should have_selector ".alert-success", content: "Tip was succesfully created"
  click_link "Tips"
  page.should have_selector ".tip", content: "A cool tip"
end