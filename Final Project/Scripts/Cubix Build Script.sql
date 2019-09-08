/* Cubix */

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BikeInventoryService')	
DROP TABLE BikeInventoryService	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Reference')	
DROP TABLE Reference	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BikeInventory')	
DROP TABLE	BikeInventory	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Brand')	
DROP TABLE	Brand	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'EventCustomer')
DROP TABLE	EventCustomer	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Event')
DROP TABLE	Event	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Customer')	
DROP TABLE	Customer	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BikeCondition')
DROP TABLE	BikeCondition	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'BikeType')	
DROP TABLE	BikeType	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'ServiceStatus')
DROP TABLE	ServiceStatus	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'LocationService')
DROP TABLE	LocationService	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Employee')	
DROP TABLE	Employee
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Location')
DROP TABLE	Location 
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'City')	
DROP TABLE	City	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'State')	
DROP TABLE	State	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'EmployeeRole')
DROP TABLE	EmployeeRole	
GO

IF EXISTS (SELECT * FROM sys.tables WHERE name = 'Service')	
DROP TABLE	Service 
GO
	

/*Create Tables*/

CREATE TABLE Service
(
serviceID INTEGER NOT NULL,
serviceName VARCHAR(50) NOT NULL,
serviceDesc VARCHAR(350) 

CONSTRAINT serviceIDPK PRIMARY KEY (serviceID)
);

CREATE TABLE EmployeeRole
(
empRoleID INTEGER NOT NULL,
empRoleName VARCHAR(50) NOT NULL,
empRoleDesc VARCHAR(350) NOT NULL

CONSTRAINT empRoleIDPK PRIMARY KEY (empRoleID)
);

CREATE TABLE State
(
stateID INTEGER NOT NULL,
stateName VARCHAR(50) NOT NULL

CONSTRAINT stateIDPK PRIMARY KEY (stateID)
);

CREATE TABLE City
(
cityID INTEGER NOT NULL,
cityName VARCHAR(50) NOT NULL,
stateID INTEGER NOT NULL

CONSTRAINT cityIDPK PRIMARY KEY (cityID)
CONSTRAINT stateIDFK FOREIGN KEY (stateID)
			REFERENCES State(stateID)
);

CREATE TABLE Location
(
locationID INTEGER NOT NULL,
locationName VARCHAR(100) NOT NULL,
locationAddress VARCHAR(100) NOT NULL,
locationZip VARCHAR(20) NOT NULL,
locationContact VARCHAR(20),
locationReferPrice Decimal(10, 2),
cityID INTEGER NOT NULL

CONSTRAINT locationIDPK PRIMARY KEY (locationID)
CONSTRAINT locationCityIDFK FOREIGN KEY (cityID)
			REFERENCES city(cityID)
);

CREATE TABLE Employee
(
empID INTEGER NOT NULL,
empLastName VARCHAR(100) NOT NULL,
empFirstName VARCHAR(100) NOT NULL,
empPhone VARCHAR(20) NOT NULL,
empAddress VARCHAR(100) NOT NULL,
empHireDate DATETIME NOT NULL,
empEmail VARCHAR(100),
cityID INTEGER NOT NULL,
empRoleID INTEGER NOT NULL,
locationID INTEGER NOT NULL

CONSTRAINT empIDPK PRIMARY KEY (empID)
CONSTRAINT employeeCityIDFK FOREIGN KEY(cityID)
			REFERENCES City(cityID),
CONSTRAINT empRoleIDFK FOREIGN KEY (empRoleID)
			REFERENCES EmployeeRole(empRoleID),
CONSTRAINT emplocationIDFK FOREIGN KEY (locationID)
			REFERENCES Location(locationID)

); 

CREATE TABLE LocationService
(
locationID INTEGER NOT NULL,
serviceID INTEGER NOT NULL,
servicePrice Decimal NOT NULL

CONSTRAINT locationServiceIDPK PRIMARY KEY (locationID, serviceID)
CONSTRAINT locationServIDFK FOREIGN KEY(locationID)
			REFERENCES Location(locationID),
CONSTRAINT serviceLocIDFK FOREIGN KEY(serviceID)
			REFERENCES Service(serviceID)
);

CREATE TABLE ServiceStatus
(
serviceStatusID INTEGER NOT NULL,
statusName VARCHAR(100) NOT NULL,
statusDesc VARCHAR(350)

CONSTRAINT serviceStatusIDPK PRIMARY KEY (serviceStatusID),
CONSTRAINT projectStatusCK CHECK (statusName = 'NOT YET STARTED' or 
								  statusName = 'IN PROGRESS' or
								  statusName = 'COMPLETED: READY FOR PICK UP' or
								  statusName = 'COMPLETED: RETURNED TO CUSTOMER'
								  )


);

CREATE TABLE BikeType
(
bikeTypeID INTEGER NOT NULL,
bikeType VARCHAR(100) NOT NULL

CONSTRAINT bikeTypeIDPK PRIMARY KEY (BikeTypeID)

);

CREATE TABLE BikeCondition
(
bikeConditionID INTEGER NOT NULL,
bikeCondition VARCHAR(100) NOT NULL,
bikeConditionDesc VARCHAR(350)

CONSTRAINT bikeConditionIDPK PRIMARY KEY (BikeConditionID),
CONSTRAINT bikeConditionCK CHECK (bikeCondition = 'NEW' or 
								  bikeCondition = 'OLD' or
								  bikeCondition = 'EXTERNAL'					
								    )

);

