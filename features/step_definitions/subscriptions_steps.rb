Given /^a logged user with subscriptions$/ do
  step "a logged user"
  create :subscription, user: @user
end

When /^I subscribe to the tips mails$/ do
  click_link "Subscriptions"
  click_link "Subscribe to the daily email"
end

When /^I unsubscribe to the tips mails$/ do
  click_link "Subscriptions"
  click_link "Unsubscribe from the daily email"
end

Then /^I should see a confirmation of the subscription$/ do
  page.should have_selector ".alert-success", content: "Subscription was successfully created"
end

Then /^I should see a confirmation of the unsubscription$/ do
  page.should have_selector ".alert-success", content: "Subscription was successfully destroyed"
end
