grant process on *.* to smartuser;
SHOW GRANTS FOR dummyuser;
create user smartuser;
drop user dummyuser;
show databases;
show tables;
show tables myFirstDB;
drop user smartuser;
drop database myFirstDB;
create database noahsDB;
use noahsDB;
create table employee (
    id      integer,
    name    varchar(50),
    income  float,
    internship boolean
    );
insert into employee (id, name, internship) values (1,'noah', 0);
insert into employee (id, name, internship) values (2,'martin', 1);
show tables;

drop table employee;
create table employee (
    id      integer not null primary key auto_increment,
    name    varchar(50) not null ,
    income  float not null ,
    internship boolean not null
    );

insert into employee (id, name, income, internship) values (0, 'noah', '2000', 0);
insert into employee (id, name, income, internship) values (0, 'martin', '1000', 1);
insert into employee (id, name, income, internship) values (0, 'minz', '4000', 1);
insert into employee (id, name, income, internship) values (0, 'franzisca', '2000', 1);
insert into employee (id, name, income, internship) values (0, 'spitz', '2030', 0);
insert into employee (id, name, income, internship) values (0, 'millinark', '12000', 0);
insert into employee (id, name, income, internship) values (0, 'humfred', '100', 0);
insert into employee (id, name, income, internship) values (0, 'sminko', '20000', 0);

select * from employee;
select id,name,income,internship from employee order by income;
select * from employee where income >= 2000
order by income desc;
show table employee;

create database guestbookdb;
insert into benutzer (vorname, nachname, adresse1 ,adresse2, postleitzahl, stadt, land, telefon, mobile, datum) values (0, 'noah', '2000', 0);

select * from benutzer;
use guestbookdb;

insert into eintrag (id, titel, text, datum, FK_login) value (1,'Herr', 'spagetti', current_date(),1)
insert into eintrag (id, titel, text, datum, FK_login) value (2,'Herr', 'Polenta', current_date(),2)
insert into eintrag (id, titel, text, datum, FK_login) value (3,'Frau', 'Spaezli', current_date(),3)
insert into eintrag (id, titel, text, datum, FK_login) value (4,'Frau', 'Ramen', current_date(),4)
insert into eintrag (id, titel, text, datum, FK_login) value (5,'Herr', 'Spinat', current_date(),5)

select * from eintrag by;

show databases;

create database myTestDB;
use myTestDB;

drop table adresses;
drop table logins;
drop table gender;
drop table persons;

create table if not exists logins
(
    loginID integer primary key not null auto_increment,
    user varchar(50) not null,
    password varchar(50) not null
);
select * from logins;
insert into logins (loginID, user, password)values(0,'noah','sillycat34523')
insert into logins (loginID, user, password)values(0,'noah','sillycat34523');
INSERT INTO logins (loginID, user, password) VALUES (0, 'MarieCurie', 'Radiation1911');
INSERT INTO logins (loginID, user, password) VALUES (0, 'NelsonMandela', 'AntiApartheid90');
INSERT INTO logins (loginID, user, password) VALUES (0, 'Beyonce', 'DestinysChild567');
INSERT INTO logins (loginID, user, password) VALUES (0, 'SteveJobs', 'Apple1234');
INSERT INTO logins (loginID, user, password) VALUES (0, 'AbrahamLincoln', 'Gettysburg1863');
INSERT INTO logins (loginID, user, password) VALUES (0, 'MarilynMonroe', 'Hollywood123');
INSERT INTO logins (loginID, user, password) VALUES (0, 'LeonardoDaVinci', 'MonaLisa789');
INSERT INTO logins (loginID, user, password) VALUES (0, 'OprahWinfrey', 'TalkShow456');
INSERT INTO logins (loginID, user, password) VALUES (0, 'AlbertEinstein', 'Relativity321');
INSERT INTO logins (loginID, user, password) VALUES (0, 'ElvisPresley', 'Graceland123');

select * from logins;

create table if not exists adresses
(
    adressID integer primary key not null auto_increment,
    street varchar(50) not null,
    code varchar(50) not null,
    town varchar(50) not null,
    country varchar(50) not null
);

select * from adresses;

INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Baldernstrasse 10', '8802', 'Kilchberg' ,'Switzerland');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, '1600 Amphitheatre Parkway', '94043', 'Mountain View', 'United States');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, '10 Downing Street', 'SW1A 2AA', 'London', 'United Kingdom')
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Eiffel Tower', '75007', 'Paris', 'France');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Red Square', '109012', 'Moscow', 'Russia');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, '1600 Pennsylvania Avenue NW', '20500', 'Washington, D.C.', 'United States');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Sydney Opera House', '2000', 'Sydney', 'Australia');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'The Great Wall of China', '100040', 'Beijing', 'China');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Taj Mahal', '282001', 'Agra', 'India');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Christ the Redeemer', '22221-125', 'Rio de Janeiro', 'Brazil');
INSERT INTO adresses (adressID, street, code, town, country) VALUES (0, 'Pyramid of Giza', '12566', 'Giza', 'Egypt');

create table if not exists gender
(
    genderID integer primary key not null auto_increment,
    gender varchar(50) not null,
    abrev varchar(50)
);

select * from gender;


insert into gender (genderID, gender, abrev) value (0,'Male','M');
insert into gender (genderID, gender, abrev) value (0,'Female','F');
insert into gender (genderID, gender, abrev) value (0,'Neutral','N');


delete from adresses Where adressID = 1;

create table if not exists persons
(
    personID integer primary key not null auto_increment,
    name varchar(255)   not null,
    surname varchar(255),
    birthday varchar(10),
    genderID int,
    foreign key (genderID) references gender(genderId)
);
                           drop table persons;
select * from persons;

insert into persons (personID, name, surname, birthday, genderID) value (0,name, surname, birthday, 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Elvis', 'Presley', '1935-01-08', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Albert', 'Einstein', '1879-03-14', 2);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Oprah', 'Winfrey', '1954-01-29', 3);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Leonardo', 'Da Vinci', '1452-04-15', 4);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Marilyn', 'Monroe', '1926-06-01', 5);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Abraham', 'Lincoln', '1809-02-12', 6);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Steve', 'Jobs', '1955-02-24', 7);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Beyonce', '', '1981-09-04', 8);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Nelson', 'Mandela', '1918-07-18', 9);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Marie', 'Curie', '1867-11-07', 10);

delete from persons where personID = 32;

INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Elvis', 'Presley', '1935-01-08', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Albert', 'Einstein', '1879-03-14', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Oprah', 'Winfrey', '1954-01-29', 2);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Leonardo', 'Da Vinci', '1452-04-15', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Marilyn', 'Monroe', '1926-06-01', 2);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Abraham', 'Lincoln', '1809-02-12', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Steve', 'Jobs', '1955-02-24', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Beyonce', '', '1981-09-04', 2);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Nelson', 'Mandela', '1918-07-18', 1);
INSERT INTO persons (personID, name, surname, birthday, genderID) VALUES (0, 'Marie', 'Curie', '1867-11-07', 2);

select * from persons;

select persons.personID, persons.name, persons.surname, persons.birthday,gender.gender, gender.abrev
from persons, gender
where persons.genderid = gender.genderID
order by 2;

create table if not exists countries
(
    countryID integer primary key not null auto_increment,
    country varchar(255) not null,
    code varchar(3)

)

insert into countries (countryID, country,code) value
(0, 'United States', 'US')                                         ,
(0, 'United Kingdom', 'GB')                                       ,
(0, 'France', 'FR')                                              ,
(0, 'Germany', 'DE')                                            ,
(0, 'Canada', 'CA')                                            ,
(0, 'Australia', 'AU')                                        ,
(0, 'Japan', 'JP')                                           ,
(0, 'Italy', 'IT')                                          ,
(0, 'Spain', 'ES')                                         ,
(0, 'India', 'IN')                                        ,
(0, 'Brazil', 'BR')                                      ,
(0, 'China', 'CN')                                      ,
(0, 'Russia', 'RU')                                    ,
(0, 'South Korea', 'KR')                              ,
(0, 'Mexico', 'MX')                                  ,
(0, 'Netherlands', 'NL')                            ,
(0, 'Sweden', 'SE')                                ,
(0, 'Norway', 'NO')                               ,
(0, 'Denmark', 'DK')                             ,
(0, 'New Zealand', 'NZ')                        ,
(0, 'Argentina', 'AR')                         ,
(0, 'South Africa', 'ZA')                     ,
(0, 'Switzerland', 'CH')                     ,
(0, 'Belgium', 'BE')                        ,
(0, 'Austria', 'AT')                       ,
(0, 'Greece', 'GR')                       ,
(0, 'Turkey', 'TR')                      ,
(0, 'Portugal', 'PT')                   ,
(0, 'Ireland', 'IE')                   ,
(0, 'Singapore', 'SG')                 ,
(0, 'Thailand', 'TH')                  ,
(0, 'Malaysia', 'MY')                    ,
(0, 'Philippines', 'PH')                ,
(0, 'Poland', 'PL')                     ,
(0, 'Hungary', 'HU')                    ,
(0, 'Czech Republic', 'CZ')              ,
(0, 'Switzerland', 'CH')               ,
(0, 'Finland', 'FI')                   ,
(0, 'Chile', 'CL')                     ,
(0, 'Colombia', 'CO')                 ,
(0, 'Peru', 'PE')                     ,
(0, 'Egypt', 'EG')                    ,
(0, 'Saudi Arabia', 'SA')             ,
(0, 'United Arab Emirates', 'AE')     ,
(0, 'Israel', 'IL')          ,
(0, 'Iran', 'IR')          ,
(0, 'Nigeria', 'NG')        ,
(0, 'Kenya', 'KE')        ,
(0, 'South Africa', 'ZA');


