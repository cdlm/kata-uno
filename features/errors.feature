Feature: Demonstrating wrong plays

  Scenario: Draw is invalid as a reveal
    Given I run `uno` interactively
    And I type:
      """
      3 players
      Alice
      Bob
      Carol
      draw
      """
    And I close the stdin stream
    Then it should pass with:
      """
      draw
      !!! format error
      """

  Scenario: Playing mistakes are reported but have no effect on the game
    Given I run `uno` interactively
    And I type:
      """
      6 players
      Alice
      Bob
      Carol
      Dave
      Erin
      Frank
      7 red
      2 green Frank
      reverse red Alice
      2 blue Frank
      2 red Frank
      """
    And I close the stdin stream
    Then it should pass with:
      """
      6 players
      Alice
      Bob
      Carol
      Dave
      Erin
      Frank
      7 red
      # Alice to play
      2 green Frank
      # wrong player
      # Alice to play
      reverse red Alice
      # Alice 6 cards left
      # Frank to play
      2 blue Frank
      # wrong card
      # Frank to play
      2 red Frank
      # Frank 6 cards left
      # Erin to play
      """

