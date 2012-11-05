Feature: Tips Links
  In order enrich the tips with more info
  as a user
  I want to add links to the tips

  @wip
  @javascript
  Scenario: Set tip links
    Given a logged user
    When I can create a new tip with links on it
    Then I should see the links on the recently created tip
