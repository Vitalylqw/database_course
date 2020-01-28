-- �������� ����������� ������� ����� ��� ���� ������ ���� ������ vk (��������� �������).

-- ��������� ��� ���������� ON DELETE , ��������� ��� �������� �������� ������ ���������, 
-- ��� ������� �� ���������������� ����������.�� ����, ����� ����������� ����� ������ �������.
-- �� ����� ��� ��������, �� �������� ������ ����������� ���������
-- � ���� �������� �� ����, ��� ������� �� ����� ������. ��� ����� �������, �� ����������� ��������� , ��� ������������

ALTER TABLE communities 
	ADD CONSTRAINT communities_photo_id_fk
		FOREIGN KEY (photo_id) REFERENCES media(id)
		ON DELETE SET NULL;
	
ALTER TABLE communities_users
	ADD CONSTRAINT communities_users_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT communities_users_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE;
	
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id),
	ADD CONSTRAINT friend_user_id_fk
		FOREIGN KEY (friend_id) REFERENCES users(id),
	ADD CONSTRAINT friendship_status_id_fk
		FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);	

ALTER TABLE likes
	ADD CONSTRAINT likes_user_id_fk 
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT likes_target_type_id_fk 
		FOREIGN KEY (target_type_id) REFERENCES target_types(id);
		
ALTER TABLE media
	ADD CONSTRAINT media_user_id_fk 
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT media_media_type_id_fk 
		FOREIGN KEY (media_type_id) REFERENCES media_types(id);	
	
ALTER TABLE meetings_users
	ADD CONSTRAINT meetings_users_user_id_fk 
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT meetings_users_meeting_id_fk 
		FOREIGN KEY (meeting_id) REFERENCES meetings(id);	
	
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   
-- � ������� posts � ���� media_id ���� ������ ������� �� ��������� ��������� ����������� �������� �����. �������� ��   
UPDATE posts SET media_id=FLOOR(1+RAND()*100) WHERE media_id=0;

   
ALTER TABLE posts
	ADD CONSTRAINT posts_user_id_fk 
		FOREIGN KEY (user_id) REFERENCES users(id)
		ON DELETE CASCADE,
	ADD CONSTRAINT posts_media_id_fk 
		FOREIGN KEY (media_id) REFERENCES media(id);
	
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;	
   
   
		