DROP DATABASE IF EXISTS CINeeds;
CREATE DATABASE CINeeds;
USE CINeeds;

--Table containing user login info
CREATE TABLE CIN_User (
userID INT,
username VARCHAR(32),
password VARCHAR(32),
PRIMARY KEY (userID));

--Table containing all data required for posts
CREATE TABLE CIN_Post (
postID INT AUTO_INCREMENT,
userID INT,
postType VARCHAR(8), --either REQUEST or OFFER
category VARCHAR(16), --can be the following values: food, housing, financial, health, academic, other
postTitle VARCHAR(32),
postData TINYTEXT,
postDate DATE,
offerExpDate DATE, --can be null if not an offer
PRIMARY KEY (postID),
FOREIGN KEY (userId) REFERENCES CIN_User(userID));

--Add imagePath and contact to CIN_Post table
ALTER TABLE CIN_Post
ADD COLUMN imagePath VARCHAR(255) DEFAULT NULL,
ADD COLUMN contact   VARCHAR(255) DEFAULT NULL;