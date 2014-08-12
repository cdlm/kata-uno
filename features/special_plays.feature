Feature: Demonstrating special plays

  Scenario: Game given in the mail
    When I run `uno` interactively
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
    7 green Alice
    draw Bob
    +2 green Carol
    skip green Erin
    reverse green Alice
    joker blue Frank
    +4 yellow Erin
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
    7 green Alice
    # Alice 6 cards left
    # Bob to play
    draw Bob
    # Bob 8 cards left
    # Carol to play
    +2 green Carol
    # Carol 6 cards left
    # Dave 9 cards left
    # Erin to play
    skip green Erin
    # Erin 6 cards left
    # Alice to play
    reverse green Alice
    # Alice 5 cards left
    # Frank to play
    joker blue Frank
    # Frank 6 cards left
    # Erin to play
    +4 yellow Erin
    # Erin 5 cards left
    # Dave 13 cards left
    # Carol to play
    """
