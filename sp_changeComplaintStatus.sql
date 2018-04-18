USE CATALOGOS
GO

ALTER PROCEDURE sp_changeComplaintStatus(
	@option INT
	, @complaintsd_complaints_id uniqueidentifier
	, @profile INT
	, @complaintsd_userId INT
)
AS
BEGIN
	DECLARE
		@msg VARCHAR(300)
		, @keyDime varchar(32) = ''
		, @complaintsd_comments VARCHAR(50) = ''
		, @complaintsd_userLogin VARCHAR(15) = ''

	SET @keyDime = (SELECT cfg_valor FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 25)
	SET @complaintsd_userLogin = (SELECT usuario FROM CATALOGOS.dbo.tc_empleados WHERE id_empleados = @complaintsd_userId)

	BEGIN TRY
		IF @profile <> (SELECT CAST(cfg_valor AS int) FROM CATALOGOS.dbo.tc_config WHERE cfg_id = 24 AND cfg_estatus = 1)
			RAISERROR('No cuentas con acceso para revisar la información', 16, 1)

		UPDATE CATALOGOS.dbo.tc_complaints SET
			complaints_complaintss_id = @option
		WHERE complaints_id = @complaintsd_complaints_id

		IF @option = 2
			SET @complaintsd_comments = 'El aviso procede.'
		ELSE
			SET @complaintsd_comments = 'El aviso no procede'

		INSERT INTO CATALOGOS.dbo.[td_complaints_detail] (
			[complaintsd_complaints_id]
			, [complaintsd_comments]
			, [complaintsd_complaintss_id]
			, [complaintsd_userLogin]
		) VALUES (
			@complaintsd_complaints_id
			, ENCRYPTBYPASSPHRASE(@keyDime, @complaintsd_comments)
			, @option
			, @complaintsd_userLogin
		)

		SELECT 'ok' AS msg;
					
	END TRY
	BEGIN CATCH
		SET @msg = (SELECT SUBSTRING(ERROR_MESSAGE(), 1, 300))
		RAISERROR(@msg, 16, 1)
	END CATCH
END

--EXEC CATALOGOS.dbo.sp_changeComplaintStatus
--	@option = 2
--	, @complaintsd_complaints_id = '46553886-0d41-4fd9-85b5-edd27f4fbe9e'
--	, @profile = 76
--	, @complaintsd_userId = 13