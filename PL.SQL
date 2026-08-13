-- Lauren Bell and Spencer Berg, Group 37  ---

-- Adapted from code from PL/SQL Explorations in Canvas: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=26923362

DROP PROCEDURE IF EXISTS DeleteRichardSmith;
CREATE PROCEDURE DeleteRichardSmith()
BEGIN
    UPDATE Employees SET ManagerID = NULL WHERE ManagerID = 'rsmith';
    DELETE FROM SupportTickets WHERE EmployeeID = 'rsmith';
    DELETE FROM Employees WHERE EmployeeID = 'rsmith';
END