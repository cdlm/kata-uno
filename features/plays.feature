Feature: Simple games with 3 players

  Background:
    When I run `uno` interactively
    And I type:
      """
      3 players
      Alice
      Bob
      Carol
      """

  Scenario: Playing numbers
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

  Scenario: Detecting an incorrect card by the correct player
    When I type "2 blue"
    And I type "3 yellow Alice"
    And I close the stdin stream
    Then it should pass with:
      """
      3 yellow Alice
      # wrong card
      """

  Scenario: Detecting a wrong player
    When I type "2 blue"
    And I type "2 blue Bob"
    And I close the stdin stream
    Then it should pass with:
      """
      2 blue Bob
      # wrong player
      """

  Scenario: Accepting a twin number
    When I type "joker green"
    And I type "1 green Alice"
    And I type "1 green Alice"
    And I close the stdin stream
    Then it should pass with:
      """
      1 green Alice
      # Alice 6 cards left
      # Bob to play
      1 green Alice
      # Alice 5 cards left
      # Bob to play
      """

  Scenario: Rejecting a false twin number
    When I type "joker green"
    And I type "1 green Alice"
    And I type "2 green Alice"
    And I close the stdin stream
    Then it should pass with:
      """
      1 green Alice
      # Alice 6 cards left
      # Bob to play
      2 green Alice
      # wrong player
      # Bob to play
      """

  Scenario: Rejecting a twin reverse
    When I type "joker green"
    And I type "reverse green Alice"
    And I type "reverse green Alice"
    And I close the stdin stream
    Then it should pass with:
      """
      reverse green Alice
      # Alice 6 cards left
      # Carol to play
      reverse green Alice
      # wrong player
      # Carol to play
      """

  Scenario: Rejecting a twin draw
    When I type "joker green"
    And I type "draw Alice"
    And I type "draw Alice"
    And I close the stdin stream
    Then it should pass with:
      """
      draw Alice
      # Alice 8 cards left
      # Bob to play
      draw Alice
      # wrong player
      # Bob to play
      """

  Scenario: Alice wins quickly
    When I type:
      """
      joker green
      3 green Alice
      3 green Alice
      9 green Bob
      8 green Carol
      2 green Alice
      2 green Alice
      7 green Bob
      6 green Carol
      1 green Alice
      1 green Alice
      5 green Bob
      4 green Carol
      0 green Alice
      """
    Then it should pass with:
      """
      0 green Alice
      # Alice 0 card left
      # Alice wins
      """
