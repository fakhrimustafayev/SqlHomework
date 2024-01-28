use Northwind
select * from Categories
select * from Products

ALTER PROCEDURE ProductCategoryEkleme
  @CategoryName nvarchar(50),
  @Description nvarchar(50),
  @ProductName nvarchar(50),
  @UnitPrice nvarchar(50),
  @UnitsInStock nvarchar(50)
AS
 BEGIN
  DECLARE @CategoryID INT

  --Kategoriyanin movcudlugunu yoxlayiriq
  IF NOT  EXISTS (SELECT 1 FROM Categories WHERE CategoryName=@CategoryName)
  BEGIN
  INSERT INTO Categories (CategoryName,Description) VALUES (@CategoryName,@Description)
  SET @CategoryID = SCOPE_IDENTITY();  --yeni id'ni menimsedirik
  END
  ELSE
   BEGIN
     SET @CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = @CategoryName)
	 PRINT 'Bu kategoriy movcuddur. Kategoriya ID: ' + CAST(@CategoryID AS NVARCHAR(10));
   END

   INSERT INTO Products (CategoryID,ProductName,UnitPrice,UnitsInStock) VALUES (@CategoryID,@ProductName,@UnitPrice,@UnitsInStock) 
   END


 
