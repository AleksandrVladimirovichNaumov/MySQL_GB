-- 1) Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select u.id, u.name, count(u.name) as 'orders quantity'
from users u
join orders o on u.id = o.user_id
group by u.id





-- 2) Выведите список товаров products и разделов catalogs, который соответствует товару.
-- 	  id of selected product is 2

-- w/o joins
select p.name, c.name 
from products p, catalogs c 
where
(p.catalog_id in (
					select catalog_id
					from products p2 
					where p2.id = '2'
				)
and
c.id in (
			select catalog_id
			from products p3
			where p3.id = '2'
		)
)
		
-- with join		
select p.name, c.name 
from products p
join catalogs c on p.catalog_id = c.id
where p.catalog_id in (
						select catalog_id
						from products p2 
						where p2.id = '2'
						)

						
						
						
-- 3) (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
--    Поля from, to и label содержат английские названия городов, поле name — русское.
--    Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  from_ VARCHAR(255),
  to_ VARCHAR(255)
);

INSERT INTO flights (from_, to_) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255) PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');
 
select f.id , c.name , c2.name 
from flights f 
join cities c on f.from_ = c.label
join cities c2 on f.to_ =c2.label
order by 1
						



