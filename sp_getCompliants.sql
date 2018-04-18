USE CATALOGOS
GO

ALTER PROCEDURE sp_getCompliants (
	@profile int
	, @complaints_id uniqueidentifier = NULL
)
AS
BEGIN
	DECLARE
		@keyDime varchar(32) = ''
		, @errorMessage varchar(500) 

	BEGIN TRY
		SET @keyDime = (SELECT cfg_valor FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 25)

		IF @profile <> (SELECT CAST(cfg_valor AS int) FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 24 AND cfg_estatus = 1)
			RAISERROR('No cuentas con acceso para revisar la información', 16, 1)

		SELECT 
			ROW_NUMBER() OVER(ORDER BY a.complaints_dateCreate DESC ) AS [No]
			, [complaints_id]
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
		WHERE (@complaints_id IS NOT NULL AND complaints_id = @complaints_id) OR (@complaints_id IS NULL)
	
	END TRY
	BEGIN CATCH				
		SET @errorMessage = CAST(ERROR_MESSAGE() AS varchar(300))		
		RAISERROR(@errorMessage, 16, 1)
	END CATCH	
END
