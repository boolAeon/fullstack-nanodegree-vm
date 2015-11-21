-- File to invoke with \i option from psql to intialize database and tables

-- Drop database if already created
DROP DATABASE IF EXISTS tournament; 

-- Create and connect to tournament database
CREATE DATABASE tournament;
\c tournament

-- Create Relations- Players are registered with name
--                   Matches are registered with winner, loser pair
CREATE TABLE Players(id SERIAL PRIMARY KEY, player_name TEXT);
CREATE TABLE Matches(match_id SERIAL PRIMARY KEY, 
	                 winner INTEGER REFERENCES Players(id), 
	                 loser INTEGER REFERENCES Players(id));

-- Create View for Player win query
CREATE VIEW PlayerWins AS SELECT Players.id, Players.player_name, 
								 count(Matches.winner) 
                                 as num_wins 
                                 FROM Players 
                                 LEFT JOIN Matches 
                                 ON Players.id = Matches.winner 
                                 GROUP BY Players.id ORDER BY Players.id;

-- Create View for matches played query if either id matches winner or loser
CREATE VIEW PlayerMatches AS SELECT Players.id, count(Matches.match_id) 
                                    as num_matches 
                                    FROM Players 
                                    LEFT JOIN Matches 
                                    ON Players.id = Matches.winner 
                                    OR Players.id = Matches.loser 
                                    GROUP BY Players.id 
                                    ORDER BY Players.id;

-- Create View for Player Standings by joining the two queries above
CREATE VIEW PlayerStandings AS SELECT PlayerWins.id, PlayerWins.player_name, 
                                      PlayerWins.num_wins, 
                                      PlayerMatches.num_matches 
                                      FROM PlayerWins 
                                      RIGHT JOIN PlayerMatches 
                                      ON PlayerWins.id = PlayerMatches.id 
                                      ORDER BY PlayerWins.num_wins DESC;
