create database Sportmeet_Management_System;
USE  Sportmeet_Management_System;

CREATE TABLE PLAYER (
    Player_ID VARCHAR(5) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Gender VARCHAR(50) NOT NULL,
    Birthday DATE NOT NULL,
    District VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Captain_ID VARCHAR(5)  ,
    Team_ID VARCHAR(5),
    Age INT NOT NULL,
    
    PRIMARY KEY (Player_ID)
);

DELIMITER //
CREATE TRIGGER calculate_age
BEFORE INSERT ON PLAYER
FOR EACH ROW
BEGIN
    SET NEW.Age = YEAR(CURRENT_DATE()) - YEAR(NEW.Birthday);
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER recalculate_age
BEFORE UPDATE ON PLAYER
FOR EACH ROW
BEGIN
    SET NEW.Age = YEAR(CURRENT_DATE()) - YEAR(NEW.Birthday);
END;
//
DELIMITER ;


create table INJURY_RECORD(
	Player_ID varchar(5) not null,
    Name varchar(50) not null,
    Description varchar(150) not null,
    
    primary key(Player_ID,Name)
);


create table TEAM(
	Team_ID varchar(5) not null,
	Team_Name varchar(50) not null,
	District varchar(50) not null,
	City varchar(50) not null,
    Sportmeet_ID varchar(5),
    Official_ID varchar(5) not null,
    Sport_ID varchar(5) not null,
    
    primary key(Team_ID),
	unique(Team_Name)

);


create table SPORT(
	Sport_ID varchar(5) not null,
	Name varchar(50) not null,
	Description varchar(250) not null,
    Type varchar(10) not null,    
    
    primary key(Sport_ID)
);


create table SPORTMEET(
	Sportmeet_ID varchar(5) not null,
	Name varchar(50) not null,
	Start_Date date not null,
	End_Date date not null,
	Registration_Date date not null,
    
    primary key(Sportmeet_ID)
);


create table SPONSOR(
	Sponsor_ID varchar(6) not null,
	Name varchar(50) not null,
	Sponsorship_Amount varchar(50) not null,
	Contact_Email varchar(100) not null,
    
    primary key(Sponsor_ID),
	unique(Contact_Email)
);
create table CONTACT(
	Sponsor_ID varchar(6) not null,
	Phone_Num varchar(50) not null,
	Name varchar(50) not null,
        
    primary key(Sponsor_ID,Phone_Num)
);


create table OFFICIAL(
	Official_ID varchar(5) not null,
	Name varchar(50) not null,
	Role varchar(15) not null,
	Sportmeet_ID varchar(5) ,

    
	primary key(Official_ID)
);

create table EVENT(
	Event_ID varchar(5) not null,
	Name varchar(50) not null,
	Time time not null,
    Date date not null,
	Sport_ID varchar(5) not null,
	Official_ID varchar(5) not null,
	Venue_ID varchar(5) not null,
	 
	primary key(Event_ID)
);
create table RESULT(
	Event_ID varchar(5) not null,
	Name varchar(50) not null,
	Ranking varchar(50) not null,
	Medal varchar(50) not null,

	primary key(Event_ID,Name)
);


create table VENUE(
	Venue_ID varchar(5) not null,
	Name varchar(50) not null,
	Capacity int ,
	District varchar(50) not null,
	City varchar(50) not null,
	
    primary key(Venue_ID)
);


CREATE TABLE SPONSOR_SPORTSMEET (
    Sponsor_ID VARCHAR(6) NOT NULL,
    Sportmeet_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY (Sponsor_ID, Sportmeet_ID),
    FOREIGN KEY (Sponsor_ID) REFERENCES SPONSOR(Sponsor_ID),
    FOREIGN KEY (Sportmeet_ID) REFERENCES SPORTMEET(Sportmeet_ID)
);

