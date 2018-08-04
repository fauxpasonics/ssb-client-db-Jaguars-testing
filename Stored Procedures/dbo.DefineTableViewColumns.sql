SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[DefineTableViewColumns](
@db VARCHAR(100)
,@isTable BIT
,@schema VARCHAR(50)
,@name VARCHAR(100)
)
AS

BEGIN

DECLARE @runStatement VARCHAR(MAX)

IF (@isTable = 1)
BEGIN

SET @runStatement = 'USE ' + @db +

' SELECT columns.name as ColumnName
	   ,types.name as DataType
	   ,types.max_length	
	   ,types.precision	
	   ,types.scale
FROM sys.tables tables
	JOIN sys.schemas schemas
		ON schemas.schema_id = tables.schema_id
	JOIN sys.columns columns
		ON columns.object_id = tables.object_id
	JOIN sys.types types
		ON types.system_type_id = columns.system_type_id
		   AND types.user_type_id = columns.user_type_id
WHERE tables.NAME = ''' + @name +
	  ''' AND schemas.name = ''' + @schema + ''''

END

ELSE
BEGIN

SET @runStatement = 'USE ' + @db +

' SELECT columns.name as ColumnName
	   ,types.name as DataType
	   ,types.max_length	
	   ,types.precision	
	   ,types.scale
FROM sys.views views
	JOIN sys.schemas schemas
		ON schemas.schema_id = views.schema_id
	JOIN sys.columns columns
		ON columns.object_id = views.object_id
	JOIN sys.types types
		ON types.system_type_id = columns.system_type_id
		   AND types.user_type_id = columns.user_type_id
WHERE views.NAME = ''' + @name +
	  ''' AND schemas.name = ''' + @schema + ''''

END

EXEC (@runStatement)

END


GO
