create database DispensenDB;
use DispensenDB;

CREATE TABLE IF NOT EXISTS login(
    loginID int primary key auto_increment,
    username varchar(255) not null ,
    password varchar(255) not null ,
    admin tinyint DEFAULT 0
);

create table if not exists files
(
    fileID integer primary key not null auto_increment,
    file_name varchar(255)   not null,
    file_data LONGBLOB
);
create table if not exists reasons
(
    reasonID integer primary key not null auto_increment,
    reason varchar(255),
    reason_abrev varchar(50)
);

create table if not exists locations
(
    locationID integer primary key not null auto_increment,
    location varchar(255)
);

create table if not exists lessions
(
    lessionID integer primary key not null auto_increment,
    lession varchar(255)
);

create table if not exists jobs
(
    jobID integer primary key not null auto_increment,
    job varchar(255)
);

create table if not exists gender
(
    genderID integer primary key not null auto_increment,
    gender varchar(255),
    abrev varchar(1)
);

CREATE TABLE IF NOT EXISTS user (
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
  accepted INT DEFAULT 0,
  FOREIGN KEY (userID) REFERENCES user(user_id),
  FOREIGN KEY (reasonID) REFERENCES reasons(reasonID),
  FOREIGN KEY (lessionID) REFERENCES lessions(lessionID),
  FOREIGN KEY (JobID) REFERENCES jobs(jobID),
  FOREIGN KEY (fileID) REFERENCES files(fileID)
);

INSERT INTO login (username, password, admin) VALUES
('user1', 'pass1', 0),
('user2', 'pass2', 0),
('user3', 'pass3', 0),
('user4', 'pass4', 0),
('user5', 'pass5', 0),
('user6', 'pass6', 0),
('user7', 'pass7', 0),
('user8', 'pass8', 0),
('user9', 'pass9', 0),
('user10', 'pass10', 0),
('admin', 'admin1', 1);

INSERT INTO locations (location) VALUES
('Horgen See'),
('Stäfa'),
('Horgen Oberdorf');

INSERT INTO gender (gender, abrev) VALUES
('Male', 'M'),
('Female', 'F'),
('Other', 'O');

INSERT INTO reasons (reason, reason_abrev) VALUES
('Medical', 'M'),
('Personal', 'P'),
('Family Emergency', 'F'),
('Other', 'O'),
('Unknown', 'U');

INSERT INTO jobs (job) VALUES
('Mediamatiker/Mediamatikerin'),
('Informatiker/Informatikerin'),
('Kauffrau/Kaufmann'),
('Fachmann/Fachfrau Betreuung');


INSERT INTO files (fileID, file_name, file_data) VALUES
(0,'file1.pdf','URL'),
(0,'file2.docx','URL'),
(0,'file3.txt','URL'),
(0,'file4.jpg','URL'),
(0,'file5.png','URL'),
(0,'file6.xlsx','URL'),
(0,'file7.png','URL'),
(0,'file8.docx','URL'),
(0,'file9.pdf','URL'),
(0,'file10.jpg','URL'),
(0,'file11.pdf','URL'),
(0,'file12.docx','URL'),
(0,'file13.txt','URL'),
(0,'file14.jpg','URL'),
(0,'file15.png','URL'),
(0,'file16.xlsx','URL'),
(0,'file17.png','URL'),
(0,'file18.docx','URL'),
(0,'file19.pdf','URL'),
(0,'file20.jpg','URL'),
(0,'file21.pdf','URL'),
(0,'file22.docx','URL'),
(0,'file23.txt','URL'),
(0,'file24.jpg','URL'),
(0,'file25.png','URL'),
(0,'file26.xlsx','URL'),
(0,'file27.png','URL'),
(0,'file28.docx','URL'),
(0,'file29.pdf','URL'),
(0,'file30.jpg','URL');

INSERT INTO lessions (lession) VALUES
('M258'),
('M261'),
('M264'),
('M267'),
('M270'),
('M273'),
('M276'),
('M279'),
('M282'),
('M285');