CREATE TABLE SPORTSMEET_SPORT (
    Sportmeet_ID VARCHAR(5) NOT NULL,
    Sport_ID VARCHAR(5) NOT NULL,
    PRIMARY KEY (Sportmeet_ID, Sport_ID),
    FOREIGN KEY (Sportmeet_ID) REFERENCES SPORTMEET(Sportmeet_ID),
    FOREIGN KEY (Sport_ID) REFERENCES SPORT(Sport_ID)
);

ALTER TABLE OFFICIAL
ADD FOREIGN KEY (Sportmeet_ID) REFERENCES SPORTMEET(Sportmeet_ID) on delete set null on update cascade;

ALTER TABLE TEAM
ADD FOREIGN KEY (Sportmeet_ID) REFERENCES SPORTMEET(Sportmeet_ID) on delete set null on update cascade;

ALTER TABLE EVENT
ADD FOREIGN KEY (Venue_ID) REFERENCES VENUE(Venue_ID) on update cascade;

ALTER TABLE TEAM
ADD FOREIGN KEY (Official_ID) REFERENCES OFFICIAL(Official_ID) on update cascade;

ALTER TABLE EVENT
ADD FOREIGN KEY (Official_ID) REFERENCES OFFICIAL(Official_ID) on update cascade;

ALTER TABLE PLAYER
ADD FOREIGN KEY (Team_ID) REFERENCES TEAM(Team_ID) on delete set null on update cascade;

ALTER TABLE TEAM
ADD FOREIGN KEY (Sport_ID) REFERENCES SPORT(Sport_ID) on update cascade;

ALTER TABLE INJURY_RECORD
ADD FOREIGN KEY (Player_ID) REFERENCES PLAYER(Player_ID) on update cascade;

ALTER TABLE RESULT
ADD FOREIGN KEY (Event_ID) REFERENCES EVENT(Event_ID) on update cascade;

ALTER TABLE EVENT
ADD FOREIGN KEY (Sport_ID) REFERENCES SPORT(Sport_ID) on update cascade;

ALTER TABLE PLAYER
ADD FOREIGN KEY (Captain_ID) REFERENCES PLAYER(Player_ID) on delete set null on update cascade;


ALTER TABLE CONTACT
ADD FOREIGN KEY (Sponsor_ID) REFERENCES SPONSOR(Sponsor_ID) on update cascade;



   
    
    
    
INSERT INTO SPORT (Sport_ID, Name, Description, Type)
VALUES
    ('SP1', 'Soccer', 'Association football sport', 'Indoor'),
    ('SP2', 'Swimming', 'Aquatic sport', 'Outdoor'),
    ('SP3', 'Basketball', 'Team sport with a ball', 'Indoor'),
    ('SP4', 'Athletics', 'Track and field events', 'Outdoor'),
    ('SP5', 'Volleyball', 'Team sport with a net', 'Indoor'),
    ('SP6', 'Table Tennis', 'Indoor sport with small ball', 'Indoor'),
    ('SP7', 'Badminton', 'Racket sport', 'Indoor'),
    ('SP8', 'Gymnastics', 'Physical exercise and performance', 'Indoor'),
    ('SP9', 'Boxing', 'Combat sport', 'Indoor'),
    ('SP10', 'Rugby', 'Team sport with an oval ball', 'Outdoor');

INSERT INTO SPORTMEET (Sportmeet_ID, Name, Start_Date, End_Date, Registration_Date)
VALUES
    ('SM1', 'Summer Olympics 2023', '2023-07-15', '2023-08-15', '2023-04-01'),
    ('SM2', 'Winter Olympics 2024', '2024-02-10', '2024-02-26', '2023-11-01'),
    ('SM3', 'World Cup 2023', '2023-06-01', '2023-07-15', '2023-03-01');

