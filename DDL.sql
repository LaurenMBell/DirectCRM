-- Lauren Bell and Spencer Berg, Group 37  ---

-- This code was written by Lauren Bell, without AI 

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

DROP TABLE IF EXISTS UserProducts;
DROP TABLE IF EXISTS Licenses;
DROP TABLE IF EXISTS SupportTickets;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Products;

CREATE OR REPLACE TABLE Products(
   ProductID varchar(50) UNIQUE NOT NULL,
   ProductName varchar(50) NOT NULL,
   PRIMARY KEY(ProductID)
);

INSERT INTO Products (ProductName, ProductID)
VALUES ("DSpec", "dspec"),
("DAI", "dai"),
("Direct Message", "directmessage");

CREATE OR REPLACE TABLE Clients (
   ClientID varchar(50) UNIQUE NOT NULL,
   ClientName varchar(50) NOT NULL,
   Revenue bigint NOT NULL,
   PRIMARY KEY(ClientID)
);

INSERT INTO Clients (ClientName, ClientID, Revenue)
VALUES ("Nike", "nike", 46400000000),
("Oregon State University", "osu", 1850000000),
("FLIR Systems", "flirsystems", 1940000000);


CREATE OR REPLACE TABLE Users (
   UserID varchar(50) UNIQUE NOT NULL,
   fNameUser varchar(50) NOT NULL,
   lNameUser varchar(50) NOT NULL,
   ClientID varchar(50) NOT NULL,
   `Password` varchar(50) NOT NULL,
   SecurityQuestion varchar(200) NOT NULL,
   SecurityAnswer varchar(50) NOT NULL,
   PRIMARY KEY (UserID),
   FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

INSERT INTO Users (UserID, fNameUser, lNameUser, ClientID, Password, SecurityQuestion, SecurityAnswer)
VALUES ("hansel002", "Hansel", "Greene", "osu", "Passw0rd123", "What was the name of your first pet?", "Orange"),
("trinity919", "Trinity", "Garcia-Scott", "nike", "p@$$word10", "What was the name of your middle school?", "George Washington Middle School"),
("jeremy873", "Jeremy", "Preston", "flirsystems", "PaSsW0rd!", "What was the make and model of your first car?", "Honda Accord"), 
("thomas987", "Thomas", "Burgess", "osu", "password1025!", "What was the name of your middle school?", "Oak Middle School"), 
("sasha487", "Sasha", "Franklin", "osu", "PASSword9876", "What is your mothers maiden name?", "Brown");

CREATE OR REPLACE TABLE Employees (
   fNameEmp varchar(50) NOT NULL,
   lNameEmp varchar(50) NOT NULL,
   EmployeeID varchar(50) UNIQUE NOT NULL,
   ManagerID varchar(50),
   Salary decimal(10,2) NOT NULL,
   Email varchar(30) NOT NULL,
   PRIMARY KEY (EmployeeID),
   FOREIGN KEY(ManagerID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees (fNameEmp, lNameEmp, EmployeeID, ManagerID, Salary, Email)
VALUES ("Amy", "Johnson", "ajohnson", NULL, 150000.00, "amy.johnson6@gmail.com"),
("Richard", "Smith", "rsmith", "ajohnson", 95000.00, "richard.smith@hotmail.com"),
("Shawna", "Williams", "swilliams", "ajohnson", 90000.00, "shawna.williams@gmail.com"),
("Dave", "Gray", "dgray", "rsmith", 85000.00, "dave.gray@gmail.com");

CREATE OR REPLACE TABLE SupportTickets (
   TicketID varchar(50) UNIQUE NOT NULL,
   TicketStatus varchar(15) NOT NULL,
   `Description` varchar(500) NOT NULL,
   UserID varchar(50) NOT NULL,
   EmployeeID varchar(50) NOT NULL,
   PRIMARY KEY(TicketID),
   FOREIGN KEY(UserID) REFERENCES Users(UserID),
   FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO SupportTickets (TicketID, TicketStatus, `Description`, UserID, EmployeeID)
VALUES ("T00010", "Pending", "Load time for Direct Message was over 3 minutes", "thomas987", "dgray"),
("T00981", "Completed", "Locked out of DAI acct.", "hansel002", "swilliams"),
("T87102", "Completed", "Can't add new chat in Direct Message", "sasha487", "swilliams");


CREATE OR REPLACE TABLE Licenses (
   LicenseID varchar(50) UNIQUE NOT NULL,
   ProductID varchar(50) NOT NULL,
   Expiration date NOT NULL,
   UserID varchar(50) NOT NULL,
   PRIMARY KEY(LicenseID),
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
   FOREIGN KEY (UserID) REFERENCES Users(UserID)
      ON DELETE CASCADE 
      ON UPDATE CASCADE
);


INSERT INTO Licenses (ProductID, LicenseID, Expiration, UserID)
VALUES ("dai", "DAI365", "2026-09-01", "hansel002"),
("directmessage", "DirChat Plus", "2027-01-31", "trinity919"),
("dspec", "Base Analyst", "2027-01-31", "jeremy873");

CREATE OR REPLACE TABLE UserProducts (
   UserProductsID varchar(50) UNIQUE NOT NULL,
   UserID varchar(50) NOT NULL,
   ProductID varchar(50) NOT NULL,
   PRIMARY KEY (UserProductsID),
   FOREIGN KEY (UserID) REFERENCES Users(UserID),
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
      ON DELETE CASCADE 
      ON UPDATE CASCADE
);

INSERT INTO UserProducts( UserProductsID, UserID, ProductID)
VALUES ("UP0001", "hansel002", "dai"),
("UP8000", "trinity919", "directmessage"),
("UP7001", "trinity919", "dspec");

SET FOREIGN_KEY_CHECKS=1;
COMMIT;