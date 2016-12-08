-- TCS 461  Name:Shujing Yu  NetID: syu31
-- court reservation system

-- League Member
DROP TABLE IF EXISTS league_member CASCADE;

CREATE TABLE league_member (
	Member_ID    INTEGER,
	FName      VARCHAR     NOT NULL,
	LName      VARCHAR     NOT NULL,
   PRIMARY KEY(Member_ID)
);

--Penalty
DROP TABLE IF EXISTS penalty CASCADE;

CREATE TABLE penalty (
	Penalty_ID   INTEGER,
	Member_ID    INTEGER  NOT NULL,
	Start_Date   DATE     NOT NULL,
	End_Date     DATE     NOT NULL,  -- 6 weeks after Start_Date
   PRIMARY KEY (Penalty_ID),
   FOREIGN KEY (Member_ID) REFERENCES league_member(Member_ID) ON UPDATE CASCADE ON DELETE SET NULL
);

--Court
DROP TABLE IF EXISTS court CASCADE;

CREATE TABLE court(
  Court_ID   INTEGER,   
  Location   VARCHAR,
   PRIMARY KEY(Court_ID)
);


--Reservation
DROP TABLE IF EXISTS reservation CASCADE;

CREATE TABLE reservation (
	Reservation_ID    INTEGER,
	Member_ID     INTEGER,
	Play_Date     DATE   NOT NULL, --YYYY-MM-DD
	Play_Hour     TIME   NOT NULL,  --Use a 24-hour clock, available from 10:00 to 24:00
	Apply_Date    DATE   NOT NULL, --YYYY-MM-DD
	Check_Status   VARCHAR, -- Confirmation Status(Pending or Confirmed or Canceled or Dropped)
	Court_ID      INTEGER  NOT NULL,
   PRIMARY KEY (Reservation_ID),
   FOREIGN KEY (Member_ID) REFERENCES league_member(Member_ID) ON UPDATE CASCADE ON DELETE SET NULL,
   FOREIGN KEY (Court_ID) REFERENCES court(Court_ID) ON UPDATE CASCADE ON DELETE SET NULL
);




--Triggers:
--1. Trigger for Check_Status
CREATE OR REPLACE FUNCTION confirm_reservation() 
RETURNS TRIGGER AS $confirm_reservation$
BEGIN 
   --Reservations only can be confirmed from 20 minutes before until 10 minutes after the hour;
   IF ((Current_Date + CURRENT_TIME < old.Play_Date + old.Play_Hour - INTERVAL '20 minutes') 
   	    OR ( Current_Date + CURRENT_TIME > old.Play_Date + old.Play_Hour + INTERVAL'10 minutes'))
      AND new.Check_Status='Confirmed' 
   THEN 
       RAISE EXCEPTION'You cannot confirm this reservation right now.';
   --only can be canceled any time prior to the game, which means cannot be canceled after the hour;
   ELSEIF new.Check_Status='Canceled' AND Current_Date + CURRENT_TIME > old.Play_Date + old.Play_Hour
   THEN 
       RAISE EXCEPTION'You cannot cancel this reservation right now.';
   --can only be dropped until 10 minutes after the hour;
   ELSEIF new.Check_Status='Dropped' AND Current_Date + CURRENT_TIME < old.Play_Date + old.Play_Hour + INTERVAL'10 minutes'
   THEN 
       RAISE EXCEPTION'You cannot drop this reservation right now.';
   END IF;
   RETURN NEW;
END;
$confirm_reservation$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS confirm_reservation ON reservation;
CREATE TRIGGER confirm_reservation 
BEFORE UPDATE OF Check_Status ON reservation
   FOR EACH ROW
   EXECUTE PROCEDURE confirm_reservation();

--2. Trigger for inserting a new reservation
CREATE OR REPLACE FUNCTION insert_reservation() 
RETURNS TRIGGER AS $insert_reservation$
DECLARE PenaltyPoints INTEGER;
DECLARE Same  INTEGER;
BEGIN 
--check penalty points and lead time
   select count(*) INTO PenaltyPoints from penalty where new.Member_ID= Member_ID AND End_Date > Current_Date; -- use INTO!!!! and don't forget ";"
   IF new.Apply_Date = Current_Date AND new.Play_Date - Current_Date + PenaltyPoints>7 
   THEN 
       RAISE EXCEPTION 'You cannot make a reservation today.';
   END IF;
--check if this timeslot and court has been reserved
   select count(*) INTO Same from reservation where new.Play_Date= Play_Date AND new.Play_Hour= Play_Hour AND new.Court_ID= Court_ID;
   IF Same<>0  
   THEN
       RAISE EXCEPTION 'Your desired court for this timeslot has been reserved, please try another one.';
   END IF;
--check if court is open for this hour(available only from 10:00 to 22:00)
   IF new.Play_Hour<>'10:00' AND new.Play_Hour<>'11:00' AND new.Play_Hour<>'12:00' AND new.Play_Hour<>'13:00' AND new.Play_Hour<>'14:00' 
      AND new.Play_Hour<>'15:00' AND new.Play_Hour<>'16:00' AND new.Play_Hour<>'17:00' AND new.Play_Hour<>'18:00' AND new.Play_Hour<>'19:00' 
      AND new.Play_Hour<>'20:00' AND new.Play_Hour<>'21:00' AND new.Play_Hour<>'22:00' AND new.Play_Hour<>'23:00'
   THEN
       RAISE EXCEPTION 'Our court is closed at this hour.';
   END IF; 
   RETURN NEW;
END;
$insert_reservation$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS insert_reservation ON reservation;
CREATE TRIGGER insert_reservation 
BEFORE INSERT ON reservation   -- use ON!!!!!
   FOR EACH ROW
   EXECUTE PROCEDURE insert_reservation();


