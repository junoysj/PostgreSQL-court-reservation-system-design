--3a
select Member_ID, Play_Hour, Court_ID, Check_Status
from reservation
where Play_Date= CURRENT_DATE;

--3b  m: Shujing Yu   
select Member_ID, Reservation_ID, Play_Date, Play_Hour, Court_ID, Check_Status
from (select Member_ID from league_member where FName='Shujing' AND LName='Yu')as s natural join reservation
where Play_Date between CURRENT_DATE AND CURRENT_DATE+7;

select count(*) as current_penalty_points
from (select Member_ID from league_member where FName='Shujing' AND LName='Yu')as a natural join penalty;

--3c
--n+p>7 (p=2, n=7)
INSERT INTO reservation
VALUES (30000020,100011, '2016-04-22', '16:00','2016-04-15','Pending',4);
--n+p<=7 (p=2,n=3)
INSERT INTO reservation
VALUES (30000021,100011, '2016-04-18', '16:00','2016-04-15','Pending',4);

--3d  confirm m's next reservation
UPDATE reservation
SET Check_Status='Confirmed'
WHERE Reservation_ID=30000014; 


--3e  cancel one of m's upcoming reservations
UPDATE reservation
SET Check_Status='Canceled'
WHERE Reservation_ID=30000019; 


--3f
select Member_ID, Reservation_ID, Play_Date, Play_Hour, Court_ID, Check_Status
from (select Member_ID from league_member where FName='Shujing' AND LName='Yu')as s natural join reservation
where Play_Date between CURRENT_DATE AND CURRENT_DATE+7;


--3g
--a. cancel the reservation after the hour
UPDATE reservation
SET Check_Status='Canceled'
WHERE Reservation_ID=30000011;


--b. make a new reservation whose timeslot and court ID are same as an existing reservation
INSERT INTO reservation
VALUES (30000025,100015, '2016-04-18', '19:00','2016-04-14','Pending',4);  



































