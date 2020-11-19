select * from Students
USE users GO

DECLARE @ListOfStudents Table (
[rowNumber] int NOT NULL identity(1,1), [LastName] varchar(100) NULL, 
[FirstName] varchar(100) NULL,
 [Username] varchar(100) NULL, 
[UserPassword] varchar(100) NULL
)

IF EXISTS (SELECT * FROM @listOfStudents) 
BEGIN 
INSERT INTO @ListOfStudents (LastName, FirstName, Username, UserPassword) 
SELECT LastName, FirstName, Username, password FROM Students
DECLARE @currentRow int
DECLARE @maximumRows int
DECLARE @ExecTemp nvarchar(1000)
DECLARE @_Login nvarchar(100), @_Password nvarchar(100), @_DefaultDatabase nvarchar(100)
--Driving loop
 WHILE @currentRow <= @maximumRows
 	BEGIN 
		SET @ExecTemp = 'CREATE LOGIN ' + @_Login + ' WITH PASSWORD = ''' + @_Password + ''', DEFAULT_DATABASE = ' + @_DefaultDatabase 
		PRINT (@ExecTemp)
		EXEC (@ExecTemp)
		END
SET @currentRow += 1;
END
BEGIN

--Creating databases

DECLARE @dbFilePath nvarchar(2000) 
DECLARE @dbLogPath nvarchar(2000)
DECLARE @createFolderXP nvarchar(2000) 
DECLARE @domainLogin nvarchar(30) 
DECLARE @prefix nvarchar(200)
DECLARE @dbName nvarchar(1000)

DECLARE @logicalDataName nvarchar(600) 
DECLARE @logicalLogName nvarchar(600) 
DECLARE @dataFileName nvarchar(600) 
DECLARE @logFileName nvarchar(600)

DECLARE @dataSize nvarchar(500) 
DECLARE @dataMaxSize nvarchar(500) 
DECLARE @dataFileGrowth nvarchar(500) 
DECLARE @logSize nvarchar(500) 
DECLARE @logMaxSize nvarchar(500) 
DECLARE @logFileGrowth nvarchar(500)
DECLARE @exeTemp nvarchar(500)
PRINT('Begin create database')
SET @LogicalDataName=@DBName + '_dat'
SET @DataFileName= @dbFilePath + @DBName + '.mdf'
SET @LogicalLogName=@DBName + '_log'
SET @LogFileName= @dbLogPath + @DBName + '.ldf'

SET @exeTemp = 'CREATE DATABASE ' + @DBName + ' ON ('
+ 'NAME = [' + @LogicalDataName + '], '
+ 'FILENAME = [' + @DataFileName + '], '
+ 'SIZE = ' + @DataSize + ', '
+ 'MAXSIZE = ' + @DataMaxSize + ', '
+ 'FILEGROWTH = ' + @DataFileGrowth + ') '
+ 'LOG ON ('
+ 'NAME = [' + @LogicalLogName + '], '
+ 'FILENAME = [' + @LogFileName + '], '
+ 'SIZE = ' + @LogSize + ', '
+ 'MAXSIZE = ' + @LogMaxSize + ', '
+ 'FILEGROWTH = ' + @LogFileGrowth + ') ' PRINT('Creating database ' + @DBName)
PRINT(exeTemp)
END(@exeTemp)
END

SET @exeTemp='USE ' + @_DBName + ' CREATE USER [' + @_Login + '] FOR LOGIN [' + @_Login + ']'
