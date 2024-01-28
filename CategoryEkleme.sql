use Northwind

select * from Categories

ALTER PROCEDURE GetCategories 
    @Category nvarchar(50)
AS
 BEGIN
    DECLARE @CategoryID INT
	   --CategoryName'in uzunlugunu kecib kecmediyini yoxluyur
    IF LEN(@Category) > (SELECT CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Categories' AND COLUMN_NAME = 'CategoryName')
    BEGIN
        PRINT 'Error: Daxil etdyiniz kategoriya adi cox uzundur';
        RETURN;
    END

	--Kategoriyani kontrol etme
	IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @Category)
    BEGIN
	--Kategoriya yoxsua elave et
        INSERT INTO Categories (CategoryName) VALUES (@Category);
	END
	 ELSE
    BEGIN
        -- Kategoriya zaten varsa xeberdarliq mesajı gönder
		SET @CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = @Category);
        PRINT 'Bu ' + CAST(@CategoryID AS NVARCHAR(10))+' IDli  kategoriya movcuddur';
    END
  END;



