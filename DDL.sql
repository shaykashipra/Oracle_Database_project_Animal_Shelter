DROP TABLE donations;
DROP TABLE donators;
DROP TABLE duties;
DROP TABLE employees;
DROP TABLE owners;
DROP TABLE adoptions;
DROP TABLE animals;
DROP TABLE boxes;

CREATE TABLE boxes (
    box_id NUMBER PRIMARY KEY,
    max_capacity NUMBER CHECK (max_capacity>0),
    current_capacity NUMBER,
    species VARCHAR2(20),
    CONSTRAINT capacity_check CHECK (current_capacity<=max_capacity AND current_capacity>=0)
);
CREATE TABLE animals (
    animal_id NUMBER PRIMARY KEY,
    animal_name VARCHAR2(20),
    species VARCHAR2(20),
    statuses VARCHAR2(30) CHECK (statuses IN ('Healthy', 'Sick', 'Pending') OR statuses IS NULL),
    joined_at DATE NOT NULL,
    left_at DATE,
    health varchar2(30) CHECK (health IN ('Good', 'Needs Attention')),
    box_id NUMBER,
    FOREIGN KEY (box_id) REFERENCES boxes(box_id) ON DELETE CASCADE,
    CONSTRAINT check_animal_conditions CHECK (
        (statuses='Healthy' AND health='Good') OR
        (left_at IS NULL OR left_at>joined_at)
    )
);

CREATE TABLE adoptions (
    adoption_id number PRIMARY KEY,
    animal_id NUMBER,
    adoption_date date,
    descriptions varchar2(100),
    FOREIGN KEY (animal_id) REFERENCES animals(animal_id) ON DELETE CASCADE
);

CREATE TABLE owners (
   owner_id NUMBER primary key,
   firstname VARCHAR2(50),
   lastname VARCHAR2(50),
   address VARCHAR2(100),
   adoption_id NUMBER,
    FOREIGN KEY (adoption_id ) REFERENCES adoptions(adoption_id) ON DELETE CASCADE,
    adopted_at  date
);
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    firstname VARCHAR2(20),
    lastname VARCHAR2(20),
    salary NUMBER CHECK (salary>0),
    joined_at DATE,
    left_at DATE,
    CONSTRAINT check_employee_dates CHECK (left_at IS NULL OR joined_at < left_at)
);


CREATE TABLE duties (
    duty_id NUMBER PRIMARY KEY,
    emp_id NUMBER,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    box_id number,
    FOREIGN KEY (box_id) REFERENCES boxes(box_id) ON DELETE CASCADE,
    weekday number,
    start_at NUMBER, 
    end_at NUMBER,
    responsibilities varchar2(100)
);


CREATE TABLE donators (
    donator_id number PRIMARY KEY,
    firstname varchar2(20),
    lastname varchar2(20),
    address varchar2(50)
);


CREATE TABLE donations (
    donation_id NUMBER PRIMARY KEY,
    donator_id NUMBER,
    FOREIGN KEY (donator_id) REFERENCES donators(donator_id) ON DELETE CASCADE,
    animal_id number,
    FOREIGN KEY (animal_id)  REFERENCES animals(animal_id) ON DELETE CASCADE,
    amount NUMBER CHECK (amount>0),
    date_of_donation date
);



-- Add Column 

alter table animals add  breed varchar2(30) NOT NULL;
alter table animals add  donation_status NUMBER DEFAULT 0 CHECK (donation_status IN (-1,0, 1));
alter table animals add  behaviour varchar2(100);
alter table animals add  descriptions varchar2(100);
alter table animals add  picture blob;

alter table employees add roles VARCHAR2(100);

alter table donators add total_donations number CHECK (total_donations>=0);

--Modify Column Definition
alter table duties modify start_at TIMESTAMP;
alter table duties modify end_at TIMESTAMP;

--Rename the column 
alter table animals rename column statuses to animal_status;

alter table duties rename column weekday to weekdays;

alter table owners rename column address to owner_address;

alter table donators rename column address to donator_address;

--delete column 
alter table animals drop column picture;

