-- �� ������� catalogs ����������� ������ ��� ������ �������. SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- ������������ ������ � �������, �������� � ������ IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by case when id=5 then 0 when id=1 then 1 when id=2 then 2 end;