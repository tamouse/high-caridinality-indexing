Feature: Search for people by given name
  In order to ensure that people can be found
  As a people service client
  I want to be able to get the list of all people with a given name

  Background:
    Given an API path to the PersonsController

  Scenario: Search for People by given name
    Given 10 people with the given name of "Susan"
    And 17 people
    When I search for people with the given name "Susan"
    Then I get a successful response
    And I receive 10 results
    And results have given name of "Susan"
  
  


  
  
  
