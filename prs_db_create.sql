-- Drop and Create the PRS database

DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;

-- Create Tables
CREATE TABLE User (
	ID				int				primary key auto_increment,
	UserName	 	varchar(20)		not null,
	Password 		varchar(10) 	not null,
	FirstName 		varchar(20) 	not null,
	LastName	 	varchar(20)		not null, 		
	PhoneNumber		varchar(12) 	not null,
	Email 			varchar(75) 	not null,
	IsReviewer		tinyint			not null,
	IsAdmin	 		tinyint			not null,
    CONSTRAINT uname unique (UserName)
    );
    
CREATE TABLE Vendor (
	ID				int				primary key auto_increment,
	Code		 	varchar(10)		not null,
	Name	 		varchar(255) 	not null,
	Address 		varchar(255) 	not null,
	City		 	varchar(255)	not null, 		
	State			varchar(2)		not null,
	Zip 			varchar(5)		not null,
	PhoneNumber		varchar(12)		not null,
	Email	 		varchar(100)	not null,
    CONSTRAINT vcode unique (Code)
    );
    
CREATE TABLE Request (
	ID					int				primary key auto_increment,
	UserID				int				not null,
	Description			varchar(100)	not null,
	Justification		varchar(255)	not null,
	DateNeeded			date			not null, 		
	DeliveryMode		varchar(25)		not null,
	Status				varchar(20)		not null,
	Total				decimal(10,2)	not null,
	SubmittedDate		datetime		not null,
    ReasonForRejection	varchar(100),
    FOREIGN KEY (UserID) REFERENCES User(ID)
    );
    
CREATE TABLE Product (
	ID				int				primary key auto_increment,
	VendorID		int				not null,
	PartNumber		varchar(50)		not null,
	Name			varchar(150)		not null,
	Price		 	decimal(10,2)	not null, 		
	Unit			varchar(255),
	PhotoPath		varchar(255),
    FOREIGN KEY (VendorID) REFERENCES Vendor(ID),
    CONSTRAINT vendor_part unique (VendorID, PartNumber)
    );
    
CREATE TABLE LineItem (
	ID				int				primary key auto_increment,
	RequestID		int				not null,
	ProductID		int				not null,
	Quantity		int				not null,
    FOREIGN KEY (RequestID) REFERENCES Request(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    CONSTRAINT req_pdt unique (RequestID, ProductID)
    );
    
    
-- User Inserts
INSERT INTO User (ID, UserName, Password, FirstName, LastName, 
					PhoneNumber, Email, IsReviewer, IsAdmin) 
	VALUES (1, 'dfrey', 'pw01', 'Dennis', 'Frey', '513-123-1122',
			'dfrey@gmail.com', 0, 1);
INSERT INTO User (ID, UserName, Password, FirstName, LastName, 
					PhoneNumber, Email, IsReviewer, IsAdmin) 
	VALUES (2, 'jsnow','pw02', 'Jon','Snow','513-111-1234',
			'jsnow@gmail.com',0,0);
INSERT INTO User (ID, UserName, Password, FirstName, LastName, 
					PhoneNumber, Email, IsReviewer, IsAdmin) 
	VALUES (3, 'dtargaryen','pw03','Daenerys', 'Targaryen', '513-444-5555',
			'dtargaryen@gmail.com',1, 0);
    
-- Vendor Inserts
INSERT INTO Vendor (ID, Code, Name, Address, City, State, 
					Zip, PhoneNumber, Email)
	VALUES (1, 'AMZN', 'Amazon','410 Terry Ave North', 
			'Seattle', 'WA', '98109', '206-266-1000', 'amazon@gmail.com');
INSERT INTO Vendor (ID, Code, Name, Address, City, State, 
					Zip, PhoneNumber, Email)
	VALUES (2, 'NEGG', 'New Egg', '18045 Rowland St', 
			'Industry', 'CA' , '91748', '800-222-3333' ,'newegg@gmail.com');
INSERT INTO Vendor (ID, Code, Name, Address, City, State, 
					Zip, PhoneNumber, Email)
	VALUES (3, 'MCCT', 'Micro Center', '11755 Mosteller Rd', 
			'Sharonville', 'OH', '45241', '513-782-8500', 'microcenter@gmail.com');
INSERT INTO Vendor (ID, Code, Name, Address, City, State, 
					Zip, PhoneNumber, Email)
	VALUES (4, 'BBUY','Best Buy','5555 Glenway Ave',
			'Cincinnati','OH','45238','513-347-3457','bestbuy@gmail.com');
    
-- Product Inserts
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (1, 1, 'ASMB001', 'ASUS Motherboard', 350.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (2, 1, 'AMDX12', 'AMD Ryzen 12 Core Processor', 400.00, '1', 'C:/Pics'); 
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (3, 1, 'INTI7', 'Intel i7 8 Core Processor', 390.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (4, 2, 'SMGSSD', 'Samsung SSD 1TB', 150.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (5, 2, 'WD8TB', 'Western Digital 8TB', 170.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (6, 2, 'COR16', 'Corsair RAM 16GB', 100.00,'1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (7, 3, 'GSK16', 'GSkill RAM 16GB', 90.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (8, 3, 'CORATX', 'Corsair ATX Case', 70.00, '1','C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (9, 3, 'NVRTX', 'Nvidia RTX Video Card',  1100.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (10, 4, 'SMG28', 'Samsung 28in 4K Monitor', 350.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (11, 4, 'MSKEY', 'Microsoft Ergonomic Keyboard', 35.00, '1', 'C:/Pics');
INSERT INTO Product (ID, VendorID, PartNumber, Name, Price, Unit, PhotoPath)
	VALUES (12, 4, 'MSMSE', 'Microsoft Ergonomic Mouse', 35.00, '1', 'C:/Pics');

    