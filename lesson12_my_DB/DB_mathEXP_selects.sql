-- select all experimets were user is admin or experiment is assigned to user (for example user ID=2)

select id as 'experiment id', name as 'experiment name', description as 'experiment description'
from experiment e
where admin_id = 2 or assign_to_id = 2;


-- find all users with 3 and more experiments (where they are admins) and with normal status to offer premium status 

select  firstname , lastname, email 
from users u 
where user_type = 'P' and id in(
	select e.admin_id
	from experiment e
	group by e.admin_id
	having count(e.admin_id)>=3
);

-- select all comments and author's name for experiment ID = 100 starting from new to old
select u.firstname, u.lastname, c.comment, c.created_at
from comments c 
join users u on c.user_id = u.id 
where experiment_id = 100
order by created_at desc ;


-- data to tables were inserted automatically by http://filldb.info.
-- There were no restrictions for experiment id in experimetal tables
-- as a result there are mitsmatches between experiment's arguments quantity and experemental_data table which was used for storage
-- so, this select will show experiments that were incorrectly added to table

select e.id
from experiment e 
where
	(e.id in(
		select ed.experiment_id 
		from experimental_data_1 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 1
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_2 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 2
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_3 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 3
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_4 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 4
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_5 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 5
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_6 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 6
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_7 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 7
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_8 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 8
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_9 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 9
		group by ed.experiment_id))
or 
	(e.id in(
		select ed.experiment_id 
		from experimental_data_10 ed
		join experiment e on e.id = ed.experiment_id 
		where e.arguments_quantity <> 10
		group by ed.experiment_id))
order by e.id; 
