# 1.Query to retrieve city name, country code, and year for cities with a high urban population:
SELECT Distinct cd.name, cd.country_code as Country, cd.urbanarea_pop
FROM leader.cities cd
JOIN leader.economies ed ON cd.country_code = ed.code
WHERE cd.urbanarea_pop
ORDER BY urbanarea_pop DESC;

# 2. Query to retrieve city name, country code to find which country has highest fertality rate?
SELECT Distinct cd.name, cd.country_code, pd.fertility_rate
FROM leader.cities cd
JOIN leader.populations pd ON cd.country_code = pd.country_code
ORDER BY fertility_rate DESC;

#3. Which country has the highest life_expectancy and high income_group? 
SELECT DISTINCT cd.country_code AS Country, ed.gdp_percapita, pd.life_expectancy, ed.income_group, pd.year as Year
FROM leader.cities cd
JOIN leader.economies ed ON cd.country_code = ed.code
JOIN leader.populations pd ON cd.country_code = pd.country_code AND ed.year = pd.year
WHERE pd.year IN (2010, 2015)
ORDER BY pd.life_expectancy DESC;

#4. Find the country and city has the lowest unemployment rate?
SELECT DISTINCT cd.country_code, cd.name as City, ed.unemployment_rate
FROM leader.cities cd
JOIN leader.economies ed ON cd.country_code = ed.code
WHERE cd.city_proper_pop > 1000000 AND ed.unemployment_rate < 3
ORDER BY ed.unemployment_rate DESC;

#5. Which country has the highest inflation rate?
SELECT  DISTINCT cd.country_code, cd.name AS City, ed.inflation_rate
FROM leader.cities cd
JOIN leader.populations pd ON cd.country_code = pd.country_code
JOIN leader.economies ed ON cd.country_code = ed.code
WHERE ed.inflation_rate > 10
ORDER BY ed.inflation_rate DESC;

#6. Find the avg fertility rate change from 2010 - 2015?
SELECT DISTINCT pd.country_code AS Country,
     ROUND(AVG(CASE WHEN pd.year = 2010 THEN pd.fertility_rate END), 2) AS avg_fertility_2010,
       ROUND(AVG(CASE WHEN pd.year = 2015 THEN pd.fertility_rate END), 2) AS avg_fertility_2015,
       ROUND(AVG(CASE WHEN pd.year = 2015 THEN pd.fertility_rate END) - AVG(CASE WHEN pd.year = 2010 THEN pd.fertility_rate END), 2) AS fertility_rate_change
FROM leader.populations pd
WHERE pd.year IN (2010, 2015)
GROUP BY pd.country_code
ORDER BY fertility_rate_change DESC;

#7. Find the income group categories desending order?
SELECT income_group, ROUND(AVG(gdp_percapita), 2) AS avg_gdp_percapita
FROM leader.economies
WHERE year = 2015
GROUP BY income_group;

#8. Find the country with the highest population size in 2015
SELECT country_code, year, size
FROM leader.populations 
WHERE year = 2015 AND size = (SELECT MAX(size) FROM leader.populations WHERE year = 2015);

#9. Calculate the total investment for each country in 2015
SELECT code, year, SUM(total_investment) AS total_investment, sum(gross_savings) as Gross_Savings
FROM leader.economies
WHERE year = 2015
GROUP BY code, year, gross_savings
ORDER BY total_investment DESC;




















