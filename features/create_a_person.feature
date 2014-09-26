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

  
  
  
  
