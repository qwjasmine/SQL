
rUSE Test_BIDW
Go


Alter Function Func_StarTriangle (@input int)
Returns varchar(max) AS

Begin

Declare 
@counter int, @total int, @a varchar(1), @b varchar(1), @triangle varchar(max)

Set @counter =0
Set @total = @input
Set @a = '*'
Set @b = ' ' 


While @counter <= @total



set @triangle = replicate (@b, @counter) + replicate (@a, @total-@counter)
set @counter = @counter +1
Return @triangle


End

Select dbo.Func_StarTriangle (5)

Go


Create Table Patient

(id int,
first_name varchar(20),
last_name varchar(20),
date_of_birth date)

Insert into Patient (id, first_name, last_name, date_of_birth) values
(1, 'Bob', 'Dylon', '1960-03-08'),
(2, 'Maggie', 'May', '1980-09-09'),
(3, 'Cici', 'Walter', '1990-06-30')




Create Table Doctor

(id int,
first_name varchar(20),
last_name varchar(20),
date_of_birth date)

Insert into Doctor (id, first_name, last_name, date_of_birth) values
(1, 'Bob', 'Dylon', '1960-03-08'),
(2, 'Maggie', 'May', '1980-09-09'),
(3, 'Cici', 'Walter', '1980-06-30')

Go


Alter Proc SP_FUNGAME ( @DOB DATE)

As

Begin
Declare @DATE date, @counter int, @X int

SET @Date = @DOB
SET @Counter =1

While @Counter <= 8
Set @X = Cast (substring (Convert (varchar,@DOB), @COUNTER, 1) as int)
Set @Counter = @Counter + 1

print @X

End



Use Test_BIDW

Create Table EmployeeTest 

(ID int,
FirtName varchar(20),
LastName varchar (20),
JobTitle varchar (200),
Email varchar (500)

Constraint PK_Test Primary Key (ID))

Insert into EmployeeTest
Select 
E.BusinessEntityID,
P.FirstName,
P.LastName,
E.JobTitle,
A.EmailAddress

From AdventureWorks2012.HumanResources.Employee E
Inner Join AdventureWorks2012.Person.Person P
on E.BusinessEntityID = P.BusinessEntityID
Inner Join AdventureWorks2012.Person.EmailAddress A
on P.BusinessEntityID = A.BusinessEntityID

Select *
From EmployeeTest

Insert into EmployeeTest Values (291, 'Terri', 'Duffy', 'Vice President of Engineering', 'terri0@adventure-works.com')
Go 100

Alter Table EmployeeTest
Drop Constraint PK_Test
Go

EXEC sp_rename 'dbo.EmployeeTest.FirtName', 'FirstName', 'COLUMN'
go
Create Clustered Index CI_EMP ON dbo.EmployeeTest (ID)
Drop Index [CI_EMP] on dbo. EmployeeTest
Create NonClustered Index NCI_EMP on dbo.EmployeeTest (FirstName)
Drop Index [NCI_EMP] on dbo.EmployeeTest

Alter Table EmployeeTest
Add Constraint PK_Test Primary Key (ID)

Truncate Table EmployeeTest

select avg_fragmentation_in_percent as 'external frag',
       avg_page_space_used_in_percent as ' internal frag'
from sys.dm_db_index_physical_stats 
(DB_ID ('AdventureWorks2012'),
OBJECT_ID ('person.person'),
OBJECT_ID ('[PK_Person_BusinessEntityID]'),
null,
'Detailed'
)
DBCC showcontig ('Person.Person')

Use AdventureWorks2012

Select P.FirstName, P.LastName, E.JobTitle

From HumanResources.Employee E
With (Index ([AK_Employee_NationalIDNumber]))
Inner Join Person.Person P
with (Index ([AK_Person_rowguid]))
On E.BusinessEntityID = P.BusinessEntityID

select IIF (5>3, 'Great', 'ThinkAgain')

select day(EOMONTH (GETDATE()))

select @@ROWCOUNT
USE AdventureWorks2012
Drop Table dbo.MyEmployees

USE Test_BIDW

