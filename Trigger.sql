use Northwind

select* from Shippers
select * from Orders
select * from Orders Details 
-- Shippers tablosu üzerinde çalışacak trigger oluşturma
CREATE TRIGGER Shippers_Trigger
ON Shippers
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Ekleme işlemi kontrolü
    IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED) 
    BEGIN
        PRINT 'Kayıt Ekleme İşlemi Yapıldı';
    END;

    -- Güncelleme işlemi kontrolü
    IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED) 
    BEGIN
        PRINT 'Güncelleme İşlemi Yapıldı';
    END;

    -- Silme işlemi kontrolü
    IF NOT EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED) 
    BEGIN
        PRINT 'Silme İşlemi Yapıldı';
    END;
END;


--INSERT emeliyyati
INSERT INTO Shippers (CompanyName, Phone) VALUES ('Yeni Company', '1234567890');

-- UPDATE emeliyyati
UPDATE Shippers SET CompanyName = 'Yenilenmis Company' WHERE ShipperID = 1;

-- SILME emeliyyati
DELETE FROM [Order Details] WHERE OrderID IN (SELECT OrderID FROM Orders WHERE ShipVia = 2);
DELETE FROM Orders WHERE ShipVia = 2;
DELETE FROM Shippers WHERE ShipperID = 2;