CREATE TABLE Customer
(
customerID INTEGER NOT NULL,
customerLast VARCHAR(100) NOT NULL,
customerFirst VARCHAR(100) NOT NULL,
customerPhone VARCHAR(20) NOT NULL,
customerAddress VARCHAR(100) NOT NULL,
customerZipcode VARCHAR(20) NOT NULL,
customerJoinDate DATETIME NOT NULL DEFAULT GETDATE(),
customerEmail VARCHAR(100),
cityID INTEGER NOT NULL


CONSTRAINT consultantTitlePK PRIMARY KEY (customerID)
CONSTRAINT customerCityFK FOREIGN KEY(cityID)
			REFERENCES City(cityID),
);


CREATE TABLE Event
(
eventID INTEGER NOT NULL,
eventName VARCHAR(100),
eventAddress VARCHAR(100),
eventZipcode VARCHAR(20), 
eventDate DATETIME,
eventStartTime DATETIME,
eventEndTime DATETIME, 
eventDesc VARCHAR (100),
locationID INTEGER NOT NULL,
cityID INTEGER

CONSTRAINT eventIDPK PRIMARY KEY (eventID)
CONSTRAINT eventCityFK FOREIGN KEY (cityID)
			  REFERENCES City(cityID),
CONSTRAINT eventLocationFK FOREIGN KEY (locationID)
			  REFERENCES Location(locationID)
			  
);

CREATE TABLE EventCustomer
(
eventID INTEGER NOT NULL,
customerID INTEGER NOT NULL

CONSTRAINT eventCustomerPK PRIMARY KEY (eventID, customerID)
CONSTRAINT eventCustomerIDFK FOREIGN KEY(eventID)
			REFERENCES Event(eventID),
CONSTRAINT customerEventIDFK FOREIGN KEY(customerID)
			REFERENCES Customer(customerID)
);

CREATE TABLE Brand
(
brandID INTEGER NOT NULL,
brandName VARCHAR(50) NOT NULL

CONSTRAINT brandIDPK PRIMARY KEY (brandID)
);

CREATE TABLE  BikeInventory
(
bikeInventoryID INTEGER NOT NULL,
bikeSerialNum INTEGER, 
bikeName VARCHAR(100) NOT NULL,
bikeSize DECIMAL (10,2) NOT NULL,
bikePrice DECIMAL (10, 2),
bikeColorScheme VARCHAR(50),
bikeSpecDesc VARCHAR(500), 
bikePurchasedDate VARCHAR(100),
bikeConditionID INTEGER NOT NULL,
bikeTypeID INTEGER NOT NULL,
locationID INTEGER NOT NULL, 
customerID INTEGER,
brandID INTEGER

CONSTRAINT bikeInventoryIDPK PRIMARY KEY (bikeInventoryID)

CONSTRAINT bIBikeConditionIDFK FOREIGN KEY(bikeConditionID)
			REFERENCES BikeCondition(bikeConditionID),
CONSTRAINT bIBikeTypeIDFK FOREIGN KEY(bikeTypeID)
			REFERENCES BikeType(bikeTypeID),
CONSTRAINT bILocationIDFK FOREIGN KEY(locationID)
			REFERENCES Location(locationID),
CONSTRAINT bICustomerIDK FOREIGN KEY(customerID)
			REFERENCES Customer(customerID),
CONSTRAINT bIBrandIDFK FOREIGN KEY(brandID)
			REFERENCES Brand(brandID)		

);

CREATE TABLE Reference
(
referenceID INTEGER NOT NULL,
referLocationID INTEGER NOT NULL,
referToLocationID INTEGER NOT NULL,
bikeInventoryID INTEGER NOT NULL,
referCustomerID INTEGER NOT NULL, 
referDetails VARCHAR(350) NOT NULL

CONSTRAINT referenceIDPK PRIMARY KEY (referenceID)

CONSTRAINT rReferLocationIDFK FOREIGN KEY(referLocationID)
			REFERENCES Location(LocationID),
CONSTRAINT rReferToLocationDFK FOREIGN KEY(referToLocationID)
			REFERENCES Location(LocationID),
CONSTRAINT rBikeInventoryIDFK FOREIGN KEY(bikeInventoryID)
			REFERENCES BikeInventory(bikeInventoryID),
CONSTRAINT rReferCustomerIDFK FOREIGN KEY(referCustomerID)
			REFERENCES Customer(customerID)

);

CREATE TABLE  BikeInventoryService
(
bikeInventoryID INTEGER NOT NULL,
serviceID INTEGER NOT NULL,
empID INTEGER NOT NULL,
bikeEntryDate DATETIME NOT NULL DEFAULT GETDATE(),
serviceNote VARCHAR(500), 
serviceStatusID INTEGER

CONSTRAINT bISeventCustomerPK PRIMARY KEY (bikeInventoryID, serviceID, bikeEntryDate)
CONSTRAINT bISbikeInventoryIDFK FOREIGN KEY(bikeInventoryID)
			REFERENCES bikeInventory (bikeInventoryID),
CONSTRAINT bISserviceIDFK FOREIGN KEY(serviceID)
			REFERENCES Service(serviceID), 
CONSTRAINT bISempIDFK FOREIGN KEY(empID)
			REFERENCES Employee(empID),
CONSTRAINT bIServiceStatusIDFK FOREIGN KEY(serviceStatusID)
			REFERENCES ServiceStatus(serviceStatusID),
);


	




