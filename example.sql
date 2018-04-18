DECLARE
	@complaintsd_idx int = 0
	, @complaintsd_complaints_idx uniqueidentifier = '8FEEA501-4BCE-4FF1-A7DA-77CA6B6605FC'
	, @complaintsd_commentsx varchar(MAX) = 'Test de comentarios qwerty qazwsx edcrfv qwerty asdfghzxcvbn'
	, @complaintsd_fileNamex varchar(MAX) = 'CPdescarga.txt'
	, @complaintsd_fileSizex varchar(MAX) = '27874 KB'
	, @complaintsd_attachmentx varbinary(MAX) = 0x
	, @complaintsd_complaintss_idx int = 1
	, @complaintsd_dateCreatex datetime = GETDATE()
	, @complaintsd_userLoginx varchar(45) = 'joseob'

--SET @complaintsd_attachmentx = (SELECT * FROM OPENROWSET(BULK N'D:\WEB\uploadFiles\CPdescarga.txt', SINGLE_BLOB)	AS BLOBData)

EXEC CATALOGOS.dbo.sp_setComplaintDetail
	@complaintsd_id	= @complaintsd_idx
	, @complaintsd_complaints_id = @complaintsd_complaints_idx
	, @complaintsd_comments = @complaintsd_commentsx
	, @complaintsd_fileName = @complaintsd_fileNamex
	, @complaintsd_fileSize = @complaintsd_fileSizex
	, @complaintsd_attachment = @complaintsd_attachmentx
	, @complaintsd_complaintss_id = @complaintsd_complaintss_idx
	, @complaintsd_userLogin = @complaintsd_userLoginx

SELECT * FROM CATALOGOS.dbo.td_complaints_detail

EXEC CATALOGOS.dbo.sp_getCompliantDetail
	@profile = 0
	, @complaints_id = @complaintsd_complaints_idx