CREATE TABLE dbo.MyEmployees  
(  
EmployeeID SMALLINT NOT NULL,  
FirstName NVARCHAR(30)  NOT NULL,  
LastName  NVARCHAR(40) NOT NULL,  
Title NVARCHAR(50) NOT NULL,  
DeptID SMALLINT NOT NULL,  
ManagerID SMALLINT NULL,  
 CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC),
 CONSTRAINT FK_MyEmployees_ManagerID_EmployeeID FOREIGN KEY (ManagerID) REFERENCES dbo.MyEmployees (EmployeeID)
)

INSERT INTO dbo.MyEmployees VALUES   
 (1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)  
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)  
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)  
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)  
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)  
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)  
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)  
,(16,  N'David',N'Bradley', N'Marketing Manager', 4, 273)  
,(23,  N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);  

Select * from dbo.MyEmployees
GO

With DirectReport (ManagerID, EmployeeID, Title, EmployeeLevel) AS

(Select ManagerID, EmployeeID, Title, 1 as EmployeeLevel
From dbo.MyEmployees
Where ManagerID IS NULL
UNION ALL
Select E.ManagerID, E.EmployeeID, E.Title, EmployeeLevel + 1
From dbo.MyEmployees E
Inner Join DirectReport D
on E.ManagerID = D.EmployeeID
)

Select ManagerID, EmployeeID, Title, EmployeeLevel
From DirectReport

use AdventureWorksDW2012

select * from dbo.DimEmployee

select distinct M.EmployeeKey, M.FirstName, M.LastName, M.Title
From dbo.DimEmployee E
INNER JOIN
dbo.DimEmployee M
on E.ParentEmployeeKey = M.EmployeeKey
Where M.Status = 'Current'
Order by M.Title

Select concat (M.FirstName,' ', M.LastName, ' ( ', M.ParentEmployeeKey, ' ) ' )
From dbo.DimEmployee E
Full outer join
dbo.DimEmployee M
on E.ParentEmployeeKey = M.EmployeeKey
Where E.EmployeeKey is null AND
M.Status = 'Current'
Order by M.ParentEmployeeKey

use Test_BIDW

Create Table BankCustomer
(BID int,
FirstName varchar (20),
LastName varchar (20),
ReferedBy int,
Bonus money

constraint PK_ID primary key clustered (BID asc))

Insert into BankCustomer Values
(1, N'Ken', N'Sánchez', null, null),
(2, N'Brian', N'Welcker', 1, null),
(3, N'Stephen', N'Jiang', 1, null),
(4, N'Michael', N'Blythe', 3, null),
(5, N'Linda', N'Mitchell', 4, null),
(6,N'Syed', N'Abbas', 5, null),
(7, N'Lynn', N'Tsoflias',6, null),
(8, N'David',N'Bradley', 3, null)

select * from BankCustomer

Select *
From BankCustomer C
INNER Join BankCustomer R
on C.ReferedBy = R.BID

Update BankCustomer
Set LastName = 'Abbas'
Where BID = 2
Go

Select ROW_NUMBER () over (partition by LastName Order by LastName) as 'RowNumber', FirstName, LastName
From BankCustomer

Select rank () over (order by LastName) as 'RowNumber', FirstName, LastName
From BankCustomer

Select Ntile (4) over (order by LastName) as 'RowNumber', FirstName, LastName
From BankCustomer

Use AdventureWorks2012

Select * from
	(
	Select Rank() Over (Partition By ProductCategoryID Order By SUM(SOD.OrderQty) desc) as 'Ranking',
		SOD.ProductID, P.Name AS ProductName, PS.ProductCategoryID, PS.Name AS ProductCategoryName, 
		SUM(SOD.OrderQty) as 'QtySold'
	from Sales.SalesOrderDetail as SOD
	inner join Production.Product as P
	on SOD.ProductID=P.ProductID
	inner join Production.ProductSubcategory as PS
	on P.ProductSubcategoryID=PS.ProductSubcategoryID
	Group by SOD.ProductID, P.Name, ProductCategoryID, PS.Name
	) as RankProductSold
	Where Ranking=1
	Order By ProductCategoryID




