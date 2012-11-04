Feature: Tips CRUD
  In order to expand and share my knowledge
  As a user
  I want to create / read and modify Tips

  Scenario: Tip creation
    Given a logged user
    Then I can create a new tip
    And I should see the recently created tip in the tips list page

  Scenario: Tip Details
    Given a logged user
    And some existing tips
    Then I can see details about the tips
