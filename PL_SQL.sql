--Variable Declaration and Printing Value
SET SERVEROUTPUT ON;
DECLARE
    -- Boxes
    box_id boxes.box_id%TYPE;
    species boxes.species%TYPE;
    max_capacity boxes.max_capacity%TYPE;
    -- Animals
    animal_id animals.animal_id%TYPE;
    animal_name animals.animal_name%TYPE;
    -- Adoptions
    adoption_id adoptions.adoption_id%TYPE;
    adoption_date adoptions.adoption_date%TYPE;
    -- Employees
    emp_id employees.emp_id%TYPE;
    emp_name employees.firstname%TYPE;

BEGIN
    --Boxes
    SELECT box_id,species,max_capacity INTO box_id,species,max_capacity FROM boxes WHERE box_id=1;
    DBMS_OUTPUT.PUT_LINE('Box ID: '||box_id||' Species: '||species||' Max Capacity: '||max_capacity);
    --animals
    SELECT animal_id,animal_name INTO animal_id,animal_name FROM animals WHERE animal_id=1;
    DBMS_OUTPUT.PUT_LINE('Animal ID: '||animal_id||',Name: '||animal_name);
    
    --adoptions
    SELECT adoption_id,adoption_date INTO adoption_id,adoption_date FROM adoptions WHERE adoption_id=1;
    DBMS_OUTPUT.PUT_LINE('Adoption ID: '||adoption_id||',Adoption Date: '||adoption_date);
    
    --employees
    SELECT emp_id,firstname INTO emp_id,emp_name FROM employees WHERE emp_id=1;
    DBMS_OUTPUT.PUT_LINE('Employee ID: '||emp_id||',Name: '||emp_name);


END;
/


--Insertion with Default Value

SET SERVEROUTPUT ON;
DECLARE
BEGIN
    DELETE FROM owners WHERE owner_id=4;
    DELETE FROM adoptions WHERE adoption_id=4;
    DELETE FROM animals WHERE animal_id=11;
    DELETE FROM boxes WHERE box_id=7;
    DELETE FROM employees WHERE emp_id=11;
    INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (7,200,100,'Insects');
    INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (11,'Buzzy','Insects','Bee','Healthy',TO_DATE('2023-07-01','YYYY-MM-DD'),NULL,0,'Good','Active','Buzzes around',7);
    INSERT INTO adoptions (adoption_id,animal_id,adoption_date,descriptions) VALUES (4,5,TO_DATE('2023-04-15','YYYY-MM-DD'),'Adopted by a loving family');
    INSERT INTO owners (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at) VALUES (4,'Shayka','Islam','Khulna',4,TO_DATE('2023-04-25','YYYY-MM-DD'));
    INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (11,'Joya','Ahsan',28000,TO_DATE('2023-10-20','YYYY-MM-DD'),NULL,'Adoption Coordinator');


END;
/

--Row Type
SET SERVEROUTPUT ON;
DECLARE
    animal animals%ROWTYPE;
BEGIN
    SELECT * INTO animal FROM animals WHERE animal_id=1;
    DBMS_OUTPUT.PUT_LINE('Animal ID: '||animal.animal_id||' Name: '||animal.animal_name);
END;
/

--Cursor and Row Count
--1
DECLARE
  CURSOR c IS SELECT * FROM animals;
  animal animals%ROWTYPE;
BEGIN
    OPEN c;
    FETCH c INTO animal;
    WHILE c%FOUND LOOP
        DBMS_OUTPUT.PUT_LINE('Executed-->Animal ID: '||animal.animal_id||' Name: '||animal.animal_name);
        FETCH c INTO animal;
    END LOOP;
    CLOSE c;
END;
/
--2
SET SERVEROUTPUT ON;
DECLARE
    counter1 NUMBER:=0;
    counter2 NUMBER:=0;
    counter3 NUMBER:=0;
    
    CURSOR b IS SELECT * FROM boxes;
    CURSOR e IS SELECT * FROM employees;
    CURSOR d IS SELECT * FROM donations;
    
    box2 boxes%ROWTYPE;
    emp employees%ROWTYPE;
    don donations%ROWTYPE;
