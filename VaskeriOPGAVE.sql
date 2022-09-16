USE master
GO
if DB_ID('VaskeriDB') IS NOT NULL
    BEGIN
        ALTER DATABASE VaskeriDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE VaskeriDB
    END
GO
CREATE DATABASE VaskeriDB
GO

USE VaskeriDB

DROP TABLE IF EXISTS Vaskerier
CREATE TABLE Vaskerier(
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
Åben Time NOT NULL,
Luk Time NOT NULL
)
GO

DROP TABLE IF EXISTS Brugere
CREATE TABLE Brugere(
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Name] NVARCHAR(20) NOT NULL,
Email NVARCHAR(60) UNIQUE NOT NULL,
[Password] NVARCHAR(24) NOT NULL,
check (LEN([Password]) >= 5) NOT NULL,
Konto Decimal (8,2) NOT NULL,
VaskeriID INT FOREIGN Key REFERENCES Vaskerier(ID),
Oprettelse Date NOT NULL
)
GO


DROP TABLE IF EXISTS Maskiner
CREATE TABLE Maskiner(
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
[Name] NVARCHAR(30) NOT NULL,
Pris Decimal(7,2) NOT NULL,
VaskeTid INT NOT NULL,
VaskeriID INT FOREIGN Key REFERENCES Vaskerier(ID)
)
GO

DROP TABLE IF EXISTS Bookinger
CREATE TABLE Bookinger(
ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
Tidspunkt DATETIME NOT NULL,
BrugereID INT FOREIGN Key REFERENCES Brugere(ID),
MaskineID INT FOREIGN Key REFERENCES Maskiner(ID)
)
GO

-- Vaskerier

INSERT INTO Vaskerier ([Name] , Åben, Luk)
VALUES ('Whitewash Inc.', '08:00' , '20:00')

INSERT INTO Vaskerier ([Name] , Åben, Luk)
VALUES ('Double Bubble', '02:00' , '22:00')

INSERT INTO Vaskerier ([Name] , Åben, Luk)
VALUES ('Wash & Coffee', '12:00' , '20:00')


-- Brugere
INSERT INTO Brugere ([Name] , Email,  [Password], Konto, VaskeriID, Oprettelse)
VALUES ('John','john_doe66@gmail.com', 'password', 100.00, 2, '2021-02-15')

INSERT INTO Brugere ([Name] , Email,  [Password], Konto, VaskeriID, Oprettelse)
VALUES ('Neil Armstrong','firstman@nasa.gov', 'eagleLander69', 1000.00 , 1, '2021-02-10')

INSERT INTO Brugere ([Name] , Email,  [Password], Konto, VaskeriID, Oprettelse)
VALUES ('Batman','noreply@thecave.com', 'Rob1n', 500.00 , 3, '2020-03-10')

INSERT INTO Brugere ([Name] , Email,  [Password], Konto, VaskeriID, Oprettelse)
VALUES ('Goldman Sachs','moneylaundering@gs.com', 'NotRecognized', 100000.00 , 1, '2021-01-01')

INSERT INTO Brugere ([Name] , Email,  [Password], Konto, VaskeriID, Oprettelse)
VALUES ('50 Cent','50cent@gmail.com', 'ItsMyBirthday',  0.50 , 3, '2020-07-06')



-- Maskiner 

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('Mielle 911 Turbo', 5.00 , 60, 2)

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('Siemons IClean', 10000.00 , 30, 1)

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('Electrolax FX-2', 15.00 , 45, 2)

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('NASA Spacewasher 8000', 500.00 , 5, 1)

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('The Lost Sock', 3.50 , 90, 3)

INSERT INTO Maskiner ([Name] , Pris , VaskeTid , VaskeriID )
VALUES ('Yo Mama', 0.50 , 120, 3)

-- Bookinger

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 12:00:00', 1, 1)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 16:00:00', 1, 3)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 08:00:00', 2, 4)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 15:00:00', 3, 5)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 20:00:00', 4, 2)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 19:00:00', 4, 2)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 10:00:00', 4, 2)

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2021-02-26 16:00:00', 5, 6)


BEGIN TRANSACTION Booking;

INSERT INTO Bookinger ([Tidspunkt], BrugereID, MaskineID)
VALUES ('2022-09-15 12:00:00', 4, 2)

Commit;

go
CREATE VIEW BookingView AS 
	SELECT Bookinger.Tidspunkt, Brugere.[Name] AS Bruger_Navn, Maskiner.[Name], Maskiner.Pris 
  FROM Bookinger
	JOIN Brugere ON Bookinger.BrugereID = Brugere.ID
	JOIN Maskiner ON Bookinger.MaskineID = Maskiner.ID
go

SELECT * FROM BookingView
--DML INSERT/UPDATE/DELETE

SELECT Email FROM Brugere WHERE Email like '%@gmail.com'

SELECT * FROM Maskiner JOIN Vaskerier ON Maskiner.VaskeriID = Vaskerier.ID

SELECT Maskiner.[Name] ,COUNT(bookinger.MaskineID) AS Bookinger From Maskiner
JOIN Bookinger on bookinger.maskineID = maskiner.ID
Group By Maskiner.[Name]

DELETE FROM Bookinger WHERE CAST(Tidspunkt as time(0)) BETWEEN '12:00:00' AND '13:00:00'

UPDATE Brugere SET [Password] = 'SelinaKyle' WHERE Id = 3;