select * from countries;

use myTestDB;

drop table adresses;


create table if not exists adresses
(
    adressID integer primary key not null auto_increment,
    street varchar(50) not null,
    code varchar(50) not null,
    town varchar(50) not null,
    country varchar(50) not null,
    countryID int,
    foreign key (countryID) references countries(countryID)
);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (1, 'Baldernstrasse 10', '8802', 'Kilchberg', 'Switzerland', 23);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (2, '1600 Amphitheatre Parkway', '94043', 'Mountain View', 'United States', 1);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (3, '10 Downing Street', 'SW1A 2AA', 'London', 'United Kingdom', 2);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (4, 'Eiffel Tower', '75007', 'Paris', 'France', 3);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (5, 'Red Square', '109012', 'Moscow', 'Russia', 13);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (6, '1600 Pennsylvania Avenue NW', '20500', 'Washington, D.C.', 'United States', 1);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (7, 'Sydney Opera House', '2000', 'Sydney', 'Australia', 6);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (8, 'The Great Wall of China', '100040', 'Beijing', 'China', 12);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (9, 'Taj Mahal', '282001', 'Agra', 'India', 10);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (10, 'Christ the Redeemer', '22221-125', 'Rio de Janeiro', 'Brazil', 11);
INSERT INTO adresses (adressID, street, code, town, country, countryID) VALUES (11, 'Pyramid of Giza', '12566', 'Giza', 'Egypt', 42);


select adresses.adressID, adresses.street, adresses.code, adresses.town,adresses.country, countries.code
from adresses, countries
where adresses.countryID = countries.countryID
order by 2;


create table if not exists persons
(
    personID integer primary key not null auto_increment,
    name varchar(255)   not null,
    surname varchar(255),
    birthday varchar(10),
    genderID int,
    foreign key (genderID) references gender(genderId),
    adressID int,
    foreign key (adressID) references adresses(adressID),
    loginID int,
    foreign key (loginID) references logins(loginID)
);

drop table persons;

-- Elvis Presley
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (1, 'Elvis', 'Presley', '1935-01-08', 1, 1, 10);

-- Albert Einstein
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (2, 'Albert', 'Einstein', '1879-03-14', 1, 3, 9);

-- Oprah Winfrey
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (3, 'Oprah', 'Winfrey', '1954-01-29', 2, 7, 8);

-- Leonardo Da Vinci
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (4, 'Leonardo', 'Da Vinci', '1452-04-15', 1, 4, 7);

-- Marilyn Monroe
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (5, 'Marilyn', 'Monroe', '1926-06-01', 2, 5, 6);

-- Abraham Lincoln
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (6, 'Abraham', 'Lincoln', '1809-02-12', 1, 6, 5);

-- Steve Jobs
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (7, 'Steve', 'Jobs', '1955-02-24', 1, 2, 4);

-- Beyonce
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (8, 'Beyonce', '', '1981-09-04', 2, 8, 3);

-- Nelson Mandela
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (9, 'Nelson', 'Mandela', '1918-07-18', 1, 9, 2);

-- Marie Curie
INSERT INTO persons (personID, name, surname, birthday, genderID, adressID, loginID) VALUES (10, 'Marie', 'Curie', '1867-11-07', 2, 10, 1);


select persons.personID,logins.loginID, logins.user, logins.password, persons.name, persons.surname
     , persons.birthday, gender.gender, gender.abrev
     , adresses.street, adresses.code, adresses.town, countries.country, countries.code
