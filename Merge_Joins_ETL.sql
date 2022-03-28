
--Using MERGE Statement to perform ETL

IF EXISTS (SELECT 1 FROM SYS.TABLES where name ='Locations_stage')
BEGIN 
DROP TABLE Locations_stage
END
 
IF EXISTS (SELECT 1 FROM SYS.TABLES where name ='Locations')
BEGIN 
DROP TABLE Locations
END
 
 
CREATE TABLE [dbo].[Locations](
  [LocationID] [int] NULL,
  [LocationName] [varchar](100) NULL
) 
GO
 
 
 
CREATE TABLE [dbo].[Locations_stage](
  [LocationID] [int] NULL,
  [LocationName] [varchar](100) NULL
) 
GO
 
 
INSERT INTO Locations values (1,'Richmond Road'),(2,'Brigade Road') ,(3,'Houston Street')
 
 
INSERT INTO Locations_stage values (1,'Richmond Cross') ,(3,'Houston Street'), (4,'Canal Street')
 
MERGE Locations T
USING Locations_stage S ON T.LocationID=S.LocationID
 
WHEN MATCHED THEN
UPDATE SET LocationName=S.LocationName
 
 
WHEN NOT MATCHED BY TARGET 
THEN 
INSERT (LocationID,LocationName)
VALUES (S.LocationID,S.LocationName)
 
WHEN NOT MATCHED BY SOURCE 
THEN 
DELETE
  OUTPUT DELETED.*, $action AS [Action], INSERTED.* ;


--Using a left outer join to insert, delete rows and inner join to update matched rows

DELETE T FROM Locations T 
LEFT OUTER JOIN Locations_stage S on T.LocationID=S.LocationID
WHERE S.LocationID IS NULL

update t set LocationName=s.LocationName from Locations t 
inner join Locations_stage s on t.LocationID=s.LocationID

INSERT INTO Locations(LocationID,LocationName)
select  t.LocationID,T.LocationName FROM Locations_stage T 
LEFT OUTER JOIN Locations S on T.LocationID=S.LocationID
WHERE S.LocationID IS NULL