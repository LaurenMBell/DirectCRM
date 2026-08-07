-- Lauren Bell and Spencer Berg, Group 37  ---

DROP PROCEDURE IF EXISTS DeleteHanselGreene;
DELIMITER //
CREATE PROCEDURE DeleteHanselGreene()
BEGIN
    DELETE FROM SupportTickets
    WHERE UserID IN (
        SELECT UserID FROM Users
        WHERE fNameUser = 'Hansel' AND lNameUser = 'Greene'
    );

    DELETE FROM Users
    WHERE fNameUser = 'Hansel' AND lNameUser = 'Greene';
END //
DELIMITER ;