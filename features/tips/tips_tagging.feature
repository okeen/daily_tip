Feature: Tips Tagging
  In order to easily organize the tips
  as a user
  I want to set tags to my tips

  Scenario: Set tip tag list
    Given a logged user
    When I can create a new tip with tags on it
    Then I should see the tag list in the recently created tip
