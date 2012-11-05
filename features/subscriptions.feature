Feature: Subscriptions to tips
  In order to be updated about tips
  As a user
  I want to subscribe to the tips so I receive a daily mail with them

  Scenario: Subscribe to tips
    Given a logged user
    When I subscribe to the tips mails
    Then I should see a confirmation of the subscription

  Scenario: Unsubscribe to tips
    Given a logged user with subscriptions
    When I unsubscribe to the tips mails
    Then I should see a confirmation of the unsubscription
