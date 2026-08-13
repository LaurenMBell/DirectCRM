-- Lauren Bell and Spencer Berg, Group 37  ---

-- Adapted from code from PL/SQL Explorations in Canvas: https://canvas.oregonstate.edu/courses/2051721/pages/exploration-pl-slash-sql-part-2-stored-procedures-for-cud?module_item_id=26923362

-- Used to demo resetting the db in Step 4
DROP PROCEDURE IF EXISTS DeleteRichardSmith;

DELIMITER //
CREATE PROCEDURE DeleteRichardSmith()
BEGIN
    UPDATE Employees SET ManagerID = NULL WHERE ManagerID = 'rsmith';
    DELETE FROM SupportTickets WHERE EmployeeID = 'rsmith';
    DELETE FROM Employees WHERE EmployeeID = 'rsmith';
END //
DELIMITER ;


-- InsertProduct Procedure
DROP PROCEDURE IF EXISTS InsertProduct;

DELIMITER //
CREATE PROCEDURE InsertProduct (
    IN p_Item VARCHAR(255),
    IN p_GenreID VARCHAR(255),
    IN p_Rating VARCHAR(255),
    IN p_Active TINYINT(1),
    OUT p_NewMovieID INT
)
COMMENT 'Insert product'
BEGIN
    INSERT INTO `movie-Movies` (Item, GenreID, Rating, Active)
    VALUES (p_Item, p_GenreID, p_Rating, p_Active);
    
    SET p_NewMovieID = LAST_INSERT_ID();
END //
DELIMITER ;


-- InsertClient Procedure
DROP PROCEDURE IF EXISTS InsertClient;

DELIMITER //
CREATE PROCEDURE InsertClient (
    IN p_ClientID VARCHAR(255),
    IN p_ClientName VARCHAR(255),
    IN p_Revenue DECIMAL(15, 2)
)
BEGIN
    INSERT INTO Clients (ClientID, ClientName, Revenue)
    VALUES (p_ClientID, p_ClientName, p_Revenue);
END //
DELIMITER ;