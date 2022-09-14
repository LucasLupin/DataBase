USE master
GO
if DB_ID('TankDB') IS NOT NULL
    BEGIN
        ALTER DATABASE TankDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
        DROP DATABASE TankDB
    END
GO
CREATE DATABASE TankDB
GO

DROP TABLE IF EXISTS Tank
CREATE TABLE Tank(
Id INT IDENTITY(1,1),
[Name] NVARCHAR(255),
Amount INT,
CountryId INT
)

DROP TABLE IF EXISTS Country
CREATE TABLE Country(
Id INT IDENTITY(1,1),
[Name] NVARCHAR(255)
)

--DML INSERT/UPDATE/DELETE

INSERT INTO Tank([Name], Amount, CountryId)
VALUES('Leopard 1', 5, 2)

INSERT INTO Tank ([Name], Amount, CountryId)
VALUES('Centurion', 6, 1)

INSERT INTO Tank ([Name], Amount)
VALUES('M41', 3)

INSERT INTO Country([Name])  VALUES('Denmark')
INSERT INTO Country ([Name]) VALUES('USA')

UPDATE Tank SET [Name] = 'Sherman', Amount= 2 WHERE Id = 3;

DELETE FROM Tank WHERE Id= 1;

--DDL

SELECT Tank.[Name] AS Tank, Country.[Name] AS Country From Tank
FULL JOIN Country ON Tank.CountryId = CountryId