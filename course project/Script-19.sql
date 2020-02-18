select Artikul, (c.Cena*(100-(SELECT Proc_Skid from Clients limit 1))/100 )
	FROM ClPrice c
	JOIN Price p 
		ON c.KodTov=p.KodTov
	where 	p.KodTov=80113;	


SELECT Proc_Skid from Clients limit 1;

select Artikul, c.Cena
	FROM ClPrice c
	JOIN Price p 
		ON c.KodTov=p.KodTov
	where 	p.KodTov=80113;	
	
SELECT (SELECT Proc_Skid from Clients limit 1)/10 ;


SELECT Artikul,Model  from Price WHERE Artikul<>TRIM(Model);


SELECT COUNT(*)  from Price WHERE Artikul<>TRIM(Model);

SELECT Artikul,Model  from Price WHERE Artikul LIKE '%_z%';



SELECT COUNT(*)  from Price WHERE Artikul LIKE '%_z%';

SELECT * from (SELECT Artikul,Model  from Price WHERE Artikul<>TRIM(Model)) as f 
	LEFT JOIN (SELECT Artikul,Model  from Price WHERE Artikul LIKE '%_z%') as s
		ON f.Artikul=s.Artikul WHERE s.Artikul ISNULL;
	
SELECT 	Artikul, Tov_Name ,ost, o.KodTov FROM Price p LEFT JOIN M_RezOst o on p.KodTov=o.KodTov;

SELECT artikul,idx_Artikul,LOWER(artikul),LOWER(idx_Artikul) from Price WHERE LOWER(Artikul)<>LOWER(idx_Artikul);

SELECT artikul,
CASE WHEN c.NoSkidka=1 THEN c.Cena ELSE (c.Cena*(100-(SELECT Proc_Skid from Clients limit 1))/100 ) END as price, 
CASE WHEN ost=1 THEN 100 ELSE 0 END as balance
	FROM ClPrice c	
	JOIN Price p 
		ON c.KodTov=p.KodTov;
	where 	p.KodTov=80113;

SELECT COUNT(*) from Price ;
SELECT COUNT(*) from ClPrice ;

SELECT artikul,p.KodTov
	FROM Price p 	
	LEFT JOIN  ClPrice c
		ON c.KodTov=p.KodTov
	WHERE c.KodTov ISNULL;
DELETE from lost; 

SELECT p.artikul as model,
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

select "" ,1;
		
