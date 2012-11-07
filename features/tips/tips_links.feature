Feature: Tips Links
  In order enrich the tips with more info
  as a user
  I want to add links to the tips

  @javascript
  Scenario: Set tip links
    Given a logged user
    When I can create a new tip with links on it
    Then I should see the links on the recently created tip

  @javascript
  Scenario: Preview links content inline
    Given a logged user
    And some existing tips with links
    When I go to the first tip page
    And I preview the first link
    Then I should see the link page content previewed

