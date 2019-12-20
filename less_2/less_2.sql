DROP database IF EXISTS example;

create database if not exists example;

use example;

drop TABLE if exists users;

create TABLE if not EXISTS users (
id serial primary key,
name varchar(255) comment 'Наименование пользователя'
) comment='Пользователи';


