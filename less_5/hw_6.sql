--����������� ������� ������� ������������� � ������� users

SELECT floor(avg (TO_DAYS(NOW()) - TO_DAYS(birthday_at))/365.25) '������� �������, ���' FROM users;

