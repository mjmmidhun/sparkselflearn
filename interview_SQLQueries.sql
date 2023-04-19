/* Add multiple values to one column in existing table */
update table <tablename> set salary = case name when name1 then 10000 when name2 then 20000
where name in (name1,name2)

/* To find highest salary in each dept */
select max(salary), dept from coffeeshop.details group by dept;

/* TO find second highest salary from each dept */
WITH cteRowNum AS (
SELECT *,
       DENSE_RANK() OVER(PARTITION BY dept ORDER BY Salary DESC) AS RowNum
    FROM DETAILS
 )
 SELECT *
 FROM cteRowNum
 WHERE RowNum = 2;
 
/*  Window functions */
 select e.*,MAX(salary) over(PARTITION by dept) as max_salary from employee e;
 
/*  delete duplicate records */
WITH records as (
select d.*, row_number() over(order by empname) as RN from details d)

DELETE FROM records WHERE RN NOT IN (
SELECT MAX(RN) FROM records GROUP BY EMPNAME,DEPT,CONTACTNO,CITY)

--Create INDEX
CREATE INDEX idx_name ON employees (name);

--insert new data to existing hive table with new partition.
INSERT INTO TABLE sales PARTITION (country='Canada')
SELECT '2023-01-01', 'ProductA', 1000 UNION ALL
SELECT '2023-01-02', 'ProductB', 1500 UNION ALL
SELECT '2023-01-03', 'ProductC', 2000;

--create an external table from  existing table
CREATE EXTERNAL TABLE my_external_table
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/path/to/external/table'
AS
SELECT *
FROM my_existing_table;
