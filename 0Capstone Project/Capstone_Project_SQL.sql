/*Create and use database*/
create database capstone;
use capstone;

/*View dataset*/
select * from merged_data;

-- 1. Find the top 10 players by most goals scored.
select player_name_y, SUM(goals) as total_goals from merged_data group by player_name_y order by total_goals desc limit 10;
/*Interpretation- 'Christian Pulisic' is the number 1 player by most goals scored (658).*/

-- 2. Find the average market_value_in_eur for players in each country_of_birth.
select country_of_birth, avg(market_value_in_eur) from merged_data group by country_of_birth order by avg(market_value_in_eur) desc;
/*Interpretation- Average market_value_in_eur for players is highest in England (25M).*/

-- 3. Find the number of players in each home_club.
select home_club_name, COUNT(DISTINCT player_id) as player_count from merged_data where home_club_name is not null group by home_club_name order by player_count desc;
/*Interpretation- 'Borussia Dortmund' has the most number of players (11).*/

-- 4. Find the number of players in each away_club.
select away_club_name, COUNT(DISTINCT player_id) as player_count from merged_data where away_club_name is not null group by away_club_name order by player_count desc;
/*Interpretation- 'Borussia Dortmund' has the most number of players (8).*/

-- 5. Find the players who haven't scored any goals.
select player_name_y from merged_data group by player_name_y having SUM(goals)=0;
/*Interpretation- Players who haven't scored any goals are 'Lynden Gooch', 'Caleb Stanko', 'Tim Ream' and 'Luca de la Torre'.*/

-- 6. Find the top 10 referees by most yellow_cards given.
select referee, SUM(yellow_cards) as total_yellow_cards from merged_data group by referee order by total_yellow_cards desc limit 10;
/*Interpretation- 'Felix Zwayer' is the number 1 referee by most yellow_cards given (76).*/

-- 7. List players with their assigned home_club_manager.
select DISTINCT player_name_y, home_club_manager_name from merged_data;
/*Interpretation- Players have been listed with their assigned home_club_manager. */

-- 8. Find the top 10 stadiums with the highest average attendance.
select stadium, avg(attendance) as average_attendance from merged_data group by stadium order by average_attendance desc limit 10;
/*Interpretation- 'Santiago Bernabeu' is the number 1 stadium with the highest average attendance (76894).*/

-- 9. Find the top 10 stadiums with the most goals scored.
select stadium, SUM(goals) as total_goals from merged_data group by stadium order by total_goals desc limit 10;
/*Interpretation- 'SIGNAL IDUNA PARK' is the number 1 stadium with the most goals scored there (220).*/

-- 10. Find the total number of players.
select count(DISTINCT player_id) as total_players from merged_data;
/*Interpretation- The total number of players are 24.*/

-- 11. Find the total number of referees.
select count(DISTINCT referee) as total_referees from merged_data;
/*Interpretation- The total number of referees are 131.*/

-- 12. Find the total number of stadiums.
select count(DISTINCT stadium) as total_stadiums from merged_data;
/*Interpretation- The total number of stadiums are 124.*/

-- 13. Find the names of all players who have scored more goals than the average number of goals.
select player_name_y from merged_data group by player_name_y having SUM(goals)>AVG(goals);
/*Interpretation- Players who have scored more goals than the average number of goals have been listed.*/


