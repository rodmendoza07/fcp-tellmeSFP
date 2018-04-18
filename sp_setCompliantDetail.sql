USE CATALOGOS
GO

ALTER PROCEDURE sp_setComplaintDetail (
	@complaintsd_id	int = 0
	, @complaintsd_complaints_id uniqueidentifier
	, @complaintsd_comments varchar(MAX) = ''
	, @complaintsd_fileName varchar(MAX) = ''
	, @complaintsd_fileSize varchar(MAX) = ''
	, @complaintsd_attachment1 nvarchar(MAX) = ''
	, @complaintsd_complaintss_id int = 1
	, @complaintsd_userId INT = ''
)
AS
BEGIN
	DECLARE
		@messageError varchar(500) = ''
		, @keyDime varchar(32) = ''
		, @complaintsd_userLogin varchar(45)
		, @complaintsd_attachment varbinary(MAX) = 0x

	SET @keyDime = (SELECT cfg_valor FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 25)
	SET @complaintsd_userLogin = (SELECT usuario FROM CATALOGOS.dbo.tc_empleados WHERE id_empleados = @complaintsd_userId)
	--SET @complaintsd_attachment = CAST(@complaintsd_attachment1 AS varbinary)

	BEGIN TRY
		IF (SELECT COUNT(*) FROM CATALOGOS.dbo.tc_complaints WHERE complaints_id = @complaintsd_complaints_id) = 0
			RAISERROR('No existe la denuncia proporcionada', 16, 1)

		INSERT INTO [CATALOGOS].[dbo].[td_complaints_detail]
			([complaintsd_complaints_id]
			,[complaintsd_comments]
			,[complaintsd_fileName]
			,[complaintsd_fileSize]
			,[complaintsd_attachment]
			,[complaintsd_complaintss_id]
			,[complaintsd_dateCreate]
			,[complaintsd_userLogin])
		VALUES
			(@complaintsd_complaints_id
			, ENCRYPTBYPASSPHRASE(@keyDime, @complaintsd_comments)
			, ENCRYPTBYPASSPHRASE(@keyDime, @complaintsd_fileName)
			, ENCRYPTBYPASSPHRASE(@keyDime, @complaintsd_fileSize)
			, @complaintsd_attachment1
			, @complaintsd_complaintss_id
			, GETDATE()
			, @complaintsd_userLogin)
	END TRY
	BEGIN CATCH
		SET @messageError = CAST(ERROR_MESSAGE() AS varchar(500))

		RAISERROR(@messageError, 16, 1)
	END CATCH 
END 