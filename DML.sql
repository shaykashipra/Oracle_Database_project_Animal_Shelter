--Data Insertion

INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (1,130,130,'Mammals');
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (2,130,130,'Reptiles');
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (3,30,30,'Amphibians');
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (4,25,25,'Marine');
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (5,200,200,'Birds'); 
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (6,150,150,'Fishes');


INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (1,'Simba','Mammals','Lion','Healthy',TO_DATE('2023-01-01','YYYY-MM-DD'),NULL,0,'Good','Calm','Friendly and calm.',1);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (2,'Surovi','Reptiles','Cobra','Healthy',TO_DATE('2023-02-01','YYYY-MM-DD'),NULL,0,'Good','Aggressive','Needs careful handling.',2);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (3,'Pani','Amphibians','Frog','Healthy',TO_DATE('2023-03-01','YYYY-MM-DD'),NULL,0,'Good','Calm','Loves to jump around.',3);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (4,'Machh','Marine','Goldfish','Healthy',TO_DATE('2023-04-01','YYYY-MM-DD'),NULL,0,'Good','Peaceful','Enjoys swimming.',4);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (5,'Pakhi','Birds','Parrot','Healthy',TO_DATE('2023-05-01','YYYY-MM-DD'),NULL,0,'Good','Chatty','Loves to mimic sounds.',5);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (6,'Bulbuli','Fishes','Clownfish','Healthy',TO_DATE('2023-06-01','YYYY-MM-DD'),NULL,0,'Good','Active','Very playful.',6);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (7,'Biral','Mammals','Cat','Healthy',TO_DATE('2023-07-01','YYYY-MM-DD'),NULL,0,'Good','Playful','Loves attention.',1);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (8,'Sap','Reptiles','Python','Healthy',TO_DATE('2023-08-01','YYYY-MM-DD'),NULL,0,'Good','Calm','Requires large space.',2);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (9,'Dhopa','Amphibians','Toad','Healthy',TO_DATE('2023-09-01','YYYY-MM-DD'),NULL,0,'Good','Calm','Prefers moist environment.',3);
INSERT INTO animals (animal_id,animal_name,species,breed,animal_status,joined_at,left_at,donation_status,health,behaviour,descriptions,box_id) VALUES (10,'Neela','Marine','Blue Tang','Healthy',TO_DATE('2023-10-01','YYYY-MM-DD'),NULL,0,'Good','Forgetful','Friendly with other fish.',4);


INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (1,'Amina','Rahman',25000,TO_DATE('2022-01-05','YYYY-MM-DD'),NULL,'Helper');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (2,'Bilal','Hossain',26000,TO_DATE('2022-02-10','YYYY-MM-DD'),NULL,'Trainer');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (3,'Charu','Sinha',22000,TO_DATE('2022-03-15','YYYY-MM-DD'),NULL,'Feeder');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (4,'Dipu','Roy',22000,TO_DATE('2022-04-20','YYYY-MM-DD'),NULL,'Cleaner');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (5,'Esha','Khan',27000,TO_DATE('2022-05-25','YYYY-MM-DD'),TO_DATE('2023-01-15','YYYY-MM-DD'),'Rescuer');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (6,'Fahim','Ahmed',25000,TO_DATE('2022-06-30','YYYY-MM-DD'),NULL,'Driver');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (7,'Gita','Chowdhury',24000,TO_DATE('2022-07-05','YYYY-MM-DD'),NULL,'Groomer');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (8,'Hasan','Majumdar',26000,TO_DATE('2022-08-10','YYYY-MM-DD'),NULL,'Admin');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (9,'Iqbal','Sheikh',28000,TO_DATE('2022-09-15','YYYY-MM-DD'),TO_DATE('2023-03-10','YYYY-MM-DD'),'Vet Tech'); 
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at,left_at,roles) VALUES (10,'Joya','Islam',27000,TO_DATE('2022-10-20','YYYY-MM-DD'),NULL,'Adoption Coordinator');



INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (1,1,1,1,TO_TIMESTAMP('09:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('05:00:00 PM','HH12:MI:SS PM'),'Feeding and Cleaning');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (2,2,2,2,TO_TIMESTAMP('08:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('04:00:00 PM','HH12:MI:SS PM'),'Medical Checkup');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (3,3,3,3,TO_TIMESTAMP('10:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('06:00:00 PM','HH12:MI:SS PM'),'Training Sessions');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (4,4,4,4,TO_TIMESTAMP('07:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('03:00:00 PM','HH12:MI:SS PM'),'General Care');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (5,5,5,5,TO_TIMESTAMP('09:30:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('05:30:00 PM','HH12:MI:SS PM'),'Adoption Facilitation');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (6,6,6,1,TO_TIMESTAMP('08:30:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('04:30:00 PM','HH12:MI:SS PM'),'Emergency Response');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (7,7,1,2,TO_TIMESTAMP('11:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('07:00:00 PM','HH12:MI:SS PM'),'Grooming');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (8,8,2,3,TO_TIMESTAMP('06:00:00 AM','HH12:MI:SS AM'),TO_TIMESTAMP('02:00:00 PM','HH12:MI:SS PM'),'Facility Maintenance');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (9,9,3,4,TO_TIMESTAMP('12:00:00 PM','HH12:MI:SS PM'),TO_TIMESTAMP('08:00:00 PM','HH12:MI:SS PM'),'Diet Planning');
INSERT INTO duties (duty_id,emp_id,box_id,weekdays,start_at,end_at,responsibilities) VALUES (10,10,4,5,TO_TIMESTAMP('01:00:00 PM','HH12:MI:SS PM'),TO_TIMESTAMP('09:00:00 PM','HH12:MI:SS PM'),'Health Monitoring');


INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (1,'Rahim','Ali','Dhaka',1000);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (2,'Karim','Hossain','Chittagong',1500);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (3,'Mina','Khatun','Rajshahi',800);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (4,'Asif','Rahman','Khulna',1200);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (5,'Sara','Khan','Sylhet',500);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (6,'Joy','Barua','Barisal',700);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (7,'Lima','Khan','Comilla',950);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (8,'Tina','Chowdhury','Mymensingh',1100);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (9,'Raju','Ahmed','Bogra',600);
INSERT INTO donators (donator_id,firstname,lastname,donator_address,total_donations) VALUES (10,'Nipa','Sultana','Coxs Bazar',1300);



INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (1,3,3,150,TO_DATE('2023-10-03','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (2,4,4,300,TO_DATE('2023-10-04','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (3,5,5,100,TO_DATE('2023-10-05','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (4,6,6,180,TO_DATE('2023-10-06','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (5,7,7,220,TO_DATE('2023-10-07','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (6,8,8,275,TO_DATE('2023-10-08','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (7,9,9,160,TO_DATE('2023-10-09','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (8,10,10,310,TO_DATE('2023-10-10','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (9,1,NULL,400,TO_DATE('2023-05-15','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (10,2,NULL,250,TO_DATE('2023-06-20','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (11,1,NULL,250,TO_DATE('2023-01-15','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (12,1,1,300,TO_DATE('2023-03-20','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (13,2,7,200,TO_DATE('2023-02-25','YYYY-MM-DD'));
INSERT INTO donations (donation_id,donator_id,animal_id,amount,date_of_donation) VALUES (14,2,3,350,TO_DATE('2023-04-10','YYYY-MM-DD'));

INSERT INTO adoptions (adoption_id,animal_id,adoption_date,descriptions) VALUES (1,1,TO_DATE('2023-04-15','YYYY-MM-DD'),'Adopted by a loving family.');
INSERT INTO adoptions (adoption_id,animal_id,adoption_date,descriptions) VALUES (2,5,TO_DATE('2023-04-20','YYYY-MM-DD'),'Adopted by an individual with a large yard.');
INSERT INTO adoptions (adoption_id,animal_id,adoption_date,descriptions) VALUES (3,7,TO_DATE('2023-04-25','YYYY-MM-DD'),'Adopted by a cat enthusiast.');

INSERT INTO owners (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at) VALUES (1,'Rahim','Khan','Dhaka',1,TO_DATE('2023-04-15','YYYY-MM-DD'));
INSERT INTO owners (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at) VALUES (2,'Anika','Bose','Chittagong',2,TO_DATE('2023-04-20','YYYY-MM-DD'));
INSERT INTO owners (owner_id,firstname,lastname,owner_address,adoption_id,adopted_at) VALUES (3,'Samiul','Islam','Sylhet',3,TO_DATE('2023-04-25','YYYY-MM-DD'));


--constraint error
INSERT INTO boxes (box_id,max_capacity,current_capacity,species) VALUES (7,100,150,'Birds');
INSERT INTO animals (animal_id,animal_name,species,joined_at,left_at,box_id,health,animal_status) VALUES (11,'Flash','Turtle',TO_DATE('2023-03-01','YYYY-MM-DD'),TO_DATE('2023-01-01','YYYY-MM-DD'),1,'Good','Healthy');
INSERT INTO employees (emp_id,firstname,lastname,salary,joined_at) VALUES (11,'Shayka','Islam',-100,TO_DATE('2023-01-01','YYYY-MM-DD'));
INSERT INTO animals (animal_id,animal_name,breed,joined_at,box_id,health,statuses) VALUES (12,'Zippy','Zebra',TO_DATE('2023-02-01','YYYY-MM-DD'),1,'Extremely Good','Healthy');




































































































































































































