CREATE DATABASE sp_LocationDatabase;
USE sp_LocationDatabase;

CREATE TABLE Countries
(
   CountryID INT PRIMARY KEY IDENTITY (1,1),
   CountryName NVARCHAR(50) NOT NULL
)
  
CREATE TABLE Cities
(
    CityID INT PRIMARY KEY IDENTITY (1,1),
	CityName NVARCHAR(50) NOT NULL,
	CountryID INT,
	FOREIGN KEY (CountryID) REFERENCES COUNTRIES(CountryID)
)

CREATE TABLE Districts
(
  DistrictID INT PRIMARY KEY IDENTITY (1,1),
  DistrictName NVARCHAR(50) NOT NULL,
  CityID INT,
  FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Towns
(
  TownID INT PRIMARY KEY IDENTITY (1,1),
  TownName NVARCHAR(50) NOT NULL,
  DistrictID INT,
  FOREIGN KEY (DistrictID) REFERENCES Districts(DistrictID)
)


CREATE PROCEDURE GetLocations
    @Country NVARCHAR(50),
    @City NVARCHAR(50),
    @District NVARCHAR(50),
    @Town NVARCHAR(50)
AS
BEGIN
    DECLARE @CountryID INT;
    DECLARE @CityID INT;
    DECLARE @DistrictID INT;

    -- Ölkenin varlığının kontrol edilib elave edilmesi
    IF NOT EXISTS (SELECT 1 FROM Countries WHERE CountryName = @Country)
    BEGIN
        INSERT INTO Countries (CountryName) VALUES (@Country);
        SET @CountryID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @CountryID = (SELECT CountryID FROM Countries WHERE CountryName = @Country);
    END;

    -- Seherin varlığının kontrol edilib elave edilmesi
    IF NOT EXISTS (SELECT 1 FROM Cities WHERE CityName = @City AND CountryID = @CountryID)
    BEGIN
        INSERT INTO Cities (CityName, CountryID) VALUES (@City, @CountryID);
        SET @CityID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @CityID = (SELECT CityID FROM Cities WHERE CityName = @City AND CountryID = @CountryID);
    END;

    -- Rayonun varlığının kontrol edilib elave edilmesi
    IF NOT EXISTS (SELECT 1 FROM Districts WHERE DistrictName = @District AND CityID = @CityID)
    BEGIN
        INSERT INTO Districts (DistrictName, CityID) VALUES (@District, @CityID);
        SET @DistrictID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @DistrictID = (SELECT DistrictID FROM Districts WHERE DistrictName = @District AND CityID = @CityID);
    END;

    -- Mehellenin varlığının kontrol edilib elave edilmesi
    IF NOT EXISTS (SELECT 1 FROM Towns WHERE TownName = @Town AND DistrictID = @DistrictID)
    BEGIN
        INSERT INTO Towns (TownName, DistrictID) VALUES (@Town, @DistrictID);
    END;
END;



-- Test1
EXEC GetLocations 'Azerbaijan', 'Baku', 'Yasamal', 'Galaba Circuit';

-- Test2
EXEC GetLocations 'Germany', 'Berlin', 'Celle', 'Strausberg';

-- Test3
EXEC GetLocations 'Azerbaijan', 'Baku', 'Nesimi', '28 May kucesi';

-- Test4
EXEC GetLocations 'United Kingdom', 'London', 'Boston', 'Loncolnshire';


SElect * from Countries;
select * from Cities;
select * from Districts;
select * from Towns;



