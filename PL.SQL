-- Lauren Bell and Spencer Berg, Group 37  ---

-- Adapted from code from PL/SQL Explorations in Canvas: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=26923362

DROP PROCEDURE IF EXISTS DeleteRichardSmith;
DELIMITER //
CREATE PROCEDURE DeleteRichardSmith()
BEGIN
    DELETE FROM Employee
    WHERE EmployeeID = 'rsmith';
END //
DELIMITER ;