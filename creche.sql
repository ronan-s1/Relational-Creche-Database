-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-11-01 18:24:17 GMT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
-- predefined type, no DDL - MDSYS.SDO_GEOMETRY
-- predefined type, no DDL - XMLTYPE

DROP TABLE IF EXISTS child cascade;
DROP TABLE IF EXISTS goals cascade;
DROP TABLE IF EXISTS guardian cascade;
DROP TABLE IF EXISTS stages cascade;
DROP TABLE IF EXISTS session cascade;
DROP TABLE IF EXISTS room cascade;
DROP TABLE IF EXISTS staff cascade;

CREATE TABLE child (
    child_id SERIAL PRIMARY KEY,
    name        VARCHAR(30),
    dob         DATE,
    nickname    VARCHAR(30),
    room_number VARCHAR(5) NOT NULL
);


CREATE TABLE goals (
    goal_id  SERIAL PRIMARY KEY,
    goals    VARCHAR(40),
    complete BOOLEAN,
    stage_id INTEGER NOT NULL
);


CREATE TABLE guardian (
    guardian_id    SERIAL PRIMARY KEY,
    preferred      BOOLEAN,
    child_id INTEGER NOT NULL,
    name           VARCHAR(30),
    phone          VARCHAR(30),
    relationship   VARCHAR(30),
    address        VARCHAR(60)
);

-- ALTER TABLE guardian ADD CONSTRAINT guardian_pk PRIMARY KEY ( guardian_id );

CREATE TABLE room (
    room_number VARCHAR(5) PRIMARY KEY,
    isfull        BOOLEAN,
    "size"      VARCHAR(10),
    facilities  VARCHAR(40)
);

-- ALTER TABLE room ADD CONSTRAINT room_pk PRIMARY KEY ( room_number );

CREATE TABLE "session" (
    session_id  SERIAL PRIMARY KEY,
    hours_slept INTEGER,
    food_ate    VARCHAR(30),
    well_being  VARCHAR(50),
    staff_id    INTEGER NOT NULL,
    child_id    INTEGER NOT NULL,
    room_number VARCHAR(5) NOT NULL,
    "date"      DATE
);

-- ALTER TABLE "session" ADD CONSTRAINT session_pk PRIMARY KEY ( session_id );

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    name     VARCHAR(30),
    phone    VARCHAR(20),
    email    VARCHAR(40)
);

-- ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_id );

CREATE TABLE stages (
    stage_id    SERIAL PRIMARY KEY,
    stage_name  VARCHAR(30),
    max_age     INTEGER,
    room_number VARCHAR(5) NOT NULL
);

-- ALTER TABLE stages ADD CONSTRAINT stages_pk PRIMARY KEY ( stage_id );

ALTER TABLE child
    ADD CONSTRAINT child_room_fk FOREIGN KEY ( room_number )
        REFERENCES room ( room_number );

ALTER TABLE goals
    ADD CONSTRAINT goals_stages_fk FOREIGN KEY ( stage_id )
        REFERENCES stages ( stage_id );

ALTER TABLE guardian
    ADD CONSTRAINT guardian_child_fk FOREIGN KEY ( child_id )
        REFERENCES child ( child_id );

ALTER TABLE "session"
    ADD CONSTRAINT session_child_fk FOREIGN KEY ( child_id )
        REFERENCES child ( child_id );

ALTER TABLE "session"
    ADD CONSTRAINT session_room_fk FOREIGN KEY ( room_number )
        REFERENCES room ( room_number );

ALTER TABLE "session"
    ADD CONSTRAINT session_staff_fk FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE stages
    ADD CONSTRAINT stages_room_fk FOREIGN KEY ( room_number )
        REFERENCES room ( room_number );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             5
-- ALTER TABLE                             14
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

insert into room values ('1', TRUE, 'medium', 'toys');
insert into room values ('2', FALSE, 'big', 'books');
insert into room values ('3', TRUE, 'medium', 'white boards');
insert into room values ('4', FALSE, 'big', 'Lego');
insert into room values ('5', FALSE, 'big', 'bikes');

