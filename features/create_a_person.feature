Feature: Create a Person
  As a Person Service Client
  I want to add a new person to the service
  Then I should receive the person id, and the person's given name, family name, and email back
  And the returned values should match the values sent in

  Background:
    Given an API path to the PersonsController  

  Scenario: Create a person
    Given a set of attributes for a person
    When I create a new person
    Then I get a successful response
    And I receive back the information for the person
    And the attributes match

  Scenario: Try to create a person with no family name
    Given a set of attributes without a family name
    When I create a new person
    Then I get a 400 response
    And I get some errors
    And with error message "Unable to save person"
    And with "family_name" containing:
      |can't be blank|

  Scenario: Try to create a person with no email
    Given a set of attributes without an email
    When I create a new person
    Then I get a 400 response
    And I get some errors
    And with error message "Unable to save person"
    And with "email" containing:
      |can't be blank|
