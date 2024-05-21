Feature: Product Upload Feature

  Scenario: User navigates to 'Add a new product' window
    Given a user is logged in
    When they click the upload button
    Then ensure they are taken to 'Add a new product' window

  Scenario: User clicks 'Upload an image'
    Given a user is in the 'Add a new product' window
    When they click 'Upload an image'
    Then ensure the appearance of a prompt to request gallery access

  Scenario: User selects pictures after authorizing gallery access
    Given the user authorized gallery access
    When they select pictures
    Then ensure the pictures are uploaded to the product's picture data field

  Scenario: User clicks on text fields and can type
    Given a user is in the 'Add a new product' window
    When they click any of the text fields (title, location, and description)
    Then ensure they can type

  Scenario: User tries to add a product with empty fields
    Given a user is in the 'Add a new product' window
    When they click 'Add Product' without filling all fields
    Then ensure they receive a notification to fill all fields