insert into child values(DEFAULT, 'Kate Smith', '2015-09-02', 'Kay', '1');
insert into child values(DEFAULT, 'Peter Poles', '2016-09-05', 'Pete', '1');
insert into child values(DEFAULT, 'Fred Dina', '2015-10-02', 'Freddy', '1');
insert into child values(DEFAULT, 'Mia Kal', '2016-01-12', 'Mi', '1');
insert into child values(DEFAULT, 'Patrick Gus', '2015-06-28', 'Pat', '1');
insert into child values(DEFAULT, 'Joseph Johnson', '2015-07-01', 'Joe', '1');
insert into child values(DEFAULT, 'John Molone', '2015-02-03', 'JOHNNY BOY', '2');
insert into child values(DEFAULT, 'Sonia Kuar', '2015-01-03', 'Soe', '2');
insert into child values(DEFAULT, 'Kieran Salad', '2015-12-06', 'Papi', '2');
insert into child values(DEFAULT, 'Ella Allison', '2015-12-03', 'EL', '2');
insert into child values(DEFAULT, 'Amy Mines', '2015-10-03', 'Ames', '2');
insert into child values(DEFAULT, 'Hannah Bowl', '2015-02-03', 'Hanny', '2');
insert into child values(DEFAULT, 'Abby Vinson', '2015-02-03', 'Ab', '3');
insert into child values(DEFAULT, 'Juliana Pauls', '2015-02-14', 'Yanna', '3');
insert into child values(DEFAULT, 'Mike White', '2015-02-13', 'Mikey', '3');
insert into child values(DEFAULT, 'Mathew Brown', '2015-02-04', 'Mat', '3');
insert into child values(DEFAULT, 'Tom Coffey', '2015-02-23', 'Tommy', '3');
insert into child values(DEFAULT, 'Chloe Smalls', '2014-09-03', 'klo', '3');
insert into child values(DEFAULT, 'Sandra Pling', '2015-12-05', 'Sand', '4');
insert into child values(DEFAULT, 'Christopher Murphy', '2015-05-10', 'Chris', '4');

