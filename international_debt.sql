
-- Database created
Create Database international_debt_stats;
use international_debt_stats;

-- Table Created
Create table debt(
country_name varchar(200),
country_code varchar(20),
indicator_name varchar(1000),
indicator_code varchar(100),
debt float(20)
);

-- display records
Select * From debt;

-- The number of countries with debt
Select count(*) As no_of_countries From debt;

-- Finding the number of distinct countries
Select count(distinct(country_name)) As no_of_distinct_country From debt;

--  Finding out the distinct debt indicators
Select distinct(indicator_code) As distinct_debt_indicator From debt;

-- The total amount of debt owed by all the countries
Select round(sum(debt), 2) as total_debt From debt;

-- The country with the highest debt and the amount of its debt
Select country_name, SUM(debt) as total_debt From debt group by country_name order by total_debt DESC Limit 1;

-- The average amount of debt owed by countries across different debt indicators
Select indicator_code as debt_indicator, indicator_name, round(AVG(debt), 2) as average_debt From debt 
group by debt_indicator, indicator_name
order by average_debt DESC;

-- The most common debt indicator
SELECT  indicator_code, COUNT(indicator_code) as indicator_count FROM debt
GROUP BY indicator_code
ORDER BY indicator_count DESC, indicator_code DESC;

-- The highest amount of principal repayments
SELECT country_name, indicator_name FROM debt
WHERE debt = (SELECT 
 MAX(debt)
 FROM debt
 WHERE indicator_code = 'DT.AMT.DLXF.CD');
 
 -- Other viable debt issues and maximum debt according to country
Select country_name, MAX(debt) as maximum_debt From debt group by country_name order by maximum_debt DESC;
