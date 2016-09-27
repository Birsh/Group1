CREATE DATABASE AutoInsurance
GO

USE AutoInsurance
GO

CREATE SCHEMA Policy
GO
CREATE SCHEMA Coverage
GO
CREATE SCHEMA Driver
GO
CREATE SCHEMA Vehicle
GO
CREATE Table Policy.Policy(
ID BigInt Identity(001,2)Primary key,
PolicyNumber Nvarchar(20) NOT NULL,
[PolicyEffectiveDate] DateTime NOT NULL,
[PolicyExpireDate] DateTime NOT NULL,
[PaymentOption] varchar(100) NOT NULL,
TotalAmount Double Precision NOT NULL,
Active Bit NOT NULL,
AdditionalInfo text,
CreateDate DateTime NOT NULL
)

CREATE TABLE Policy.PolicyEditLog(
ID BigInt Identity(1, 1) Primary Key,
Policy_ID Bigint Foreign Key references Policy.Policy,
EditedTableName Varchar(50) Not Null,
EditedDate Datetime Not Null,
AdditionalInfo Text,
EditedBy varchar(50) Not Null
)

CREATE TABLE Policy.BILL (
ID BigInt Identity(1, 1) Primary Key,
Bill_ID bigint not null foreign key references Policy.Policy,
DueDate datetime not null,
MinimumPayment double Precision not null,
[Created Date] datetime not null,
Balalnce double Precision not null ,
[Status] nvarchar(50) not null
)
CREATE TABLE PaymentDetail (
ID bigint primary key identity(1,1),
Bill_ID bigint not null foreign key references Policy.Bill,
Paiddate datetime not null,
Amount double Precision not null,
paymentmethod varchar(100) not null,
paymentFirstName varchar (50) ,
paymentLastName varchar(50),
CardNumber varchar(50),
Zipcode varchar(10),
Cardexpiredate varchar(10),
Cardtype varchar(20),
Debitorcredit varchar(50),
Bankname varchar(100),
AccountNumber varchar(20),
RoutingNumber varchar(20),
CheckNumber varchar(20),
Checkimage binary,
Additionalinfo Text,
Createddate datetime not null
)

CREATE TABLE Coverage.Coverage(
ID bigint Primary Key IDENTITY (1,1) NOT NULL,
CoverageName varchar (max) NOT NULL,
CoverageGroup varchar(50) NOT NULL,
Code varchar(20) NOT NULL,
IsPolicyCoverage bit NOT NULL,
IsVehicleCoverage bit NOT NULL,
[Description] varchar(max) NULL,
)

CREATE TABLE Coverage.Policy_Coverage(
ID BigInt Identity(1, 1) Primary Key,
Policy_ID Bigint Foreign Key References Policy.Policy,
Coverage_ID Bigint Foreign Key References Coverage.Coverage(ID),
Active Bit,
CreatDate  Datetime,
)
CREATE TABLE Coverage.Vehicle_Coverage(
ID Bigint Primary key identity (1,1),
Vehicle_ID Bigint Foreign Key References Vehicle.Vehicle,
Coverage_ID Bigint Foreign Key References Coverage.Coverage,
Active Bit,
CreatedDate Datetime,
)
CREATE Table Vehicle.Vehicle(
ID BigInt Identity(1, 1) Primary Key,
Policy_ID BigInt Foreign Key References Policy.Policy NOT NULL,
EditedTableName Varchar(50) NOT NULL,
EditedDate DateTime NOT NULL,
EditedBy Varchar(50) NOT NULL,
AddtionalInfo text
)
CREATE Table Vehicle.Vehicle_Driver(
ID BigInt Identity(1, 1) Primary Key,
Vehicle_ID BigInt Foreign Key REFERENCES Vehicle.Vehicle NOT NUll,
Driver_ID BigInt Foreign Key REFERENCES Driver.Driver NOT NUll,
DriverForBusinessPuprose Bit NOT NULL,
IsPrimaryDriver Bit NOT NULL,
EveryDayMileage Int NOT NULL,
CreatedDate DateTime NOT NULL,
Active Bit NOT NULL
)
CREATE Table Driver.Driver(
ID BigInt Identity(1, 1) Primary Key,
Policy_ID BigInt NOT NULL FOREIGN KEY REFERENCES Policy.Policy,
Title Varchar(50),
FirstName Varchar(50) NOT NULL,
LastName Varchar(50) NOT NULL,
MiddleInitial Char(1),
DoB Varchar(1) NOT NULL,
EmailAddress Varchar(100),
PhoneNumber Varchar(20) NOT NULL,
CellNumber Varchar(20),
SSN Varchar(12) NOT NULL,
LisenseIssuedDate Date NOT NULL,
LicenseIssuedState Varchar(50) NOT NULL,
LicenseNumber Varchar(20) NOT NULL,
IsPrimaryPolicyHolder Bit NOT NULL,
RelationWithPrimaryPo Varchar(50) NOT NULL,
Gender Varchar(10),
MaritalStatus Varchar(20),
CreatedDate DateTime NOT NULL,
Active Bit NOT NULL
)

CREATE TABLE Driver.[Driver Address] (
ID bigint Identity (1,1) NOT NULL Primary Key,
Driver_ID bigint NOT NULL Foreign Key References Driver.Driver,
Address1 varchar (100) NOT NULL,
Address2 varchar(100),
City varchar(100),
[State] varchar(50) NOT NULL,
Country varchar(100) NOT NULL,
IsItGarageAddress bit NOT NULL,
)

CREATE TABLE TrafficViolationCode(
ID bigint Identity(1,1) NOT NULL Primary Key,
TrafficViolationQuestion Varchar(max) NOT NULL,
TrafficViolationCode varchar(10) NOT NULL,
TrafficViolationPoint double Precision NOT NULL,
CodeDescription varchar(max),
)
CREATE TABLE Driver.Driver_Violation_Record(
ID bigint Identity(1,1) NOT NULL Primary Key,
Driver_ID bigint Foreign Key REFERENCES Driver.Driver,
TrafficViolationCode_ID bigint Foreign Key REFERENCES TrafficViolationCode,
Active bit NOT NULL,
)