insert into guardian values(DEFAULT, TRUE, 1, 'John Smith', '0872839129', 'Father', '123 Big Rd');
insert into guardian values(DEFAULT, FALSE, 1, 'Sarah Smith', '0861811129', 'Mother', '123 Big Rd');
insert into guardian values(DEFAULT, TRUE, 2, 'Joe Poles', '0871830129', 'Father', '12 Big Rd');
insert into guardian values(DEFAULT, FALSE, 2, 'Jules Poles', '0868911239', 'Mother', '12 Big Rd');
insert into guardian values(DEFAULT, FALSE, 3, 'Dennis Dina', '0871830129', 'Father', '31 Small Rd');
insert into guardian values(DEFAULT, TRUE, 3, 'Olivia Dina', '0868911239', 'Mother', '31 Small Rd');
insert into guardian values(DEFAULT, FALSE, 4, 'Peter Kal', '0849930122', 'Father', '55 Long Rd');
insert into guardian values(DEFAULT, TRUE, 4, 'Elena Kal', '0868627034', 'Mother', '55 Long Rd');
insert into guardian values(DEFAULT, FALSE, 5, 'John Kal', '0849930129', 'Father', '55 Long Rd');
insert into guardian values(DEFAULT, TRUE, 5, 'Elena Kal', '0868627039', 'Mother', '55 Long Rd');
insert into guardian values(DEFAULT, TRUE, 5, 'Joshua Gus', '0861560121', 'Father', '55 Long St');
insert into guardian values(DEFAULT, FALSE, 5, 'Victoria Gus', '0867727678', 'Mother', '55 Long St');
insert into guardian values(DEFAULT, TRUE, 6, 'Keith Johnson', '0852110121', 'Father', '95 Long St');
insert into guardian values(DEFAULT, FALSE, 6, 'Kelly Johnson', '0868910670', 'Mother', '95 Long St');
insert into guardian values(DEFAULT, TRUE, 7, 'Kevin Malone', '0852530621', 'Father', '10 Long St');
insert into guardian values(DEFAULT, FALSE, 7, 'Hannah Malone', '0867817670', 'Mother', '10 Long St');
insert into guardian values(DEFAULT, TRUE, 8, 'Amir Kuar', '0851039621', 'Father', '99 Long St');
insert into guardian values(DEFAULT, FALSE, 8, 'Hasfa Kuar', '0841117970', 'Mother', '99 Long St');
insert into guardian values(DEFAULT, TRUE, 9, 'Bill Salad', '0852122619', 'Father', '10 Wide St');
insert into guardian values(DEFAULT, FALSE, 9, 'Ciara Salad', '0867123677', 'Mother', '10 Wide St');
insert into guardian values(DEFAULT, TRUE, 10, 'Bill Allison', '0862840091', 'Father', '15 Wide St');
insert into guardian values(DEFAULT, FALSE, 10, 'Katherine Allison', '0863340091', 'Mother', '15 Wide St');
insert into guardian values(DEFAULT, TRUE, 11, 'Fredrick Mines', '0867283289', 'Father', '11 Wide St');
insert into guardian values(DEFAULT, FALSE, 11, 'Charlotte Mines', '0867123677', 'Mother', '11 Wide St');
insert into guardian values(DEFAULT, TRUE, 12, 'Noah Bowl', '0852111619', 'Father', '88 Wide St');
insert into guardian values(DEFAULT, FALSE, 12, 'Evelin Bowl', '0811123677', 'Mother', '88 Wide St');
insert into guardian values(DEFAULT, TRUE, 13, 'Oliver Vinson', '0852122619', 'Father', '28 Wide St');
insert into guardian values(DEFAULT, FALSE, 13, 'Grace Vinson', '0867123677', 'Mother', '28 Wide St');
insert into guardian values(DEFAULT, TRUE, 14, 'Lucas Pauls', '0852552616', 'Father', '111 Tall St');
insert into guardian values(DEFAULT, FALSE, 14, 'Layla Pauls', '085262016', 'Mother', '111 Tall St');
insert into guardian values(DEFAULT, TRUE, 15, 'Ryan White', '0866622619', 'Father', '222 Tall St');
insert into guardian values(DEFAULT, FALSE, 15, 'Emma White', '0877723677', 'Mother', '222 Tall St');
insert into guardian values(DEFAULT, TRUE, 16, 'David Brown', '0852129061', 'Father', '124 Tall St');
insert into guardian values(DEFAULT, FALSE, 16, 'Ava Brown', '086983607', 'Mother', '124 Tall St');
insert into guardian values(DEFAULT, TRUE, 17, 'Kai Coffey', '0852002619', 'Father', '74 Tall St');
insert into guardian values(DEFAULT, FALSE, 17, 'Alice Coffey', '0860800677', 'Mother', '74 Tall St');
insert into guardian values(DEFAULT, TRUE, 18, 'Leo Smalls', '0858972619', 'Father', '8 Wide St');
insert into guardian values(DEFAULT, FALSE, 18, 'Sophia Smalls', '0867112377', 'Mother', '8 Wide St');
insert into guardian values(DEFAULT, TRUE, 19, 'Isacc Pling', '0845676191', 'Father', '257 Big St');
insert into guardian values(DEFAULT, FALSE, 19, 'Hazel Pling', '0867123677', 'Mother', '257 Big St');
insert into guardian values(DEFAULT, TRUE, 20, 'Ethan Murphy', '0851112619', 'Father', '91 Wide St');
insert into guardian values(DEFAULT, FALSE, 20, 'Scarlet Murphy', '0867121237', 'Mother', '91 Wide St');

insert into staff values(DEFAULT, 'Akiy Ullah', '0872839123', 'akiy123@gmail.com');
insert into staff values(DEFAULT, 'Rob Bernard', '0867883912', 'robs12b@yahoo.ie');
insert into staff values(DEFAULT, 'Brooklyn Smith', '0872839123', 'brooklyn89@gmail.com');
insert into staff values(DEFAULT, 'Skyler Jones', '0872125123', 'skyler12J@gmail.com');
insert into staff values(DEFAULT, 'Bob Taylor', '0872125123', 'bobtaylor4@gmail.com');
insert into staff values(DEFAULT, 'Richard Lynch', '0872125123', 'rlynch12@gmail.com');
insert into staff values(DEFAULT, 'Sylvia Jenkins', '0872125123', 'sjenkins@gmail.com');

insert into stages values(DEFAULT, 'Infant', 1, '1');
insert into stages values(DEFAULT, 'Toddler', 3, '2');
insert into stages values(DEFAULT, 'School Age', 5, '3');
insert into stages values(DEFAULT, 'School Age', 5, '4');

