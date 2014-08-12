Feature: Calling from the command line

  Background:
    Given a file named "preamble_three_players.uno" with:
      """
      3 players
      Alice
      Bob
      Carol
      7 red
      """

  Scenario: Display usage
    When I run `uno --help`
    Then it should pass with regex:
      """
      ^Usage:
      """

  Scenario: Reading preamble on standard input
    When I run `uno` interactively
    And I pipe in the file "preamble_three_players.uno"
    Then it should pass with:
      """
      3 players
      Alice
      Bob
      Carol
      7 red
      # Alice to play

      """

  Scenario: Reading preamble from file
    When I run `uno preamble_three_players.uno`
    Then it should pass with:
      """
      3 players
      Alice
      Bob
      Carol
      7 red
      # Alice to play

      """
