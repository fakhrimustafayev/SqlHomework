ALTER FUNCTION CheckAge
(
    @BirthDate DATE,
    @Age INT
)
RETURNS NVARCHAR(200)
AS
BEGIN
    DECLARE @ResultMessage NVARCHAR(200);

    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @YearsCompleted INT;

    SET @YearsCompleted = DATEDIFF(YEAR, @BirthDate, @CurrentDate)
      
     -- Yaş doğrulama sonuçlarına göre mesaj oluştur

    IF @YearsCompleted >@Age
	   BEGIN
	   IF (MONTH(@CurrentDate)>= MONTH(@BirthDate) AND (DAY(@CurrentDate)>=DAY(@BirthDate) OR DAY(@CurrentDate)<DAY(@BirthDate))) OR (MONTH(@CurrentDate)<MONTH(@BirthDate) AND (DAY(@CurrentDate)>=DAY(@BirthDate)OR DAY(@CurrentDate)<DAY(@BirthDate)))
	   BEGIN
	      SET @ResultMessage = 'Yıl,ay ve gün olarak doldurmustur';
	   END
	   END
	ELSE IF @YearsCompleted =@Age
	 BEGIN
	   IF MONTH(@CurrentDate)> MONTH(@BirthDate) OR (MONTH(@CurrentDate)=MONTH(@BirthDate) AND DAY(@CurrentDate)>=DAY(@BirthDate))
	   BEGIN
	      SET @ResultMessage = 'Yıl,ay ve gün olarak doldurmustur';
	   END
	   ELSE IF MONTH(@CurrentDate)<MONTH(@BirthDate)
	   BEGIN
         SET @ResultMessage = 'Yıl olarak doldurmuştur, ay ve gün olarak doldurmamıştır';
	   END
	   ELSE IF (MONTH(@CurrentDate)=MONTH(@BirthDate) AND DAY(@CurrentDate)<DAY(@BirthDate)) 
	   BEGIN
	      SET @ResultMessage = 'Yıl ve ay olarak doldurmuştur, gün olarak doldurmamıştır';
	   END
	 END
	ELSE
	   BEGIN
	    SET @ResultMessage = 'Kişi henüz yıl, ay ve gün olarak yaşını doldurmamıştır';
	   END

    RETURN @ResultMessage;
END;

-- Test 1
DECLARE @Result1 NVARCHAR(200);
SET @Result1 = dbo.CheckAge('2001-01-28', 17);
SELECT @Result1 AS Result;

-- Test 2
DECLARE @Result2 NVARCHAR(200);
SET @Result2 = dbo.CheckAge('1973-03-08', 60);
SELECT @Result2 AS Result;

-- Test 3
DECLARE @Result3 NVARCHAR(200);
SET @Result3 = dbo.CheckAge('2003-07-14', 21);
SELECT @Result3 AS Result;

-- Test 4
DECLARE @Result4 NVARCHAR(200);
SET @Result4 = dbo.CheckAge('1990-06-23', 15);
SELECT @Result4 AS Result;

-- Test 5
DECLARE @Result5 NVARCHAR(200);
SET @Result5 = dbo.CheckAge('2007-07-24', 17);
SELECT @Result5 AS Result;



