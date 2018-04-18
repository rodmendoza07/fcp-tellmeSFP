USE CATALOGOS
GO

CREATE TABLE tc_complaints_status (
	complaintss_id				int				identity(1, 1)
	, complaintss_name			varchar(50)		CONSTRAINT const_complaintss_name DEFAULT '' NOT NULL
	, complaintss_description	varchar(300)	CONSTRAINT const_complaintss_description DEFAULT '' NOT NULL
	, complaintss_status		tinyint			CONSTRAINT const_complaintss_status DEFAULT 1 NOT NULL
	CONSTRAINT pk_complaintss_id PRIMARY KEY (complaintss_id)
)
GO

INSERT INTO tc_complaints_status (
	complaintss_name
	, complaintss_description)
VALUES('Revisión'
	, 'Revisión')

INSERT INTO tc_complaints_status (
	complaintss_name
	, complaintss_description)
VALUES('Procedente'
	, 'Procedente')

INSERT INTO tc_complaints_status (
	complaintss_name
	, complaintss_description)
VALUES('No procede'
	, 'No Procede')

CREATE TABLE tc_complaints (
	complaints_id								uniqueidentifier	CONSTRAINT const_complaints_id DEFAULT NEWID() NOT NULL
	, complaints_complainant_name				varbinary(MAX)		CONSTRAINT const_complaints_complainant_name DEFAULT 0x NOT NULL
	, complaints_complainant_lastName			varbinary(MAX)		CONSTRAINT const_complaints_complainant_lastName DEFAULT 0x NOT NULL
	, complaints_complainant_motherLastName		varbinary(MAX)		CONSTRAINT const_complaints_complainant_motherLastName DEFAULT 0x NOT NULL
	, complaints_complainant_email				varbinary(MAX)		CONSTRAINT const_complaints_complainant_email DEFAULT 0x NOT NULL
	, complaints_complainant_movil				varbinary(MAX)		CONSTRAINT const_complaints_complainant_movil DEFAULT 0x NOT NULL
	, complaints_complainant_phone				varbinary(MAX)		CONSTRAINT const_complaints_complainant_phone DEFAULT 0x NOT NULL
	, complaints_denounced_descriptionOfFacts	varbinary(MAX)		CONSTRAINT const_complaints_denounced_descriptionOfFacts DEFAULT 0x NOT NULL
	, complaints_complaintss_id					int					CONSTRAINT const_complaintss_id DEFAULT 1 NOT NULL
	, complaints_dateCreate						datetime			CONSTRAINT const_complaints_dateCreate DEFAULT GETDATE() NOT NULL
	, CONSTRAINT pk_complaints_id PRIMARY KEY (complaints_id)
	, CONSTRAINT fk_complaints_complaintss_id FOREIGN KEY (complaints_complaintss_id) REFERENCES tc_complaints_status(complaintss_id)
)
GO

CREATE TABLE td_denounced(
	denounced_id					int					identity(1,1)
	, denounced_complaints_id		uniqueidentifier	CONSTRAINT const_denounced_complaints_id DEFAULT NEWID() NOT NULL
	, denounced_name				varbinary(MAX)		CONSTRAINT const_complaints_denounced_name DEFAULT 0x NOT NULL
	, denounced_lastName			varbinary(MAX)		CONSTRAINT const_complaints_denounced_lastName DEFAULT 0x NOT NULL
	, denounced_motherLastName		varbinary(MAX)		CONSTRAINT const_complaints_denounced_motherLastName DEFAULT 0x NOT NULL
	, CONSTRAINT pk_denounced_id PRIMARY KEY(denounced_id)
	, CONSTRAINT fk_denounced_complaints_id FOREIGN KEY (denounced_complaints_id) REFERENCES tc_complaints(complaints_id)
)
GO

CREATE TABLE td_complaints_detail (
	complaintsd_id					int					identity(1, 1)
	, complaintsd_complaints_id		uniqueidentifier	CONSTRAINT const_complaintsd_complaints_id DEFAULT NEWID() NOT NULL
	, complaintsd_comments			varbinary(MAX)		CONSTRAINT const_complaintsd_comments DEFAULT 0x NOT NULL
	, complaintsd_fileName			varbinary(MAX)		CONSTRAINT const_complaintsd_fileName DEFAULT 0x NOT NULL
	, complaintsd_fileSize			varbinary(MAX)		CONSTRAINT const_complaintsd_fileSize DEFAULT 0x NOT NULL
	, complaintsd_attachment		varbinary(MAX)		CONSTRAINT const_complaintsd_attachment DEFAULT 0x NOT NULL
	, complaintsd_complaintss_id	int					CONSTRAINT const_complaintsd_complaintss_id DEFAULT 0 NOT NULL
	, complaintsd_dateCreate		datetime			CONSTRAINT const_complaintsd_dateCreate DEFAULT GETDATE() NOT NULL
	, complaintsd_userLogin			varchar(45)			CONSTRAINT const_complaintsd_userLogin DEFAULT ''
	, CONSTRAINT pk_complaintsd_id PRIMARY KEY (complaintsd_id)
	, CONSTRAINT fk_complaintsd_complaints_id FOREIGN KEY (complaintsd_complaints_id) REFERENCES tc_complaints(complaints_id)
	, CONSTRAINT fk_complaintsd_complaintss_id FOREIGN KEY (complaintsd_complaintss_id) REFERENCES tc_complaints_status(complaintss_id)
)
GO