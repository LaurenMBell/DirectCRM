/*
Lauren Bell and Spencer Berg, Group 37

AI Usage: Gemini was used to generate subqueries for selecting all employees 
who are managers and query for updating a users ticket status

Prompt: "does this get all employees who are managers? SELECT fNameEmp, ManagerID from Employees;
*/

-- get all users and their ids
SELECT UserID, fNameUser, lNameUser from Users;

-- get all products and their ids
SELECT * from Products;

-- get all clients whose revenue is above 2 billion
SELECT ClientName, Revenue FROM Clients WHERE Revenue > 2000000000;

-- get all support tickets for a specific employee
SELECT 
    TicketID, 
    TicketStatus, 
    `Description`
FROM SupportTickets
WHERE EmployeeID = @EmployeeID_selected_from_browse_employees_page;

-- get all employees who are managers
SELECT fNameEmp, lNameEmp from Employees WHERE EmployeeID IN (SELECT ManagerID from Employees);

-- get info about a selected user
SELECT UserID, fNameUser, lNameUser, ClientID FROM Users WHERE UserID = @UserID_selected_from_browse_user_page;

-- get all users with support tickets
SELECT UserID, TicketStatus, `Description` FROM SupportTickets;

-- get a user's licenses
SELECT UserID, LicenseID, Expiration FROM Licenses;

-- update the selected user's ticket to resolved
UPDATE SupportTickets
SET TicketStatus = 'Resolved'
WHERE UserID = @UserID_selected_from_browse_user_page;

-- many to many for UserProducts
INSERT INTO UserProducts (UserProductsID, UserID, ProductID) VALUES (@UserProductsIDInput, @UserID_selected_from_dropdown_Input, @ProductID_selected_from_dropdown_Input); 

UPDATE UserProducts SET UserProductsID = @UserProductsIDInput,  ProductID = @ProductID_from_dropdown_Input WHERE UserID = @UserID_from_the_update_form;

-- delete a product from a selected user
DELETE FROM UserProducts WHERE UserID = @UserID_selected_from_dropdown_Input AND ProductID = @ProductID_selected_from_dropdown_Input;