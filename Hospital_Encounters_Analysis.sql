set SQL_MODE = '';

alter table hospital_db.encounters add column Start_DateTime datetime;
alter table hospital_db.encounters add column Stop_DateTime datetime;

update encounters 
set Start_DateTime = str_to_date(replace(replace(start, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s'),
    Stop_DateTime = str_to_date(replace(replace(start, 'T', ' '), 'Z', ''), '%Y-%m-%d %H:%i:%s');
    
select
	encounterclass,
    count(*) as total_visits,
    round(sum(TOTAL_CLAIM_COST), 2) as total_cost,
    round(avg(TOTAL_CLAIM_COST), 2) as avg_cost,
    round(avg(timestampdiff(second, Start_DateTime, Stop_DateTime) / 3600), 2) as avg_duration_hours
from encounters
group by encounterclass
order by total_cost desc;    
