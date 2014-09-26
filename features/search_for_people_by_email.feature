Feature: Search for people by email
  In order to ensure that people can be found
  As a people service client
  I want to be able to get the list of all people with a given email

  Background:
    Given an API path to the PersonsController

  Scenario: Search for People by email
    Given 10 people with the email of "joe.blow@example.com"
    And 17 people
    When I search for people with the email "joe.blow@example.com"
    Then I get a successful response
    And I receive 10 results
    And results have email of "joe.blow@example.com"
  
  


  
  
  