--Add constraint
ALTER TABLE duties ADD CONSTRAINT check_dates CHECK (end_at IS NULL OR end_at>start_at);


-----------------------------------------------------------------
--                       Trigger
------------------------------------------------------------------

-- --trigger after animal is inserted 
-- CREATE OR REPLACE TRIGGER trigger_after_animal_inserted
-- AFTER INSERT ON animals
-- REFERENCING OLD as o NEW AS n
-- FOR EACH ROW
-- BEGIN
--     UPDATE boxes b SET b.current_capacity=b.current_capacity-1 WHERE b.box_id=:n.box_id;
-- END;
-- /


-- Trigger to increase box capacity after an animal is deleted
CREATE OR REPLACE TRIGGER trigger_after_animal_deleted
AFTER DELETE ON animals
REFERENCING OLD AS o
FOR EACH ROW
BEGIN
    UPDATE boxes SET current_capacity=current_capacity+1
    WHERE box_id=:o.box_id;
END;
/
--trigger after adoptions donaation status box capacity
CREATE OR REPLACE TRIGGER trigger_after_animal_adopted
AFTER INSERT ON adoptions
REFERENCING OLD as o NEW AS n
FOR EACH ROW
BEGIN
    UPDATE animals SET donation_status=-1 WHERE animal_id=:n.animal_id;
    UPDATE boxes b SET b.current_capacity=b.current_capacity+1
    WHERE b.box_id=(SELECT a.box_id FROM animals a WHERE a.animal_id=:n.animal_id);
END;
/

--before animal insertion check box has capacity or not
--and if has capacity then insert and decrease
CREATE OR REPLACE TRIGGER trg_before_animal_insert
BEFORE INSERT ON animals
REFERENCING OLD as o NEW AS n
FOR EACH ROW
DECLARE
    current_capacity NUMBER;
    box_species VARCHAR2(20);
BEGIN
    SELECT current_capacity,species INTO current_capacity,box_species
    FROM boxes
    WHERE box_id=:n.box_id;

    IF current_capacity=0 THEN
        RAISE_APPLICATION_ERROR(-20001,'the box is full,create a box record 1st');
    ELSE
        UPDATE boxes b SET b.current_capacity=b.current_capacity-1 WHERE b.box_id=:n.box_id;
    END IF;

    IF NOT(box_species=:n.species OR box_species='Others') THEN
        RAISE_APPLICATION_ERROR(-20002,'Place in Correct Box');
    END IF;
END;
/

--donation cant be done if an animal is adopted 
CREATE OR REPLACE TRIGGER trigger_before_donation_insert
BEFORE INSERT ON donations
REFERENCING OLD as o NEW AS n
FOR EACH ROW
DECLARE
    don_status NUMBER;
BEGIN
IF :n.animal_id IS NOT NULL THEN
    SELECT donation_status INTO don_status FROM animals WHERE animal_id=:n.animal_id;
    IF don_status=-1 THEN
     RAISE_APPLICATION_ERROR(-20003,'This animal has already been adopted and cannot receive further donations');
    END IF;
END IF;
END;
/

--adopted animals cant be deleted
CREATE OR REPLACE TRIGGER trg_before_animal_delete
BEFORE DELETE ON animals
REFERENCING OLD AS o NEW AS n
FOR EACH ROW

BEGIN 
    
    IF :o.donation_status=-1 THEN
        RAISE_APPLICATION_ERROR(-20004,'Cannot delete an adopted animal');
    END IF;
END;
/

--after each donation amount donator total donation amount increased
CREATE OR REPLACE TRIGGER trg_after_insert_donation
AFTER INSERT ON donations
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
BEGIN
    UPDATE donators SET total_donations=total_donations+:n.amount
    WHERE donator_id=:n.donator_id;
END;
/

--after donation donation status of animal must be changed
CREATE OR REPLACE TRIGGER trg_after_donation_insert
AFTER INSERT ON donations
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
BEGIN
IF :n.animal_id IS NOT NULL THEN
    UPDATE animals
    SET donation_status=1
    WHERE animal_id=:n.animal_id;
    END IF;
END;
/