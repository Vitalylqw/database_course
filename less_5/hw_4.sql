--�� ������� users ���������� ������� �������������, ���������� � ������� � ���.
--������ ������ � ���� ������ ���������� �������� ('may', 'august')

SELECT 
name ���,
CASE 
WHEN  month(birthday_at)=5 THEN 'may'
WHEN  month(birthday_at) = 8 THEN 'august'
END AS  '����� ��������'
FROM users where  month(birthday_at)=5 or month(birthday_at) = 8;


