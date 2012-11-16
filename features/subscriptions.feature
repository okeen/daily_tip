Feature: Subscriptions to tips
  In order to be updated about tips
  As a user
  I want to subscribe to the tips so I receive a daily mail with them

  @wip
  Scenario: Weekly Subscription to popular tip
    Given a logged user
    And some existing tips with votes
    When I go to the subscribtions page
    And I add a "Weekly" subscription for the "All" "1" tips
    Then I should see a confirmation of the subscription
    And I should see a "weekly" subscription for the "all" "1" tips
    And I should receive a weekly email with the "all" "1" tips

  @wip
  Scenario: Daily Subscription to popular tip
    Given a logged user
    And some existing tips with votes
    When I go to the subscribtions page
    And I add a "Daily" subscription for the "All" "10" tips
    Then I should see a confirmation of the subscription
    And I should see a "daily" subscription for the "all" "10" tips
    And I should receive a daily email with the "all" "10" tips

  @wip
  Scenario: Weekly Subscription to Technology tips
    Given a logged user
    And some existing tips with votes and category "technology"
    And some other tagged tips with category "technology"
    When I go to the subscribtions page
    And I add a "Weekly" subscription for the "Technology" "10" tips
    Then I should see a confirmation of the subscription
    And I should see a "weekly" subscription for the "technology" "10" tips
    And I should receive a weekly email with the "technology" "10" tips

  Scenario: Unsubscribe to tips
    Given a logged user with subscriptions
    When I unsubscribe to the tips mails
    Then I should see a confirmation of the unsubscription
