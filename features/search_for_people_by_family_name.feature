Feature: Search for people by family name
  In order to ensure that people can be found
  As a people service client
  I want to be able to get the list of all people with a family name

  Background:
    Given an API path to the PersonsController

  Scenario: Search for People by family name
    Given 10 people with the family name of "Rodriquez"
    And 17 people
    When I search for people with the family name "Rodriquez"
    Then I get a successful response
    And I receive 10 results
    And results have family name of "Rodriquez"

  Scenario: Search for non-existant family name
    Given 10 people
    When I search for people with the family name "12345"
    Then I get a successful response
    And I receive 0 results
  
