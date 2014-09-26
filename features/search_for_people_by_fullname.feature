Feature: Search for people by full name
  In order to ensure that people can be found
  As a people service client
  I want to be able to get the list of all people with a full name

  Background:
    Given an API path to the PersonsController

  Scenario: Search for People by full name
    Given 10 people with family and given names of "Rodriquez", "Susan"
    And 17 people
    When I search for people with the family name of "Rodriquez" and given name of "Susan"
    Then I get a successful response
    And I receive 10 results
    And results have the family name of "Rodriquez" and given name of "Susan"
