The folder contains two python files- tournament.py and tournament_test.py and
one file called tournament.sql which is used to store TABLE definitions and 
VIEWS. All three files must be present in the same folder on a system with 
postgresql installed. 

tournament_test.py is the unit test file that imports and invokes routines 
implemented in tournament.py that exercise the database design.

First initialize the database and table from psql command line using the 
tournament.sql file
Run psql command in shell and in the commandline use the \i option
> psql
vagrant >> \i tournament.sql

This will create the tournament database and connect to it
 
On another shell, run the tournament_test.py as follows-
> python tournament_test.py

Following is the output that will be seen showing all unit tests pass-
1. Old matches can be deleted.
2. Player records can be deleted.
3. After deleting, countPlayers() returns zero.
4. After registering a player, countPlayers() returns 1.
5. Players can be registered and deleted.
6. Newly registered players appear in the standings with no matches.
7. After a match, players have updated standings.
8. After one match, players with one win are paired.
Success!  All tests pass!