from adresses, countries, gender, persons, logins
where persons.adressID = adresses.adressID
and persons.genderID = gender.genderID
and adresses.countryID = countries.countryID
and persons.loginID = logins.loginID
order by 1;



select * from gender;

use myTestDB;


create  database DispensenDB;

use DispensenDB;

create table if not exists files
(
    fileID integer primary key not null auto_increment,
    file_name varchar(255)   not null,
    file_data LONGBLOB
);

select * from login


CREATE TABLE user (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  loginID INT,
  locationID INT,
  genderID INT,
  name VARCHAR(255),
  surname VARCHAR(255),
  email VARCHAR(255),
  phone_number VARCHAR(20),
  class VARCHAR(255),
  FOREIGN KEY (loginID) REFERENCES login(loginID),
  FOREIGN KEY (locationID) REFERENCES locations(locationID),
  FOREIGN KEY (genderID) REFERENCES gender(genderID)
);

CREATE TABLE dispensions (
  dispensionID INT PRIMARY KEY AUTO_INCREMENT,
  userID INT,
  start_date DATE,
  end_date DATE,
  reasonID INT,
  comment VARCHAR(255),
  lessionID INT,
  teachers VARCHAR(255),
  work_check BOOLEAN,
  parent_check BOOLEAN,
  JobID INT,
  fileID INT,
  FOREIGN KEY (userID) REFERENCES user(user_id),
  FOREIGN KEY (reasonID) REFERENCES reasons(reasonID),
  FOREIGN KEY (lessionID) REFERENCES lessions(lessionID),
  FOREIGN KEY (JobID) REFERENCES jobs(jobID),
  FOREIGN KEY (fileID) REFERENCES files(fileID)
);

show tables;

use dispensenDB;

INSERT INTO reasons (reason, reason_abrev) VALUES
('Medical', 'MED'),
('Family Emergency', 'FAM'),
('Personal', 'PER'),
('Other', 'OTH'),
('Unknown', 'UNK');

select * from user;

INSERT INTO jobs (job) VALUES
('Mediamatiker/Mediamatikerin'),
('Informatiker/Informatikerin'),
('Kauffrau/Kaufmann'),
('Fachmann/Fachfrau Betreuung');

INSERT INTO files (file_name, file_data) VALUES
('file1.pdf','URL'),
('file2.docx'),
('file3.txt'),
('file4.jpg'),
('file5.png'),
('file6.xlsx'),
('file7.png'),
('file8.docx'),
('file9.pdf'),
('file10.jpg');


INSERT INTO dispensions (userID, start_date, end_date, reasonID, comment, lessionID, teachers, work_check, parent_check, JobID, fileID) VALUES
(51, '2023-01-01', '2023-01-05', 1, 'Medical leave', 1, 'Mr. Smith', 1, 0, 2, 1),
(52, '2023-02-01', '2023-02-05', 2, 'Family emergency', 2, 'Mrs. Johnson', 1, 1, 1, 2),
(53, '2023-03-01', '2023-03-05', 3, 'Personal reasons', 3, 'Mr. Davis', 0, 0, 2, 1),
(54, '2023-04-01', '2023-04-05', 4, 'Other reason', 4, 'Ms. Williams', 1, 1, 3, 2),
(55, '2023-05-01', '2023-05-05', 5, 'Unknown reason', 5, 'Mr. Brown', 0, 0, 4, 3),
(56, '2023-06-01', '2023-06-05', 1, 'Medical leave', 1, 'Mr. Smith', 1, 0, 2, 1),
(57, '2023-07-01', '2023-07-05', 2, 'Family emergency', 2, 'Mrs. Johnson', 1, 1, 3, 2),
(58, '2023-08-01', '2023-08-05', 3, 'Personal reasons', 3, 'Mr. Davis', 0, 0, 4, 3),
(59, '2023-09-01', '2023-09-05', 4, 'Other reason', 4, 'Ms. Williams', 1, 1, 2, 4),
(60, '2023-10-01', '2023-10-05', 5, 'Unknown reason', 5, 'Mr. Brown', 0, 0, 1, 5);


INSERT INTO gender (gender, abrev) VALUES
('Male', 'M'),
('Female', 'F'),
('Other', 'O');

INSERT INTO locations (location) VALUES
('Horgen See'),
('Stäfä'),
('Horgen Oberdorf');

INSERT INTO login (username, password) VALUES
('user1', 'pass1'),
('user2', 'pass2'),
('user3', 'pass3'),
('user4', 'pass4'),
('user5', 'pass5'),
('user6', 'pass6'),
('user7', 'pass7'),
('user8', 'pass8'),
('user9', 'pass9'),
('user10', 'pass10');