Select   
         S.SalesPersonID,
         P.FirstName + ISNULL (P.MiddleName, NULL) + P.LastName as FullName,
		 Sum (TotalDue) AS SUM,
		 Rank() OVER (Order by Sum (TotalDue) desc) as Ranking
         

From Sales.SalesOrderHeader S
Inner Join Person.Person P
On S.SalesPersonID = P.BusinessEntityID
Where SalesPersonID is not null
Group by S.SalesPersonID, P.FirstName + ISNULL (P.MiddleName, NULL) + P.LastName


Select 
 FirstName
From Person.Person
Where FirstName in

(Select FirstName From 
(Select FirstName,ROW_NUMBER () OVER (Partition by FirstName Order by FirstName) as Ranking 
from Person.Person) as Derived 
Where Ranking >1 )

Order by FirstName
Go

Select * from Sales.SalesOrderDetail

Select * from Production.ProductSubcategory
Select * from Production.Product
Go

Select *
From
(Select SOD.ProductID, P.Name, PS.ProductCategoryID,Sum (SOD.OrderQty) as TotalQty, ROW_NUMBER () OVER (Partition By PS.ProductCategoryID Order By SUM (SOD.OrderQty) Desc) as Ranking
From Sales.SalesOrderDetail SOD
Inner Join Production.Product P
on SOD.ProductID = P.ProductID
Inner Join Production.ProductSubcategory PS
on P.ProductSubcategoryID = PS.ProductSubcategoryID
Group By SOD.ProductID, P.Name, PS.ProductCategoryID) as Derived
Where Ranking =1




USE Test_BIDW
Drop Table RankTest

Create Table RankTest
(ID int identity (1,1),
Name varchar (50),
Salary money

Constraint PK_Test  Primary Key Clustered(ID))

Insert Into RankTest Values
('Clark', 80000),
('Clark',80000),
('Diana',90000), 
('Diana',70000), 
('Bruce',180000), 
('Bruce',180000), 
('Clark',65000), 
('Hal',69000), 
('Tim',85000), 
('Tim',80000)

Select * From RankTest

Select *
From
(Select Name, ROW_NUMBER () OVER (Partition by Name Order by Name) as Ranking
From RankTest)as Derived
Where Ranking >1

USE AdventureWorks2012

Select BusinessEntityID
From Person.Person
Except 
Select BusinessEntityID
From HumanResources.Employee

Select 
       SOH.CustomerID,
	   P.FirstName + ISNULL (P.MiddleName, NULL) + P.LastName as FullName,
	   TotalDue,
       PA1.AddressLine1 + PA1.City + PA1.PostalCode + PSP1.CountryRegionCode as BillingAddress,
	    PA2.AddressLine1 + PA2.City + PA2.PostalCode + PSP2.CountryRegionCode as ShippingAddress
From Sales.SalesOrderHeader SOH
Left Join Sales.Customer C
on SOH.CustomerID = C.CustomerID
Left Join Person.Person P
on C.PersonID = P.BusinessEntityID
Left Join Person.Address PA1
on SOH.BillToAddressID = PA1.AddressID
Left Join Person.StateProvince PSP1
on PA1.StateProvinceID = PSP1.StateProvinceID
Left Join Person.Address PA2
ON SOH.ShiptoAddressID = PA2.AddressID
Left Join Person.StateProvince PSP2
ON PA2.StateProvinceID = PSP2.StateProvinceID


Use AdventureWorks2012

declare @ID int
Set @ID = 156

Select P.FirstName + ISNULL (P.MiddleName, null) + P.LastName as FullName,
       E.JobTitle,
	   E.Gender,
	   E.MaritalStatus
From HumanResources.Employee E
Inner Join Person.Person P
on E.BusinessEntityID = P.BusinessEntityID
Where P.BusinessEntityID = @ID
Go

Declare @database varchar(20), @schema varchar(20), @tablename varchar(20), @string varchar(200)

Set @database = 'AdventureWorks2012'
set @schema = 'Person'
set @tablename = 'Person'
Set @string = 'select * from ' + @database + '.' +@schema + '.' + @tablename
exec (@string)
Go

