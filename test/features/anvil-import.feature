Feature: Anvil Import

Scenario: read number of tiers in anvil file
  Given I have an anvil document "doc" with 2 tiers
  When I import "doc"
  Then "doc" should respond to "tiers.count" with 2.