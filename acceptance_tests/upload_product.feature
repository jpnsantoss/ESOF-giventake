
Feature: Adding a New Product

  Scenario: User clicks the upload button and is taken to 'Add a new product' window
    Given that a user is logged in
    When they click the upload button
    Then ensure they are taken to 'Add a new product' window

  Scenario: User clicks 'Upload an image' and sees a prompt to request gallery access
    Given that a user is in the 'Add a new product' window
    When they click 'Upload an image'
    Then ensure the appearance of a prompt to request gallery access

  Scenario: User authorizes gallery access and selects pictures
    Given that the user authorized gallery access
    When they select pictures
    Then ensure the pictures are uploaded to the product's picture data field

  Scenario: User can type in text fields (title, location, and description)
    Given that a user is in the 'Add a new product' window
    When they click any of the text fields
    Then ensure they can type

  Scenario: User clicks 'Add Product' with all fields filled
    Given that a user is in the 'Add a new product' window
    When they click 'Add Product'
    Then ensure all fields (title, location, description, and pictures) are filled
