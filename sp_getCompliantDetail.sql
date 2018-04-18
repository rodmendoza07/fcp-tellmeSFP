USE CATALOGOS
GO

ALTER PROCEDURE sp_getCompliantDetail (
	@profile int = 0
	, @complaints_id uniqueidentifier
)
AS
BEGIN
	DECLARE
		@keyDime varchar(32) = ''
		, @errorMessage varchar(500) = ''

	BEGIN TRY
		SET @keyDime = (SELECT cfg_valor FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 25)

		IF @profile <> (SELECT CAST(cfg_valor AS int) FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 24)
			RAISERROR('No cuentas con acceso para revisar la información', 16, 1)

		SELECT 
			[complaints_id]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_name)) AS [complaints_complainant_name]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_lastName)) AS [complaints_complainant_lastName]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_motherLastName)) AS [complaints_complainant_motherLastName]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_email)) AS [complaints_complainant_email]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_movil)) AS [complaints_complainant_movil]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_complainant_phone)) AS [complaints_complainant_phone]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaints_denounced_descriptionOfFacts)) AS [complaints_denounced_descriptionOfFacts]
			, a.complaints_complaintss_id
			, a.complaints_dateCreate
			, b.complaintss_description
			, CASE
				WHEN b.complaintss_id = 1 THEN 'label label-warning'
				WHEN b.complaintss_id = 2 THEN 'label label-primary'
				WHEN b.complaintss_id = 3 THEN 'label label-danger'
			END AS complaintss_class
		FROM [CATALOGOS].[dbo].[tc_complaints] a
			INNER JOIN CATALOGOS.dbo.tc_complaints_status b ON (a.complaints_complaintss_id = b.complaintss_id)
		WHERE complaints_id = @complaints_id

		SELECT 
			a.denounced_id
			, a.denounced_complaints_id
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.denounced_name)) AS [complaints_denounced_name]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.denounced_lastName)) AS [complaints_denounced_lastName]
			, CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.denounced_motherLastName)) AS [complaints_denounced_motherLastName]
		FROM CATALOGOS.dbo.td_denounced a
		WHERE a.denounced_complaints_id = @complaints_id

		SELECT
			a.complaintsd_id
			, a.complaintsd_complaints_id
			, ISNULL(CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaintsd_comments)), '') AS [complaintsd_comments]
			, ISNULL(CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaintsd_fileName)), '') AS [complaintsd_fileName]
			, ISNULL(CONVERT(varchar(MAX), DECRYPTBYPASSPHRASE(@keyDime, a.complaintsd_fileSize)), '') AS [complaintsd_fileSize]
			, a.complaintsd_attachment
			, b.complaintss_name
			, a.complaintsd_dateCreate
			, a.complaintsd_userLogin
			, a.complaintsd_complaintss_id
		FROM CATALOGOS.dbo.td_complaints_detail a WITH (NOLOCK)
			INNER JOIN CATALOGOS.dbo.tc_complaints_status b WITH (NOLOCK) ON (a.complaintsd_complaintss_id = b.complaintss_id)
		WHERE a.complaintsd_complaints_id = @complaints_id
		ORDER BY a.complaintsd_dateCreate DESC
		
	END TRY
	BEGIN CATCH
		SET @errorMessage = CAST(ERROR_MESSAGE() AS varchar(500))

		RAISERROR(@errorMessage, 16, 1)
	END CATCH
END