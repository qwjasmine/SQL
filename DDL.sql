select Name, Database_id, is_cdc_enabled from sys.databases
Exec Sys.sp_cdc_enable_db
Select Name, is_tracked_by_cdc from sys.tables
Exec sys.sp_cdc_enable_table
@Source_schema = 'dbo',
@Source_Name = 'ETLTestSource',
@Role_Name = Null,
@capture_instance = 'CDC_test',
@supports_net_changes = 1


EXEC SYS.sp_cdc_disable_db
EXEC SYS.sp_cdc_disable_table
@Source_schema = 'dbo',
@Source_Name = 'ETLTestSource',
@capture_instance = 'CDC_test'

Use Test_BIDW



Create Table ETLTestSource
(ID int primary key not null,
FirstName varchar(20),
LastName varchar(20),
Birthday DATE,
City varchar(20))

Create Table SCDTrans
(SKey int identity (1,1) not null,
ID int,
FirstName varchar(20),
LastName varchar(20),
Birthday DATE,
City varchar(20),
StarteDate datetime,
EndDate datetime,
CurrentFlag int null,
HashCode as Checksum (FirstName, LastName, City))

Create Table Tracking
(ID int,
HashCode Bigint,
CurrentFlag int)

Create Table ETLDestination(ID int not null,
FirstName varchar(20),
LastName varchar(20),
Birthday DATE,
City varchar(20))

Alter Table ETLDestination
Drop Constraint [PK__ETLDesti__3214EC27081ABE2B]

Select * From ETLTestSource
Select * From SCDTrans
Select * From Tracking
Select * From ETLDestination

Truncate Table ETLTestSource
Truncate Table SCDTrans
Truncate Table Tracking
Truncate Table ETLDestination

Alter Table Tracking
Add SKey int 
Alter Table Tracking
Add CurrentFlag int

Update ETLTestSource
Set FirstName = 'Crina' Where ID = 3
Insert into ETLTestSource values (5, 'Silvia', 'Bravo', '1998-08-01', 'Fortbend')
