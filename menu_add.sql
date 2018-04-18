INSERT INTO CATALOGOS.dbo.tc_menus 
	(tcmenu_id_ap
	,tcmenu_descrip
	,tcmenu_parent
	,tcmenu_url
	,tcmenu_order
	,tcmenu_class) 
VALUES
	(22
	, 'Dime'
	,234
	,'#/pld/tellme/review'
	,11
	,'{ active:view.page == "/pld/tellme/review" }')

UPDATE CATALOGOS.dbo.tc_menus SET
	tcmenu_class = '{ active: view.page == "/pld/dailyRequirement" || view.page == "/pld/authconfig" || view.page == "/pld/inquiries" || view.page == "/pld/wisw" || view.page == "/pld/tellme/review" || view.page == "/pld/tellme/review/tracing/complaint/" + view.urlDimeId }'
WHERE tcmenu_id = 234

UPDATE CATALOGOS.dbo.tc_config SET
	cfg_valor = 76
WHERE cfg_id = 24


select * from CATALOGOS.dbo.tc_menus where tcmenu_id > 228

select * from CATALOGOS.dbo.tc_aplicaciones

UPDATE CATALOGOS.dbo.tc_aplicaciones SET
	nombre_ap = 'SFP'
WHERE id_ap = 22;

select * from CATALOGOS.dbo.tc_menus where tcmenu_id_ap = 22

UPDATE CATALOGOS.dbo.tc_menus SET
	tcmenu_parent = 0
WHERE tcmenu_id = 234

UPDATE CATALOGOS.dbo.tc_menus SET
	tcmenu_icon = 'fa fa-chart-line'
WHERE tcmenu_id = 240