Declare @ID int
Set @ID =156
Select CONCAT ('Person with Name ', P.FirstName, ' ', P.LastName, ' works as a ', E.JobTitle)
From AdventureWorks2012.HumanResources.Employee E
Inner Join AdventureWorks2012.Person.Person P
on E.BusinessEntityID = P.BusinessEntityID
Where E.BusinessEntityID = @ID
Go
Use AdventureWorksDW2012

Select * from dbo.DimEmployee
Go



WITH DirectReports (EmployeeKey, ParentEmployeeKey, FirstName, LastName, Title,  LEVEL) AS

	(Select EmployeeKey, ParentEmployeeKey, FirstName, LastName, Title, 1 as LEVEL
	From dbo.DimEmployee
	Where ParentEmployeeKey is NULL
	And Status = 'Current'

	Union All

	Select e.EmployeeKey, e.ParentEmployeeKey, e.FirstName, e.LastName, e.Title, LEVEL+1
	From dbo.DimEmployee e
	Inner Join DirectReports d
	on e.ParentEmployeeKey = d.employeeKey
	AND e.Status = 'Current')

Select EmployeeKey, ParentEmployeeKey, FirstName, LastName, Title,  LEVEL
From DirectReports
Go

Declare @counter int, @total int
Declare @string varchar (900)

set @counter =1
set @total = (Select COUNT(*) from AdventureWorks2012.HumanResources.Employee)

While @counter <= @total

Begin

Set @string = (
               Select CONCAT (PP.FirstName, ' ', PP.LastName, ' works as a(n) ', HE.JobTitle, ' and lives in ', PA.City, ' ',C.Name)
               From AdventureWorks2012.Person.Person as PP
			   Inner Join AdventureWorks2012.Humanresources.Employee as HE
			   on PP.BusinessEntityID = HE.BusinessEntityID
			   Inner Join AdventureWorks2012.Person.BusinessEntityAddress as PBA
			   on HE.BusinessEntityID = PBA.BusinessEntityID
			   Inner Join AdventureWorks2012.Person.Address as PA
			   On PBA.AddressID = PA.AddressID
			   inner join AdventureWorks2012.Person.StateProvince PSP
			   on PA.StateProvinceID = PSP.StateProvinceID
			   Inner Join AdventureWorks2012.Person.CountryRegion as C
			   on PSP.CountryRegionCode = C.CountryRegionCode
			   Where  PP.BusinessEntityID = @counter
			   
			   )

Print @string
Set @counter = @counter +1

End
Go

Select * From Humanresources.Employee
Go

Declare @counter int, @total int, @sick int, @string varchar (900)
Set @counter =1
set @total = (select count(*) from AdventureWorks2012.HumanResources.Employee)

While @counter <= @total

Begin 

Set @sick = (Select SickLeaveHours from AdventureWorks2012.HumanResources.Employee Where BusinessEntityID = @counter)
Set @string = (Select CONCAT (P.BusinessEntityID, ' ', P.FirstName + ' ' + P.LastName)
               From AdventureWorks2012.Person.Person P 
			   inner join AdventureWorks2012.HumanResources.Employee E 
			   on P.BusinessEntityID = E.BusinessEntityID 
			   where P.BusinessEntityID = @counter)
If @sick >= 40 
   Print @string + 'is very prone to sickness.'


Else If @sick >=20
  Print @string + 'is moderately prone to sickness.'

Else
  print @string + 'is rarely sick.'

  Set @counter =@counter + 1
End
Go

Select E.BusinessEntityID, P.FirstName + ' ' + P.LastName, Status=
       Case MaritalStatus 
	   When 'M' Then 'Married'
	   When 'S' Then 'Single'
	  
	   End
	   
From AdventureWorks2012. HumanResources.Employee E
Inner Join AdventureWorks2012. Person.Person P
on E.BusinessEntityID = P.BusinessEntityID
Go


Declare @counter int, @total int, @a varchar(1), @b varchar (1), @string varchar (200)

Set @counter=0
Set @total = 5
Set @a = '*'
Set @b = ' '

While @counter <= @total
Begin


set @string = REPLICATE (@b, @counter) + REPLICATE (@a, @total-@counter)
Print @string
Set @counter = @counter +1
END
Go

