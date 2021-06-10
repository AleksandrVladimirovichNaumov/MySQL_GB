DROP DATABASE IF EXISTS MathEXP;
CREATE DATABASE MathEXP;
USE MathEXP;



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


DROP TABLE IF EXISTS experiment_status;
CREATE TABLE experiment_status(
	id BIGINT UNSIGNED NOT NULL unique, 
    status VARCHAR(50)
);
drop table if exists approximation_methods;
create table approximation_methods(
	id bigint UNSIGNED NOT NULL unique,
	description varchar(50)
	
);


drop table if exists experiment;
create table experiment(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_name VARchar(50),
	admin_id BIGINT UNSIGNED NOT NULL,
	status_id BIGINT UNSIGNED NOT NULL,
	approximation_id BIGINT UNSIGNED NOT NULL,

	foreign key (admin_id) references users(id),
	foreign key (status_id) references experiment_status(id),
	foreign key (approximation_id) references approximation_methods(id)
);


drop table if exists parameter_description;
create table parameter_description(
	id bigint UNSIGNED NOT NULL unique,
	name varchar(50),
	dimension varchar(50)
);

drop table if exists parameter_value;
create table parameter_value(
	id bigint UNSIGNED NOT NULL unique,
	parameter_id bigint UNSIGNED NOT NULL unique,
	experiment_id bigint UNSIGNED NOT NULL unique,
	value double,
	
	foreign key (parameter_id) references parameter_description(id),
	foreign key (experiment_id) references experiment(id),
	
	INDEX parameter_of_experiment(parameter_id, experiment_id)
);



drop table if exists experimental_data;
create table experimental_data(
	id bigint UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	experiment_id bigint UNSIGNED NOT NULL unique,
	parameter_1_id bigint UNSIGNED NOT NULL unique,
	parameter_2_id bigint UNSIGNED NOT NULL unique,
	parameter_3_id bigint UNSIGNED NOT NULL unique,
	parameter_4_id bigint UNSIGNED NOT NULL unique,
	parameter_5_id bigint UNSIGNED NOT NULL unique,
	parameter_6_id bigint UNSIGNED NOT NULL unique,
	
	function_value double,
	
	foreign key (experiment_id) references experiment(id),
	foreign key (parameter_1_id) references parameter_value(id),
	foreign key (parameter_2_id) references parameter_value(id),
	foreign key (parameter_3_id) references parameter_value(id),
	foreign key (parameter_4_id) references parameter_value(id),
	foreign key (parameter_5_id) references parameter_value(id),
	foreign key (parameter_6_id) references parameter_value(id)
	
);

drop table if exists graphs;
create table graphs(
	id bigint UNSIGNED NOT NULL unique,
	experiment_id bigint UNSIGNED NOT NULL unique,
	file blob,
	foreign key (experiment_id) references experiment(id)
);





drop table if exists equalation;
create table equalation(
	id bigint UNSIGNED NOT NULL unique,
	experiment_id bigint UNSIGNED NOT NULL unique,
	description varchar(50),
	file blob,
	foreign key (experiment_id) references experiment(id)
);


DROP TABLE IF EXISTS experiment_working_group;
CREATE TABLE experiment_working_group (
	user_id bigint UNSIGNED NOT NULL unique,
	group_id bigint UNSIGNED NOT NULL unique,
	
	PRIMARY KEY (user_id, group_id), 
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (group_id) REFERENCES experiment(id)
);

drop table if exists comments;
create table comments(
	user_id bigint UNSIGNED NOT NULL unique,
	comment text,
	created_at datetime default NOW(),
	experiment_id bigint UNSIGNED NOT NULL unique,
	foreign key (experiment_id) references experiment(id),
	foreign key (user_id) references experiment_working_group(user_id)
);