INSERT INTO SPONSOR (Sponsor_ID, Name, Sponsorship_Amount, Contact_Email)
VALUES
    ('SPON1', 'Bet Sports Inc.', '100000', 'Betsport@gmail.com'),
    ('SPON2', 'LLC Corporation', '75000', 'LLC@gmail.com'),
    ('SPON3', 'Sports Gear Co.', '50000', 'gear@gmail.com'),
    ('SPON4', 'Sports Unlimited', '90000', 'unlimited@gmail.com'),
    ('SPON5', 'Sportsworld', '120000', 'sportsworld@gmail.com'),
    ('SPON6', 'Sporty Brands', '85000', 'sportybrands@gmail.com'),
    ('SPON7', 'Athlete Foundation', '60000', 'foundation@gmail.com'),
    ('SPON8', 'Sports Excellence', '110000', 'excellence@gmail.com'),
    ('SPON9', 'Play Hard', '95000', 'playhard@gmail.com'),
    ('SPON10', 'FitPro', '80000', 'fitpro@gmail.com');

INSERT INTO SPORTSMEET_SPORT (Sportmeet_ID, Sport_ID)
VALUES
    ('SM1', 'SP1'),
    ('SM1', 'SP2'),
    ('SM1', 'SP3'),
    ('SM2', 'SP2'),
    ('SM2', 'SP4'),
    ('SM3', 'SP1'),
    ('SM3', 'SP3');

INSERT INTO OFFICIAL (Official_ID, Name, Role, Sportmeet_ID)
VALUES
    ('OF1', 'John Smith', 'Referee', 'SM1'),
    ('OF2', 'Alice Johnson', 'Judge', 'SM1'),
    ('OF3', 'David Brown', 'Referee', 'SM2'),
    ('OF4', 'Emily Davis', 'Judge', 'SM2'),
    ('OF5', 'Michael White', 'Referee', 'SM3'),
    ('OF6', 'Sarah Wilson', 'Judge', 'SM3'),
    ('OF7', 'Alice Johnson', 'Register', 'SM1'),
    ('OF8', 'Ethan Davis', 'Register', 'SM2'),
    ('OF9', 'Olivia Wilson', 'Register', 'SM3');

INSERT INTO VENUE (Venue_ID, Name, Capacity, District, City)
VALUES
    ('V1', 'Olympic Stadium', 8000, 'Downtown', 'Metropolis'),
    ('V2', 'Aquatics Center', 1000, 'Beachside', 'Coastal City'),
    ('V3', 'Basketball Arena', 1500, 'City Center', 'Metropolis'),
    ('V4', 'Athletics Stadium', 25000, 'Suburb', 'Suburban City'),
    ('V5', 'Volleyball Hall', 12000, 'Downtown', 'Metropolis'),
    ('V6', 'Table Tennis Center', 8000, 'City Center', 'Metropolis'),
    ('V7', 'Badminton Arena', 9000, 'Suburb', 'Suburban City'),
    ('V8', 'Gymnastics Hall', 6000, 'City Center', 'Metropolis'),
    ('V9', 'Boxing Arena', 7000, 'Downtown', 'Metropolis'),
    ('V10', 'Rugby Stadium', 18000, 'City Center', 'Metropolis'),
    ('V11', 'Taekwondo Dojo', 1800, 'City Center', 'Metropolis');

INSERT INTO TEAM (Team_ID, Team_Name, District, City, Sportmeet_ID, Official_ID, Sport_ID)
VALUES
    ('T1', 'Phoenix', 'Downtown', 'Metropolis', 'SM1', 'OF7', 'SP1'),
    ('T2', 'Thunder', 'Beachside', 'Coastal City', 'SM1', 'OF7', 'SP2'),
    ('T3', 'Titans', 'City Center', 'Metropolis', 'SM2', 'OF8', 'SP3'),
    ('T4', 'Guardians', 'Suburb', 'Suburban City', 'SM2', 'OF8', 'SP4'),
    ('T5', 'Cyclones', 'Downtown', 'Metropolis', 'SM1', 'OF9', 'SP1'),
    ('T6', 'Rangers', 'City Center', 'Metropolis', 'SM3', 'OF9', 'SP3');


