Feature: Tips Tagging
  In order to easily organize the tips
  as a user
  I want to set tags to my tips

  Scenario: Set tip tag list
    Given a logged user
    And I can create a new tip with tags on it
    And I should see the tag list in the recently created tip

  Scenario: Tip Details
    Given a logged user
    And some existing tips
    Then I can see details about the tips