CREATE TABLE #Product
(ProductShortName varchar(30), ProductFullName varchar(30))

INSERT INTO #Product (ProductShortName) VALUES
('LPTP'),
('DSKTP'),
('MNTR'),
('KBD')

Select * From #Product

Update #Product
Set ProductFullName = 
CASE ProductShortName
When 'LPTP' Then 'Laptop Computer'
When 'DSKTP' Then 'Desktop Computer'
When 'MNTR' Then 'Monitor'
When 'KBD' Then 'keyboard'
Else 'Unknown'
End

Insert into #Product (ProductShortName) values ('sktp')
Go


Create Proc DDLTempTable As

Update #Product
Set ProductFullName = 
CASE ProductShortName
When 'LPTP' Then 'Laptop Computer'
When 'DSKTP' Then 'Desktop Computer'
When 'MNTR' Then 'Monitor'
When 'KBD' Then 'keyboard'
Else 'N/A'
End

Exec DDLTempTable

Drop Proc DDLTempTable

Use Test_BIDW
Go

Create Proc NewTable  (@tablename varchar(20), 
            @Col1 varchar(20), @Col1Type varchar(20),
			@Col2 varchar(20), @Col2Type varchar(20)) 
			
AS

Declare @string varchar (max), @T varchar(20), @a varchar(20), @a1 varchar(20), @b varchar(20), @b1 varchar(20)
Set @T = @tablename
Set @a = @Col1
Set @a1= @Col1Type
Set @b = @Col2
Set @b1 = @Col2Type       
Set @string = 'Create Table ' + @T + ' ( ' + @a + ' ' +@a1 + ', ' + @b + ' ' +@b1 + ' ) ' 
Print @string
Exec @string

Exec Test_BIDW.NewTable 'AUTO', 'ID', 'int', 'Name', 'varchar(20)'


Create Table Auto
(Id int,
Name varchar(20))
Drop Table Auto
Drop Proc NewTable

Use AdventureWorks2012
Go
Select * From Person.Person

Create Proc EmpInfo (@LastName varchar (30)) AS

Select P.FirstName + ' ' + P.LastName as 'FullName',
       CONCAT (PA.AddressLine1, ' ', PA.City, ' ', PA.PostalCode, ' ', C.Name) as 'Address'
From AdventureWorks2012.Person.Person P
Inner Join AdventureWorks2012.Person.BusinessEntityAddress PBA
on P.BusinessEntityID = PBA.BusinessEntityID
Inner Join AdventureWorks2012.Person.Address PA
on PBA.AddressID = PA.AddressID
Inner Join AdventureWorks2012.Person.StateProvince PSP
on PA.StateProvinceID = psp.StateProvinceID
Inner Join AdventureWorks2012.Person.CountryRegion C
on PSP.CountryRegionCode = C.CountryRegionCode
Where P.LastName = @LastName

Exec EmpInfo Lee
Drop proc EmpInfo

Create Proc SearchEmpInfo (@ID int = null, @FirstName varchar(20) = null, @LastName varchar(20)= null) AS

Begin

If @ID is not null and @FirstName is null and @LastName is null

    
	Select P.FirstName + ' ' + P.LastName as 'FullName',
	       E.JobTitle,
		   CONCAT (PA.AddressLine1, ' ', PA.City, ' ', PA.PostalCode, ' ', C.Name) as 'Address'
	From AdventureWorks2012.HumanResources.Employee E
	Inner Join AdventureWorks2012.Person.Person P
	on E.BusinessEntityID = P.BusinessEntityID
	Inner Join AdventureWorks2012.Person.BusinessEntityAddress PBA
	on P.BusinessEntityID = PBA.BusinessEntityID
	Inner Join AdventureWorks2012.Person.Address PA
	on PBA.AddressID = PA.AddressID
	Inner Join AdventureWorks2012.Person.StateProvince PSP
	on PA.StateProvinceID = psp.StateProvinceID
	Inner Join AdventureWorks2012.Person.CountryRegion C
	on PSP.CountryRegionCode = C.CountryRegionCode
	Where P.BusinessEntityID = @ID

