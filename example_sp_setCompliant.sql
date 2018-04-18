--sp_help tc_complaints
--sp_help td_denounced

DECLARE
	@denouncedX denounced

INSERT INTO @denouncedX
SELECT
	'Rodolfo' AS [name]
	, 'Osorio' AS [lastName]
	, 'Bustamante' AS [motherLastName]
UNION
SELECT
	'Luis Rodrigo' AS [name]
	, 'Mendoza' AS [lastName]
	, 'Rodriguez' AS [motherLastName]
UNION
SELECT
	'Alejandro' AS [name]
	, 'Badillo' AS [lastName]
	, 'Zarate' AS [motherLastName]

SELECT *
FROM @denouncedX

EXECUTE CATALOGOS.dbo.sp_setCompliant
	@complaints_complainant_name = N'David'
	, @complaints_complainant_lastName =  N'González'
	, @complaints_complainant_motherLastName = N'Vidal'
	, @complaints_complainant_email = N'david.gonzalez@grupoporvenir.com.mx'
	, @complaints_complainant_movil = N'5512345678'
	, @complaints_complainant_phone = N'5512345678'
	, @denounced = @denouncedX
	, @complaints_denounced_descriptionOfFacts = N'No puede hacer algo ASP Classic'