INSERT INTO PLAYER (Player_ID, Name, Gender, Birthday, District, City, Captain_ID, Team_ID, Age)
VALUES
    ('P1', 'James Smith', 'Male', '1990-05-15', 'Downtown', 'Metropolis', NULL, 'T1', 33),
    ('P2', 'Sarah Johnson', 'Female', '1992-08-20', 'Beachside', 'Coastal City',NULL, 'T2', 31),
    ('P3', 'David Brown', 'Male', '1995-03-10', 'City Center', 'Metropolis', 'P2', 'T3', 28),
    ('P4', 'Emily Davis', 'Female', '1997-12-05', 'Suburb', 'Suburban City', 'P1' , 'T4', 26),
    ('P5', 'Michael Wilson', 'Male', '1993-09-25', 'Downtown', 'Metropolis', 'P1' , 'T5', 30),
    ('P6', 'Jennifer Lee', 'Female', '1996-06-30', 'City Center', 'Metropolis', 'P1' , 'T6', 27),
    ('P7', 'Robert Martinez', 'Male', '1998-04-18', 'Downtown', 'Metropolis', 'P2' , 'T1', 25),
    ('P8', 'Jessica Anderson', 'Female', '1994-01-12', 'City Center', 'Metropolis', 'P2' , 'T2', 29),
    ('P9', 'William Jackson', 'Male', '1991-11-08', 'Suburb', 'Suburban City', 'P1' , 'T3', 32),
    ('P10', 'Laura Taylor', 'Female', '1999-07-22', 'Downtown', 'Metropolis', 'P3' , 'T4', 24);


INSERT INTO INJURY_RECORD (Player_ID, Name, Description)
VALUES
    ('P1', 'Knee Injury', 'Torn ACL'),
    ('P2', 'Shoulder Injury', 'Rotator cuff tear'),
    ('P3', 'Ankle Injury', 'Sprained ankle'),
    ('P4', 'Hamstring Injury', 'Strained hamstring'),
    ('P5', 'Elbow Injury', 'Tennis elbow'),
    ('P6', 'Wrist Injury', 'Fractured wrist'),
    ('P7', 'Back Injury', 'Herniated disc'),
    ('P8', 'Knee Injury', 'Meniscus tear'),
    ('P9', 'Shoulder Injury', 'Dislocated shoulder'),
    ('P10', 'Ankle Injury', 'Ankle sprain');

INSERT INTO SPONSOR_SPORTSMEET (Sponsor_ID, Sportmeet_ID)
VALUES
    ('SPON1', 'SM1'),
    ('SPON2', 'SM2'),
    ('SPON3', 'SM1'),
    ('SPON4', 'SM3'),
    ('SPON5', 'SM2'),
    ('SPON6', 'SM3'),
    ('SPON7', 'SM1'),
    ('SPON8', 'SM2'),
    ('SPON9', 'SM3'),
    ('SPON10', 'SM1');

INSERT INTO EVENT (Event_ID, Name, Time, Date, Sport_ID, Official_ID, Venue_ID)
VALUES
    ('E1', 'Soccer Match 1', '14:00:00', '2023-07-20', 'SP1', 'OF1', 'V1'),
    ('E2', 'Swimming Finals', '17:30:00', '2023-07-25', 'SP2', 'OF2', 'V2'),
    ('E3', 'Basketball Semifinal', '19:45:00', '2023-08-05', 'SP3', 'OF3', 'V3'),
    ('E4', 'Athletics Sprint', '10:00:00', '2023-07-30', 'SP4', 'OF4', 'V4'),
    ('E5', 'Volleyball Final', '15:15:00', '2023-08-10', 'SP5', 'OF5', 'V5'),
    ('E6', 'Table Tennis Singles', '09:30:00', '2023-08-02', 'SP6', 'OF6', 'V6'),
    ('E7', 'Badminton Doubles', '14:45:00', '2023-08-08', 'SP7', 'OF1', 'V7'),
    ('E8', 'Gymnastics All-Around', '11:00:00', '2023-08-03', 'SP8', 'OF2', 'V8'),
    ('E9', 'Boxing Finals', '16:20:00', '2023-08-12', 'SP9', 'OF3', 'V9'),
    ('E10', 'Rugby Final', '18:30:00', '2023-08-15', 'SP10', 'OF4', 'V10');