BEGIN
    OPEN b;
    FETCH b INTO box2;
    WHILE b%FOUND LOOP
        counter1:=counter1+1;
        DBMS_OUTPUT.PUT_LINE('Executed--> box id: '||box2.box_id||',species: '||box2.species||',row count: '||counter1); 
        FETCH b INTO box2;
    END LOOP;
    CLOSE b;
    
    OPEN e;
    FETCH e INTO emp;
    WHILE e%FOUND LOOP
        counter2:=counter2+1;
        DBMS_OUTPUT.PUT_LINE('Executed--> employee id: '||emp.emp_id||',name: '||emp.firstname||' '||emp.lastname||',row count: '||counter2); 
        FETCH e INTO emp;
    END LOOP;
    CLOSE e;
    
    OPEN d;
    FETCH d INTO don;
    WHILE d%FOUND LOOP
        counter3:=counter3+1;
        DBMS_OUTPUT.PUT_LINE('Executed--> donation id: '||don.donation_id||',amount: '||don.amount||',row count: '||counter3); 
        FETCH d INTO don;
    END LOOP;
    CLOSE d;
END;
/

-----------------------------------------------------------------
--                Procedure
----------------------------------------------------------------

--Procedure
--insert a box
CREATE OR REPLACE PROCEDURE insert_box(
    box_id boxes.box_id%TYPE,
    max_capacity boxes.max_capacity%TYPE,
    current_capacity boxes.current_capacity%TYPE,
    species boxes.species%TYPE
) AS
BEGIN
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (box_id,max_capacity,current_capacity,species);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into boxes: ');
END;
/

--Procedure
--animals insertion
CREATE OR REPLACE PROCEDURE insert_animal(animal IN animals%ROWTYPE)
AS
BEGIN
    INSERT INTO animals VALUES animal;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed ');
        
END;
/
--Procedure
--insert into adoptions
CREATE OR REPLACE PROCEDURE insert_adoption(
    adoption_id adoptions.adoption_id%TYPE,
    animal_id adoptions.animal_id%TYPE,
    adoption_date adoptions.adoption_date%TYPE,
    descriptions adoptions.descriptions%TYPE
) AS
BEGIN
INSERT INTO adoptions (adoption_id,animal_id,adoption_date,descriptions) VALUES (adoption_id,animal_id,adoption_date,descriptions);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into adoptions');
END;
/

