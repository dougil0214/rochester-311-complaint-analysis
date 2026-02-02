-- Create clean complaint table
CREATE TABLE complaints_clean AS
SELECT 
	STR_TO_DATE(`Request Date`, '%m/%d/%Y %k:%i') AS request_date,
     TRIM(Type) AS complaint_type,
     TRIM(department) AS department,
     TRIM(bureau) AS bureau,
	LOWER(TRIM(LEADING '.' FROM TRIM(`Street Name`))) AS street_name,
	NULLIF(zip, '') AS zip_code
FROM 311_data_audit;
 
 -- Checking new table
SELECT COUNT(*) 
FROM complaints_clean;

-- Chekcing mizzing zips
SELECT COUNT(*)
FROM complaints_clean
WHERE zip_code IS NULL;

-- preview street names
SELECT street_name
FROM complaints_clean
LIMIT 10;

-- Preview dates
SELECT request_date
FROM complaints_clean
LIMIT 10;

UPDATE complaints_clean
SET street_name = LOWER(street_name);

UPDATE complaints_clean
SET street_name = REPLACE(street_name, ' st', ' street')
WHERE street_name LIKE '% st';

UPDATE complaints_clean
SET street_name = REPLACE(street_name, ' av', ' avenue')
WHERE street_name LIKE '% av';

UPDATE complaints_clean
SET street_name = REPLACE(street_name, ' blvd', ' boulevard')
WHERE street_name LIKE '% blvd';

UPDATE complaints_clean
SET street_name = REPLACE(street_name, '#name', NULL)
WHERE street_name LIKE '#name';

