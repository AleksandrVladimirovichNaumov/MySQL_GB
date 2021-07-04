-- create a view with all experimental data for experiment ID=69

create OR REPLACE VIEW experiment_69_data AS
SELECT pv1.value as 'X1' , pv2.value as 'X2' ,pv3.value as 'X3' , pv4.value as 'X4', pv5.value as 'X5', pv6.value as 'X6', pv7.value as 'X7' ,pv8.value as 'X8' , pv9.value as 'X9' , pv10.value as 'X10' , ed.function_value as 'Y' 
FROM experimental_data_10 ed
join parameter_value pv1 on pv1.id = ed.parameter_1_id
join parameter_value pv2 on pv2.id = ed.parameter_1_id
join parameter_value pv3 on pv3.id = ed.parameter_1_id
join parameter_value pv4 on pv4.id = ed.parameter_1_id
join parameter_value pv5 on pv5.id = ed.parameter_1_id
join parameter_value pv6 on pv6.id = ed.parameter_1_id
join parameter_value pv7 on pv7.id = ed.parameter_1_id
join parameter_value pv8 on pv8.id = ed.parameter_1_id
join parameter_value pv9 on pv9.id = ed.parameter_1_id
join parameter_value pv10 on pv10.id = ed.parameter_1_id
WHERE ed.experiment_id = 69;

-- select from view experiment_69_data only rows there function is possitiove (>0)
select *
from experiment_69_data
where Y>0

-- createa view with with a worgroup for experiment ID=50
create OR REPLACE VIEW experiment_50_working_group AS
SELECT u.id as 'id', u.firstname as 'first name', u.lastname as 'second name'
FROM users u
join experiment_working_group ewg ON u.id=ewg.user_id 
WHERE ewg.group_id = 50 ;

-- select list of members from working group to whom experiment can be assigned (all expect meber already assign to)
select *
from experiment_50_working_group
where id <> (select e.assign_to_id from experiment e where e.id = 50);
-- 