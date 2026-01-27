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

-- Complaints per street
SELECT 
	COUNT(complaint_type) AS complaint_count,
    street_name
FROM complaints_clean
WHERE street_name NOT LIKE '% and %'
AND street_name NOT LIKE '% & %' -- Exlcluding data where street names are labeled as 'intersection of steet and street'
GROUP BY street_name
ORDER BY street_name;