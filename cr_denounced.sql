USE CATALOGOS
GO

CREATE TYPE dbo.denounced AS TABLE (
	denounced_name				varchar(MAX)
	, denounced_lastName		varchar(MAX)
	, denounced_motherLastName	varchar(MAX)
)
GO
