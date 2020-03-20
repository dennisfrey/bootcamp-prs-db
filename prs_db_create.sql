-- Drop and Create the prs database

DROP DATABASE IF EXISTS prs;
CREATE DATABASE prs;
USE prs;

-- Create Tables
CREATE TABLE User (
	ID 				int 			primary key auto_increment,
	UserName	 	varchar(20)		not null,
	Password 		varchar(10) 	not null,
	FirstName 		varchar(20) 	not null,
	LastName	 	varchar(20)		not null, 		
	PhoneNumber		varchar(12) 	not null,
	Email 			varchar(75) 	not null,
	IsReviewer		tinyint 		not null,
	IsAdmin	 		tinyint 		not null,
    CONSTRAINT uname unique (UserName)
    );
    
CREATE TABLE Vendor (
	ID 				int 			primary key auto_increment,
	Code		 	varchar(10)		not null,
	Name	 		varchar(255) 	not null,
	Address 		varchar(255) 	not null,
	City		 	varchar(255)	not null, 		
	State			varchar(2)	 	not null,
	Zip 			varchar(5)	 	not null,
	PhoneNumber		varchar(12)		not null,
	Email	 		varchar(100)	not null,
    CONSTRAINT vcode unique (Code)
    );
    
CREATE TABLE Request (
	ID 					int 			primary key auto_increment,
	UserID		 		int				not null,
	Description			varchar(100) 	not null,
	Justification		varchar(255) 	not null,
	DateNeeded	 		date			not null, 		
	DeliveryMode		varchar(25)	 	not null,
	Status 				varchar(20)	 	not null,
	Total				decimal(10,2)	not null,
	SubmittedDate		datetime		not null,
    ReasonForRejection	varchar(100),
    FOREIGN KEY (UserID) REFERENCES User(ID)
    );
    
CREATE TABLE Product (
	ID 				int 			primary key auto_increment,
	VendorID		int				not null,
	PartNumber		varchar(50) 	not null,
	Name			varchar(150) 	not null,
	Price		 	decimal(10,2)	not null, 		
	Unit			varchar(255),
	PhotoPath		varchar(255),
    FOREIGN KEY (VendorID) REFERENCES Vendor(ID),
    CONSTRAINT vendor_part unique (VendorID, PartNumber)
    );
    
CREATE TABLE LineItem (
	ID 				int 			primary key auto_increment,
	RequestID		int				not null,
	ProductID		int			 	not null,
	Quantity		int			 	not null,
    FOREIGN KEY (RequestID) REFERENCES Request(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID),
    CONSTRAINT req_pdt unique (RequestID, ProductID)
    );
    
    
-- Insert some test data
    

    