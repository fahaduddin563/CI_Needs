USE cineedsc_db;

DROP PROCEDURE IF EXISTS ban_user;
DELIMITER //
CREATE PROCEDURE ban_user (IN inUserID INT) BEGIN UPDATE CIN_User SET banned = TRUE WHERE userID = inUserID; END//
DELIMITER ;

DROP PROCEDURE IF EXISTS flag_post;
DELIMITER //
CREATE PROCEDURE flag_post (IN inPostID INT) BEGIN UPDATE CIN_Post SET flagCount = flagCount + 1 WHERE postID = inPostID; END//
DELIMITER ;

SELECT * FROM CIN_User;
CALL ban_user(1);
SELECT * FROM CIN_User;

DROP PROCEDURE IF EXISTS graveyard_post;
DELIMITER //
CREATE PROCEDURE graveyard_post (IN inPostID INT, IN inAdminID INT, IN inReason VARCHAR(255))
BEGIN
    -- Copy the post into CIN_Graveyard before deleting
    INSERT INTO CIN_Graveyard (postID, adminID, userID, postType, category, postTitle, postData, postDate, imagePath, contact, flagCount, reason, deletedDate)
    SELECT postID, inAdminID, userID, postType, category, postTitle, postData, postDate, imagePath, contact, flagCount, inReason, CURDATE()
    FROM CIN_Post
    WHERE postID = inPostID;

    -- Delete the post from the live table
    DELETE FROM CIN_Post WHERE postID = inPostID;
END//
DELIMITER ;