INSERT INTO RESULT (Event_ID, Name, Ranking, Medal)
VALUES
    ('E1', 'Phoenix', '1st', 'Gold'),
    ('E1', 'Thunder', '2nd', 'Silver'),
    ('E1', 'Titans', '3rd', 'Bronze'),
    ('E2', 'Cyclones', '1st', 'Gold'),
    ('E3', 'Titans', '1st', 'Gold'),
    ('E3', 'Guardians', '2nd', 'Silver'),
    ('E4', 'Thunder', '1st', 'Gold'),
    ('E4', 'Titans', '2nd', 'Silver'),
    ('E5', 'Cyclones', '1st', 'Gold'),
    ('E6', 'Phoenix', '1st', 'Gold'),
    ('E10', 'Rangers', '1st', 'Gold');

INSERT INTO CONTACT (Sponsor_ID, Phone_Num, Name)
VALUES
    ('SPON1', '0711234567', 'John Doe'),
    ('SPON2', '0719876543', 'Jane Smith'),
    ('SPON3', '0762345678', 'Michael Johnson'),
    ('SPON4', '0768765432', 'Emily Davis'),
    ('SPON5', '0773456789', 'Chris Wilson'),
    ('SPON6', '0776543210', 'Sophia Lee'),
    ('SPON7', '0722743823', 'David Brown'),
    ('SPON8', '0725432109', 'Emma White'),
    ('SPON9', '0719876543', 'Oliver Adams'),
    ('SPON10', '0702834978', 'Ava Martin');
    
    
    
    
    
    
   
    update TEAM set Team_Name ='Cydex' where Team_ID='T1';
    update TEAM set Team_Name ='Hunter',District = 'New Delhi',City= 'Delhi',Sportmeet_ID='SM3',Official_ID ='OF4', Sport_ID ='SP4' where Team_ID='T2';
    delete from TEAM  where Team_ID='T3';

    
  
/*---------------------------------------------Basic Queries--------------------------------------------------------------------------------------------*/


SELECT * FROM player; /*select operation*/
 
 SELECT Name,District FROM player; /*project operation*/
 
 SELECT * FROM player,team;  /*cartesian operation*/
 
 CREATE VIEW SponsorSportmeetView AS 							
SELECT sponsor.name, sponsor_sportsmeet.Sportmeet_ID
FROM sponsor																						/*Creating a User View*/
JOIN sponsor_sportsmeet ON sponsor.Sponsor_ID = sponsor_sportsmeet.Sponsor_ID
JOIN sportmeet ON sponsor_sportsmeet.Sportmeet_ID = sportmeet.Sportmeet_ID;
 
 SELECT  * FROM SponsorSportmeetView;
 
 
 SELECT Name as Player_Name,Age as Player_Age FROM player; /*renaming operation*/
 
 
 SELECT AVG(Age) AS average_age FROM player;  /*Aggregation function*/
 

 SELECT* FROM player WHERE Name LIKE '%son'; /*Use of LIKE key word*/

/*---------------------------------------------Complex Queries--------------------------------------------------------------------------------------------*/
CREATE VIEW superv AS
SELECT a.Name AS Supervisor
FROM official AS a where a.Role like 'J%'
UNION								/*Union*/
SELECT b.Team_Name AS Team
FROM team AS b ;
SELECT * FROM superv;


/*Tuning*/
show index from official;
EXPLAIN(SELECT * FROM superv);
create index role_idx on official(Role);
show index from official;
EXPLAIN(SELECT * FROM superv);

drop index role_idx on official;




-- teams and their relavant officials
CREATE VIEW relavant AS
SELECT official.Name AS Supervisor,team.Team_Name AS Team
FROM official 															/*Intersect*/
INNER JOIN team ON official.Official_ID = team.Official_ID where Team.District like 'N%'	;
SELECT * FROM relavant;

