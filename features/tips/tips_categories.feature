Feature: Tips Categories
  In order to easily organize the tips
  as a user
  I want to set categories to my tips

  @wip
  Scenario: Set tip category
    Given a logged user
    When I create a new tip and set a category on it
    Then I should see the category in the recently created tip

  Scenario: Tag category navigation
    Given a logged user
    And some tagged tips with category "Programming"
    When I click on the category "Programming"
    Then I should see the tips having the category "Programming"

