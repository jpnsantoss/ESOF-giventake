
Feature: Accepting or Declining Requests

  Scenario: User accepts a request
    Given the user has accepted a request
    When the decision is processed
    Then ensure the request status is updated in the database as 'Accepted'

  Scenario: User declines a request
    Given the user has declined a request
    When the decision is processed
    Then ensure the request status is updated in the database as 'Declined'

  Scenario: Database is updated with the request status
    Given the request status is updated in the database
    When the user checks the 'Requests' screen
    Then ensure the updated status reflects appropriately for the user
