Feature: Tips Categories
  In order to easily organize the tips
  as a user
  I want to set categories to my tips

  Scenario: Set tip category
    Given a logged user
    When I create a new tip and set a category on it
    Then I should see the category in the recently created tip

  Scenario: Tag category navigation
    Given a logged user
    And some tagged tips with category "Technology"
    When I click on the category "Technology"
    Then I should see the category "Technology" active
    Then I should see the tips having the category "Technology"

  @wip
  Scenario: Use subdomain when accessing categories
    Given a logged user
    And some tagged tips with category "Technology"
    And some other tagged tips with category "Health"
    When I go the "technology" subdomain
    Then I should see the category "Technology" active
    Then I should see the tips having the category "Technology"

  @wip
  Scenario: Category subdomain scoped search
    Given a logged user
    And some existing tips with votes and category "Technology"
    And some other tagged tips with category "Health"
    When I go the "technology" subdomain
    And I sort the tips by popularity
    Then I should see the tips having the category "Technology"
    And I can see the tips ordered by popularity
