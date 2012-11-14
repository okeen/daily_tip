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
  click_link "Unsubscribe"
end

Then /^I should see a confirmation of the subscription$/ do
  page.should have_selector ".alert-success", content: "Subscription was successfully created"
end

Then /^I should see a confirmation of the unsubscription$/ do
  page.should have_selector ".alert-success", content: "Subscription was successfully destroyed"
end

When /^I go to the subscribtions page$/ do
  visit "/user/subscriptions"
end

When /^I add a "([^"]*)" subscription for the "([^"]*)" "([^"]*)" tips$/ do |period, tip_scope, tip_count|
  select period, from: "Email reception period"
  select tip_scope, from: "What tips?"
  select tip_count, from: "How many tips?"
  click_button "Subscribe"
end

When /^I should see a "([^"]*)" subscription for the "([^"]*)" "([^"]*)" tips$/ do |period, tip_scope, tip_count|
  @subscription = @user.subscriptions.last
  within "#subscriptions" do
    page.should have_selector "#subscription_#{@subscription.id}.subscription"
    within "#subscription_#{@subscription.id}.subscription" do
      page.should have_content period
      page.should have_content tip_count
      page.should have_content tip_scope
    end
  end
end