INSERT INTO user (loginID, locationID, genderID, name, surname, email, phone_number, class) VALUES
(1, 1, 1, 'Noah', 'Müller', 'noah.muller@gmail.com', '079 123 23 42', 'ClassA'),
(2, 2, 2, 'Mia', 'Meier', 'mia.meier@hotmail.com', '078 234 34 53', 'ClassB'),
(3, 3, 1, 'Luca', 'Schmid', 'luca.schmid@outlook.com', '077 345 45 64', 'ClassC'),
(4, 1, 2, 'Emma', 'Keller', 'emma.keller@yahoo.com', '076 456 56 75', 'ClassA'),
(5, 1, 1, 'Leon', 'Weber', 'leon.weber@gmail.com', '079 567 67 86', 'ClassB'),
(6, 1, 2, 'Sofia', 'Schneider', 'sofia.schneider@outlook.com', '078 678 78 97', 'ClassC'),
(7, 2, 1, 'Gabriel', 'Huber', 'gabriel.huber@yahoo.com', '077 789 89 01', 'ClassA'),
(8, 1, 2, 'Lina', 'Meyer', 'lina.meyer@gmail.com', '076 890 90 12', 'ClassB'),
(9, 1, 1, 'Elias', 'Steiner', 'elias.steiner@yahoo.com', '079 901 01 23', 'ClassC'),
(10, 1, 3, 'Alex', 'Suter', 'alex.suter@gmail.com', '079 234 34 56', 'ClassB');


