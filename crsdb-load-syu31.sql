--1 member
INSERT INTO league_member
VALUES (100010,'Neal','Lee');

INSERT INTO league_member
VALUES (100011,'Shujing','Yu');

INSERT INTO league_member
VALUES (100012,'Rachel','Mayer');

INSERT INTO league_member
VALUES (100013,'Jessie','Bryant');

INSERT INTO league_member
VALUES (100014,'Monica','Marks');

INSERT INTO league_member
VALUES (100015,'Aaron','Luo');

--2 penalty
INSERT INTO penalty
VALUES (2000001, 100010,'2016-02-01', DATE'2016-02-01'+INTEGER'42');

INSERT INTO penalty
VALUES (2000002, 100014,'2016-01-18', DATE'2016-01-18'+INTEGER'42');

INSERT INTO penalty
VALUES (2000003, 100011,'2016-01-19', DATE'2016-01-19'+INTEGER'42');

INSERT INTO penalty
VALUES (2000004, 100011,'2016-03-12', DATE'2016-03-12'+INTEGER'42');

INSERT INTO penalty
VALUES (2000005, 100010,'2016-04-11', DATE'2016-04-11'+INTEGER'42');

INSERT INTO penalty
VALUES (2000006, 100010,'2016-04-11', DATE'2016-04-11'+INTEGER'42');

--3 court
INSERT INTO court
VALUES (1, 'EAST');

INSERT INTO court
VALUES (2, 'WEST');

INSERT INTO court
VALUES (3, 'NORTH');

INSERT INTO court
VALUES (4, 'SOUTH');


--4 reservation
INSERT INTO reservation
VALUES (30000011,100010, '2016-02-01', '20:00','2016-01-28','Dropped',1);

INSERT INTO reservation
VALUES (30000012,100010, '2016-04-15', '10:00','2016-04-10','Confirmed',4);  

INSERT INTO reservation
VALUES (30000013,100015, '2016-04-15', '11:00','2016-04-10','Confirmed',4);  

INSERT INTO reservation
VALUES (30000014,100011, '2016-04-15', '23:00','2016-04-10','Pending',1); 

INSERT INTO reservation
VALUES (30000015,100011, '2016-04-16', '13:00','2016-04-11','Pending',2);  

INSERT INTO reservation
VALUES (30000016,100014, '2016-04-21', '16:00','2016-04-15','Pending',3); 

INSERT INTO reservation
VALUES (30000017,100011, '2016-04-20', '16:00','2016-04-15','Pending',3);  

INSERT INTO reservation
VALUES (30000018,100012, '2016-04-18', '19:00','2016-04-15','Pending',4);  

INSERT INTO reservation
VALUES (30000019,100011, '2016-04-20', '17:00','2016-04-15','Pending',2);  






