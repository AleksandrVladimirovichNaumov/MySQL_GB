-- 1. DB creation


-- creating database
DROP DATABASE IF EXISTS MathEXP;
CREATE DATABASE MathEXP;
USE MathEXP;


-- creating table with users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50), 
    lastname VARCHAR(50),
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100),
 	user_type char(1), -- 'N' normal type of user, 'P' remium type of user
 	start_date_of_premium DATE, -- Date when preium pass was bought
 	days_of_premium DATE -- days quantity of premium pass
);


-- creating table with experiment status
DROP TABLE IF EXISTS experiment_status;
CREATE TABLE experiment_status(
	id BIGINT UNSIGNED auto_increment NOT NULL unique, 
    status VARCHAR(50)  -- ongoing, onhold, action required, etc.
);


-- creating table with aproximation method
drop table if exists approximation_methods;
create table approximation_methods(
	id bigint UNSIGNED auto_increment NOT NULL unique,
	name VARCHAR(50),
	description varchar(500)
);


-- creating table with experiment itself
drop table if exists experiment;
create table experiment(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARchar(50),
	description text,
	admin_id BIGINT UNSIGNED NOT NULL,
	status_id BIGINT UNSIGNED NOT NULL,
	approximation_id BIGINT UNSIGNED NOT NULL,
	assign_to_id BIGINT UNSIGNED NOT NULL,
	arguments_quantity int unsigned not null, -- up to 10. based on this will selected table for arguments storing

	foreign key (admin_id) references users(id),
	foreign key (status_id) references experiment_status(id),
	foreign key (approximation_id) references approximation_methods(id),
	foreign key (assign_to_id) references users(id)
);


-- creating table with description of argument
drop table if exists parameter_description;
create table parameter_description(
	id bigint UNSIGNED NOT NULL auto_increment unique,
	name varchar(50),
	dimension varchar(50)
);


-- creating table with parameters value
drop table if exists parameter_value;
create table parameter_value(
	id bigint UNSIGNED NOT NULL auto_increment unique,
	parameter_id bigint UNSIGNED NOT NULL,
	experiment_id bigint UNSIGNED NOT NULL,
	value double,
	
	foreign key (parameter_id) references parameter_description(id),
	foreign key (experiment_id) references experiment(id),
	
	INDEX parameter_of_experiment(parameter_id, experiment_id)
);


-- creating table for data storage for 1 argument experiment
drop table if exists experimental_data_1;
create table experimental_data_1(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id)	
);


-- creating table for data storage for 2 argument experiment
drop table if exists experimental_data_2;
create table experimental_data_2(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id)
);


-- creating table for data storage for 3 argument experiment
drop table if exists experimental_data_3;
create table experimental_data_3(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id)	
);


-- creating table for data storage for 4 argument experiment
drop table if exists experimental_data_4;
create table experimental_data_4(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,

	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id)	
);


-- creating table for data storage for 5 argument experiment
drop table if exists experimental_data_5;
create table experimental_data_5(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id)	
);


-- creating table for data storage for 6 argument experiment
drop table if exists experimental_data_6;
create table experimental_data_6(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	parameter_6_id bigint UNSIGNED NOT NULL ,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id)
);


-- creating table for data storage for 7 argument experiment
drop table if exists experimental_data_7;
create table experimental_data_7(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	parameter_6_id bigint UNSIGNED NOT NULL ,
	parameter_7_id bigint UNSIGNED NOT NULL ,
	
	function_value double,

	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id),
	foreign key (parameter_7_id) references parameter_value(id)	
);


-- creating table for data storage for 8 argument experiment
drop table if exists experimental_data_8;
create table experimental_data_8(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	parameter_6_id bigint UNSIGNED NOT NULL ,
	parameter_7_id bigint UNSIGNED NOT NULL ,
	parameter_8_id bigint UNSIGNED NOT NULL ,

	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id),
	foreign key (parameter_7_id) references parameter_value(id),
	foreign key (parameter_8_id) references parameter_value(id)	
);


-- creating table for data storage for 9 argument experiment
drop table if exists experimental_data_9;
create table experimental_data_9(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	parameter_6_id bigint UNSIGNED NOT NULL ,
	parameter_7_id bigint UNSIGNED NOT NULL ,
	parameter_8_id bigint UNSIGNED NOT NULL ,
	parameter_9_id bigint UNSIGNED NOT NULL ,

	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id),
	foreign key (parameter_7_id) references parameter_value(id),
	foreign key (parameter_8_id) references parameter_value(id),
	foreign key (parameter_9_id) references parameter_value(id)	
);


-- creating table for data storage for 10 argument experiment
drop table if exists experimental_data_10;
create table experimental_data_10(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL ,
	created_at datetime,
	parameter_1_id bigint UNSIGNED NOT NULL ,
	parameter_2_id bigint UNSIGNED NOT NULL ,
	parameter_3_id bigint UNSIGNED NOT NULL ,
	parameter_4_id bigint UNSIGNED NOT NULL ,
	parameter_5_id bigint UNSIGNED NOT NULL ,
	parameter_6_id bigint UNSIGNED NOT NULL ,
	parameter_7_id bigint UNSIGNED NOT NULL ,
	parameter_8_id bigint UNSIGNED NOT NULL ,
	parameter_9_id bigint UNSIGNED NOT NULL ,
	parameter_10_id bigint UNSIGNED NOT NULL ,

	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id),
	foreign key (parameter_7_id) references parameter_value(id),
	foreign key (parameter_8_id) references parameter_value(id),
	foreign key (parameter_9_id) references parameter_value(id),
	foreign key (parameter_10_id) references parameter_value(id)
);


-- creating table for experiment's graphs & diagrames storage
drop table if exists graphs;
create table graphs(
	id bigint UNSIGNED NOT null AUTO_INCREMENT unique,
	experiment_id bigint UNSIGNED NOT NULL ,
	file blob,
	foreign key (experiment_id) references experiment(id)
);


-- creating table for experiment's equalations storage
drop table if exists equalation;
create table equalation(
	id bigint UNSIGNED NOT null AUTO_INCREMENT unique,
	experiment_id bigint UNSIGNED NOT NULL ,
	description varchar(50),
	file blob,
	foreign key (experiment_id) references experiment(id)
);


-- creating table for experiment's working group
DROP TABLE IF EXISTS experiment_working_group;
CREATE TABLE experiment_working_group (
	user_id bigint UNSIGNED NOT NULL ,
	group_id bigint UNSIGNED NOT NULL ,
	
	PRIMARY KEY (user_id, group_id), 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (group_id) REFERENCES experiment(id)
);


-- creating table for comments in experiment's working group
drop table if exists comments;
create table comments(
	id bigint UNSIGNED NOT NULL auto_increment unique,
	user_id bigint UNSIGNED NOT NULL ,
	comment text,
	created_at datetime default NOW(),
	experiment_id bigint UNSIGNED NOT NULL ,
	foreign key (experiment_id) references experiment(id),
	foreign key (user_id) references experiment_working_group(user_id)
);


-- creating table for pictures in experiment's working group comments
drop table if exists pictures;
create table pictures(
	id bigint UNSIGNED NOT NULL auto_increment unique,
	comment_id bigint UNSIGNED NOT NULL ,
	file blob,
	created_at datetime default NOW(),
	foreign key (comment_id) references comments(id)
);

