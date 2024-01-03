drop database DispensenDB1;
create database DispensenDB1;

use DispensenDB1;

CREATE TABLE IF NOT EXISTS login(
    loginID int primary key auto_increment,
    username varchar(255) not null ,
    password varchar(255) not null ,
    admin tinyint
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

INSERT INTO files (file_name, file_data) VALUES
('file1.pdf','URL'),
('file2.docx','URL'),
('file3.txt','URL'),
('file4.jpg','URL'),
('file5.png','URL'),
('file6.xlsx','URL'),
('file7.png','URL'),
('file8.docx','URL'),
('file9.pdf','URL'),
('file10.jpg','URL');

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
(1, 1, 1, 'John', 'Doe', 'john.doe@example.com', '1234567890', 'ClassA'),
(2, 2, 2, 'Alice', 'Johnson', 'alice.j@example.com', '9876543210', 'ClassB'),
(3, 3, 1, 'Bob', 'Williams', 'bob.w@example.com', '4567890123', 'ClassC'),
(4, 1, 2, 'Eva', 'Davis', 'eva.d@example.com', '7890123456', 'ClassA'),
(5, 1, 1, 'Charlie', 'Smith', 'charlie.s@example.com', '5678901234', 'ClassB'),
(6, 1, 2, 'Sophia', 'Brown', 'sophia.b@example.com', '8901234567', 'ClassC'),
(7, 2, 1, 'Henry', 'Jones', 'henry.j@example.com', '2345678901', 'ClassA'),
(8, 1, 2, 'Olivia', 'Taylor', 'olivia.t@example.com', '3456789012', 'ClassB'),
(9, 1, 1, 'Liam', 'Anderson', 'liam.a@example.com', '4567890123', 'ClassC'),
(10, 1, 2, 'Ava', 'White', 'ava.w@example.com', '5678901234', 'ClassA');

INSERT INTO dispensions (userID, start_date, end_date, reasonID, comment, lessionID, teachers, work_check, parent_check, JobID, fileID) VALUES
(1, '2023-01-01', '2023-01-05', 1, 'Medical leave', 1, 'Mr. Smith', 1, 1, 2, 1),
(2, '2023-02-01', '2023-02-05', 2, 'Family emergency', 2, 'Mrs. Johnson', 1, 1, 1, 2),
(3, '2023-03-01', '2023-03-05', 3, 'Personal reasons', 3, 'Mr. Davis', 1, 1, 2, 1),
(4, '2023-04-01', '2023-04-05', 4, 'Other reason', 4, 'Ms. Williams', 1, 1, 3, 2),
(5, '2023-05-01', '2023-05-05', 5, 'Unknown reason', 5, 'Mr. Brown', 1, 1, 4, 3),
(6, '2023-06-01', '2023-06-05', 1, 'Medical leave', 1, 'Mr. Smith', 1, 1, 2, 1),
(7, '2023-07-01', '2023-07-05', 2, 'Family emergency', 2, 'Mrs. Johnson', 1, 1, 3, 2),
(8, '2023-08-01', '2023-08-05', 3, 'Personal reasons', 3, 'Mr. Davis', 1, 1, 4, 3),
(9, '2023-09-01', '2023-09-05', 4, 'Other reason', 4, 'Ms. Williams', 1, 1, 2, 4),
(10, '2023-10-01', '2023-10-05', 5, 'Unknown reason', 5, 'Mr. Brown', 1, 1, 1, 5);

