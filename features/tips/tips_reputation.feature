Feature: Tips Reputation
  In order to get good quality tips
  As a user
  I want to vote tips as good or bad and see tips with the best score

  @javascript
  Scenario: Tips votes
    Given a logged user
    And some existing tips
    When I go to the first tip page
    Then I should see the tip with no vote yet
    And I give the tip an "up" vote
    Then I should see the tip as "up" voted from me
    When I give the tip an "down" vote
    Then I should see the tip as "down" voted from me

  Scenario: Tips popularity
    Given a logged user
    And some existing tips with votes
    When I sort the tips by popularity
    Then I can see the tips ordered by popularity

