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
;