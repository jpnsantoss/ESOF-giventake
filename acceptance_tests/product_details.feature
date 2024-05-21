Feature: Product Details Page

  Scenario: User clicks on a specific product from the list of available products
    Given that a user is logged in and viewing the list of available products
    When they click on a specific product
    Then ensure they are taken to the product details page for that product

  Scenario: User views the product details page
    Given that a user is on the product details page
    When they view the page
    Then ensure they can see the product's name, description, price, and any other relevant details

  Scenario: User views the product details page
    Given that a user is on the product details page
    When they view the page
    Then ensure they can see a button to add the product to their cart

  Scenario: User adds the product to their cart
    Given that a user is on the product details page
    When they click the button to add the product to their cart
    Then ensure the product is added to their cart and a confirmation message is displayed

  Scenario: User views the product details page
    Given that a user is on the product details page
    When they view the page
    Then ensure they can see a button to go back to the list of products

  Scenario: User goes back to the list of products
    Given that a user is on the product details page
    When they click the button to go back to the list of products
    Then ensure they are taken back to the list of products