Else If @ID is null and @FirstName is not null and @LastName is null

    
	Select P.FirstName + ' ' + P.LastName as 'FullName',
	       E.JobTitle,
		   CONCAT (PA.AddressLine1, ' ', PA.City, ' ', PA.PostalCode, ' ', C.Name) as 'Address'
	From AdventureWorks2012.HumanResources.Employee E
	Inner Join AdventureWorks2012.Person.Person P
	on E.BusinessEntityID = P.BusinessEntityID
	Inner Join AdventureWorks2012.Person.BusinessEntityAddress PBA
	on P.BusinessEntityID = PBA.BusinessEntityID
	Inner Join AdventureWorks2012.Person.Address PA
	on PBA.AddressID = PA.AddressID
	Inner Join AdventureWorks2012.Person.StateProvince PSP
	on PA.StateProvinceID = psp.StateProvinceID
	Inner Join AdventureWorks2012.Person.CountryRegion C
	on PSP.CountryRegionCode = C.CountryRegionCode
	Where P.FirstName = @FirstName


Else If @ID is null and @FirstName is  null and @LastName is not null

    
	Select P.FirstName + ' ' + P.LastName as 'FullName',
	       E.JobTitle,
		   CONCAT (PA.AddressLine1, ' ', PA.City, ' ', PA.PostalCode, ' ', C.Name) as 'Address'
	From AdventureWorks2012.HumanResources.Employee E
	Inner Join AdventureWorks2012.Person.Person P
	on E.BusinessEntityID = P.BusinessEntityID
	Inner Join AdventureWorks2012.Person.BusinessEntityAddress PBA
	on P.BusinessEntityID = PBA.BusinessEntityID
	Inner Join AdventureWorks2012.Person.Address PA
	on PBA.AddressID = PA.AddressID
	Inner Join AdventureWorks2012.Person.StateProvince PSP
	on PA.StateProvinceID = psp.StateProvinceID
	Inner Join AdventureWorks2012.Person.CountryRegion C
	on PSP.CountryRegionCode = C.CountryRegionCode
	Where P.LastName = @LastName

Else
    Print 'Please enter either ID, first name, or last name.'

End

Exec SearchEmpInfo 


Drop Proc SearchEmpInfo
Go

Create Proc StarTriangle (@input int) AS

Declare @counter int, @total int, @a varchar(1), @b varchar(1),@string varchar (max)

Set @counter = 0
Set @total = @input
Set @a = '*'
Set @b = ' '

While @counter <= @total
Begin

set @string = REPLICATE (@b, @counter) + REPLICATE (@a, @total-@counter)
Print @string
Set @counter = @counter + 1

End

Exec StarTriangle 10
Drop Proc StarTriangle
 
Drop Proc Aster

Use Test_BIDW


Create Proc Aster (@Input int) AS
	BEGIN 
	Declare @String varchar(255), @counter int
	Set @String='*'
	Set @counter=1
	While @Counter<@Input
	Begin
	set @String=@String+' *'
	set @counter=@counter+1
	End
	Set @counter=1
	While @counter<=Len(@String)
	Begin
	print @string
	set @string=STUFF(@string,@counter,1,' ')
	set @counter=@counter+2
	End
	END
	Go
	Exec Aster 5
	Go

Use Test_BIDW
Go
Drop Function Hypotenuse
Go

Create Function Hypotenuse (@a int, @b int) 
Returns int AS

Begin
 Return sqrt (SQUARE (@a) + SQUARE (@b))
End

Select dbo.Hypotenuse (3,4)

Drop Function Hypotenuse
Go
Drop Function Circumference

Alter Function Circumference (@r int)
Returns int AS
Begin
  return 2* Pi() *@r
End

Select dbo.Circumference (4)
Drop Function Circumference
Go

Alter Function CurrentAage (@DOB date)
Returns int AS

Begin
Declare @age int
Set @age =DATEDIFF(DAY, @DOB, GETDATE())/365.25
Return @age
End

Select dbo.CurrentAage ('1985-07-15')

Drop Function CurrentAage

Go

Drop Function triangle

