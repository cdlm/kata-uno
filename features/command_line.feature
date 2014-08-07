Feature: calling from the command line

    Background:
        Given a file named "preamble_three_players.uno" with:
        """
        3 players
        Alice
        Bob
        Carol
        7 red
        """

    Scenario: display usage
        When I run `uno --help`
        Then it should pass with regex:
        """
        ^Usage:
        """

    Scenario: reading preamble on standard input
        When I run `uno` interactively
        And I pipe in the file "preamble_three_players.uno"
        Then it should pass with:
        """
        3 players
        Alice
        Bob
        Carol
        7 red

        """

    Scenario: reading preamble from file
        When I run `uno preamble_three_players.uno`
        Then it should pass with:
        """
        3 players
        Alice
        Bob
        Carol
        7 red

        """
