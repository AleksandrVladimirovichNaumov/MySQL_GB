-- 1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается
--    время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
drop table if exists logs;
CREATE TABLE IF NOT EXISTS logs (
   date_time datetime NOT NULL,
   table_name text NOT NULL,
   primary_key int NOT null,
   name text NOT NULL
 ) ENGINE=ARCHIVE DEFAULT CHARSET=utf8;

-- for users logs
drop trigger if exists logs_on_users;
DELIMITER //
CREATE TRIGGER logs_on_users
AFTER INSERT ON users
FOR EACH ROW BEGIN
    INSERT INTO logs
    VALUES (now(), 'users', new.id, new.name);
end//

DELIMITER ;

INSERT INTO `users` (`name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('Sylvia', '1992-02-28', '2021-06-20 12:47:35','2021-06-20 12:47:35');


-- for catalogs logs
drop trigger if exists logs_on_catalogs;
DELIMITER //
CREATE TRIGGER logs_on_catalogs
AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
    INSERT INTO logs
    VALUES (now(), 'catalogs', new.id, new.name);
end//

DELIMITER ;

INSERT INTO `catalogs` ( `name`) VALUES ('мониторы');

-- for products logs
drop trigger if exists logs_on_products;
DELIMITER //
CREATE TRIGGER logs_on_products
AFTER INSERT ON products
FOR EACH ROW BEGIN
    INSERT INTO logs
    VALUES (now(), 'products', new.id, new.name);
end//

DELIMITER ;

INSERT INTO `products` (`name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('LG', 'top of the top', '1', '1', '2021-06-20 12:47:35','2021-06-20 12:47:35');

-- 2) (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
drop procedure if exists million_users;
DELIMITER //
CREATE PROCEDURE million_users()
BEGIN
    DECLARE i int DEFAULT 0;
    WHILE i <= 1000000 DO
        INSERT INTO `users` (`name`, `birthday_at`, `created_at`, `updated_at`) VALUES (CONCAT('bot', i), DATE_ADD('1000-01-01', INTERVAL i DAY), now(),now());
        SET i = i + 1;
    END WHILE;
end//
DELIMITER ;

-- better not to start
call million_users(); 


-- 3) В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
-- copy lines from redis client comand line

-- create hash ip_visit ther keys will be ip addresses and value will be quantity of visits
127.0.0.1:6379> HMSET ip_visit 192.168.0.1 1 172.0.0.12 3 127.0.0.1 4
OK
-- show of values from ip_visit
127.0.0.1:6379> HVALS ip_visit
1) "1"
2) "3"
3) "4"
-- show value of key 192.168.0.1
127.0.0.1:6379> HGET ip_visit 192.168.0.1
"1"
-- show all keys
127.0.0.1:6379> HKEYS ip_visit
1) "192.168.0.1"
2) "172.0.0.12"
3) "127.0.0.1"

-- 4) При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот,
--    поиск электронного адреса пользователя по его имени.
-- copy lines from redis client comand line

-- create hash for user->email storage
127.0.0.1:6379> HMSET user-email dog dog@gmail.com cat cat@gmail.com
OK
-- create hash for email->user storage
127.0.0.1:6379> HMSET email-user dog@gmail.com dog cat@gmail.com cat
OK
-- get email by user name
127.0.0.1:6379> HGET user-email dog
"dog@gmail.com"
-- get user by email
127.0.0.1:6379> HGET email-user cat@gmail.com
"cat"

-- 5) Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

db.shop.insert(
				{'категории':
					{'материнские платы':[
						{name:'ASUS ROG MAXIMUS X HERO',
						 description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
						 price: 17852},
						{name:'Gigabyte H310M S2H',
						 description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
						 price: 14852}],
				 	 'процессоры':[
				 		{name:'Intel Core i3-8100',
				 		 description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
				 		 price: 27852},
				 		{name:'Intel Core i5-7400',
				 		 description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
				 		 price: 32852}]
				 	}
				}
			   )