/*Tuning*/
show index from team;
EXPLAIN(SELECT * FROM relavant);
create index District_idx on team(District);
show index from team;
EXPLAIN(SELECT * FROM relavant);


drop index District_idx on team;




-- unoccupied venues
CREATE VIEW unoccupied AS 
SELECT a.Name AS Unoccupied_Venues ,a.Capacity As Audience_Capacity,a.District,a.City
FROM venue AS a																				/*Set differnece*/
WHERE a.Venue_ID NOT IN (SELECT b.Venue_ID FROM event AS b) AND a.District like 'C%';
SELECT * FROM unoccupied;

/*Tuning*/
show index from venue;
EXPLAIN(SELECT * FROM unoccupied);
create index Districtv_idx on venue(District);
show index from venue;
EXPLAIN(SELECT * FROM unoccupied);

drop index Districtv_idx on venue;


-- teams that have players in all sports 

SELECT DISTINCT T.Team_Name
FROM TEAM T
WHERE NOT EXISTS (
    -- Subquery to check if there is a sport that doesn't have a player in the team
    SELECT S.Sport_ID
    FROM SPORTSMEET_SPORT S
    WHERE NOT EXISTS (
        -- Subquery to check if the team has a player in the sport
        SELECT P.Player_ID
        FROM PLAYER P																	/*Set division*/
        WHERE P.Team_ID = T.Team_ID
        AND P.Team_ID IS NOT NULL
        AND P.Team_ID <> ''
        AND P.Team_ID NOT LIKE '%NULL%'
       
    )
);



-- Create a view for the inner join between PLAYER and TEAM
CREATE VIEW PlayerTeamView AS
SELECT P.Player_ID, P.Name AS Player_Name, T.Team_Name
FROM PLAYER P 										/*Inner Join*/
INNER JOIN TEAM T ON P.Team_ID = T.Team_ID where T.city like 'M%';
SELECT * FROM PlayerTeamView;



/*Tuning*/
show index from team;
EXPLAIN(SELECT * FROM PlayerTeamView);
create index city_idx on team(City);
show index from team;
EXPLAIN(SELECT * FROM PlayerTeamView);

drop index city_idx on team;

-- Create a view for the natural join between PLAYER and TEAM
CREATE VIEW PlayerTeamNaturalJoin AS
SELECT P.Player_ID, P.name AS Player_Name, T.Team_Name
FROM PLAYER P													/*Natural Join*/
NATURAL JOIN TEAM T  where P.Name like 'J%';
SELECT * FROM PlayerTeamNaturalJoin;

/*Tuning*/
show index from player;
EXPLAIN(SELECT * FROM PlayerTeamNaturalJoin);
create index name_idx on player(name);
show index from player;
EXPLAIN(SELECT * FROM PlayerTeamNaturalJoin);

drop index name_idx on player;


-- Create a view for the left outer join between PLAYER and TEAM
CREATE VIEW PlayerTeamLeftOuterJoin AS
SELECT P.Player_ID, P.Name AS Player_Name, T.Team_Name			/*Left Join*/
FROM PLAYER P
LEFT JOIN TEAM T ON P.Team_ID = T.Team_ID ;
SELECT * FROM PlayerTeamLeftOuterJoin;



-- Create a view for the right outer join between PLAYER and TEAM
CREATE VIEW PlayerTeamRightOuterJoin AS
SELECT P.Player_ID, P.Name AS Player_Name, T.Team_Name
FROM TEAM T														/*Right Join*/				
RIGHT JOIN PLAYER P ON P.Team_ID = T.Team_ID;
SELECT * FROM PlayerTeamRightOuterJoin;


