Feature: Retrieve information for a person
  In order to retrieve information for a person
  As a People Service Client
  I want to get information back for a person based on their ID

  Background:
    Given an API path to the PersonsController
    And a person
  
  Scenario: Retrieve a person by ID
    When I request a person by ID
    Then I get a successful response
    And I receive back the information for the person
    And the attributes match

  Scenario: Try to retrieve a non-existant person
    When I request a person with a non-existant ID
    Then I get a 404 response