INSERT INTO user (loginID, locationID, genderID, name, surname, email, phone_number, class) VALUES
(1, 1, 1, 'John', 'Doe', 'john.doe@example.com', '1234567890', 'ClassA'),
(2, 2, 2, 'Alice', 'Johnson', 'alice.j@example.com', '9876543210', 'ClassB'),
(3, 3, 1, 'Bob', 'Williams', 'bob.w@example.com', '4567890123', 'ClassC'),
(4, 1, 2, 'Eva', 'Davis', 'eva.d@example.com', '7890123456', 'ClassD'),
(5, 1, 1, 'Charlie', 'Smith', 'charlie.s@example.com', '5678901234', 'ClassE'),
(6, 1, 2, 'Sophia', 'Brown', 'sophia.b@example.com', '8901234567', 'ClassF'),
(7, 2, 1, 'Henry', 'Jones', 'henry.j@example.com', '2345678901', 'ClassG'),
(8, 1, 2, 'Olivia', 'Taylor', 'olivia.t@example.com', '3456789012', 'ClassH'),
(9, 1, 1, 'Liam', 'Anderson', 'liam.a@example.com', '4567890123', 'ClassI'),
(10, 1, 2, 'Ava', 'White', 'ava.w@example.com', '5678901234', 'ClassJ');



INSERT INTO lessions (lession) VALUES
('M101'),
('M202'),
('M303'),
('M404'),
('M505'),
('M606'),
('M707'),
('M808'),
('M909'),
('M010'),
('M011');

select * from lessions;

select d.start_date, d.end_date, u.name, u.surname, u.email, u.phone_number, u.class, l.location, d.dispensionID, d.reasonID, r.reason, r.reason_abrev, d.JobID,j.jobID,j.job
from user u, locations l, dispensions d, reasons r, jobs j
where j.jobID = d.jobID
and r.reasonID = d.reasonID
and u.locationID = l.locationID
and u.user_id = d.userID
order by 2;

Select * from jobs;

use dispensenDB

show tables;

select * from lessions;

INSERT INTO dispensions (userID, start_date, end_date, reasonID, comment, lessionID, teachers, work_check, parent_check, JobID, fileID) VALUES
(51, '2024-01-01', '2024-01-05', 1, 'Ist Krank und hat ein Artztzeugnis', 3, 'Mr. Demir', 1, 1, 3, 9);

delete from lessions where lessionID >10;

UPDATE lessions
SET lession = 'M102'
WHERE lessionID = 1;

create table test_name(
name int,
email int);

select * from user;
SELECT *  FROM dispensions d, user u  WHERE u.user_id = 51;

select d.start_date, d.end_date, u.name, u.surname, u.email, u.phone_number, u.class, l.location, d.dispensionID, d.reasonID, r.reason, r.reason_abrev, d.JobID,j.jobID,j.job
from user u, locations l, dispensions d, reasons r, jobs j
where d.userID = 51
and r.reasonID = d.reasonID
and u.locationID = l.locationID
and j.jobID = d.jobID
order by 2;

select * from files;

SELECT
    d.dispensionID,
    u.user_id,
    d.start_date,
    d.end_date,
    u.name,
    u.surname,
    u.email,
    u.phone_number,
    u.class,
    d.teachers,
    l.location,
    r.reason,
    r.reason_abrev,
    d.comment,
    j.job,
    d.work_check,
    d.parent_check,
    f.file_name,
    f.file_data,
    d.accepted
FROM
    dispensions d
JOIN
    user u ON d.userID = u.user_id
JOIN
    locations l ON u.locationID = l.locationID
JOIN
    reasons r ON r.reasonID = d.reasonID
JOIN
    jobs j ON j.jobID = d.jobID
JOIN
    files f ON f.fileID = d.fileID
WHERE
    d.userID = 51;

select *
from dispensions;
alter table user drop column admin;

alter table login add column admin int1;

insert into login (loginID, username, password, admin)
values ("0", "admin2", "admin2","1");

update login set admin = "0" where loginID<11;

update dispensions set accepted = "" where dispensionID <246;

select * from dispensions where dispensionID =252;

select * from dispensions;

SELECT * FROM dispensions WHERE dispensionID = 253 ORDER BY end_date;

start date, end date, reasonID, comment, lessionID, teachers. work check, parent check and jobID