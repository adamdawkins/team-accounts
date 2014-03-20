Feature: 
  As a coach, 
  I want to file expenses 
  in order to be recompensed

  Scenario: Go to the new expense page
    Given I am logged in
    When I visit "/expenses/new"
    Then I should see a form

  Scenario: File an expense
    Given I am logged in
    When I visit "/expenses/new"
    And I file an expense with value £38.98 and description "First Aid Equipment"
    Then I should see "Your Expense Request has been filed"
    And I should see "First Aid Equipment"
    And I should see "£38.98"
