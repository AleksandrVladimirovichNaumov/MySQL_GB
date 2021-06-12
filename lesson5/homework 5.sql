-- ������������ ������� �� ���� ����������, ����������, ���������� � �����������

-- 1) ����� � ������� users ���� created_at � updated_at ��������� ��������������. ��������� �� �������� ����� � ��������.

update users set 
	created_at = current_timestamp() ,
	updated_at = current_timestamp() ;

-- if required to complete only empty cells

update users 
set
	created_at = current_timestamp()
where 
	created_at = null
;

update users
set 
	updated_at = current_timestamp()
where 
	updated_at = null 
;




-- 2) ������� users ���� �������� ��������������. ������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� ��������
--    � ������� 20.10.2017 8:10. ���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.

-- just to make columns as varchar
alter table users
modify column created_at Varchar(20),
modify column updated_at Varchar(20)

-- convert to datetime
alter table users
modify column created_at Datetime,
modify column updated_at Datetime




-- 3) � ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����,
--    ���� �� ������ ������� ������. ���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value. 
--    ������ ������� ������ ������ ���������� � �����, ����� ���� �������.

-- create table storehouses_products
drop table if exists storehouses_products;
create table storehouses_products(
	id bigint UNSIGNED NOT NULL,
	value bigint UNSIGNED NOT NULL
);

-- inset lines
INSERT INTO storehouses_products values
(1, 0),
(2, 2500),
(3, 0),
(4, 30),
(5, 500),
(6, 1)
;

-- sortinf with if()
select value from storehouses_products sp 
order by if(value=0, 1,0), value ;




-- 4) (�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
--    ������ ������ � ���� ������ ���������� �������� (may, august)

-- current month format for birthday is numeric. formating month is select. 
select user_id, date_format(birthday, '%d %M %Y')  from profiles p 
where month(birthday) = '5' or month(birthday) = '8'

-- 5) (�� �������) �� ������� catalogs ����������� ������ ��� ������ �������.
--    SELECT * FROM catalogs WHERE id IN (5, 1, 2); ������������ ������ � �������, �������� � ������ IN.

-- in my users table id starts from 200. I updated request based on my table
SELECT * FROM users WHERE id IN (205, 201, 202) ORDER BY find_in_set(`id`,'205,201,202')




-- ������������ ������� ���� ���������� �������

-- 1) ����������� ������� ������� ������������� � ������� users.

-- firstly calculating year based on difference birthday year and current year 
-- after deleting 1 from age if current year's month is less than birthday's month
-- 1 is from <
select
	avg(
  	   	(YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) 
  		)
FROM profiles


-- 2)����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������.
--   ������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.

select 
	weekday(date_format(birthday, '2021-%m-%d')) as 'day_number',
	count(*) as 'birthdays_qnty'
from profiles
group by weekday(date_format(birthday, '2021-%m-%d'))
order by day_number;

-- 3)(�� �������) ����������� ������������ ����� � ������� �������.

drop table if exists task3;
create table task3(
	value bigint
);

INSERT INTO task3 values (1), (2), (3), (4), (5);

-- V lob)
select (select value from task3 where value=1)*(select value from task3  where value=2)*(select value from task3  where value=3)*(select value from task3  where value=4)*(select value from task3  where value=5) as 'Multiplication'

-- from stackowerflow

SELECT exp(SUM(log(value))) from task3



