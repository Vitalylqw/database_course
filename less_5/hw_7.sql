-- ����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������. 
-- ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.


select DAYNAME(DATE_FORMAT(birthday_at,CONCAT(YEAR(now()),'-%m-%d %T'))) as Day_of_week,count(*) FROM users GROUP by Day_of_week; 
