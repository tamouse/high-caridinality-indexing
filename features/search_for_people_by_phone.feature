Feature: Search for people by phone
  In order to ensure that people can be found
  As a people service client
  I want to be able to get the list of all people with a phone

  Background:
    Given an API path to the PersonsController

  Scenario: Search for People by phone
    Given 10 people with the phone of "1-800-555-1212"
    And 17 people
    When I search for people with the phone "1-800-555-1212"
    Then I get a successful response
    And I receive 10 results
    And results have phone of "1-800-555-1212"
  
  


  
  
  
