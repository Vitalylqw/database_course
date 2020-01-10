-- ��� ��������� ���� �������, �� ������� �������� ����. ����� ����, ������������, ���� � ��. � ������ ���������� ����� ������ ��� ������ , ����������� ����� ���
CREATE TABLE IF NOT EXISTS resource_type_like (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(150) NOT NULL UNIQUE
);

INSERT INTO resource_type_like (name) VALUES 
('users'),
('media'),
('posts');

SELECT * FROM resource_type_like;

-- ������� ��� �������� ������, ������� �������� ������������. resource_id - id �������, ������� ������� ������������, � ������� ����� �������
-- status - ������� ������ ������. 1 ����� ����, 0 ��� �����
CREATE TABLE IF NOT EXISTS likes (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
user_id INT UNSIGNED NOT NULL,
resource_type_like_id INT UNSIGNED NOT NULL,
resource_id INT UNSIGNED NOT NULL,
status bool not null DEFAULT 1,
created_at datetime default now(),
updated_at datetime default now() on update now()
);

-- ������� ��� �������� ������� ������ /������ ������ ������������ �� ��������. type_like - 1 - ���������� ����, 0 - ������� ����

CREATE TABLE IF NOT EXISTS history_likes (
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
likes_id INT UNSIGNED NOT NULL,
type_like bool not null DEFAULT 1,
created_at datetime default now()
);



