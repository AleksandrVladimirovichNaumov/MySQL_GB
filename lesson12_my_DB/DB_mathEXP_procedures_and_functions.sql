-- procedure to select eperemental data based on experiment id.
-- based on experiment arguments quantity should be selected correct experemental_data table
 
drop procedure if exists experiment_data;
DELIMITER //
create procedure experiment_data(in exp_id INT)
begin
	
	DECLARE arg_qnty INT;
	select e.arguments_quantity into arg_qnty from experiment e where e.id = exp_id;
	drop table if exists temp_expreimetal_data;
	CASE arg_qnty 
        WHEN 1 THEN     	
        	create temporary table temp_expreimetal_data as  select * from experimental_data_1 ed where ed.experiment_id = exp_id; 
        WHEN 2 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_3 ed where ed.experiment_id = exp_id; 
        WHEN 3 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_3 ed where ed.experiment_id = exp_id;
		WHEN 4 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_4 ed where ed.experiment_id = exp_id;
		WHEN 5 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_5 ed where ed.experiment_id = exp_id;
        WHEN 6 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_6 ed where ed.experiment_id = exp_id; 
        WHEN 7 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_7 ed where ed.experiment_id = exp_id; 
        WHEN 8 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_8 ed where ed.experiment_id = exp_id;
		WHEN 9 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_9 ed where ed.experiment_id = exp_id;
		WHEN 10 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_10 ed where ed.experiment_id = exp_id;
	END CASE;
	select * from temp_expreimetal_data;
end//
DELIMITER ;

call experiment_data(8);



-- procedure to select required quantity of max/min values of function with all argumets.
drop procedure if exists max_min_values;
DELIMITER //
create procedure max_min_values(exp_id INT, values_qnty INT, max_min text)
begin
	DECLARE arg_qnty INT;
	select e.arguments_quantity into arg_qnty from experiment e where e.id = exp_id;
	drop table if exists temp_expreimetal_data;
	CASE arg_qnty 
        WHEN 1 THEN     	
        	create temporary table temp_expreimetal_data as  select * from experimental_data_1 ed where ed.experiment_id = exp_id; 
        WHEN 2 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_3 ed where ed.experiment_id = exp_id; 
        WHEN 3 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_3 ed where ed.experiment_id = exp_id;
		WHEN 4 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_4 ed where ed.experiment_id = exp_id;
		WHEN 5 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_5 ed where ed.experiment_id = exp_id;
        WHEN 6 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_6 ed where ed.experiment_id = exp_id; 
        WHEN 7 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_7 ed where ed.experiment_id = exp_id; 
        WHEN 8 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_8 ed where ed.experiment_id = exp_id;
		WHEN 9 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_9 ed where ed.experiment_id = exp_id;
		WHEN 10 THEN 
            create temporary table temp_expreimetal_data as select * from experimental_data_10 ed where ed.experiment_id = exp_id;
	END CASE;

 	IF max_min = 'max' THEN 
        SELECT * from temp_expreimetal_data order by function_value desc limit values_qnty; 
    ELSEif max_min = 'min' THEN
        SELECT * from temp_expreimetal_data order by function_value  limit values_qnty;
    else 
    	select 'Incorrect argument value: should be "max" or "min".';
    END IF;
	
end//
DELIMITER ;

call max_min_values('10','3','max');
call max_min_values('50','2','min');
call max_min_values('5','8','mix');



