USE CATALOGOS
GO

ALTER PROCEDURE sp_setCompliant (
	@complaints_complainant_name varchar(100)
	, @complaints_complainant_lastName varchar(100)
	, @complaints_complainant_motherLastName varchar(100)
	, @complaints_complainant_email varchar(250)
	, @complaints_complainant_movil varchar(15)
	, @complaints_complainant_phone varchar(15)
	, @denounced dbo.denounced readonly
	, @complaints_denounced_descriptionOfFacts varchar(MAX)
)
AS
BEGIN
	DECLARE
		@complaints_id uniqueidentifier = NEWID()
		, @complaints_complaintss_id tinyint = 1
		, @complaints_dateCreate datetime = GETDATE()
		, @keyDime varchar(32) = ''

	SET @keyDime = (SELECT cfg_valor FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 25)

	INSERT INTO [dbo].[tc_complaints]
		([complaints_id]
		,[complaints_complainant_name]
		,[complaints_complainant_lastName]
		,[complaints_complainant_motherLastName]
		,[complaints_complainant_email]
		,[complaints_complainant_movil]
		,[complaints_complainant_phone]
		,[complaints_denounced_descriptionOfFacts]
		,[complaints_complaintss_id]
		,[complaints_dateCreate])
	VALUES
		( @complaints_id
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_name)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_lastName)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_motherLastName)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_email)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_movil)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_complainant_phone)
		, ENCRYPTBYPASSPHRASE(@keyDime, @complaints_denounced_descriptionOfFacts)
		, @complaints_complaintss_id
		, @complaints_dateCreate)

	INSERT INTO CATALOGOS.dbo.td_denounced(
		denounced_complaints_id
		, denounced_name
		, denounced_lastName
		, denounced_motherLastName	
	)
	SELECT
		@complaints_id
		, ENCRYPTBYPASSPHRASE(@keyDime, a.denounced_name)
		, ENCRYPTBYPASSPHRASE(@keyDime, a.denounced_lastName)
		, ENCRYPTBYPASSPHRASE(@keyDime, a.denounced_motherLastName)
	FROM @denounced a

	SELECT @complaints_id AS [complaints_id]
END