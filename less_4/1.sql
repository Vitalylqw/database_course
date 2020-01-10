
SELECT * FROM users LIMIT 10;

select * from profiles limit 10;

create TEMPORARY table sex (name char(1));
insert into sex values ('m'),('f');

select * from sex order by rand() limit 1;


update profiles set sex=(select sex from sex order by rand() limit 1 );

select * from messages ;

select floor (rand()*10+1);

update messages SET
from_user_id=floor(rand()*100+1),
to_user_id= floor(1+rand()*100);

select * from media_types;

truncate media_types;

insert into media_types (name) VALUES
('audio'),
('video'),
('photo');

update media set 
media_type_id=floor(rand()*3+1),
user_id=floor(rand()*100+1);
update media set filename=CONCAT('/user_',user_id,'/',floor(1+rand()*10000));

update media set metadata=concat('{"oner":"',(select concat(first_name,'_',last_name) from users where id=user_id),'"}');

select * from media;

DESCRIBE media;
alter table media modify column metadata JSON;

describe friendship;

update friendship set 
user_id = floor(rand()*100+1),
friend_id=floor(rand()*100+1);

select * from friendship;

truncate friendship_statuses;

insert into friendship_statuses (name) VALUES
('Confirmed'),
('Requested'),
('Canceled');

select * from friendship_statuses;

update friendship set status_id=floor(rand()*3+1);

select * from communities ;

delete from communities where id>20;

select * from communities_users ;

update communities_users set 
community_id=floor(rand()*20+1),
user_id = floor(rand()*100+1);

drop table if exists posts ;

create table if not exists posts  (
id int unsigned not null auto_increment primary key,
user_id int unsigned not null,
header varchar(255),
body text not null,
media_id int unsigned,
created_at datetime default now(),
updated_at datetime default now() on update now()
);

update friendship_statuses set name='Interrupted' where name='Canceled';

alter table profiles add column update_at datetime default now() on update now();


create table if not exists meetings (
id int unsigned not null auto_increment primary key,
name varchar(150) not null unique,
sheduled_at datetime
 );