insert into session values(DEFAULT, 3, 'chicken', 'healthy', 3, 1, 1, '2022-11-04');
insert into session values(DEFAULT, 3, 'mushy peas', 'healthy', 3, 2, 1, '2022-11-04');
insert into session values(DEFAULT, 2, 'fruit', 'healthy', 3, 3, 1, '2022-11-04');
insert into session values(DEFAULT, 4, 'soup', 'healthy', 3, 4, 1, '2022-11-04');
insert into session values(DEFAULT, 4, 'bananas', 'healthy', 3, 5, 1, '2022-11-04');
insert into session values(DEFAULT, 3, 'beef', 'healthy', 3, 6, 1, '2022-11-04');
insert into session values(DEFAULT, 4, 'beef', 'healthy', 2, 7, 2, '2022-11-04');
insert into session values(DEFAULT, 4, 'broccoli', 'unhealthy', 2, 8, 2, '2022-11-04');
insert into session values(DEFAULT, 5, 'soup', 'healthy', 2, 9, 2, '2022-11-04');
insert into session values(DEFAULT, 3, 'banana', 'healthy', 2, 10, 2, '2022-11-04');
insert into session values(DEFAULT, 3, 'plums', 'sleepy', 2, 11, 2, '2022-11-04');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 2, 12, 2, '2022-11-04');
insert into session values(DEFAULT, 5, 'salad', 'healthy', 4, 13, 3, '2022-11-04');
insert into session values(DEFAULT, 5, 'peas', 'healthy', 4, 14, 3, '2022-11-04');
insert into session values(DEFAULT, 2, 'cucumbers', 'healthy', 4, 15, 3, '2022-11-04');
insert into session values(DEFAULT, 5, 'oranges', 'healthy', 4, 16, 3, '2022-11-04');
insert into session values(DEFAULT, 6, 'cake', 'sick', 4, 17, 3, '2022-11-04');
insert into session values(DEFAULT, 4, 'lollipop', 'healthy', 4, 18, 3, '2022-11-04');
insert into session values(DEFAULT, 4, 'plums', 'tired', 5, 19, 4, '2022-11-04');
insert into session values(DEFAULT, 4, 'ham', 'healthy', 5, 20, 4, '2022-11-04');
insert into session values(DEFAULT, 3, 'chicken', 'healthy', 6, 1, 1, '2022-11-03');
insert into session values(DEFAULT, 3, 'mash potato', 'healthy', 6, 2, 1, '2022-11-03');
insert into session values(DEFAULT, 2, 'sandwiches', 'healthy', 6, 3, 1, '2022-11-03');
insert into session values(DEFAULT, 1, 'soup', 'healthy', 6, 4, 1, '2022-11-03');
insert into session values(DEFAULT, 2, 'bananas', 'healthy', 6, 5, 1, '2022-11-03');
insert into session values(DEFAULT, 3, 'carrots', 'healthy', 6, 6, 1, '2022-11-03');
insert into session values(DEFAULT, 4, 'beef', 'healthy', 3, 7, 2, '2022-11-03');
insert into session values(DEFAULT, 4, 'broccoli', 'healthy', 3, 8, 2, '2022-11-03');
insert into session values(DEFAULT, 4, 'grapes', 'healthy', 3, 9, 2, '2022-11-03');
insert into session values(DEFAULT, 3, 'banana', 'healthy', 3, 10, 2, '2022-11-03');
insert into session values(DEFAULT, 3, 'plums', 'agitated', 3, 11, 2, '2022-11-03');
insert into session values(DEFAULT, 5, 'ham', 'healthy', 3, 12, 2, '2022-11-03');
insert into session values(DEFAULT, 5, 'milk', 'healthy', 4, 13, 3, '2022-11-03');
insert into session values(DEFAULT, 5, 'peas', 'healthy', 4, 14, 3, '2022-11-03');
insert into session values(DEFAULT, 6, 'cucumbers', 'sleepy', 4, 15, 3, '2022-11-03');
insert into session values(DEFAULT, 5, 'oranges', 'healthy', 4, 16, 3, '2022-11-03');
insert into session values(DEFAULT, 6, 'cake', 'tired', 4, 17, 3, '2022-11-03');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 4, 18, 3, '2022-11-03');
insert into session values(DEFAULT, 4, 'plums', 'healthy', 2, 19, 4, '2022-11-03');
insert into session values(DEFAULT, 4, 'peas', 'healthy', 2, 20, 4, '2022-11-03');
insert into session values(DEFAULT, 3, 'chicken', 'healthy', 6, 1, 1, '2022-11-02');
insert into session values(DEFAULT, 3, 'mash potato', 'healthy', 6, 2, 1, '2022-11-02');
insert into session values(DEFAULT, 2, 'sandwiches', 'healthy', 6, 3, 1, '2022-11-02');
insert into session values(DEFAULT, 4, 'soup', 'healthy', 6, 4, 1, '2022-11-02');
insert into session values(DEFAULT, 4, 'bananas', 'healthy', 6, 5, 1, '2022-11-02');
insert into session values(DEFAULT, 3, 'carrots', 'healthy', 6, 6, 1, '2022-11-02');
insert into session values(DEFAULT, 4, 'beef', 'healthy', 2, 7, 2, '2022-11-02');
insert into session values(DEFAULT, 4, 'broccoli', 'healthy', 2, 8, 2, '2022-11-02');
insert into session values(DEFAULT, 5, 'grapes', 'healthy', 2, 9, 2, '2022-11-02');
insert into session values(DEFAULT, 2, 'banana', 'healthy', 2, 10, 2, '2022-11-02');
insert into session values(DEFAULT, 4, 'plums', 'agitated', 2, 11, 2, '2022-11-02');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 2, 12, 2, '2022-11-02');
insert into session values(DEFAULT, 5, 'milk', 'healthy', 4, 13, 3, '2022-11-02');
insert into session values(DEFAULT, 5, 'peas', 'healthy', 4, 14, 3, '2022-11-02');
insert into session values(DEFAULT, 2, 'cucumbers', 'healthy', 4, 15, 3, '2022-11-02');
insert into session values(DEFAULT, 5, 'oranges', 'healthy', 4, 16, 3, '2022-11-02');
insert into session values(DEFAULT, 6, 'cake', 'tired', 4, 17, 3, '2022-11-02');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 4, 18, 3, '2022-11-02');
insert into session values(DEFAULT, 4, 'plums', 'healthy', 3, 19, 4, '2022-11-02');
insert into session values(DEFAULT, 4, 'peas', 'healthy', 3, 20, 4, '2022-11-02');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 1, 1, 1, '2022-11-1');
insert into session values(DEFAULT, 4, 'oranges', 'healthy', 1, 2, 1, '2022-11-1');
insert into session values(DEFAULT, 2, 'sandwiches', 'healthy', 1, 3, 1, '2022-11-1');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 1, 4, 1, '2022-11-1');
insert into session values(DEFAULT, 4, 'bananas', 'healthy', 1, 5, 1, '2022-11-1');
insert into session values(DEFAULT, 3, 'carrots', 'healthy', 1, 6, 1, '2022-11-1');
insert into session values(DEFAULT, 4, 'icecream', 'unhealthy', 2, 7, 2, '2022-11-1');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 2, 8, 2, '2022-11-1');
insert into session values(DEFAULT, 3, 'peaches', 'healthy', 2, 9, 2, '2022-11-1');
insert into session values(DEFAULT, 3, 'apples', 'healthy', 2, 10, 2, '2022-11-1');
insert into session values(DEFAULT, 3, 'plums', 'healthy', 2, 11, 2, '2022-11-1');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 2, 12, 2, '2022-11-1');
insert into session values(DEFAULT, 2, 'milk', 'healthy', 3, 13, 3, '2022-11-1');
insert into session values(DEFAULT, 2, 'peas', 'healthy', 3, 14, 3, '2022-11-1');
insert into session values(DEFAULT, 2, 'cucumbers', 'healthy', 3, 15, 3, '2022-11-1');
insert into session values(DEFAULT, 5, 'oranges', 'healthy', 3, 16, 3, '2022-11-1');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 3, 17, 3, '2022-11-1');
insert into session values(DEFAULT, 4, 'apples', 'healthy', 3, 18, 3, '2022-11-1');
insert into session values(DEFAULT, 4, 'plums', 'healthy', 4, 19, 4, '2022-11-1');
insert into session values(DEFAULT, 4, 'pineapples', 'healthy', 4, 20, 4, '2022-11-1');

insert into goals values(DEFAULT, 'Develop awareness of own body', FALSE, 1);
insert into goals values(DEFAULT, 'Develop awareness of own environment', FALSE, 1);
insert into goals values(DEFAULT, 'pick up things', FALSE, 1);
insert into goals values(DEFAULT, 'stack blocks', FALSE, 2);
insert into goals values(DEFAULT, 'sit well in a chair', FALSE, 2);
insert into goals values(DEFAULT, 'climb stairs', FALSE, 2);
insert into goals values(DEFAULT, 'cycle a bike', FALSE, 3);
insert into goals values(DEFAULT, 'pour liquid into a cup', FALSE, 3);
insert into goals values(DEFAULT, 'write own name', FALSE, 3);