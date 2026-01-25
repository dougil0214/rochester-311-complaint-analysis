-- Checking all rows imported correctly 
SELECT 
	COUNT(*) AS total_rows
FROM 311_data_audit;

-- looking at data types on rows
DESCRIBE 311_data_audit;

-- Missing data counts
SELECT 
	COUNT(*) AS total_rows,
	SUM(subject IS NULL) AS subject_nulls,
    SUM(Reason IS NULL) AS reason_nulls,
    SUM(Type IS NULL) AS type_nulls,
    SUM(Department IS NULL) AS department_nulls,
    SUM(Bureau IS NULL) AS bureau_nulls,
    SUM(`Request Date` IS NULL) AS request_date_nulls,
    SUM(`Street Name` IS NULL) AS street_name_nulls,
    SUM(ZIP IS NULL) AS zip_nulls
FROM 311_data_audit;


