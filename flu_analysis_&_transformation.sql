/*
FEB 18, 2024
INFLUENZA STAFFING ANALYSIS
ALAN SAMPEDRO
*/


/* STATISTICAL ANALYSIS */

-- Mortality & population over 65 ratios
WITH
mortality_nonull AS (
SELECT key, 
	   "age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" + "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + over_100 AS total_deaths
  FROM (SELECT state || county || year AS key,
			   COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE("age_85-89", 0) AS "age_85-89",
	    	   COALESCE("age_90-94", 0) AS "age_90-94",
			   COALESCE("age_95-99", 0) AS "age_95-99",
	    	   COALESCE(over_100, 0) AS over_100
   		  FROM mortality)
),

census_nonull AS (
SELECT key, total,
	   ("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) * 1.0 / total AS over_65_ratio
  FROM (SELECT total,
			   state || county || year AS key,
		       COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE(over_85, 0) AS over_85
		  FROM census)
)

SELECT ROUND(b.over_65_ratio, 5) as over_65_ratio,
	   ROUND((a.total_deaths * 1.0 / b.total) * 1000, 5) AS mortality_rate
  FROM mortality_nonull a
	   JOIN census_nonull b
			ON a.key = b.key
;


-- Normalized mortality & population over 65 ratios
WITH
mortality_nonull AS (
SELECT key, 
	   "age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" + "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + over_100 AS total_deaths
  FROM (SELECT state || county || year AS key,
			   COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE("age_85-89", 0) AS "age_85-89",
	    	   COALESCE("age_90-94", 0) AS "age_90-94",
			   COALESCE("age_95-99", 0) AS "age_95-99",
	    	   COALESCE(over_100, 0) AS over_100
   		  FROM mortality)
),

census_nonull AS (
SELECT key, total,
	   ("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) * 1.0 / total AS over_65_ratio
  FROM (SELECT total,
			   state || county || year AS key,
		       COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE(over_85, 0) AS over_85
		  FROM census)
),

ratios AS (
SELECT ROUND(b.over_65_ratio, 5) as over_65_ratio,
	   ROUND((a.total_deaths * 1.0 / b.total) * 1000, 5) AS mortality_rate
  FROM mortality_nonull a
	   JOIN census_nonull b
			ON a.key = b.key
)

SELECT (LOG(over_65_ratio)-AVG(LOG(over_65_ratio)) OVER()) / STDDEV(LOG(over_65_ratio)) OVER() AS over_65_ratio_normalized,
	   (LOG(mortality_rate)-AVG(LOG(mortality_rate)) OVER()) / STDDEV(LOG(mortality_rate)) OVER() AS mortality_rate_normalized
  FROM ratios
 WHERE over_65_ratio != 0
   AND mortality_rate != 0
;


-- Normalized mortality & population over 65 ratios for regression analysis / (no zeros) / (no outliers - 2 std's from the mean)
WITH
mortality_nonull AS (
SELECT key, 
	   "age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" + "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + over_100 AS total_deaths
  FROM (SELECT state || county || year AS key,
			   COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE("age_85-89", 0) AS "age_85-89",
	    	   COALESCE("age_90-94", 0) AS "age_90-94",
			   COALESCE("age_95-99", 0) AS "age_95-99",
	    	   COALESCE(over_100, 0) AS over_100
   		  FROM mortality)
),

census_nonull AS (
SELECT key, total,
	   ("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) * 1.0 / total AS over_65_ratio
  FROM (SELECT total,
			   state || county || year AS key,
		       COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE(over_85, 0) AS over_85
		  FROM census)
),

ratios AS (
SELECT ROUND(b.over_65_ratio, 5) as over_65_ratio,
	   ROUND((a.total_deaths * 1.0 / b.total) * 1000, 5) AS mortality_rate
  FROM mortality_nonull a
	   JOIN census_nonull b
			ON a.key = b.key
),

log_transformation AS (
SELECT (LOG(over_65_ratio)-AVG(LOG(over_65_ratio)) OVER()) / STDDEV(LOG(over_65_ratio)) OVER() AS over_65_ratio_normalized,
	   (LOG(mortality_rate)-AVG(LOG(mortality_rate)) OVER()) / STDDEV(LOG(mortality_rate)) OVER() AS mortality_rate_normalized
  FROM ratios
 WHERE over_65_ratio != 0
   AND mortality_rate != 0
)

SELECT over_65_ratio_normalized, mortality_rate_normalized
  FROM log_transformation
 WHERE over_65_ratio_normalized BETWEEN -2 AND 2
   AND mortality_rate_normalized BETWEEN -2 AND 2
;


-- Deaths under and over 65 years old
SELECT "age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" AS deaths_under_65,
	   "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + over_100 AS deaths_over_65
  FROM (SELECT state || county || year AS key,
			   COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE("age_85-89", 0) AS "age_85-89",
	    	   COALESCE("age_90-94", 0) AS "age_90-94",
			   COALESCE("age_95-99", 0) AS "age_95-99",
	    	   COALESCE(over_100, 0) AS over_100
   		  FROM mortality)
;


-- Deaths under and over 65 years old (no outliers)
WITH
over_under AS (
SELECT "age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" AS deaths_under_65,
	   "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + over_100 AS deaths_over_65
  FROM (SELECT state || county || year AS key,
			   COALESCE("age_25-29", 0) AS "age_25-29",
	    	   COALESCE("age_35-39", 0) AS "age_35-39",
	   		   COALESCE("age_40-44", 0) AS "age_45-49",
	  		   COALESCE("age_45-49", 0) AS "age_40-44",
	    	   COALESCE("age_50-54", 0) AS "age_50-54",
	    	   COALESCE("age_55-59", 0) AS "age_55-59",
	    	   COALESCE("age_60-64", 0) AS "age_60-64",
	    	   COALESCE("age_65-69", 0) AS "age_65-69",
	    	   COALESCE("age_70-74", 0) AS "age_70-74",
	    	   COALESCE("age_75-79", 0) AS "age_75-79",
	    	   COALESCE("age_80-84", 0) AS "age_80-84",
	    	   COALESCE("age_85-89", 0) AS "age_85-89",
	    	   COALESCE("age_90-94", 0) AS "age_90-94",
			   COALESCE("age_95-99", 0) AS "age_95-99",
	    	   COALESCE(over_100, 0) AS over_100
   		  FROM mortality)
)

SELECT deaths_under_65, deaths_over_65
  FROM over_under
 WHERE deaths_under_65 < (SELECT AVG(deaths_under_65) + (STDDEV(deaths_under_65) * 2)
						    FROM over_under)
   AND deaths_over_65 < (SELECT AVG(deaths_over_65) + (STDDEV(deaths_over_65) * 2)
						   FROM over_under)
;



/* EXPLORATORY ANALYSIS */


-- Fix inconsistencies in visits table
UPDATE visits
SET state = 'Texas'
WHERE state = 'Teas'

UPDATE visits
SET state = 'New Mexico'
WHERE state = 'New Meico'


-- Yearly national median of ili-related hospital visits (2019-2023)
SELECT year,
	   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY ili_patients) AS median_ili
  FROM visits
 WHERE year NOT IN (2018, 2024)
 GROUP BY year
;


-- Weekly median ILI Hospitalization Rates in 2022 and 2023
WITH
median_22 AS (
SELECT week,
	   PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY (ili_patients * 1.0 / total_patients) * 100) AS ili_hospitalization_rate
  FROM visits
 WHERE year = 2022
   AND total_patients != 0
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')
 GROUP BY week
),

median_23 AS (
SELECT week,
	   PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY (ili_patients * 1.0 / total_patients) * 100) AS ili_hospitalization_rate
  FROM visits
 WHERE year = 2023
   AND total_patients != 0
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')
 GROUP BY week
)

SELECT a.week, ROUND(a.ili_hospitalization_rate::NUMERIC, 1) AS "2022",
	   ROUND(b.ili_hospitalization_rate::NUMERIC, 1) AS "2023"
  FROM median_22 a
  	   JOIN median_23 b
	   	 ON a.week = b.week
;


-- National monthly ILI hospitalizations 2022-2023
WITH
hospitalizations AS (
SELECT year, EXTRACT(MONTH FROM make_date(year, 1, 1) + (week - 1) * 7) AS month,
	   SUM(ili_patients) AS monthly_hospitalizations
  FROM visits
 WHERE year IN (2022, 2023)
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')
 GROUP BY year, EXTRACT(MONTH FROM make_date(year, 1, 1) + (week - 1) * 7)
)

SELECT year, month, monthly_hospitalizations,
	   ROUND((monthly_hospitalizations - LAG(monthly_hospitalizations) OVER (PARTITION BY year ORDER BY month)::NUMERIC) / LAG(monthly_hospitalizations) OVER (ORDER BY month) * 100, 1) AS percentage_diff_from_previous_month,
	   ROUND((monthly_hospitalizations - AVG(monthly_hospitalizations) OVER(PARTITION BY year))::NUMERIC / AVG(monthly_hospitalizations) OVER(PARTITION BY year)::NUMERIC * 100, 1) AS percentage_diff_from_avg
  FROM hospitalizations
 ORDER BY year, month
;


WITH
regional_hospitalizations AS (
SELECT CASE
	   WHEN state IN ('Connecticut', 'Maine', 'Massachusetts', 'New Hampshire', 'Rhode Island',
				      'Vermont', 'New Jersey', 'New York', 'New York City', 'Pennsylvania') THEN 'Northeast'
       WHEN state IN ('Illinois', 'Indiana', 'Michigan', 'Ohio', 'Wisconsin', 'Iowa', 'Kansas',
				      'Minnesota', 'Missouri', 'Nebraska', 'North Dakota', 'South Dakota') THEN 'Midwest'
       WHEN state IN ('Delaware', 'Florida', 'Georgia', 'Maryland', 'North Carolina', 'South Carolina',
				      'Virginia', 'District of Columbia', 'West Virginia', 'Alabama', 'Kentucky',
				      'Mississippi', 'Tennessee', 'Arkansas', 'Louisiana', 'Oklahoma', 'Texas') THEN 'South'
       WHEN state IN ('Arizona', 'Colorado', 'Idaho', 'Montana', 'Nevada', 'New Mexico', 'Utah',
				      'Wyoming', 'Alaska', 'California', 'Hawaii', 'Oregon', 'Washington') THEN 'West'
	    END AS region,
	   year, EXTRACT(MONTH FROM make_date(year, 1, 1) + (week - 1) * 7) AS month,
	   SUM(ili_patients) AS monthly_hospitalizations
  FROM visits
 WHERE year IN (2022, 2023)
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')
 GROUP BY region, year, EXTRACT(MONTH FROM make_date(year, 1, 1) + (week - 1) * 7)
)

SELECT region, year, month, monthly_hospitalizations,
	   ROUND((monthly_hospitalizations - LAG(monthly_hospitalizations) OVER (PARTITION BY region, year ORDER BY month)::NUMERIC) / LAG(monthly_hospitalizations) OVER (ORDER BY month) * 100, 1) AS percentage_diff_from_previous_month,
	   ROUND((monthly_hospitalizations - AVG(monthly_hospitalizations) OVER(PARTITION BY region, year))::NUMERIC / AVG(monthly_hospitalizations) OVER(PARTITION BY region, year)::NUMERIC * 100, 1) AS percentage_diff_from_avg
  FROM regional_hospitalizations
 ORDER BY region, year, month
;


-- ILI Hospitalizations per State in 2023
SELECT state,
	   SUM(ili_patients) AS total_hospitalizations
  FROM visits
 WHERE year = 2023
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')
 GROUP BY state
 ORDER BY total_hospitalizations DESC
;

-- Population over 65 years old
SELECT state,
	   SUM("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) AS population_over_65
  FROM census
 WHERE year = 2022
 GROUP BY state
 ORDER BY population_over_65 DESC
 LIMIT 5
;
  
  
-- Weekly ILI, Census, and Mortality trends 2019-2022 (dashboard dataset)
SELECT vis.state, vis.year, vis.week, make_date(vis.year, 1, 1) + (vis.week - 1) * 7 AS visit_date, vis.total_patients, vis.ili_patients,
       pop.total_population, pop.population_over_65,
	   mort.total_deaths, mort.deaths_over_65
  FROM visits vis
  LEFT JOIN (SELECT state, year,
			        SUM("age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" + "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) AS total_population,
			        SUM("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + over_85) AS population_over_65
  			   FROM census
 			  GROUP BY state, year
			 ) pop --IMPORTANT: Population figures are from 2017 to 2022.
	   	 ON vis.state = pop.state AND vis.year = pop.year
		 	LEFT JOIN (SELECT state, year,
					   	      SUM("age_25-29" + "age_35-39" + "age_40-44" + "age_45-49" + "age_50-54" + "age_55-59" + "age_60-64" + "age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + "age_95-99" + over_100) AS total_deaths,
					   		  SUM("age_65-69" + "age_70-74" + "age_75-79" + "age_80-84" + "age_85-89" + "age_90-94" + "age_95-99" + over_100) AS deaths_over_65
					     FROM (SELECT state, year,
								      COALESCE("age_25-29", 0) AS "age_25-29",
								      COALESCE("age_35-39", 0) AS "age_35-39",
								      COALESCE("age_40-44", 0) AS "age_45-49",
								      COALESCE("age_45-49", 0) AS "age_40-44",
								      COALESCE("age_50-54", 0) AS "age_50-54",
								      COALESCE("age_55-59", 0) AS "age_55-59",
								      COALESCE("age_60-64", 0) AS "age_60-64",
								      COALESCE("age_65-69", 0) AS "age_65-69",
								      COALESCE("age_70-74", 0) AS "age_70-74",
								      COALESCE("age_75-79", 0) AS "age_75-79",
								      COALESCE("age_80-84", 0) AS "age_80-84",
								      COALESCE("age_85-89", 0) AS "age_85-89",
								      COALESCE("age_90-94", 0) AS "age_90-94",
							 		  COALESCE("age_95-99", 0) AS "age_95-99",
								      COALESCE(over_100, 0) AS over_100
   		  						 FROM mortality
							   )
					    GROUP BY state, year
					   ) mort -- IMPORTANT: Mortality figures are from 2017-2020. Not all the regions in the scope of this analysis have mortality figures — see query below.
				   ON vis.state = mort.state AND vis.year = mort.year
 WHERE vis.state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands') 
   AND vis.year NOT IN (2018, 2024)
   AND vis.week != 53
   AND vis.total_patients != 0
 ORDER BY vis.state, vis.year, vis.week
;


-- Regions/states in visits table missing mortality data
SELECT DISTINCT state
  FROM visits
 WHERE state NOT IN (SELECT DISTINCT state
  					   FROM mortality) 
   AND state NOT IN ('Puerto Rico', 'Commonwealth of the Northern Mariana Islands', 'Virgin Islands')		   
;