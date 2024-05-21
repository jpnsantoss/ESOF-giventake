Feature: Product Search and Display

  Scenario: User views available products on the Home Screen
    Given the user is logged in to the app
    When they are in the 'Home Screen'
    Then ensure they can see a list of available products near them

  Scenario: User searches for products by typing specific tags
    Given the user is logged in to the app
    When they click the 'Search' bar
    Then ensure they can type in specific tags

  Scenario: User searches for products matching the chosen tags
    Given that the user typed tags in the 'Search' bar
    When they click 'Search'
    Then ensure all products matching the tags chosen are displayed
