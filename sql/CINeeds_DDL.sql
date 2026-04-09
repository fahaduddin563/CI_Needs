USE cineedsc_db;

DROP TABLE IF EXISTS CIN_Reply;
DROP TABLE IF EXISTS CIN_Post;
DROP TABLE IF EXISTS CIN_User;
-- Table containing user login info
CREATE TABLE CIN_User (
userID INT,
username VARCHAR(32),
password VARCHAR(32),
banned BOOLEAN DEFAULT FALSE,
PRIMARY KEY (userID));

-- Table containing all data required for posts
CREATE TABLE CIN_Post (
postID INT AUTO_INCREMENT,
userID INT,
postType VARCHAR(8), -- either REQUEST or OFFER
category VARCHAR(16), -- can be the following values: food, housing, financial, health, academic, other
postTitle VARCHAR(32),
postData TINYTEXT,
postDate DATE,
offerExpDate DATE, -- can be null if not an offer
imagePath VARCHAR(255) DEFAULT NULL,
contact   VARCHAR(255) DEFAULT NULL,
flagCount INT DEFAULT 0,
PRIMARY KEY (postID),
FOREIGN KEY (userId) REFERENCES CIN_User(userID));

CREATE TABLE CIN_Reply (
    replyID INT AUTO_INCREMENT,
    userID INT,
    postID INT,
    replyData TINYTEXT,
    replyDate DATE,
    PRIMARY KEY (replyID),
    FOREIGN KEY (userID) REFERENCES CIN_User (userID),
    FOREIGN KEY (postID) REFERENCES CIN_Post (postID)
)


-- Table containing posts removed by an admin (graveyard)
-- Original post data is copied here before deletion from CIN_Post
CREATE TABLE CIN_Graveyard (
graveyardID  INT AUTO_INCREMENT,
postID       INT,               -- original post ID (kept for reference)
adminID      INT,               -- userID of the admin who removed the post
userID       INT,               -- original post owner
postType     VARCHAR(8),
category     VARCHAR(16),
postTitle    VARCHAR(32),
postData     TINYTEXT,
postDate     DATE,
imagePath    VARCHAR(255) DEFAULT NULL,
contact      VARCHAR(255) DEFAULT NULL,
flagCount    INT DEFAULT 0,
reason       VARCHAR(255),      -- reason provided by the admin
deletedDate  DATE,              -- date the post was sent to graveyard
PRIMARY KEY (graveyardID),
FOREIGN KEY (adminID) REFERENCES CIN_User(userID)
);