-- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
--    Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

start transaction;
insert into sample.users(id, name) select id, name from shop.users where id = '1';
commit;

-- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products и
--    соответствующее название каталога name из таблицы catalogs

create or replace view name_and_category as
select p.name as item , c.name as category
from products p
join catalogs c on p.catalog_id = c.id;

select * from name_and_category;

-- 3) по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные
--    записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который
--    выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном
--    таблице и 0, если она отсутствует
drop table if exists dates;
create table dates(dates date primary key);

insert into dates values
('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-17');



drop procedure if exists empty_dates;
DELIMITER //
create procedure empty_dates()
begin
	
	DECLARE i INT DEFAULT 0;
	declare temp_date date;
	drop table if exists dates_check;
	create temporary table dates_check(dates date primary key,  status int);
	while i < 31 do
 		select dates into temp_date from dates where day(dates) = i+1;
	 	if (select date_add('2018-08-01', interval i day) = temp_date) 
	 		then insert into dates_check values (date_add('2018-08-01', interval i day), '1');
	 		else insert into dates_check values (date_add('2018-08-01', interval i day), '0');
	 	end if;
		set i = i + 1;

	end while;
	select * from dates_check;
end//

call empty_dates//

-- 4) (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет
--    устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

drop table if exists dates_task4;
create table dates_task4(dates date primary key);

insert into dates_task4 values
('2018-08-01'),
('2018-08-04'),
('2018-08-16'),
('2018-08-05'),
('2018-08-21'),
('2018-08-19'),
('2018-08-03'),
('2018-08-07'),
('2018-08-13'),
('2018-08-30');

drop procedure if exists max_5;
DELIMITER //
create procedure max_5()
begin
	
	drop table if exists temp_max5;
	create temporary table temp_max5(dates date primary key);
	insert into temp_max5 select dates from dates_task4 order by dates desc limit 5;
	delete from dates_task4 where dates_task4.dates not in (select dates from temp_max5);
	select * from dates_task4;
end//

call max_5//


