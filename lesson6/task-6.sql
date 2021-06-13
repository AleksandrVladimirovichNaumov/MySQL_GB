
-- 2) Пусть задан некоторый пользователь. 
--    Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- cheking quantity of messages from id which are friends
select
	count(*) as 'messages_qnty',
	from_user_id 
from 
	messages m
where
-- selected user is 202
	to_user_id = '202'
	and
-- checking that user in message is a friend	
	(
-- user 202 can be initator in friend_request table
	from_user_id in (
					select
						initiator_user_id
						
					from
						friend_requests
					where
						(initiator_user_id = '202'
						and
						status = 'approved')
						or
						(target_user_id = '202'
						and
						status = 'approved')
					)
	or
-- or user 202 can be target in friend_request table
	from_user_id in (
					select
						target_user_id
						
					from
						friend_requests
					where
						(initiator_user_id = '202'
						and
						status = 'approved')
						or
						(target_user_id = '202'
						and
						status = 'approved') 
					)
	)
group by from_user_id
order by messages_qnty desc;



-- 3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.


select
	count(profile_id) as 'likes_qnty'
from
	likes_profile
where profile_id in
	(select user_id	from
		(select user_id from profiles order by birthday desc limit 10)
		subtable
	);


-- 4) Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- dont know why, but this code does not work.

-- select
-- 	(select	count(user_id) from likes_profile where user_id in
-- 		(select user_id	from profiles where gender = 'm')
-- 	) as men_likes
-- 	,
-- 	(select	count(user_id) from likes_profile where user_id in
-- 		( select user_id from profiles where gender = 'f')
-- 	) as women_likes
-- 	,	
-- case 
-- 	when men_likes > women_likes then 'more likes from men'
-- 	when men_likes < women_likes then 'more likes from women'
-- 	when men_likes = women_likes then 'more likes from men'
-- end



-- same code works when 'as men_likes' & "as women_likes" is not in use
select
-- counting all men likes
	(select	count(user_id) from likes_profile where user_id in
		(select user_id	from profiles where gender = 'm')
	) as men_likes
	,
-- counting all women likes
	(select	count(user_id) from likes_profile where user_id in
		( select user_id from profiles where gender = 'f')
	) as women_likes
	,
-- comparison
case 
	when (select	count(user_id) from likes_profile where user_id in
		(select user_id	from profiles where gender = 'm')
	) > (select	count(user_id) from likes_profile where user_id in
		( select user_id from profiles where gender = 'f')
	) then 'more likes from men' 
	when (select	count(user_id) from likes_profile where user_id in
		(select user_id	from profiles where gender = 'm')
	) < (select	count(user_id) from likes_profile where user_id in
		( select user_id from profiles where gender = 'f')
	)  then 'more likes from women'
	when (select	count(user_id) from likes_profile where user_id in
		(select user_id	from profiles where gender = 'm')
	) = (select	count(user_id) from likes_profile where user_id in
		( select user_id from profiles where gender = 'f')
	)  then 'more likes from men'
end


-- 5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

-- criteria of low activity
-- old outcoming messages
-- old likes of profile
-- old uploaded media

-- creating a table with last actions for users
drop table if exists low_activity_users;
create table low_activity_users(
	id bigint,
	last_action_date datetime
);
-- inserting 10 last messsages (max()) for users which dates are the oldest in a table
insert into low_activity_users
(select from_user_id, max(created_at) from messages group by from_user_id order by created_at limit 10);
-- inserting 10 last profile likes for users which dates are the oldest in a table
insert into low_activity_users
(select user_id, max(created_at) from likes_profile group by user_id order by created_at  limit 10);
-- inserting 10 last loaded for users which dates are the oldest in a table
insert into low_activity_users
(select user_id, max(updated_at) from media group by user_id order by updated_at  limit 10);

-- showing only unique id from low_activity_users with last action date
select id, max(last_action_date) from low_activity_users group by id order by last_action_date limit 10;







	