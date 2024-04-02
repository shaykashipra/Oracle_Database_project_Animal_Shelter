--Update operation
UPDATE employees SET roles='Senior Caregiver' WHERE emp_id=2;
UPDATE owners SET owner_address='Fulbarigate Street' WHERE owner_id=3;
UPDATE donations SET amount=2000 WHERE donation_id=5;
UPDATE boxes SET max_capacity=140 WHERE box_id=1;
UPDATE animals SET box_id=(SELECT box_id FROM boxes WHERE species='Fishes') WHERE box_id=6;


--delete operation
--delete adopted animals from animals table
DELETE FROM animals WHERE animal_id IN ( SELECT animal_id FROM adoptions);
--delete empty box from boxes
DELETE FROM boxes WHERE box_id NOT IN (SELECT DISTINCT box_id FROM animals);
--delete donators with no donation 
DELETE FROM donators WHERE donator_id NOT IN (SELECT DISTINCT donator_id FROM donations);

