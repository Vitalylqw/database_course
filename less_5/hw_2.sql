-- ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR 
-- � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10". ���������� ������������� ���� � ���� DATETIME, 
-- �������� �������� ����� ��������.

UPDATE users set created_at = STR_TO_DATE(created_at,'%d.%m.%Y %H:%i');
alter TABLE users MODIFY COLUMN created_at datetime;

UPDATE users set updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %H:%i');
alter TABLE users MODIFY COLUMN created_at datetime;



