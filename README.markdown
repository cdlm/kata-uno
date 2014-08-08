# Uno rules checker

A simple little reference implementation for a programming assignment.
The problem statement follows (in french).

 - - -

# Un arbitre pour le jeu Uno

Vous devez implémenter une librairie de classes permettant de vérifier le déroulement d'une partie de Uno (règles et cartes de base selon <http://fr.wikipedia.org/wiki/Uno>).

## Spécification du format d'entrée

Le programme principal demandé doit accepter comme unique argument le nom d'un fichier texte respectant le format de l'exemple suivant :

    6 players
    Alice
    Bob
    Carol
    Dave
    Erin
    Frank
    7 red
    5 red Alice
    5 green Bob
    +2 green Carol
    skip green Erin
    reverse green Alice
    joker blue Frank
    +4 yellow Erin

La première ligne indique le nombre N de joueurs de la partie (ici, N=6) suivi du mot `players`.
Les N lignes suivantes spécifient les prénoms ou pseudonymes des joueurs, dans l'ordre de jeu (un mot chaque).
La ligne suivante `7 red` indique la première carte retournée dans la défausse, et marque ainsi le début de partie.
Le reste des lignes du fichiers contiennent deux ou trois mots, indiquant :

  - premier mot :
  un type de carte défaussée (`0` à `9`, `+2`, `skip`, `reverse`, `joker`, ou `+4`) ou `draw` si le joueur pioche volontairement

  - second mot (omis après draw) :
  une couleur parmi `red`, `green`, `blue`, `yellow`, précisant la couleur annoncée pour le `joker` et le `+4`, et la couleur de la carte jouée pour les autres.

  - dernier mot :
  le nom ou pseudonyme du joueur ayant joué cette carte.


## Spécification du format de sortie

Le programme doit à l'exclusion de toute autre chose, ré-afficher les lignes lues, en insérant entre elles des lignes commençant par un signe dièse, donnant les diagnostics de l'arbitre après chaque carte défaussée :

    6 players
    Alice
    Bob
    Carol
    Dave
    Erin
    Frank
    7 red
    # Alice to play
    5 red Alice
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

…et ainsi de suite :

  - nombre de cartes restant dans la main du joueur ayant défaussé,
  - nombre de cartes dans la main de l'éventuel joueur ayant dû piocher,
  - nom du joueur suivant.

Quand un joueur défausse sa dernière carte, le diagnostic indique la fin de partie :

    (déroulement de la partie)

    # Alice to play
    1 blue Alice
    # Alice 0 card left
    # Alice wins

Dans le cas d'une défausse illégale, le programme affiche un diagnostic indiquant l'erreur, puis continue l'analyse du fichier comme si le joueur avait repris sa carte en main :

    (18 premières lignes identiques au premier exemple)

    # Erin to play
    skip green Erin
    # Erin 6 cards left
    # Alice to play
    2 green Frank
    # wrong player
    # Alice to play
    reverse green Alice
    # Alice 5 cards left
    # Frank to play
    2 blue Frank
    # wrong card
    # Frank to play

Les diagnostics d'erreur peuvent être :

    # wrong player
    # wrong card

Si un joueur a gagné la partie, les éventuelles lignes de défausse suivantes causent toutes le diagnostic `wrong player`.
