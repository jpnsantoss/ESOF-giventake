Feature: Profile Picture upload

  Scenario: User navigates to profile window
    Given the user is logged in
    When they click the 'Profile' bubble in the top right corner
    Then ensure they are taken to their 'Profile' window

  Scenario: User edits profile
    Given the user is in the 'Profile' window
    When they click the 'Edit' button
    Then ensure they can edit the 'Profile picture' and 'Biography' fields

  Scenario: User changes profile picture
    Given the user is in 'Edit' mode
    When they click 'Change profile picture'
    Then ensure a prompt for requesting gallery access is displayed

  Scenario: User authorizes gallery access and selects a picture
    Given the user authorized gallery access
    When they choose a picture
    Then change their 'Profile picture' field to the chosen image
