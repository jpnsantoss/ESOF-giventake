Feature: Account Creation and Login

  Scenario: User is not logged in and opens the app
    Given that a user is not logged in
    When they open the app
    Then ensure that an initial screen for creating an account or logging into an existing account pops up

  Scenario: User is in the initial screen and clicks 'Create an account'
    Given that a user is in the initial screen
    When they click 'Create an account'
    Then ensure the appearance of text fields for creating a username and password

  Scenario: User has typed a username and password and clicks 'Create account'
    Given that the user has typed an username and password
    When they click 'Create account'
    Then ensure the creation only if the username is unique
