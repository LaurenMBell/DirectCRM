-- Lauren Bell and Spencer Berg, Group 37 - DML ---
USE cs340_bergsp;

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;

-- SAMPLE DATA -----
INSERT INTO Employees (fNameEmp, lNameEmp, EmployeeID, ManagerID, Salary, Email)
VALUES ("Richard", "Smith", "rsmith", "ajohnson", 95000.00, "richard.smith@hotmail.com"),
("Amy", "Johnson", "ajohnson", NULL, 150000.00, "amy.johnson6@gmail.com"),
("Shawna", "Williams", "swilliams", "ajohnson", 90000.00, "shawna.williams@gmail.com"),
("Dave", "Gray", "dgray", "rsmith", 85000.00, "dave.gray@gmail.com");

INSERT INTO SupportTickets (TicketID, TicketStatus, `Description`, UserID, EmployeeID)
VALUES ("T00010", "Pending", "Load time for Direct Message was over 3 minutes", "thomas987", "dgray"),
("T00981", "Completed", "Locked out of DAI acct.", "hansel002", "swilliams"),
("T87102", "Completed", "Can't add new chat in Direct Message", "sasha487", "swilliams");

INSERT INTO Clients (ClientName, ClientID, Revenue)
VALUES ("Nike", "nike", 46400000000),
("Oregon State University", "osu", 1850000000),
("FLIR Systems", "flirsystems", 1940000000);

INSERT INTO Licenses (ProductID, LicenseID, Expiration, UserID)
VALUES ("dai", "DAI365", "2026-09-01", "hansel002"),
("directmessage", "DirChat Plus", "2027-01-31", "trinity919"),
("dspec", "Base Analyst", "2027-01-31", "jeremy873");

INSERT INTO Products (ProductName, ProductID)
VALUES ("DSpec", "dspec"),
("DAI", "dai"),
("Direct Message", "directmessage");

INSERT INTO Users (UserID, fNameUser, lNameUser, ClientID, Password, SecurityQuestion, SecurityAnswer)
VALUES ("hansel002", "Hansel", "Greene", "osu", "Passw0rd123", "What was the name of your first pet?", "Orange"),
("trinity919", "Trinity", "Garcia-Scott", "nike", "p@$$word10", "What was the name of your middle school?", "George Washington Middle School"),
("jeremy873", "Jeremy", "Preston", "flirsystems", "PaSsW0rd!", "What was the make and model of your first car?", "Honda Accord"), 
("thomas987", "Thomas", "Burgess", "osu", "password1025!", "What was the name of your middle school?", "Oak Middle School"), 
("sasha487", "Sasha", "Franklin", "osu", "PASSword9876", "What is your mothers maiden name?", "Brown");

INSERT INTO UserProducts( UserProductsID, UserID, ProductID)
VALUES ("UP0001", "hansel002", "dai"),
("UP8000", "trinity919", "directmessage"),
("UP7001", "trinity919", "dspec");

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;