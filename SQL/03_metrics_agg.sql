-- Core metric complaints section. Complaints over days and month. Complaints by street. 

-- Complaints per day
SELECT 
	DATE(request_date) AS request_day,
	COUNT(complaint_type) AS complaint_count
FROM complaints_clean
GROUP BY DATE(request_date)
ORDER BY request_day;

-- Complaints per month
SELECT 
	DATE_FORMAT(request_date, '%Y-%m') as request_month,
    COUNT(complaint_type) AS complaint_count
FROM complaints_clean
GROUP BY request_month
ORDER BY request_month;

-- Complaints per street name

SELECT 
	COUNT(complaint_type) AS complaint_count,
    street_name
FROM complaints_clean
WHERE street_name NOT LIKE '% and %'
AND street_name NOT LIKE '% & %' -- Exlcluding data where street names are labeled as 'intersection of steet and street'
GROUP BY street_name
ORDER BY street_name;

-- Top 10 streets and % of total complaints

-- CTE
WITH street_complaints AS( SELECT 
	COUNT(complaint_type) AS complaint_count,
    street_name
FROM complaints_clean
WHERE street_name NOT LIKE '% and %' -- Exlcluding data where street names are labeled as 'intersection of steet and street'
AND street_name NOT LIKE '% & %'-- Exlcluding data where street names are labeled as 'intersection of steet & street'
AND street_name NOT LIKE 'unknown' -- Excluding data with street name as 'unknown'
GROUP BY street_name
ORDER BY street_name)

SELECT 
*,
complaint_count/SUM(complaint_count) OVER() AS percentage_of_total_complaints
FROM street_complaints
ORDER BY complaint_count DESC
LIMIT 10;

-- Quantify unkown street name

SELECT 
	complaint_type,
	COUNT(complaint_type) AS count_of_complaint_type
FROM complaints_clean
WHERE street_name LIKE 'unkn%'
GROUP BY complaint_type
ORDER BY count_of_complaint_type DESC;

-- Quantify 'intersection of steet and (&) street'

SELECT 
	complaint_type,
	COUNT(complaint_type) AS count_of_complaint_type
FROM complaints_clean
WHERE street_name LIKE '% and %'
OR street_name LIKE '% & %'
GROUP BY complaint_type
ORDER BY count_of_complaint_type DESC;








