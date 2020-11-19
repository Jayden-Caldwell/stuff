/*
CREATE DATABASE caldja3_IN705Assignment1
*/
GO
USE caldja3_IN705Assignment1

IF OBJECT_ID('quotecomponent') IS NOT NULL DROP TABLE quotecomponent
IF OBJECT_ID('quote') IS NOT NULL DROP TABLE quote
IF OBJECT_ID('customer') IS NOT NULL DROP TABLE customer
IF OBJECT_ID('assemblysubcomponent') IS NOT NULL DROP TABLE assemblysubcomponent
IF OBJECT_ID('component') IS NOT NULL DROP TABLE component
IF OBJECT_ID('supplier') IS NOT NULL DROP TABLE supplier
IF OBJECT_ID('category') IS NOT NULL DROP TABLE category
IF OBJECT_ID('contact') IS NOT NULL DROP TABLE contact

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] identity (1,1) NOT NULL,
	[CategoryName] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Contact](
	[ContactID] [int] identity(1,1),
	[ContactName] [nvarchar] (32) NOT NULL,
	[ContactPhone] [char] (20) NOT NULL,
	[ContactFax] [char] (20) NULL,
	[ContactMobilePhone] [char] (12) NULL,
	[ContactEmail] [nvarchar] (100) NULL,
	[ContactWWW] [nvarchar] (150) NULL,
	[ContactPostalAddress] [nvarchar] (150) NOT NULL,
	CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED
(
	[ContactID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Component]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Component](
	[ComponentID] [int]  identity(3900,1),
	[ComponentName] [nvarchar] (32) NOT NULL,
	[ComponentDescription] [char] (50) NOT NULL,
	[TradePrice] [decimal] (7,2) NOT NULL CONSTRAINT [TradePriceCheck] CHECK (TradePrice >=0),
	[ListPrice] [decimal] (7,2)NOT NULL CONSTRAINT [ListPriceCheck] CHECK (ListPrice >=0),
	[TimeToFit] [decimal] (7,2) NOT NULL CONSTRAINT [TimeToFitCheck] CHECK(TimeToFit >=0),
	[CategoryID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	CONSTRAINT [PK_Component] PRIMARY KEY CLUSTERED
(
	[ComponentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END


GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Supplier]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] NOT NULL,
	[SupplierGST] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Quote]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Quote](
	[QuoteID] [int] identity(1,1),
	[QuoteDescription] [nvarchar] (32) NOT NULL,
	[QuoteDate] [date] NOT NULL,
	[QuotePrice] [decimal] (7,2) NULL CONSTRAINT [QuotePriceNonNegativeCheck]CHECK (QuotePrice >=0),
	[QuoteCompiler] [nvarchar] (32) NOT NULL,
	[CustomerID] [int] NOT NULL,
	CONSTRAINT [PK_Quote] PRIMARY KEY CLUSTERED
(
	[QuoteID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuoteComponent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuoteComponent](
	[QuoteID] [int],
	[ComponentID] [int],
	[Quantity] [decimal] (7,2) NOT NULL,
	[TradePrice] [decimal] (7,2) NOT NULL CONSTRAINT [TradePriceNonNegativeCheck] CHECK(TradePrice >=0),
	[ListPrice] [decimal] (7,2) NULL CONSTRAINT [ListPriceNonNegativeCheck] CHECK(ListPrice >=0),
	[TimeToFit] [decimal] (7,2) NOT NULL CONSTRAINT [TimeToFitNonNegativeCheck] CHECK(TimeToFit >=0)
	CONSTRAINT [PK_Quote_Component] PRIMARY KEY CLUSTERED
(
	[QuoteID],
	[ComponentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssemblySubcomponent]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssemblySubcomponent](
	[AssemblyID] [int],
	[SubcomponentID] [int],
	[Quantity] [nvarchar] (32) NOT NULL,
	CONSTRAINT [PK_Assembly_Subcomponent] PRIMARY KEY CLUSTERED
(
	[AssemblyID],
	[SubcomponentID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Component_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Component]'))
ALTER TABLE [dbo].[Component]  WITH CHECK ADD  CONSTRAINT [FK_Component_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Supplier_Contact]') AND parent_object_id = OBJECT_ID(N'[dbo].[Supplier]'))
ALTER TABLE [dbo].[Supplier]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_Contact] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Contact] ([ContactID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Customer_Contact]') AND parent_object_id = OBJECT_ID(N'[dbo].[Customer]'))
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Contact] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Contact] ([ContactID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Component_Supplier]') AND parent_object_id = OBJECT_ID(N'[dbo].[Component]'))
ALTER TABLE [dbo].[Component]  WITH CHECK ADD  CONSTRAINT [FK_Component_Supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
ON UPDATE CASCADE
ON DELETE NO ACTION
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Quote_Customer]') AND parent_object_id = OBJECT_ID(N'[dbo].[Quote]'))
ALTER TABLE [dbo].[Quote]  WITH CHECK ADD  CONSTRAINT [FK_Quote_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
ON UPDATE CASCADE
ON DELETE NO ACTION
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QuoteComponent_Quote]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuoteComponent]'))
ALTER TABLE [dbo].[QuoteComponent]  WITH CHECK ADD  CONSTRAINT [FK_QuoteComponent_Quote] FOREIGN KEY([QuoteID])
REFERENCES [dbo].[Quote] ([QuoteID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QuoteComponent_Component]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuoteComponent]'))
ALTER TABLE [dbo].[QuoteComponent]  WITH CHECK ADD  CONSTRAINT [FK_QuoteComponent_Component] FOREIGN KEY([ComponentID])
REFERENCES [dbo].[Component] ([ComponentID])
ON UPDATE NO ACTION
ON DELETE NO ACTION
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Subcomponent_Component]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssemblySubcomponent]'))
ALTER TABLE [dbo].[AssemblySubcomponent]  WITH CHECK ADD  CONSTRAINT [FK_Subcomponent_Component] FOREIGN KEY([SubcomponentID])
REFERENCES [dbo].[Component] ([ComponentID])
ON UPDATE NO ACTION
ON DELETE NO ACTION
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Assembly_Component]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssemblySubcomponent]'))
ALTER TABLE [dbo].[AssemblySubcomponent]  WITH CHECK ADD  CONSTRAINT [FK_Assembly_Component] FOREIGN KEY([AssemblyID])
REFERENCES [dbo].[Component] ([ComponentID])
ON UPDATE CASCADE
ON DELETE NO ACTION
GO

select * from Contact
select * from Category
select * from Component
select * from Supplier
select * from Customer
select * from Quote
select * from QuoteComponent
select * from AssemblySubcomponent
