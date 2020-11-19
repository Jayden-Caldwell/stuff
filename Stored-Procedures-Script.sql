/*  START  */

USE caldja3_IN705Assignment1

GO
CREATE or ALTER PROC createCustomer(
	@name nvarchar(32),
	@phone char(20),
	@postalAddress nvarchar(150),
	@email nvarchar(100) = NULL,
	@www nvarchar(150) = NULL,
	@fax char(20) = NULL,
	@mobilePhone char(12) = NULL,
	@customerID int output)
	AS
	BEGIN
	INSERT Contact (ContactName, ContactPhone, ContactPostalAddress, ContactEmail, ContactWWW, ContactFax, ContactMobilePhone) 
	VALUES (@name, @phone, @postalAddress, @email, @www, @fax, @mobilePhone)
	SET @customerID=SCOPE_IDENTITY()
	INSERT Customer (CustomerID) VALUES (@customerID)
    RETURN @customerID
	END
	GO

GO

GO
CREATE or ALTER PROC createQuote(
	@quoteDescription nvarchar(50),
	@quoteDate date = NULL,
	@quoteCompiler nvarchar(150),
	@customerID int,
	@quoteID int OUTPUT)
	AS
	BEGIN
	IF @quoteDate is null set @quoteDate = GETDATE()
	INSERT Quote (QuoteDescription, QuoteDate, QuoteCompiler, CustomerID)
	VALUES (@quoteDescription, @quoteDate, @quoteCompiler, @customerID)
	SET @quoteID = SCOPE_IDENTITY()
	RETURN @quoteID
	END
GO

GO
CREATE or ALTER PROC addQuoteComponent(
	@quoteID int,
	@componentID int, 
	@quantity decimal(7,2))
	AS
	DECLARE
	@tradePrice decimal(7,2),
	@listPrice decimal(7,2),
	@timeToFit decimal(7,2)
	SET @tradePrice = (SELECT tradePrice FROM Component WHERE @componentID = ComponentID)
	SET @listPrice = (SELECT listPrice FROM Component WHERE @componentID = ComponentID)
	SET @timeToFit = (SELECT timeToFit FROM Component WHERE @componentID = ComponentID)
	INSERT QuoteComponent (QuoteID, ComponentID, Quantity, TradePrice, ListPrice, TimeToFit)
	VALUES (@quoteID, @componentID, @quantity, @tradePrice, @listPrice, @timeToFit)
GO


GO
DECLARE @customerID int
DECLARE	@quoteID int
DECLARE @componentID int
EXEC createCustomer 'Bimble & Hat', '444 5555', '123 Digit Street, Dunedin', 'guy.little@bh.biz.nz', null, null, null, @customerID output
EXEC createQuote 'Craypot frame', null, 'Steve Vogel', @customerID, @quoteID output

SET @componentID = (SELECT componentID from Component where ComponentName like '%BMS.5.15%')
EXEC addQuoteComponent @quoteID, @componentID, 8

SET @componentID = (SELECT componentID from Component where ComponentName like '%SquareStrap.1000.15%')
EXEC addQuoteComponent @quoteID, @componentID, 3

SET @componentID = (SELECT componentID from Component where ComponentName like '%BMS15%')
EXEC addQuoteComponent @quoteID, @componentID, 24

SET @componentID = (SELECT componentID from Component where ComponentName like '%NMS15%')
EXEC addQuoteComponent @quoteID, @componentID, 24

SET @componentID = (SELECT componentID from Component where ComponentName like '%154%')
EXEC addQuoteComponent @quoteID, @componentID, 200

SET @componentID = (SELECT componentID from Component where ComponentName like '%ARTLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 150

SET @componentID = (SELECT componentID from Component where ComponentName like '%DESLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 120

SET @componentID = (SELECT componentID from Component where ComponentName like '%APPLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 45

GO

GO
DECLARE @customerID int
DECLARE	@quoteID int
DECLARE @componentID int
EXEC createCustomer 'Bimble & Hat', '444 5555', '123 Digit Street, Dunedin', 'guy.little@bh.biz.nz', null, null, null, @customerID output
EXEC createQuote 'Craypot stand', null, 'Bob Jeff', @customerID, @quoteID output

SET @componentID = (SELECT componentID from Component where ComponentName like '%BMS.15.40%')
EXEC addQuoteComponent @quoteID, @componentID, 2

SET @componentID = (SELECT componentID from Component where ComponentName like '%BMS15%')
EXEC addQuoteComponent @quoteID, @componentID, 4

SET @componentID = (SELECT componentID from Component where ComponentName like '%NMS15%')
EXEC addQuoteComponent @quoteID, @componentID, 4

SET @componentID = (SELECT componentID from Component where ComponentName like '%154%')
EXEC addQuoteComponent @quoteID, @componentID, 100

SET @componentID = (SELECT componentID from Component where ComponentName like '%APPLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 90

SET @componentID = (SELECT componentID from Component where ComponentName like '%DESLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 15


GO


GO
DECLARE @customerID int
DECLARE	@quoteID int
DECLARE @componentID int
EXEC createCustomer 'Hyperfont Modulator (International) Ltd', '(4) 213 4359', '3 Lambton Quay, Wellington', 'due@nz.hfm.com', null, null, null, @customerID output
EXEC createQuote 'Phasing restitution fulcrum', null, 'Steve Vogel', @customerID, @quoteID output

SET @componentID = (SELECT componentID from Component where ComponentName like '%CornerBrace.15%')
EXEC addQuoteComponent @quoteID, @componentID, 3

SET @componentID = (SELECT componentID from Component where ComponentName like '%SmallCorner.15%')
EXEC addQuoteComponent @quoteID, @componentID, 1

SET @componentID = (SELECT componentID from Component where ComponentName like '%ARTLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 320

SET @componentID = (SELECT componentID from Component where ComponentName like '%DESLAB%')
EXEC addQuoteComponent @quoteID, @componentID, 105

SET @componentID = (SELECT componentID from Component where ComponentName like '%43%')
EXEC addQuoteComponent @quoteID, @componentID, 0.5

GO