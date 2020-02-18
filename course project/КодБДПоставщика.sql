
-- Запрос на выгрузку данных, для загрузки данных в сервсиную БД
SELECT 
	p.artikul as model,
	CASE WHEN c.NoSkidka=1 THEN c.Cena ELSE (c.Cena*(100-(SELECT Proc_Skid from Clients limit 1))/100 ) END as price, 
	CASE WHEN ost=1 THEN 100 ELSE 0 END as quantity,
	Tov_Name as name,
	KolvoMin as minimum,
	model as sku,
	Brand_Nm,
	TovGroup
	FROM ClPrice c	
	JOIN Price p 
		ON c.KodTov=p.KodTov;