Alter Function triangle (@input int)
returns @tt table (star varchar(100))
AS
Begin

Declare @counter int
Set @counter = 0

While @counter <= @input
Begin
insert into @tt values (replicate('  ', @counter) + replicate (' *', @input-@counter))
set @counter = @counter + 1
End
Return 
End

Select* from  dbo.triangle (5)
Drop Function triangle


Select * from Doctor
Select * from Patient
Go

Alter Proc SP_Age (@tblname varchar(20), @fname varchar(20), @lname varchar(20), @age int out) 
As

Begin
If @tblname= 'dbo.Doctor'
Select DATEDIFF (YEAR, date_of_birth, GETDATE()) from dbo.Doctor 
Where first_name = @fname and last_name = @lname

Else if @tblname = 'dbo.Patient'
Select DATEDIFF (YEAR, date_of_birth, GETDATE()) from dbo.Patient 
Where first_name = @fname and last_name = @lname

Else
Print 'Please select from either Doctor table or Patient table.'
End

Declare @Page int
Exec SP_Age 'dbo.Doctor', 'Bob', 'Dylon', @Page out
Print @Page

Drop Proc SP_Age


Use Test_BIDW
Go

Alter Proc sp_fun (@fname varchar(40),@dob date, @LP int output, @SN int output, @OP int output) AS
Begin
Declare @counter int
Declare @tt table (Birthday date, Name varchar(1))
Set @counter = 1
While @counter <= len(@dob) or @counter <= len(@fname)
Begin
Insert into @tt
Select SUBSTRING (CAST (@dob as varchar), @counter, 1), SUBSTRING (CAST(@fname as varchar), @counter, 1)
Set @counter = @counter + 1
End

Declare @LP1 int, @SN1 int, @OP1 int
Select @LP1 = SUM (Dvalue)
From (Select Dvalue =
Case Birthday 
When '0' Then 0
When '1' Then 1
When '2' Then 2
When '3' Then 3
When '4' Then 4
When '5' Then 5
When '6' Then 6
When '7' Then 7
When '8' Then 8
When '9' Then 9
Else Null
End
from @tt) as D

Select @SN1 = SUM (Vvalue)
From (Select Vvalue =
Case Name
When 'A' Then 1
When 'E' Then 5
When 'I' Then 9
When 'o' Then 6
When 'u' Then 3
Else Null
End
From @tt) as V

Select @OP1 = SUM (Cvalue)
From (Select Cvalue=
Case Name
When 'B' Then 2
When 'C' Then 3
When 'D' Then 4
When 'F' Then 6
When 'G' Then 7
When 'H' Then 8
When 'J' Then 1
When 'K' Then 2
When 'L' Then 3
When 'M' Then 4
When 'N' Then 5
When 'P' Then 7
When 'Q' Then 8
When 'R' Then 9
When 'S' Then 1
When 'T' Then 2
When 'V' Then 4
When 'W' Then 5
When 'X' Then 6
When 'Y' Then 7
When 'Z' Then 8
Else NULL
End 
From @tt ) as C

End
Go

Declare @LP1 int, @SN1 int, @OP1 int
Exec dbo.sp_fun 'QIANWANG','1985-07-15', @LP1 OUT, @SN1 OUT, @OP1 OUT
Drop Proc sp_fun

Select * from BankCustomer
Go

Alter Proc sp_Bonus (@id int, @Bonus money out) AS
Begin
Select @Bonus = 50 * COUNT(*) From dbo.BankCustomer Where Referedby = @id
Print @Bonus
End

Declare @BonusAmount MONEY
Exec sp_Bonus 3, @BonusAmount

Drop Proc sp_Bonus
Go

Create Proc sp_Bonus AS

Begin

Declare @counter int, @nrow int, @number int

Set @counter = 1
Set @nrow = (select count (*) from dbo.BankCustomer)
While @counter <= @nrow
Begin
Select @number = 50 * COUNT (*) From BankCustomer Where ReferedBy = @counter
Update BankCustomer
Set Bonus = @number where BID = @counter
Set @counter = @counter +1
End

Select * From BankCustomer
End

Exec sp_Bonus

Drop Proc sp_Bonus