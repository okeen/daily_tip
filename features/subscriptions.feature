Feature: Subscriptions to tips
  In order to be updated about tips
  As a user
  I want to subscribe to the tips so I receive a daily mail with them

  Scenario: Weekly Subscription to popular tip
    Given a logged user
    And some existing tips with votes
    When I go to the subscribtions page
    And I add a "weekly" subscription for the "all" "1" tips
    Then I should see a confirmation of the subscription
    And I should see a "weekly" subscription for the "all" "1" tips
    And I should receive a weekly email with the "all" "1" tips

  Scenario: Daily Subscription to popular tip
    Given a logged user
    And some existing tips with votes
    When I go to the subscribtions page
    And I add a "daily" subscription for the "all" "10" tips
    Then I should see a confirmation of the subscription
    And I should see a "daily" subscription for the "all" "10" tips
    And I should receive a daily email with the "all" "10" tips

  Scenario: Unsubscribe to tips
    Given a logged user with subscriptions
    When I unsubscribe to the tips mails
    Then I should see a confirmation of the unsubscription
