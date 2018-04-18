USE CATALOGOS
GO

DELETE FROM td_complaints_detail
DELETE FROM td_denounced
DELETE FROM tc_complaints
DELETE FROM tc_complaints_status


DECLARE
	@const_id int
	,@const_name varchar(100)
	,@table varchar(100)
	,@sqlCmd varchar(1000)

SET @const_id = 0
SET @table = 'td_complaints_detail'
SET @const_name = ''

WHILE @const_id is not null
	BEGIN
		SET @const_id = (SELECT min(dobj.object_id) 
							FROM sys.columns col 
								left outer join sys.objects dobj 
									ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
							WHERE col.object_id = object_id(@table)	
								AND dobj.object_id > @const_id
								AND dobj.name is not null)

		IF @const_id is not null
			BEGIN
				SET @const_name = (SELECT dobj.name
								FROM sys.columns col 
									left outer join sys.objects dobj 
										ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
								WHERE col.object_id = object_id(@table)	
									and dobj.object_id = @const_id
									and dobj.name is not null)
				SET @sqlCmd = 'ALTER TABLE ' + @table + ' DROP CONSTRAINT ' + @const_name
				EXEC (@sqlCmd)		
			END
	END


IF EXISTS (SELECT 1 FROM  sysobjects WHERE id = object_id(@table) AND type = 'U')
	BEGIN
		SET @sqlCmd = 'DROP TABLE ' + @table
		EXEC (@sqlCmd)
	END
GO

DECLARE
	@const_id int
	,@const_name varchar(100)
	,@table varchar(100)
	,@sqlCmd varchar(1000)

SET @const_id = 0
SET @table = 'td_denounced'
SET @const_name = ''

WHILE @const_id is not null
	BEGIN
		SET @const_id = (SELECT min(dobj.object_id) 
							FROM sys.columns col 
								left outer join sys.objects dobj 
									ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
							WHERE col.object_id = object_id(@table)	
								AND dobj.object_id > @const_id
								AND dobj.name is not null)

		IF @const_id is not null
			BEGIN
				SET @const_name = (SELECT dobj.name
								FROM sys.columns col 
									left outer join sys.objects dobj 
										ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
								WHERE col.object_id = object_id(@table)	
									and dobj.object_id = @const_id
									and dobj.name is not null)
				SET @sqlCmd = 'ALTER TABLE ' + @table + ' DROP CONSTRAINT ' + @const_name
				EXEC (@sqlCmd)		
			END
	END


IF EXISTS (SELECT 1 FROM  sysobjects WHERE id = object_id(@table) AND type = 'U')
	BEGIN
		SET @sqlCmd = 'DROP TABLE ' + @table
		EXEC (@sqlCmd)
	END
GO


DECLARE
	@const_id int
	,@const_name varchar(100)
	,@table varchar(100)
	,@sqlCmd varchar(1000)

SET @const_id = 0
SET @table = 'tc_complaints'
SET @const_name = ''

WHILE @const_id is not null
	BEGIN
		SET @const_id = (SELECT min(dobj.object_id) 
							FROM sys.columns col 
								left outer join sys.objects dobj 
									ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
							WHERE col.object_id = object_id(@table)	
								AND dobj.object_id > @const_id
								AND dobj.name is not null)

		IF @const_id is not null
			BEGIN
				SET @const_name = (SELECT dobj.name
								FROM sys.columns col 
									left outer join sys.objects dobj 
										ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
								WHERE col.object_id = object_id(@table)	
									and dobj.object_id = @const_id
									and dobj.name is not null)
				SET @sqlCmd = 'ALTER TABLE ' + @table + ' DROP CONSTRAINT ' + @const_name
				EXEC (@sqlCmd)		
			END
	END


IF EXISTS (SELECT 1 FROM  sysobjects WHERE id = object_id(@table) AND type = 'U')
	BEGIN
		SET @sqlCmd = 'DROP TABLE ' + @table
		EXEC (@sqlCmd)
	END
GO

DECLARE
	@const_id int
	,@const_name varchar(100)
	,@table varchar(100)
	,@sqlCmd varchar(1000)

SET @const_id = 0
SET @table = 'tc_complaints_status'
SET @const_name = ''

WHILE @const_id is not null
	BEGIN
		SET @const_id = (SELECT min(dobj.object_id) 
							FROM sys.columns col 
								left outer join sys.objects dobj 
									ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
							WHERE col.object_id = object_id(@table)	
								AND dobj.object_id > @const_id
								AND dobj.name is not null)

		IF @const_id is not null
			BEGIN
				SET @const_name = (SELECT dobj.name
								FROM sys.columns col 
									left outer join sys.objects dobj 
										ON dobj.object_id = col.default_object_id and dobj.type = 'D' 
								WHERE col.object_id = object_id(@table)	
									and dobj.object_id = @const_id
									and dobj.name is not null)
				SET @sqlCmd = 'ALTER TABLE ' + @table + ' DROP CONSTRAINT ' + @const_name
				EXEC (@sqlCmd)		
			END
	END


IF EXISTS (SELECT 1 FROM  sysobjects WHERE id = object_id(@table) AND type = 'U')
	BEGIN
		SET @sqlCmd = 'DROP TABLE ' + @table
		EXEC (@sqlCmd)
	END
GO