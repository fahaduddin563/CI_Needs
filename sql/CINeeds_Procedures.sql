USE cineedsc_db;

DROP PROCEDURE IF EXISTS ban_user;
DELIMITER //
CREATE PROCEDURE ban_user (IN inUserID INT) BEGIN UPDATE CIN_User SET banned = TRUE WHERE userID = inUserID; END//
DELIMITER ;

DROP PROCEDURE IF EXISTS flag_post;
DELIMITER //
CREATE PROCEDURE flag_post (IN inPostID INT, IN inFlagReason VARCHAR(40), IN inFlagComment TINYTEXT) BEGIN 
INSERT INTO CIN_Flag (postID, flagReason, flagComment) VALUE (inPostID, inFlagReason, inFlagComment);
END//
DELIMITER ;

-- SELECT * FROM CIN_User;
-- CALL ban_user(1);
-- SELECT * FROM CIN_User;

-- SELECT * FROM CIN_Flag;
-- CALL flag_post(2, "test", "test");
-- SELECT * FROM CIN_Flag;