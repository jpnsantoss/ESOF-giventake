Feature: Transaction Completion and Review

  Scenario: User marks a pending transaction as completed
    Given that a user has a pending transaction
    When they open the 'Requests' page
    Then ensure they can mark it as 'Completed'

  Scenario: User opens the other user's profile after completing a transaction
    Given that a user has marked a transaction as 'Completed'
    When they open the other user's profile
    Then ensure the 'Leave a review' button is visible

  Scenario: User clicks 'Leave a review' button in the other user's profile
    Given that a user is in the profile of the user who they got the product from
    When they click the 'Leave a review' button
    Then ensure a text box and a rating prompt (0-5 stars) appear

  Scenario: User submits a review
    Given that the user has finished writing the review
    When they click 'Submit'
    Then ensure the review is visible for all other users
