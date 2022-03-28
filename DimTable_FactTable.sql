Use TestBank
Select * From dbo.AccountActivity
Select * From dbo.dimAccount
Select * From dbo.dimAccount_Type
Select * From dbo.dimCustomer
Select * From dbo.FactTransaction

Go


Create Table FactTransaction
(id int primary key identity (1,1),
account_id int,
account_type int,
Customer_id int

Constraint FK_accountid Foreign Key (account_id) references dbo.dimAccount (account_id),
Constraint FK_accounttype Foreign Key (account_type) references dbo.dimAccount_Type (account_type_code),
Constraint FK_customerid Foreign Key (customer_id) references dbo.dimCustomer (Customer_id))

EXEC sp_rename 'dbo.AccountActivity.account_id', 'Transac_id', 'COLUMN'
EXEC sp_rename 'dbo.AccountActivity.Transac_id', 'account_id', 'COLUMN'

Alter Table dbo.AccountActivity
Add Transac_id int primary key identity (1,1)

Alter Table dbo.AccountActivity
Add time datetime
Update dbo.AccountActivity
Set time = GETDATE()

Alter Table AccountActivity
Add  Customer_name varchar (20)

Update dbo.AccountActivity 
Set Customer_name = 'Apple ' Where account_id = 3

Alter Table FactTransaction
Alter Column time date

Exec sp_rename 'dbo.FactTransaction.time', 'date', 'Column'