--Procedure
--insert Owners
CREATE OR REPLACE PROCEDURE insert_owner(
    owner_id owners.owner_id%TYPE,
    firstname owners.firstname%TYPE,
    lastname owners.lastname%TYPE,
    owner_address owners.owner_address%TYPE,
    adoption_id owners.adoption_id%TYPE,
    adopted_at owners.adopted_at%TYPE
) AS
BEGIN
INSERT INTO owners (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at) VALUES (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into owners');
END;
/
--Procedure
--insert into employees
CREATE OR REPLACE PROCEDURE insert_employee(
    emp_id employees.emp_id%TYPE,
    firstname employees.firstname%TYPE,
    lastname employees.lastname%TYPE,
    salary employees.salary%TYPE,
    joined_at employees.joined_at%TYPE,
    left_at employees.left_at%TYPE,
    roles employees.roles%TYPE
) AS
BEGIN
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (emp_id,firstname,lastname,salary,joined_at,left_at,roles);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into employees');
END;
/
--Procedure
--insert into duties
CREATE OR REPLACE PROCEDURE insert_duty(
    duty_id duties.duty_id%TYPE,
    emp_id duties.emp_id%TYPE,
    box_id duties.box_id%TYPE,
    weekdays duties.weekdays%TYPE,
    start_at duties.start_at%TYPE,
    end_at duties.end_at%TYPE,
    responsibilities duties.responsibilities%TYPE
) AS
BEGIN
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into duties');
END;
/
-- Procedure
--insert into donators
CREATE OR REPLACE PROCEDURE insert_donator(
    donator_id donators.donator_id%TYPE,
    firstname donators.firstname%TYPE,
    lastname donators.lastname%TYPE,
    donator_address donators.donator_address%TYPE,
    total_donations donators.total_donations%TYPE
) AS
BEGIN
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (donator_id,firstname,lastname,donator_address,total_donations);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into donators');
END;
/
--Procedure
--insert into donations
CREATE OR REPLACE PROCEDURE insert_donation(
    donation_id donations.donation_id%TYPE,
    donator_id donations.donator_id%TYPE,
    animal_id donations.animal_id%TYPE,
    amount donations.amount%TYPE,
    date_of_donation donations.date_of_donation%TYPE
) AS
BEGIN
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (donation_id,donator_id,animal_id,amount,date_of_donation);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Insert failed into donations');
END;
/



--Delete record Procedure
-- Procedure to delete from boxes
CREATE OR REPLACE PROCEDURE delete_box(id IN boxes.box_id%TYPE)
AS
BEGIN
    DELETE FROM boxes WHERE box_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from boxes');
END;
/

-- Procedure to delete from animals
CREATE OR REPLACE PROCEDURE delete_animal(id IN animals.animal_id%TYPE)
AS
BEGIN
    DELETE FROM animals WHERE animal_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from animals');
END;
/

-- Procedure to delete from adoptions
CREATE OR REPLACE PROCEDURE delete_adoption(id IN adoptions.adoption_id%TYPE)
AS
BEGIN
    DELETE FROM adoptions WHERE adoption_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from adoptions');
END;
/

-- Procedure to delete from owners
CREATE OR REPLACE PROCEDURE delete_owner(id IN owners.owner_id%TYPE)
AS
BEGIN
    DELETE FROM owners WHERE owner_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from owners');
END;
/

-- Procedure to delete from employees
CREATE OR REPLACE PROCEDURE delete_employee(id IN employees.emp_id%TYPE)
AS
BEGIN
    DELETE FROM employees WHERE emp_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from employees');
END;
/

-- Procedure to delete from duties
CREATE OR REPLACE PROCEDURE delete_duty(id IN duties.duty_id%TYPE)
AS
BEGIN
    DELETE FROM duties WHERE duty_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from duties');
END;
/

-- Procedure to delete from donators
CREATE OR REPLACE PROCEDURE delete_donator(id IN donators.donator_id%TYPE)
AS
BEGIN
    DELETE FROM donators WHERE donator_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from donators');
END;
/

-- Procedure to delete from donations
CREATE OR REPLACE PROCEDURE delete_donation(id IN donations.donation_id%TYPE)
AS
BEGIN
    DELETE FROM donations WHERE donation_id=id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Delete failed from donations');
END;
/




----------------------------------------------------------------
--                        Function
---------------------------------------------------------------
--Box Print
CREATE OR REPLACE FUNCTION print_box(id IN boxes.box_id%TYPE) 
RETURN VARCHAR2 AS
    b boxes%ROWTYPE;
BEGIN
    SELECT * INTO b FROM boxes WHERE box_id=id;
    DBMS_OUTPUT.PUT_LINE('Box ID: '||b.box_id||',Max Capacity: '||b.max_capacity||',Current Capacity: '||b.current_capacity||',Species: '||b.species);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such box found with ID '||id);
        RETURN 'box record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving box record';
END;
/
--Animal print 
CREATE OR REPLACE FUNCTION print_animal(id IN animals.animal_id%TYPE) 
RETURN VARCHAR2 AS s animals%ROWTYPE;
BEGIN
        SELECT * INTO s FROM animals WHERE animal_id=id;
        DBMS_OUTPUT.PUT_LINE('Animal ID: '||s.animal_id||',Name: '||s.animal_name||',Species: '||s.species);
        RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such animal found with ID '||id);
        RETURN 'animal record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving animal record';
END;
/
--Adoption
CREATE OR REPLACE FUNCTION print_adoption(id IN adoptions.adoption_id%TYPE) 
RETURN VARCHAR2 AS
    a adoptions%ROWTYPE;
BEGIN
    SELECT * INTO a FROM adoptions WHERE adoption_id=id;
    DBMS_OUTPUT.PUT_LINE('Adoption ID: '||a.adoption_id||',Animal ID: '||a.animal_id||',Adoption Date: '||a.adoption_date||',Descriptions: '||a.descriptions);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such adoption found with ID '||id);
        RETURN 'adoption record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving adoption record';
END;
/
--Owner
CREATE OR REPLACE FUNCTION print_owner(id IN owners.owner_id%TYPE) 
RETURN VARCHAR2 AS
    o owners%ROWTYPE;
BEGIN
    SELECT * INTO o FROM owners WHERE owner_id=id;
    DBMS_OUTPUT.PUT_LINE('Owner ID: '||o.owner_id||',Firstname: '||o.firstname||',Lastname: '||o.lastname||',Address: '||o.owner_address||',Adoption ID: '||o.adoption_id);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such owner found with ID '||id);
        RETURN 'owner record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving owner record';
END;
/
--Employees
CREATE OR REPLACE FUNCTION print_employee(id IN employees.emp_id%TYPE) 
RETURN VARCHAR2 AS
    e employees%ROWTYPE;
BEGIN
    SELECT * INTO e FROM employees WHERE emp_id=id;
    DBMS_OUTPUT.PUT_LINE('Employee ID: '||e.emp_id||',Name: '||e.firstname||' '||e.lastname||',Salary: '||e.salary);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such employee found with ID '||id);
        RETURN 'employee record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving employee record';
END;
/
--Duty
CREATE OR REPLACE FUNCTION print_duty(id IN duties.duty_id%TYPE) 
RETURN VARCHAR2 AS
    d duties%ROWTYPE;
BEGIN
    SELECT * INTO d FROM duties WHERE duty_id=id;
    DBMS_OUTPUT.PUT_LINE('Duty ID: '||d.duty_id||',Employee ID: '||d.emp_id||',Box ID: '||d.box_id||',Weekday: '||d.weekdays);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such duty found with ID '||id);
        RETURN 'duty record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving duty record';
END;
/

--Donator
CREATE OR REPLACE FUNCTION print_donator(id IN donators.donator_id%TYPE) 
RETURN VARCHAR2 AS
    d donators%ROWTYPE;
BEGIN
    SELECT * INTO d FROM donators WHERE donator_id=id;
    DBMS_OUTPUT.PUT_LINE('Donator ID: '||d.donator_id||',Name: '||d.firstname||' '||d.lastname||',Address: '||d.donator_address);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such donator found with ID '||id);
        RETURN 'donator record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving donator record';
END;
/

--Donation
CREATE OR REPLACE FUNCTION print_donation(id IN donations.donation_id%TYPE) 
RETURN VARCHAR2 AS
    d donations%ROWTYPE;
BEGIN
    SELECT * INTO d FROM donations WHERE donation_id=id;
    DBMS_OUTPUT.PUT_LINE('Donation ID: '||d.donation_id||',Donator ID: '||d.donator_id||',Animal ID: '||d.animal_id||',Amount: '||d.amount||',Date of Donation: '||d.date_of_donation);
    RETURN 'printed successfully';
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No such donation found with ID '||id);
        RETURN 'donation record not found';
    WHEN OTHERS THEN
        RETURN 'Error retrieving donation record';
END;
/


--Functions total present animals in a specific box
--adopted animals are not included
CREATE OR REPLACE FUNCTION animal_cnt_box(id boxes.box_id%TYPE) 
RETURN NUMBER AS
    max_cap NUMBER;
    current NUMBER;
    net NUMBER;
BEGIN
    SELECT current_capacity INTO current FROM boxes WHERE box_id=id;
    SELECT max_capacity INTO max_cap FROM boxes WHERE box_id=id;

    net:=max_cap-current;
    RETURN net;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/


--------------------------------------------------------------------------------
--                       apply func,trigger & proc

--------------------------------------------------------------------------------

--use procedure for insertion into animals  table
SET SERVEROUTPUT ON;
DECLARE
    animal animals%ROWTYPE;
    result VARCHAR2(200);
    cnt_box_animal NUMBER;
BEGIN
    animal.animal_id:=12;
    animal.animal_name:='Toothless';
    animal.species:='Mammals';
    animal.breed:='Cat';
    animal.animal_status:='Healthy';
    animal.joined_at:=TO_DATE('2023-01-01','YYYY-MM-DD');
    animal.left_at:=NULL;
    animal.donation_status:=0;
    animal.health:='Good';
    animal.behaviour:='Calm';
    animal.descriptions:='Calm and friendly';
    animal.box_id:=1;
    insert_animal(animal);
    delete_animal(animal.animal_id);
    -- print_box(1);
    -- print_animal(1);
    -- print_adoption(1);
    -- print_duty(1);
    -- print_donator(1);
    -- print_donation(1);

 --    print_box(1);
 --This is wrong for function we must declare a var
--otherwise it wiLL BE CONSIDERED AS PROC
    
    result:=print_box(1);
    result:=print_animal(1);
    result:=print_adoption(1);
    result:=print_owner(1);
    result:=print_duty(1);
    result:=print_donator(1);   
    result:=print_donation(1);
    result:=print_employee(1);
    cnt_box_animal:=animal_cnt_box(2);
    DBMS_OUTPUT.PUT_LINE(cnt_box_animal);
    
END;
/


