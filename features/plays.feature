Feature: simple games with 3 players

  Background:
    When I run `uno` interactively
    And I type:
    """
    3 players
    Alice
    Bob
    Carol
    """

  Scenario: playing numbers
    When I type "7 red"
    And I type "5 red Alice"
    And I type "5 blue Bob"
    And I type "9 blue Carol"
    And I close the stdin stream
    Then it should pass with:
    """
    7 red
    # Alice to play
    5 red Alice
    # Alice 6 cards left
    # Bob to play
    5 blue Bob
    # Bob 6 cards left
    # Carol to play
    9 blue Carol
    # Carol 6 cards left
    # Alice to play
    """