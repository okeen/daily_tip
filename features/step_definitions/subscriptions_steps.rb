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

When /^I should receive a daily email with the "([^"]*)" "([^"]*)" tips$/ do |scope, count|
  Subscription.deliver_daily_tips!
  open_email @user.email
  current_email.subject.should == "Your Daily Tips are here"

  @tips_not_to_include = create_list :tip, 10, created_at: 25.hours.ago

  email_should_have_tips Tip.popular.created_the_last_24_hours.all[0.. count.to_i - 1]
  email_should_not_have_tips @tips_not_to_include
end

def email_should_have_tips(tips)
  tips.each do |tip|
    current_email.body.should  =~ /<h3>#{tip.title.gsub ".", "\."}<\/h3>/
    current_email.body.should  =~ /<a href=\"http:\/\/daily_tip.dev\/tips\/#{tip.id}\">View details<\/a>/
  end
end

def email_should_not_have_tips(tips)
  tips.each do |tip|
    current_email.body.should_not  =~ /<h3>#{tip.title.gsub ".", "\."}<\/h3>/
    current_email.body.should_not  =~ /<a href=\"http:\/\/daily_tip.dev\/tips\/#{tip.id}\">View details<\/a>/
  end
end

When /^I should receive a weekly email with the "([^"]*)" "([^"]*)" tips$/ do |scope, count|
  Subscription.deliver_weekly_tips!
  open_email @user.email
  current_email.subject.should == "Your Weekly Tips are here"

  @tips_not_to_include = create_list :tip, 10, created_at: 8.days.ago

  email_should_have_tips Tip.popular.created_the_last_week[0.. count.to_i - 1]
  email_should_not_have_tips @tips_not_to_include
end