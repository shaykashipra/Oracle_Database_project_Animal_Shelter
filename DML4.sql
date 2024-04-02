--Join operations 
--Natural Join
--based on common column of both tables
SELECT * FROM employees NATURAL JOIN duties;
--Inner Join or JOIN
SELECT a.animal_name,a.species,ad.descriptions AS adoption_description,o.firstname||' '||o.lastname AS owner_name
FROM animals a
INNER JOIN adoptions ad ON a.animal_id = ad.animal_id
INNER JOIN owners o ON ad.adoption_id = o.adoption_id;
--Left Join
SELECT a.animal_name,a.species,ad.descriptions AS adoption_description
FROM animals a
LEFT JOIN adoptions ad ON a.animal_id = ad.animal_id;
--Right Join
--all boxes and their contained animals. If some boxes have no animals assigned to them
SELECT b.box_id,b.species AS box_species,a.animal_name
FROM boxes b
RIGHT JOIN animals a ON b.box_id = a.box_id;
--Full Join
--all animals and their adoption status, including animals that haven't been adopted and adoption records without a current animal match
SELECT a.animal_name,ad.adoption_date,ad.descriptions
FROM animals a
FULL JOIN adoptions ad ON a.animal_id = ad.animal_id;



--View 
DROP VIEW view_animal_boxes;
DROP VIEW view_adoption_details;
DROP VIEW view_employee_duties;

--create view

--View of All Animals and Their Box Details
CREATE VIEW view_animal_boxes AS
SELECT a.animal_id, a.animal_name, a.species, b.box_id, b.species AS box_species
FROM animals a
JOIN boxes b ON a.box_id = b.box_id;

--View of Adoptions with Animal and Owner Details
CREATE VIEW view_adoption_details AS
SELECT ad.adoption_id, ad.animal_id, a.animal_name, o.firstname, o.lastname, ad.adoption_date, ad.descriptions
FROM adoptions ad
JOIN animals a ON ad.animal_id = a.animal_id
JOIN owners o ON ad.adoption_id = o.adoption_id;

--View of Employees, Their Duties, and Box Assignments
CREATE VIEW view_employee_duties AS
SELECT e.emp_id, e.firstname, e.lastname, d.weekdays, d.start_at, d.end_at, d.responsibilities, d.box_id
FROM employees e
JOIN duties d ON e.emp_id = d.emp_id;

--Operations on Views
SELECT * FROM view_animal_boxes;
UPDATE view_animal_boxes SET animal_name = 'Leo' WHERE animal_id = 1;


SELECT * FROM view_animal_boxes;
SELECT * FROM view_adoption_details;
SELECT * FROM view_employee_duties;


--Cascading Actions in Referential Integrity
--box_id=1 -> mammals including 'Simba' and 'Biral'
DELETE FROM boxes WHERE box_id = 1; --adopted animals wont be deleted 



