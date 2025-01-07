# [The Christmas tree famine 🎄](https://adventofsql.com/challenges/11)

## Description
Santa's Workshop faces an urgent crisis. The North Pole's Christmas tree farms, which have supplied trees to children worldwide for centuries, are showing mysterious patterns in their harvest numbers. Mrs. Claus has personally requested an analysis after noticing some fields producing record numbers while others struggle. She wants to find out which field has been performing well over recent seasons.

The TreeHarvests database contains vital information about every Christmas tree harvest since 2022. Understanding these patterns is crucial for maintaining the magic of Christmas in homes across the globe.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-11/blob/main/advent_of_sql_day_11.sql)

Mrs. Claus needs a comprehensive analysis of the tree farms. Using window functions, create a query that will shed some light on the field perfomance.
+ Show the 3-season moving average per field per season per year
+ Write a single SQL query using window functions that will reveal these vital patterns. Your analysis will help ensure that every child who wishes for a Christmas tree will have one for years to come.
+ Order them by three_season_moving_avg descending to make it easier to find the largest figure.

* Seasons are ordered as follows:
  + Spring THEN 1
  + Summer THEN 2
  + Fall THEN 3
  + Winter THEN 4

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM treeharvests ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-11/blob/main/treeharvests.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-11/blob/main/advent_answer_day11.sql)

**input**
```sql
SELECT field_name, harvest_year, season,
AVG(trees_harvested) OVER(PARTITION BY field_name ORDER BY harvest_year, season_order ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)::NUMERIC(10,2) AS three_season_moving_avg
FROM (SELECT *,
			CASE WHEN season = 'Spring' THEN 1
		 	WHEN season = 'Summer' THEN 2
		 	WHEN season = 'Fall' THEN 3
			WHEN season = 'Winter' THEN 4
			ELSE 5
		END AS season_order FROM treeharvests)
ORDER BY three_season_moving_avg DESC

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-11/blob/main/d11.PNG)