-- Create a view for the full outer join between EVENT and RESULT
CREATE VIEW EventResultFullOuterJoin AS
SELECT E.Event_ID, E.Name AS Event_Name, E.Sport_ID, R.Ranking, R.Medal
FROM EVENT E																	/*Full outer Join*/			
LEFT JOIN RESULT R ON E.Event_ID = R.Event_ID where R.medal like 'G%' 
UNION ALL
SELECT E.Event_ID, E.Name AS Event_Name, E.Sport_ID, R.Ranking, R.Medal
FROM RESULT R
RIGHT JOIN EVENT E ON E.Event_ID = R.Event_ID;
SELECT * FROM EventResultFullOuterJoin;



/*Tuning*/
show index from RESULT;
EXPLAIN(SELECT * FROM EventResultFullOuterJoin);
create index Medal_idx on RESULT(Medal);
show index from RESULT;
EXPLAIN(SELECT * FROM EventResultFullOuterJoin);

drop index Medal_idx on RESULT;



-- Create a view for the OUTER UNION between PLAYER and TEAM
CREATE VIEW OuterUnionView AS
SELECT 'PLAYER' AS SourceTable, Player_ID, Name, Gender, Birthday, District, City, Captain_ID, Team_ID, Age
FROM PLAYER
UNION																																							/*Outer Union*/		
SELECT 'TEAM' AS SourceTable, Team_ID, Team_Name AS Name, NULL AS Gender, NULL AS Birthday, District, City, NULL AS Captain_ID, NULL AS Team_ID, NULL AS Age
FROM TEAM where TEAM.District like 'D%';
SELECT * FROM OuterUnionView;

/*Tuning*/
show index from TEAM;
EXPLAIN(SELECT * FROM OuterUnionView);
create index Districtou_idx on TEAM(District);
show index from TEAM;
EXPLAIN(SELECT * FROM OuterUnionView);

drop index Districtou_idx on TEAM;



-- Find the average age of players in each team using a nested query with aggregation
CREATE VIEW averageage AS
SELECT T.Team_Name, AVG(P.Age) AS Average_Player_Age
FROM TEAM T												/*Nested Query with Aggregation*/
LEFT JOIN PLAYER P ON T.Team_ID = P.Team_ID where T.City like 'M%'	
GROUP BY T.Team_Name ;
SELECT * FROM averageage;

/*Tuning*/
show index from TEAM;
EXPLAIN(SELECT * FROM averageage);
create index Cityavg_idx on TEAM(City);
show index from TEAM;
EXPLAIN(SELECT * FROM averageage);

drop index Cityavg_idx on TEAM;


-- retrieve all players who belong to teams that are sponsored by SPON1
CREATE VIEW sponsoredby AS
SELECT * FROM PLAYER
WHERE Team_ID IN (
    SELECT Team_ID
    FROM TEAM
    WHERE Team_ID IN (															/*Nested Query with Subquery in the WHERE clause*/
        SELECT Team_ID
        FROM SPONSOR_SPORTSMEET
        WHERE Sponsor_ID = 'SPON1'
    ) AND team.District like 'D%'
);
SELECT * FROM sponsoredby;

/*Tuning*/
show index from TEAM;
EXPLAIN(SELECT * FROM sponsoredby);
create index sponsoredby_idx on TEAM(District);
show index from TEAM;
EXPLAIN(SELECT * FROM sponsoredby);

drop index sponsoredby_idx on TEAM;


-- Find teams with more players than the average age of players in all teams
SELECT T.Team_Name, COUNT(P.Player_ID) AS Number_of_Players
FROM TEAM T
INNER JOIN PLAYER P ON T.Team_ID = P.Team_ID
WHERE (
    SELECT AVG(PlayerAge)
    FROM (																					/*Nested Query with Correlated Subquery*/
        SELECT AVG(P2.Age) AS PlayerAge														
        FROM TEAM T2
        INNER JOIN PLAYER P2 ON T2.Team_ID = P2.Team_ID
        GROUP BY T2.Team_ID
    ) AS TeamAverages
) < P.Age
GROUP BY T.Team_Name
ORDER BY Number_of_Players DESC;