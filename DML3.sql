--displaying data from table 
SHOW pagesize;
SET pagesize 50;
SHOW linesize;
SET linesize 200;



SELECT * FROM boxes;
SELECT * FROM animals WHERE box_id=(SELECT box_id FROM boxes WHERE species='Mammals');

SELECT * FROM animals;
SELECT * FROM adoptions;
SELECT * FROM owners;

SELECT * FROM employees;
--Use of column alias
SELECT emp_id AS EMPLOYEE_ID,lastname AS "LAST NAME",(salary - 1000) * 5 AS Modified_Salary FROM employees;
SELECT emp_id AS EMPLOYEE_ID,lastname AS LAST_NAME,salary * 12 AS ANNUAL_SALARY FROM employees;

SELECT * FROM duties;

SELECT * FROM donators;
--Use of column alias
SELECT donator_id,firstname||' '||lastname AS FULL_NAME,total_donations AS ANNUAL_DONATION FROM donators;

SELECT * FROM donations;


--Union
--List all unique names both of animals and of donators
--union always  returns distinct rows.
--if we didnot use AS ,then col name would be the 1st one ,,animal_name
SELECT animal_name AS Name FROM animals UNION SELECT firstname AS Name FROM donators;

--Union All
--Includes duplicate values
SELECT animal_name FROM animals WHERE species = 'Cat' UNION ALL SELECT animal_name FROM animals WHERE species = 'Dog';

--Intersection
--names that are both an animal's name and a donator's first name
SELECT animal_name FROM animals INTERSECT SELECT firstname FROM donators;

--Except
--names those are not donated
--MINUS is equivalent to EXCEPT
SELECT animal_name FROM animals MINUS SELECT animal_name FROM animals WHERE  animal_id IN(SELECT animal_id FROM donations);

--With clause
--List of Animals and Their Donation Totals
WITH DonationTotal  AS(SELECT animal_id,SUM(amount) as totalDonation FROM donations GROUP BY animal_id)SELECT * FROM DonationTotal; 

--Aggregate function

--Total number of rows
SELECT COUNT(*) AS animal_count FROM animals;
SELECT COUNT(*) AS box_count FROM boxes;
SELECT COUNT(*) AS adoption_count FROM adoptions;
SELECT COUNT(*) AS owner_count FROM owners;
SELECT COUNT(*) AS employee_count FROM employees;
SELECT COUNT(*) AS duty_count FROM duties;
SELECT COUNT(*) AS donator_count FROM donators;
SELECT COUNT(*) AS donation_count FROM donations;

--Count how many animals are healthy.
SELECT COUNT(*) AS "Healthy Animal" FROM animals WHERE health='Healthy';

--Count the number of donations greater than $500.
SELECT COUNT(*) AS "Donation > 500" FROM donations WHERE amount>500;

--Count how many distinct species are present in the shelter.
SELECT COUNT(DISTINCT species) AS "distinct species count" FROM animals;

--Count the number of animals that have received at least one donation.
SELECT COUNT(DISTINCT animal_id) AS animals_with_donations FROM donations WHERE animal_id IS NOT NULL;

--Count the number of animals in each box,highlighting boxes with more than 5 animals.
SELECT box_id,COUNT(*) AS "animal count >5" FROM animals GROUP BY box_id HAVING COUNT(*) > 5;

--Calculate the total sum of donations
SELECT SUM(amount) AS total_donations FROM donations;
--Calculate total sum of donation for each animal
SELECT animal_id,SUM(amount) AS total_donations FROM donations GROUP BY animal_id;
--Determine the maximum capacity among all boxes.
SELECT MAX(max_capacity) AS "max box capacity" FROM boxes;
--Calculate the average current capacity utilization of boxes.
SELECT AVG(current_capacity) AS avg_animals_per_box FROM boxes;
SELECT 
    SUM(amount) AS total_donations,
    AVG(amount) AS average_donation,
    MIN(amount) AS smallest_donation,
    MAX(amount) AS largest_donation,
    COUNT(*) AS total_number_of_donations
FROM donations;
--Calculate the average amount of the largest donation received for each animal
WITH max_donation AS(
        SELECT animal_id,MAX(amount) AS largest_donation
        FROM donations
        GROUP BY animal_id
)
SELECT AVG(largest_donation) AS average_largest_donation FROM max_donation;

--Group By and Having
--Identify species with more than a certain number of animals
--based on a specified donation 
SELECT species,COUNT(*) AS num_animals FROM animals WHERE donation_status>0 GROUP BY species HAVING COUNT(*)>1;


--Set Membership(And,or,NOT)
-- Find animals that are 'Healthy' and have received donations
SELECT animal_name,health FROM animals WHERE health='Healthy' AND animal_id IN(SELECT animal_id FROM donations);
--Find animals that are either 'Mammals' or 'Birds'
SELECT animal_name,species FROM animals WHERE species='Mammals' OR species='Birds';
--Find all donations not made by a specific donator
SELECT donation_id,amount FROM donations WHERE donator_id NOT IN(SELECT donator_id FROM donators WHERE lastname='Khan');
--Find animals that are 'Healthy' and have received donations but are not 'Cats'
SELECT animal_name FROM animals WHERE  health='Healthy' AND animal_id IN(SELECT animal_id FROM donations) AND breed!='Cat';
SELECT animal_name FROM animals WHERE  health='Healthy' AND animal_id IN(SELECT animal_id FROM donations) AND breed NOT IN('Cat');
SELECT animal_name FROM animals WHERE breed NOT LIKE 'Cat';

--Some
--Find all donations that are greater than the avg donation made for any animal
SELECT * FROM donations where amount> SOME(SELECT AVG(amount) FROM donations GROUP BY animal_id);

--All
--Find the employees where salary is greater than all the min salary for each role
SELECT * FROM employees WHERE salary> ALL(SELECT MIN(salary) FROM employees GROUP BY roles);

--Not Exists
--Find all employees who have never been assigned any duties
SELECT * FROM employees WHERE NOT EXISTS (SELECT * FROM duties  WHERE emp_id=employees.emp_id);
--Exists
--Find all employees who have been assigned any duties
SELECT * FROM employees WHERE EXISTS (SELECT * FROM duties  WHERE emp_id=employees.emp_id);

--Unique
--Find the count of animals that have received donations
SELECT COUNT(DISTINCT animal_id) AS donated_animals FROM donations;


--String Operation
--Retrieve animals whose names start with 'B',followed by any 3 char,and then 'l'
SELECT * FROM animals WHERE animal_name LIKE 'B___l%';
--Find animals whose names start with "S"
SELECT * FROM animals WHERE animal_name LIKE 'S%';
--List animals whose names contain the substring "ir"
SELECT * FROM animals WHERE animal_name LIKE '%ir%';
--Find animals that joined in January 2023
SELECT * FROM animals WHERE joined_at BETWEEN TO_DATE('2023-01-01', 'YYYY-MM-DD') AND TO_DATE('2023-01-31', 'YYYY-MM-DD');
--Search for employees whose last name has "Khan" substr
SELECT * FROM employees WHERE lastname LIKE '%Khan%';
--Find donators whose firstname ends with m and has 5 letters
SELECT * FROM donators WHERE firstname LIKE '____m';
--Select donators whose first name starts with 'M', followed by any character,and then 'n'
SELECT * FROM donators WHERE firstname LIKE 'M_n%';