INSERT INTO dispensions (userID, start_date, end_date, reasonID, comment, lessionID, teachers, work_check, parent_check, JobID, fileID, accepted)
VALUES
(1, '2023-01-01', '2023-01-05', 2, 'I will be attending a medical appointment on these dates. It is essential for my health check-up.', 1, 'Mr. Smith', 1, 1, 2, 1, 1), -- Past and accepted
(1, '2024-02-10', '2024-02-15', 3, 'A sudden family emergency requires my immediate attention and presence. I need to be with my family during this tough time.', 1, 'Mr. Smith', 1, 1, 2, 2, 1), -- Future and accepted
(1, '2024-03-01', '2024-03-05', 1, 'I require a personal day off to handle some private matters. Urgent personal business demands my attention.', 1, 'Mr. Smith', 1, 1, 2, 3, 0), -- Future and not accepted
(2, '2023-02-01', '2023-02-05', 4, 'Due to unforeseen circumstances, I wont be able to attend class on these dates. An unexpected situation has arisen, and I need some time to deal with it.', 2, 'Mrs. Johnson', 1, 1, 3, 4, 1), -- Past and accepted
(2, '2024-02-20', '2024-02-25', 2, 'I will be out of town for a family funeral during this period. I need time off to attend this important family event.', 2, 'Mrs. Johnson', 1, 1, 3, 5, 0), -- Future and not accepted
(2, '2024-03-01', '2024-03-05', 5, 'I have an unknown situation that requires my absence from class. Unforeseen circumstances prevent my attendance. I appreciate your understanding.', 2, 'Mrs. Johnson', 1, 1, 3, 6, 1), -- Future and accepted
(3, '2023-03-01', '2023-03-05', 1, 'Medical reasons prevent me from attending class on these dates. Health issues need my immediate attention. I will keep you updated on my progress.', 3, 'Mr. Davis', 1, 1, 4, 7, 1), -- Past and accepted
(3, '2024-03-10', '2024-03-15', 3, 'I will be taking a personal day to handle private matters. Urgent personal business to attend to. I appreciate your support during this time.', 3, 'Mr. Davis', 1, 1, 4, 8, 1), -- Future and accepted
(3, '2024-04-01', '2024-04-05', 4, 'I have an unusual circumstance preventing me from attending class on these dates. An unexpected situation has arisen. Your understanding is highly appreciated.', 3, 'Mr. Davis', 1, 1, 4, 9, 0), -- Future and not accepted
(4, '2023-04-01', '2023-04-05', 5, 'Due to an unknown situation, I will be absent from class during this period. Unforeseen circumstances prevent my attendance. I apologize for any inconvenience.', 4, 'Ms. Williams', 1, 1, 3, 10, 1), -- Past and accepted
(4, '2024-04-10', '2024-04-15', 2, 'I will be out of town for a family funeral during this period. Need time off for a family event. Your understanding is much appreciated.', 4, 'Ms. Williams', 1, 1, 3, 11, 1), -- Future and accepted
(4, '2024-05-01', '2024-05-05', 1, 'Medical reasons require me to take a day off from class. Health issues need my immediate attention. Thank you for your support.', 4, 'Ms. Williams', 1, 1, 3, 12, 0), -- Future and not accepted
(5, '2023-05-01', '2023-05-05', 4, 'Unforeseen circumstances prevent me from attending class on these dates. An unexpected situation has arisen. I appreciate your understanding during this time.', 5, 'Mr. Brown', 1, 1, 4, 13, 1), -- Past and accepted
(5, '2024-05-10', '2024-05-15', 3, 'I will be out of town for a family funeral during this period. Need time off for a family event. Your understanding is much appreciated.', 5, 'Mr. Brown', 1, 1, 4, 15, 0), -- Future and not accepted
(6, '2023-06-01', '2023-06-05', 5, 'Due to an unknown situation, I will be absent from class on these dates. Unforeseen circumstances prevent my attendance. I appreciate your understanding during this time.', 1, 'Mr. Smith', 1, 1, 2, 16, 1), -- Past and accepted
(6, '2024-06-10', '2024-06-15', 4, 'I have an unusual circumstance preventing me from attending class on these dates. An unexpected situation has arisen. Thank you for your support.', 1, 'Mr. Smith', 1, 1, 2, 17, 1), -- Future and accepted
(6, '2024-07-01', '2024-07-05', 1, 'Medical reasons prevent me from attending class on these dates. Health issues need my immediate attention. Your understanding is much appreciated.', 1, 'Mr. Smith', 1, 1, 2, 18, 0), -- Future and not accepted
(7, '2023-07-01', '2023-07-05', 2, 'I will be out of town for a family funeral during this period. Need time off for a family event. Your understanding is much appreciated.', 2, 'Mrs. Johnson', 1, 1, 3, 19, 1), -- Past and accepted
(7, '2024-07-10', '2024-07-15', 3, 'I will be taking a personal day to handle private matters. Urgent personal business to attend to. I appreciate your support during this time.', 2, 'Mrs. Johnson', 1, 1, 3, 20, 1), -- Future and accepted
(7, '2024-08-01', '2024-08-05', 5, 'Due to an unknown situation, I will be absent from class on these dates. Unforeseen circumstances prevent my attendance. I apologize for any inconvenience.', 2, 'Mrs. Johnson', 1, 1, 3, 21, 0), -- Future and not accepted
(8, '2023-08-01', '2023-08-05', 3, 'I will be taking a personal day to handle private matters. Urgent personal business to attend to. I appreciate your support during this time.', 3, 'Mr. Davis', 1, 1, 1, 22, 1), -- Past and accepted
(8, '2024-08-10', '2024-08-15', 1, 'Medical reasons prevent me from attending class on these dates. Health issues need my immediate attention. Thank you for your understanding.', 3, 'Mr. Davis', 1, 1, 1, 23, 1), -- Future and accepted
(8, '2024-09-01', '2024-09-05', 2, 'I will be out of town for a family funeral during this period. Need time off for a family event. Your understanding is much appreciated.', 3, 'Mr. Davis', 1, 1, 1, 24, 0), -- Future and not accepted
(9, '2023-09-01', '2023-09-05', 4, 'I have an unusual circumstance preventing me from attending class on these dates. An unexpected situation has arisen. I appreciate your understanding during this time.', 4, 'Ms. Williams', 1, 1, 1, 25, 1), -- Past and accepted
(9, '2024-09-10', '2024-09-15', 2, 'I will be out of town for a family funeral during this period. Need time off for a family event. Your understanding is much appreciated.', 4, 'Ms. Williams', 1, 1, 1, 26, 1), -- Future and accepted
(9, '2024-10-01', '2024-10-05', 3, 'I will be taking a personal day to handle private matters. Urgent personal business to attend to. I appreciate your support during this time.', 4, 'Ms. Williams', 1, 1, 1, 27, 0), -- Future and not accepted
(10, '2023-10-01', '2023-10-05', 1, 'Medical reasons require me to take a day off from class. Health issues need my immediate attention. I will keep you updated on my progress.', 5, 'Mr. Brown', 1, 1, 4, 28, 1), -- Past and accepted
(10, '2024-10-10', '2024-10-15', 4, 'Unforeseen circumstances prevent me from attending class on these dates. An unexpected situation has arisen. I apologize for any inconvenience.', 5, 'Mr. Brown', 1, 1, 4, 29, 1), -- Future and accepted
(10, '2024-11-01', '2024-11-05', 3, 'I will be taking a personal day to handle private matters. Urgent personal business to attend to. I appreciate your support during this time.', 5, 'Mr. Brown', 1, 1, 4, 30, 0); -- Future and not accepted

