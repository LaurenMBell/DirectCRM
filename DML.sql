/*
Lauren Bell and Spencer Berg, Group 37

AI Usage (7/29): 

Google Gemini was used to generate subqueries for selecting all employees 
who are managers and query for updating a users ticket status.
Prompt: "Does this get all employees who are managers? SELECT fNameEmp, ManagerID from Employees;"
URL: https://gemini.google.com/app

GitHub Copilot was used to sort written queries to be organized by page. 
Prompt: "Organize the written queries by page in the UI. Do not change any written queries, 
just sort them into their respective pages."
URL: https://github.com/copilot
*/

-- Clients page
-- SELECT queries --
SELECT ClientName, Revenue FROM Clients WHERE Revenue > 2000000000;
SELECT * FROM Clients;

-- INSERT queries --
INSERT INTO Clients (ClientID, ClientName, Revenue)
VALUES (:ClientIDInput, :ClientNameInput, :RevenueInput);

-- DELETE queries --
DELETE FROM Clients
WHERE ClientID = :ClientID_selected_from_dropdown_Input;

-- Products page
-- SELECT queries --
SELECT * from Products;

-- DELETE queries --
DELETE FROM Products
WHERE ProductID = :ProductID_selected_from_dropdown_Input;

-- INSERT queries -- (missing from Step 4, fixed thanks to feedback :) )
INSERT INTO Products (ProductID, ProductName)
VALUES (:ProductID, :ProductName)

-- Users page
-- SELECT queries --
SELECT UserID, fNameUser, lNameUser from Users;
SELECT UserID, fNameUser, lNameUser, ClientID FROM Users WHERE UserID = :UserID_selected_from_browse_user_page;
SELECT * FROM Users;

-- INSERT queries --
INSERT INTO Users (UserID, fNameUser, lNameUser, ClientID, `Password`, SecurityQuestion, SecurityAnswer)
VALUES (:UserIDInput, :FirstNameInput, :LastNameInput, :ClientIDInput, :PasswordInput, :SecurityQuestionInput, :SecurityAnswerInput);

-- UPDATE queries --
UPDATE Users
SET fNameUser = :FirstNameInput,
    lNameUser = :LastNameInput,
    ClientID = :ClientIDInput,
    `Password` = :PasswordInput,
    SecurityQuestion = :SecurityQuestionInput,
    SecurityAnswer = :SecurityAnswerInput
WHERE UserID = :UserID_selected_from_dropdown_Input;

-- DELETE queries --
DELETE FROM Users
WHERE UserID = :UserID_selected_from_dropdown_Input;

-- Employees page
-- SELECT queries --
SELECT * FROM Employees;
SELECT fNameEmp, lNameEmp from Employees WHERE EmployeeID IN (SELECT ManagerID from Employees);

-- INSERT queries --
INSERT INTO Employees (EmployeeID, fNameEmp, lNameEmp, ManagerID, Salary, Email)
VALUES (:EmployeeIDInput, :FirstNameInput, :LastNameInput, :ManagerIDInput, :SalaryInput, :EmailInput);

-- UPDATE queries --
UPDATE Employees
SET fNameEmp = :FirstNameInput,
    lNameEmp = :LastNameInput,
    ManagerID = :ManagerIDInput,
    Salary = :SalaryInput,
    Email = :EmailInput
WHERE EmployeeID = :EmployeeID_selected_from_dropdown_Input;

-- DELETE queries --
DELETE FROM Employees
WHERE EmployeeID = :EmployeeID_selected_from_dropdown_Input;

-- Support Tickets page
-- SELECT queries --
SELECT TicketID, TicketStatus, `Description`
FROM SupportTickets
WHERE EmployeeID = :EmployeeID_selected_from_browse_employees_page;
SELECT UserID, TicketStatus, `Description` FROM SupportTickets;
SELECT * FROM SupportTickets;

-- UPDATE queries --
UPDATE SupportTickets
SET TicketStatus = 'Resolved'
WHERE UserID = :UserID_selected_from_browse_user_page;

-- INSERT queries --
INSERT INTO SupportTickets (TicketID, TicketStatus, `Description`, UserID, EmployeeID)
VALUES (:TicketIDInput, :TicketStatusInput, :DescriptionInput, :UserIDInput, :EmployeeIDInput);

-- DELETE queries --
DELETE FROM SupportTickets
WHERE TicketID = :TicketID_selected_from_dropdown_Input;

-- Licenses page
-- SELECT queries --
SELECT UserID, LicenseID, Expiration FROM Licenses;
SELECT * FROM Licenses;

-- INSERT queries --
INSERT INTO Licenses (LicenseID, ProductID, Expiration, UserID)
VALUES (:LicenseIDInput, :ProductIDInput, :ExpirationInput, :UserIDInput);

-- UPDATE queries --
UPDATE Licenses
SET ProductID = :ProductIDInput,
    Expiration = :ExpirationInput,
    UserID = :UserIDInput
WHERE LicenseID = :LicenseID_selected_from_dropdown_Input;

-- DELETE queries --
DELETE FROM Licenses
WHERE LicenseID = :LicenseID_selected_from_dropdown_Input;

-- User Products page (many-to-many)
-- SELECT queries --
SELECT * FROM UserProducts;

-- UPDATE queries --
UPDATE UserProducts SET UserProductsID = :UserProductsIDInput,  ProductID = :ProductID_from_dropdown_Input WHERE UserID = :UserID_from_the_update_form;

-- INSERT queries --
INSERT INTO UserProducts (UserProductsID, UserID, ProductID) VALUES (:UserProductsIDInput, :UserID_selected_from_dropdown_Input, :ProductID_selected_from_dropdown_Input); 

-- DELETE queries --
DELETE FROM UserProducts WHERE UserID = :UserID_selected_from_dropdown_Input AND ProductID = :ProductID_selected_from_dropdown_Input;

