-- Lauren Bell and Spencer Berg, Group 37  ---

DELIMITER //
CREATE PROCEDURE DeleteHanselGreene()
BEGIN
    DELETE FROM users WHERE fNameUser = 'Hansel' AND lNameUser = 'Greene'
END
DELIMITER;