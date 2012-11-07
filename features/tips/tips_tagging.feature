Feature: Tips Tagging
  In order to easily organize the tips
  as a user
  I want to set tags to my tips

  Scenario: Set tip tag list
    Given a logged user
    When I can create a new tip with tags on it
    Then I should see the tag list in the recently created tip

  Scenario: Tag cloud generation and navigation
    Given a logged user
    And some tagged tips with "Ruby"
    Then I see the "Ruby" on tag cloud for the tips
    When I click on the tag "Ruby"
    Then I should see the tips having that tag "Ruby"

