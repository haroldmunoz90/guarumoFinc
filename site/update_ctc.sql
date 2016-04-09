
Person no estan en devices.
SELECT *
FROM ilg_person as p
WHERE p.id not in  (select person_id from ilg_device_person)
	   
	   
--person empleados no estan en area	   
SELECT count(*) FROM ilg_person WHERE id not in (select person_id from ilg_area_person)
INSERT INTO ilg_area_person(area_id, person_id) VALUES ((FLOOR( 1 + RAND( ) *14 )) ,1668);
SELECT count(*) FROM ilg_person WHERE id not in (select person_id from ilg_device_person)
INSERT INTO ilg_device_person(device_id, person_id) VALUES (9 ,1668);
//timezone
SELECT Date(TIME),Date(CONVERT_TZ(NOW(),'-00:00','-05:00')), area_name, num_persons, total, late, on_time, early
		FROM  ilg_arrivals_date_summary where Date(TIME) = Date(CONVERT_TZ(NOW(),'-00:00','-05:00'))

INSERT INTO ilg_area_person(area_id, person_id) VALUES ((FLOOR( 1 + RAND( ) *14 )) ,2197);
INSERT INTO ilg_area_person(area_id, person_id) VALUES ((FLOOR( 1 + RAND( ) *14 )) ,2198);
INSERT INTO ilg_area_person(area_id, person_id) VALUES ((FLOOR( 1 + RAND( ) *14 )) ,2199);
INSERT INTO ilg_area_person(area_id, person_id) VALUES (40,2200);
		
		
INSERT INTO ilg_person (id,identification,name,last_name,address,enterprise_id,telephone,creation_date,
status_id,genre,device_user_id) VALUES (NULL,'8765','paas2','conlastname2','minmobre','',4,'8765'),(NULL,'9876','','las name otro','otro nombre','',4,'9876')
  ON DUPLICATE KEY UPDATE name=VALUES(name), last_name=VALUES(last_name) 

  
SELECT * FROM ilg_person WHERE id not in (select person_id from ilg_attendance)

duplicados
SELECT * FROM ilg_person p1 inner join ilg_person p2 WHERE 
p1.id > p2.id and p1.identification = p2.identification 
order by p1.identification

SELECT * FROM ilg_person p1 inner join ilg_person p2 WHERE 
p1.id > p2.id and p1.identification = p2.identification 
and p1.id not in (select person_id from ilg_attendance) 
and p2.id not in (select person_id from ilg_attendance)
order by p1.identification

seleccionar por max date
SELECT MAXTIME , DATE( a.MAXTIME ) ,p1.status_id
FROM  ilg_person p1
INNER JOIN (
SELECT person_id, MAX( TIME ) AS MAXTIME
FROM ilg_attendance
GROUP BY person_id
) AS a
INNER JOIN ilg_device_person dp
WHERE a.person_id = p1.id
AND DATE( a.MAXTIME ) <  '2013-10-01'
AND p1.enterprise_id =2
AND dp.person_id = p1.id
AND dp.device_id =9


UPDATE ilg_person as p1 
INNER JOIN (
SELECT person_id, MAX( TIME ) AS MAXTIME
FROM ilg_attendance
GROUP BY person_id
) AS a
INNER JOIN ilg_device_person dp
SET p1.status_id = 2
WHERE a.person_id = p1.id
AND DATE( a.MAXTIME ) <  '2013-10-01'
AND p1.enterprise_id =2
AND dp.person_id = p1.id
AND dp.device_id =9


SELECT ar.id AS id, ar.name AS name, (
SELECT COUNT( * ) 
FROM ilg_area_person
WHERE area_id = ar.id
) AS nEmployees, COUNT( * ) AS attendees
FROM ilg_attendance at, ilg_area_person ap, ilg_area ar
WHERE at.person_id = ap.person_id
AND ar.id = ap.area_id
AND DATE( at.time ) = DATE( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ) 
GROUP BY ar.id


SET lc_time_names = 'es_CO';
SELECT MONTHNAME(time) as month_name , count(*) as Total, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde 
FROM ilg_attendance at
WHERE enterprise_id = 2
GROUP BY DATE_FORMAT(time,'%Y-%m') ORDER BY time DESC

SET lc_time_names = 'es_CO';
SELECT person_id, MONTHNAME(time) as month_name , count(*) as Total, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde 
FROM ilg_attendance at
WHERE enterprise_id = 2
GROUP BY person_id,
DATE_FORMAT(time,'%Y-%m') ORDER BY time DESC

SELECT DATE_FORMAT(at.time,'%Y-%m') as Fecha, count(*) as Total, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde 
FROM ilg_attendance at, ilg_device dev
WHERE dev.id = at.device_id
AND dev.enterprise_id = 2
GROUP BY DATE_FORMAT(at.time,'%Y-%m')


SELECT DATE(at.time) as Fecha, ar.id as areaId, count(*) as Total, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde 
FROM ilg_attendance at, ilg_area_person ap, ilg_area ar
WHERE at.person_id = ap.person_id
AND ar.id = ap.area_id
AND ar.enterprise_id = 2
AND DATE( at.time ) = DATE( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ) 
GROUP BY ar.id

SELECT ar.id as areaId, CONCAT( IFNULL(pe.name,''),  " ", IFNULL(pe.last_name,'') ) as name , at.time as date, 
case 
        when  at.attendance_type_id = 0 and at.attendance_status_id = 0 then "Entrada a Tiempo"
        when  at.attendance_type_id = 1 and at.attendance_status_id = 0 then "Entrada Temprano"
		when  at.attendance_type_id = 2 and at.attendance_status_id = 0 then "Entrada Tarde"
		when  at.attendance_type_id = 0 and at.attendance_status_id = 1 then "Salida a Tiempo"
		when  at.attendance_type_id = 1 and at.attendance_status_id = 1 then "Salida a Temprano"
		when  at.attendance_type_id = 2 and at.attendance_status_id = 1 then "Salida Tarde"
		else ""
    end as type
FROM ilg_attendance at, ilg_area_person ap, ilg_area ar, ilg_person pe
WHERE at.person_id = ap.person_id
AND ar.id = ap.area_id
AND at.person_id = pe.id
AND ar.enterprise_id = 2
AND DATE( at.time ) = DATE( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ) 


SELECT pe.id id, ap.area_id as areaId, CONCAT( IFNULL(pe.name,''),  " ", IFNULL(pe.last_name,'') ) as name, "true" as notify
FROM   ilg_person pe, ilg_area_person ap, ilg_notification noEXIST 
WHERE pe.id = ap.person_id
AND no.rule_person_id = pe.id
AND pe.enterprise_id = 2

SELECT pe.id id, ap.area_id as areaId, CONCAT( IFNULL(pe.name,''),  " ", IFNULL(pe.last_name,'') ) as name, "true" as notify
FROM   ilg_person pe, ilg_area_person ap
WHERE pe.id = ap.person_id
AND pe.enterprise_id = 2
AND pe.id in (
select rule_person_id from ilg_notification 
)
union
SELECT pe.id id, ap.area_id as areaId, CONCAT( IFNULL(pe.name,''),  " ", IFNULL(pe.last_name,'') ) as name, "false" as notify
FROM   ilg_person pe, ilg_area_person ap
WHERE pe.id = ap.person_id
AND pe.enterprise_id = 2
AND pe.id not in (
select rule_person_id from ilg_notification 
)


SELECT DATE(time) as time, count(*) as Total,
 count( case when attendance_type_id = 2 then attendance_type_id end ) as Tarde,
 count(case when attendance_type_id = 0 then attendance_type_id end) as ATiempo,
 count(case when attendance_type_id = 1 then attendance_type_id end) as Temprano 
FROM ilg_attendance 
WHERE attendance_status_id = 0 and CONCAT(YEAR(time),(MONTH(time))) = CONCAT(YEAR(now()),(MONTH(now()))) 
GROUP BY DATE(time)

select concat( '2008-12-31', ' ' , start_time, ':00') + INTERVAL 30 MINUTE from ilg_calendar_time where name = 'Turno Mañana'

select hr.start_time,  ct.start_time, at.attendance_type_id
from ilg_hour_report hr, ilg_calendar_time ct, ilg_attendance at
where hr.shiftName = ct.name
and at.time = hr.start_time
and hr.start_time > (concat( DATE(hr.start_time), ' ' , ct.start_time, ':00')  + INTERVAL 5 MINUTE)

select hr.start_time,  ct.start_time, at.attendance_type_id
from ilg_hour_report hr
inner join ilg_person pe on pe.id = hr.personId
inner join ilg_calendar_time ct on hr.shiftName = ct.name

SELECT emp.id, emp.name, DATE(hr.start_time)
  FROM ilg_person AS emp
LEFT OUTER
  JOIN ilg_hour_report AS hr
    ON hr.person_id  = emp.id
   AND DATE(hr.start_time) IN ( '2014-01-26', '2014-01-27')
 WHERE hr.person_id  IS NULL;
 groupby DATE(hr.start_time), hr.person_id


update ilg_attendance at, ilg_hour_report hr, ilg_calendar_time ct
set at.attendance_type_id = 2
where hr.shiftName = ct.name
and at.time = hr.start_time
and hr.start_time > (concat( DATE(hr.start_time), ' ' , ct.start_time, ':00')  + INTERVAL 5 MINUTE)


update ilg_attendance at, ilg_hour_report hr, ilg_calendar_time ct
set at.attendance_type_id = 1
where hr.shiftName = ct.name
and at.time = hr.start_time
and hr.start_time < (concat( DATE(hr.start_time), ' ' , ct.start_time, ':00')  + INTERVAL 5 MINUTE)


SELECT * 
FROM  ilg_notification n
WHERE  n.rule_name =  'FIRST'
AND  n.status_id =1
AND CONVERT_TZ(NOW(),'-00:00','-05:00')
BETWEEN  n.start_date 
AND  n.end_date   
AND  n.period_id = 1
AND  n.enterprise_id = 2

SELECT * 
FROM  ilg_attendance 
WHERE  DATE(time) =  DATE(CONVERT_TZ(NOW(),'-00:00','-05:00'))



CREATE TRIGGER 111 BEFORE INSERT ON  ilg_area 
FOR EACH
ROW INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
VALUES (
NOW( ) ,  'ilg_area', NEW.enterprise_id
) ON DUPLICATE 
KEY UPDATE modified_date = VALUES (
modified_date
);


CREATE TRIGGER update_modified_after_insert AFTER INSERT ON  ilg_area 
FOR EACH
	ROW INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_area', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);

CREATE TRIGGER update_modified_after_update AFTER INSERT ON  ilg_area 
FOR EACH
	ROW INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_area', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);
	

CREATE TRIGGER update_modified_after_delete AFTER DELETE ON  ilg_area 
FOR EACH ROW 
	INSERT INTO  ilg_table_modified (  modified_date , table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_area', OLD.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);
END;	

CREATE TRIGGER up_modified_aft_ins_person AFTER INSERT ON  ilg_person 
FOR EACH
	ROW INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_person', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);

CREATE TRIGGER up_modified_aft_up_person AFTER UPDATE ON  ilg_person 
FOR EACH
	ROW INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_person', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);
	

CREATE TRIGGER up_modified_aft_del_person AFTER DELETE ON  ilg_person 
FOR EACH ROW 
	INSERT INTO  ilg_table_modified (  modified_date , table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_person', OLD.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);

CREATE TABLE IF NOT EXISTS ilg_personal_inside (
  time_updated datetime DEFAULT NULL,
  area_id bigint(20) DEFAULT NULL,
  area_name varchar(100) DEFAULT NULL,
  enterprise_id bigint(20) NOT NULL,
  num_persons int(11) DEFAULT NULL,
  KEY area_id (area_id),
  KEY enterprise_id (enterprise_id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


	
		

DROP TRIGGER IF EXISTS consolidate_arrivals_date//
CREATE TRIGGER consolidate_arrivals_date AFTER INSERT ON ilg_attendance
BEGIN
	DECLARE nAddPerson INT DEFAULT 1; 
	declare areaId bigint(20);
	declare areaName varchar(200);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 

	INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_attendance', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);
	
	select c.id, c.name into areaId, areaName from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id limit 1;

	if NEW.attendance_status_id = 0 then  
		
		SET n_total_in = 1;
		if NEW.attendance_type_id = 0 then  
			
			SET n_in_on_time = 1;
		elseif NEW.attendance_type_id = 1 then  
			
			SET n_in_early = 1;
		elseif NEW.attendance_type_id = 2 then 
			
			SET n_in_late = 1;
		end if;			
	else		
		
		SET n_total_out = 1;
		SET nAddPerson = -1;
		if NEW.attendance_type_id = 0 then 
			
			SET n_out_on_time = 1;
		elseif NEW.attendance_type_id = 1 then 
			
			SET n_out_early = 1;
		elseif NEW.attendance_type_id = 2 then
			
			SET n_out_late = 1;
		end if;			
	end if;	
	
 	
	
	INSERT INTO  `ilg_interval_attendance` (
		  `interval_started`,
		  `area_id` 		,	
		  `area_name` 		,	
		  `enterprise_id` 	,	
		  `total`			,		
		  `total_in` 		,		
		  `total_out` 		,		
		  `out_late` 		,		
		  `out_on_time` 	,		
		  `out_early` 		,		
		  `in_late` 		,		
		  `in_on_time` 		,		
		  `in_early` 
		)
		VALUES (
			DATE_FORMAT(NEW.time, "%Y-%m-%d %H:00:00"),  areaId,  areaName,  
			NEW.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`
		) ON DUPLICATE KEY UPDATE 
			total=total+1 ,
			`total_in` =total_in+n_total_in,				
			`total_out`=total_out+n_total_out,			
			`out_late`=out_late+n_out_late,		
			`out_on_time`=out_on_time+n_out_on_time,	
			`out_early`=out_early+n_out_early,	
			`in_late`=in_late+n_in_late,
			`in_on_time`=in_on_time+n_in_on_time,	
			`in_early`=in_early+n_in_early	
			;    
	
	INSERT INTO  `ilg_personal_inside` (
		`time_updated` ,
		`area_id` ,
		`area_name` ,
		`enterprise_id` ,
		`num_persons`
		)
		VALUES (
			CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ),  areaId,  areaName,  NEW.enterprise_id,  1
		)ON DUPLICATE KEY UPDATE 
			num_persons=num_persons+nAddPerson;    
	
  END
  

DROP TRIGGER IF EXISTS att_modified_after_update//
CREATE TRIGGER att_modified_after_update AFTER UPDATE ON ilg_attendance
BEGIN
	declare areaId bigint(20);
	declare areaName varchar(200);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	
	INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_attendance', NEW.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);	
	
	select c.id, c.name into areaId, areaName from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id  limit 1;

	IF NEW.attendance_status_id <> OLD.attendance_status_id OR
		NEW.attendance_type_id <> OLD.attendance_type_id
		THEN  	
		if OLD.attendance_status_id = 0 then  
			
			SET n_total_in = -1;
			if OLD.attendance_type_id = 0 then  			
				SET n_in_on_time = -1;
				
			ELSEIF OLD.attendance_type_id = 1 then 			
				SET n_in_early = -1;
				
			ELSEIF OLD.attendance_type_id = 2 then 
				
				SET n_in_late = -1;
			end if;			
		else			
			SET n_total_out = -1;
			if OLD.attendance_type_id = 0 then 
				
				SET n_out_on_time = -1;
			ELSEIF OLD.attendance_type_id = 1 then 
				
				SET n_out_early = -1;
			ELSEIF OLD.attendance_type_id = 2 then
				
				SET n_out_late = -1;
			end if;			
		end if;	
	end if;

	if NEW.attendance_status_id = 0 then  
		
		SET n_total_in = 1;
		if NEW.attendance_type_id = 0 then  			
			SET n_in_on_time = 1;
			
		ELSEIF NEW.attendance_type_id = 1 then 			
			SET n_in_early = 1;
			
		ELSEIF NEW.attendance_type_id = 2 then 
			
			SET n_in_late = 1;
		end if;			
	else		
		
		SET n_total_out = 1;
		if NEW.attendance_type_id = 0 then 
			
			SET n_out_on_time = 1;
		ELSEIF NEW.attendance_type_id = 1 then 
			
			SET n_out_early = 1;
		ELSEIF NEW.attendance_type_id = 2 then
			
			SET n_out_late = 1;
		end if;			
	end if;		
 	
	
	INSERT INTO  `ilg_interval_attendance` (
		  `interval_started`,
		  `area_id` 		,	
		  `area_name` 		,	
		  `enterprise_id` 	,	
		  `total`			,		
		  `total_in` 		,		
		  `total_out` 		,		
		  `out_late` 		,		
		  `out_on_time` 	,		
		  `out_early` 		,		
		  `in_late` 		,		
		  `in_on_time` 		,		
		  `in_early` 
		)
		VALUES (
			DATE_FORMAT(NEW.time, "%Y-%m-%d %H:00:00"),  areaId,  areaName,  
			NEW.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`
		) ON DUPLICATE KEY UPDATE 
			`total_in` =total_in+n_total_in,				
			`total_out`=total_out+n_total_out,			
			`out_late`=out_late+n_out_late,		
			`out_on_time`=out_on_time+n_out_on_time,	
			`out_early`=out_early+n_out_early,	
			`in_late`=in_late+n_in_late,
			`in_on_time`=in_on_time+n_in_on_time,	
			`in_early`=in_early+n_in_early	
			;    
	
	
END
  

DROP TRIGGER IF EXISTS att_modified_after_delete//
CREATE TRIGGER att_modified_after_delete AFTER DELETE ON ilg_attendance
BEGIN
	declare areaId bigint(20);
	declare areaName varchar(200);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	
	INSERT INTO  ilg_table_modified (  modified_date ,  table_name ,  enterprise_id ) 
	VALUES (
	CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) ,  'ilg_attendance', OLD.enterprise_id
	) ON DUPLICATE 
	KEY UPDATE modified_date = VALUES (
	modified_date
	);	
	
	select c.id, c.name into areaId, areaName from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id limit 1;

	if OLD.attendance_status_id = 0 then  
		
		SET n_total_in = -1;
		if OLD.attendance_type_id = 0 then  			
			SET n_in_on_time = -1;
			
		ELSEIF OLD.attendance_type_id = 1 then 			
			SET n_in_early = -1;
			
		ELSEIF OLD.attendance_type_id = 2 then 
			
			SET n_in_late = -1;
		end if;			
	else			
		SET n_total_out = -1;
		if OLD.attendance_type_id = 0 then 
			
			SET n_out_on_time = -1;
		ELSEIF OLD.attendance_type_id = 1 then 
			
			SET n_out_early = -1;
		ELSEIF OLD.attendance_type_id = 2 then
			
			SET n_out_late = -1;
		end if;			
	end if;	
	
	INSERT INTO  `ilg_interval_attendance` (
		  `interval_started`,
		  `area_id` 		,	
		  `area_name` 		,	
		  `enterprise_id` 	,	
		  `total`			,		
		  `total_in` 		,		
		  `total_out` 		,		
		  `out_late` 		,		
		  `out_on_time` 	,		
		  `out_early` 		,		
		  `in_late` 		,		
		  `in_on_time` 		,		
		  `in_early` 
		)
		VALUES (
			DATE_FORMAT(OLD.time, "%Y-%m-%d %H:00:00"),  areaId,  areaName,  
			OLD.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`
		) ON DUPLICATE KEY UPDATE 
			total=total-1 ,
			`total_in` =total_in+n_total_in,				
			`total_out`=total_out+n_total_out,			
			`out_late`=out_late+n_out_late,		
			`out_on_time`=out_on_time+n_out_on_time,	
			`out_early`=out_early+n_out_early,	
			`in_late`=in_late+n_in_late,
			`in_on_time`=in_on_time+n_in_on_time,	
			`in_early`=in_early+n_in_early	
			;    
	
	
END  

SELECT ar.id AS id, ar.name AS name,
count( case when t1.attendance_status_id = 0 then t1.attendance_status_id end ) as ENTRADA,
count( case when t1.attendance_status_id = 1 then t1.attendance_status_id end ) as SALIDA
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
), ilg_area_person ap, ilg_area ar
WHERE t2.person_id IS NULL 
AND t1.person_id = ap.person_id
AND ar.id = ap.area_id
AND t1.enterprise_id = 2
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 
GROUP BY ar.id


SELECT ar.id AS id, ar.name AS name,
count( case when t1.attendance_status_id = 0 then t1.attendance_status_id end ) as INSIDE
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
), ilg_area_person ap, ilg_area ar
WHERE t2.person_id IS NULL 
AND t1.person_id = ap.person_id
AND ar.id = ap.area_id
AND t1.enterprise_id = 2
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 
GROUP BY ar.id

SELECT 
count( case when t1.attendance_status_id = 0 then t1.attendance_status_id end ) as INSIDE
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
)
WHERE t2.person_id IS NULL 
AND t1.enterprise_id = 2
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 


SELECT 
*
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
)
WHERE t2.person_id IS NULL 
AND t1.enterprise_id = 2
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 

SELECT 
t1.id as id, ar.id as areaId, 
CONCAT( IFNULL(pe.name,''),  ' ', IFNULL(pe.last_name,'') ) as name ,
 t1.time as date,  
case          when  t1.attendance_type_id = 0 and t1.attendance_status_id = 0 then 'Entrada a Tiempo'         
when  t1.attendance_type_id = 1 and t1.attendance_status_id = 0 then 'Entrada Temprano'                
when  t1.attendance_type_id = 2 and t1.attendance_status_id = 0 then 'Entrada Tarde'                
when  t1.attendance_type_id = 0 and t1.attendance_status_id = 1 then 'Salida a Tiempo'              
when  t1.attendance_type_id = 1 and t1.attendance_status_id = 1 then 'Salida a Temprano'                
when  t1.attendance_type_id = 2 and t1.attendance_status_id = 1 then 'Salida Tarde'                 
else ''     end as type 
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
), ilg_area_person ap, ilg_area ar, ilg_person pe 
WHERE t2.person_id IS NULL 
AND pe.id = ap.person_id
AND t1.person_id = ap.person_id
AND t1.attendance_status_id = 0
AND ar.id = ap.area_id
AND t1.enterprise_id = 2
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 
AND t1.time > '2013-12-06 20:42:04'   
order by t1.time asc


----------   buscar attendance viejos de una persona
SELECT 
t1.person_id, t1.time
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
)
WHERE t2.person_id IS NULL 
AND t1.enterprise_id = 18
AND DATE(t1.time) < DATE( '2014-03-01' ) 
order by t1.time desc
limit 100

----  personas que no tienen marcaciones
SELECT pe.id, at.time
FROM ilg_attendance at RIGHT outer JOIN ilg_person AS pe ON at.person_id = pe.id
WHERE at.person_id IS NULL AND pe.enterprise_id = 18
AND pe.status_id = 1
order by at.time desc
limit 100

UPDATE `ilg_person` per SET per.status_id = 2
where per.id in (
SELECT pe.id
FROM ilg_attendance at RIGHT outer JOIN ilg_person AS pe ON at.person_id = pe.id
WHERE at.person_id IS NULL AND pe.enterprise_id = 18
AND pe.status_id = 1
)

UPDATE ilg_attendance at RIGHT outer JOIN ilg_person AS pe ON at.person_id = pe.id 
SET pe.status_id = 2
WHERE at.person_id IS NULL AND pe.enterprise_id = 18
AND pe.status_id = 1




SELECT at.id as id, ar.id as areaId, 
CONCAT( IFNULL(pe.name,''),  ' ', IFNULL(pe.last_name,'') ) as name ,
 at.time as date,  
case          when  at.attendance_type_id = 0 and at.attendance_status_id = 0 then 'Entrada a Tiempo'         
when  at.attendance_type_id = 1 and at.attendance_status_id = 0 then 'Entrada Temprano'                
when  at.attendance_type_id = 2 and at.attendance_status_id = 0 then 'Entrada Tarde'                
when  at.attendance_type_id = 0 and at.attendance_status_id = 1 then 'Salida a Tiempo'              
when  at.attendance_type_id = 1 and at.attendance_status_id = 1 then 'Salida a Temprano'                
when  at.attendance_type_id = 2 and at.attendance_status_id = 1 then 'Salida Tarde'                 
else ''     end as type 
FROM ilg_attendance at, ilg_area_person ap, ilg_area ar, ilg_person pe 
WHERE at.person_id = ap.person_id AND ar.id = ap.area_id AND at.person_id = pe.id 
AND ar.enterprise_id = 2 
AND DATE( at.time ) = DATE( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) )  
AND at.time > '2013-12-06 20:42:04' 
order by at.time asc

SELECT ar.id AS id, ar.name AS name,   
(       SELECT COUNT( * )         
		FROM ilg_area_person      
		WHERE area_id = ar.id 
) AS nEmployees ,
(   SELECT   count( case when t1.attendance_status_id = 0 then t1.attendance_status_id end )     
		FROM ilg_attendance AS t1     
		LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id    
			AND (    t1.time < t2.time      
			OR (     t1.time = t2.time
					AND t1.Id < t2.Id
			)
		), ilg_area_person ap     
	WHERE t2.person_id IS NULL      
	AND t1.person_id = ap.person_id     
	AND ap.area_id = ar.id    
	AND t1.enterprise_id = 2     
	AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00'))     
) as TotalInside   
FROM ilg_area ar   
WHERE ar.enterprise_id = 2   

select d.LastActivity,
TIMESTAMPDIFF(SECOND, d.LastActivity, NOW()  )  as diffsec,
case when TIMESTAMPDIFF(SECOND, d.LastActivity, NOW() )   > 360  then "INACTIVO" 
 when d.LastActivity IS NULL  then "INACTIVO" else "ACTIVO" end as STATE
 from ilg_device d
;


SELECT 
count(*)
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
)
WHERE t2.person_id IS NULL 
AND t1.enterprise_id = 2
AND t1.attendance_status_id = 0
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 




SELECT ar.id AS id, ar.name AS name,
count( * ) as INSIDE
FROM ilg_attendance AS t1 
LEFT OUTER JOIN ilg_attendance AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.time < t2.time
	OR (
		t1.time = t2.time
		AND t1.Id < t2.Id
	)
), ilg_area_person ap, ilg_area ar
WHERE t2.person_id IS NULL 
AND t1.person_id = ap.person_id
AND ar.id = ap.area_id
AND ar.id = 6
AND t1.attendance_status_id = 0
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 
GROUP BY ar.id

DashBoard Daily
SELECT (
			   SELECT   count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end )
			   FROM ilg_attendance AS t1   LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id  
			   AND (    t1.time < t2.time
			   OR (     t1.time = t2.time
			   AND t1.Id < t2.Id
			   )
			   ), ilg_area_person ap 
			   WHERE t2.person_id IS NULL
			   AND t1.person_id = ap.person_id
			   AND t1.enterprise_id = 2
			   AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00'))
	   ) as TotalInside,
   SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo,
   SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano, 
   SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde,  
   SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo,  
   SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
   SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde
   FROM ilg_attendance at, ilg_device dev
   WHERE dev.id = at.device_id 
   AND dev.enterprise_id = 2  
   AND DATE( at.time ) = DATE( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ) )  
GROUP BY DATE(at.time) LIMIT 0, 100





SELECT `shiftName`, person_id, count(*), sum( `worked_hours`)
FROM  `ilg_hour_report_summary` 
where person_id = 1433
group by `shiftName`,person_id
order by person_id


corregir problema en ilg_hour_report_summary  no coincde


SET GLOBAL LC_TIME_NAMES = 'es_CO';


  
  
  
  select id,name,
(
	SELECT ar.name
	FROM ilg_area_person ap, ilg_area ar
	WHERE ilg_person.id = ap.person_id AND ar.id = ap.area_id limit 1
) as arname
 from ilg_person where LOWER(
(
	SELECT ar.name
	FROM ilg_area_person ap, ilg_area ar
	WHERE ilg_person.id = ap.person_id AND ar.id = ap.area_id limit 1
)
) LIKE LOWER('%com%')


SELECT ar.id AS id, ar.name AS name,  
(SELECT COUNT( * ) FROM ilg_area_person   WHERE area_id = ar.id  ) AS nEmployees , 
( SELECT count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end )     
	FROM ilg_attendance AS t1 LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id
	AND (t1.time < t2.time OR (t1.time = t2.time AND t1.Id < t2.Id ) 
	), 
	ilg_area_person ap 
	WHERE t2.person_id IS NULL 
	AND t1.person_id = ap.person_id 
	AND ap.area_id = ar.id 
	AND t1.enterprise_id = 11 
	AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) 
) as TotalInside 
FROM ilg_area ar 
WHERE ar.enterprise_id = 11 
group by ar.id ORDER BY ar.name ASC


SELECT count(*) from 
(SELECT COUNT(*) 	FROM ilg_area_person   	WHERE area_id = ar.id  ) AS nEmployees , 
( SELECT count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end )     
FROM ilg_attendance AS t1 LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id     
AND (t1.time < t2.time OR (t1.time = t2.time AND t1.Id < t2.Id ) ), ilg_area_person ap 
WHERE t2.person_id IS NULL 
AND t1.person_id = ap.person_id 
AND ap.area_id = ar.id 
AND t1.enterprise_id = 11 
AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) ) as TotalInside 
FROM ilg_area ar 
WHERE ar.enterprise_id = 11  
group by ar.id ORDER BY ar.name ASC) as tmp


trigger
BEGIN
	declare areaId bigint(20);
	declare areaName varchar(200);
	declare enterpriseId bigint(20);
	

	if NEW.worked_hours is null then
		SET NEW.worked_hours = 0;
	end if;	
	if NEW.regular_hour is null then
		SET NEW.regular_hour = 0;
	end if;	
	if NEW.night_recharge is null then
		SET NEW.night_recharge = 0;
	end if;	
	if NEW.extra_hour_day is null then
		SET NEW.extra_hour_day = 0;
	end if;	
	if NEW.extra_hour_night is null then
		SET NEW.extra_hour_night = 0;
	end if;	
	if NEW.holiday_recharge is null then
		SET NEW.holiday_recharge = 0;
	end if;	
	if NEW.holiday_night_recharge is null then
		SET NEW.holiday_night_recharge = 0;
	end if;	
	if NEW.holiday_extra_hour_day is null then
		SET NEW.holiday_extra_hour_day = 0;
	end if;	
	if NEW.holiday_extra_hour_night is null then
		SET NEW.holiday_extra_hour_night = 0;
	end if;	
	
	select c.id, c.name, c.enterprise_id into areaId, areaName, enterpriseId from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id;

	INSERT INTO  `ilg_hour_report_summary` (
		`person_id` ,
		`area_id` ,
		`area_name` ,
		`enterprise_id` ,
		`shiftName` ,
		`year_month` ,
		`worked_hours` ,
		`regular_hour` ,
		`night_recharge` ,
		`extra_hour_day` ,
		`extra_hour_night` ,
		`holiday_recharge` ,
		`holiday_night_recharge` ,
		`holiday_extra_hour_day` ,
		`holiday_extra_hour_night`
		)
		VALUES (
			NEW.person_id,
			areaId,
			areaName,
			enterpriseId,
			NEW.shiftName,
			DATE_FORMAT(NEW.start_time, "%Y-%m-01 00:00:00"),
			NEW.worked_hours,
			NEW.regular_hour,
			NEW.night_recharge,
			NEW.extra_hour_day,
			NEW.extra_hour_night,
			NEW.holiday_recharge,
			NEW.holiday_night_recharge,
			NEW.holiday_extra_hour_day,
			NEW.holiday_extra_hour_night
		) ON DUPLICATE KEY UPDATE 
			worked_hours=worked_hours+NEW.worked_hours ,
			`regular_hour` =regular_hour+NEW.regular_hour,				
			`night_recharge`=night_recharge+NEW.night_recharge,			
			`extra_hour_day`=extra_hour_day+NEW.extra_hour_day,		
			`extra_hour_night`=extra_hour_night+NEW.extra_hour_night,	
			`holiday_recharge`=holiday_recharge+NEW.holiday_recharge,	
			`holiday_night_recharge`=holiday_night_recharge+NEW.holiday_night_recharge,
			`holiday_extra_hour_day`=holiday_extra_hour_day+NEW.holiday_extra_hour_day,	
			`holiday_extra_hour_night`=holiday_extra_hour_night+NEW.holiday_extra_hour_night	
			;    
	
  END
  
  
  
  
  SELECT ar.id AS id, ar.name AS name,  
  (SELECT COUNT( * ) FROM ilg_area_person  WHERE area_id = ar.id  ) AS nEmployees , 
  ( SELECT count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end )     FROM ilg_attendance AS t1 LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id     AND (t1.time < t2.time OR (t1.time = t2.time AND t1.Id < t2.Id ) ), ilg_area_person ap WHERE t2.person_id IS NULL AND t1.person_id = ap.person_id AND ap.area_id = ar.id AND t1.enterprise_id = 2 
  AND DATE(t1.time) >= DATE(CONVERT_TZ(NOW() - INTERVAL 1 DAY ,'-00:00','-05:00')) ) as TotalInside 
  FROM ilg_area ar 
  WHERE ar.enterprise_id = 2 group by ar.id ORDER BY ar.name ASC
  
  
  
  
  
  SELECT at.person_id , at.person_id ,DATE( at.time ) as ATDAY,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 0,1) as ENTRADA,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 1,1) as SALIDA,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 2,1) as ENTRADA2,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 3,1) as SALIDA2,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 4,1) as ENTRADA3,
( select at2.time from ilg_attendance at2 where at.person_id = at2.person_id and DATE( at.time ) = DATE( at2.time ) limit 5,1) as SALIDA3
FROM ilg_attendance at 
 WHERE enterprise_id = 2 and manual = 'F' and at.person_id = 1596 
group by person_id,DATE( at.time )
ORDER BY time DESC LIMIT 0, 10


  SELECT at.person_id , at.person_id , DATE( at.time ) as ATDAY, count(*) as COUNT
FROM ilg_attendance at 
 WHERE enterprise_id = 2 and manual = 'F'
group by at.person_id, DATE( at.time )
ORDER BY time DESC LIMIT 0, 10



SELECT at.person_id, at.person_id,at.time,at.attendance_type_id,at.attendance_status_id,
at.manual 
,
( select pe.status_id 
from ilg_person as pe 
where pe.id = at.person_id limit 1 ) as status_id
FROM ilg_attendance at  
WHERE at.enterprise_id = 2  

 
AND at.time like '%2012-11-06%' and 2 > 1 ORDER BY time DESC  LIMIT 0, 10


SELECT person_id, person_id,time,attendance_type_id,attendance_status_id,manual 
,
( select pe.status_id 
from ilg_person as pe 
where pe.id = at.person_id limit 1 ) as status_id
FROM ilg_attendance at  
WHERE enterprise_id = 2   
AND time like '%2012-11-06%' and 2 > 1 ORDER BY time DESC  LIMIT 0, 10

SELECT r.id
FROM ilg_rule as r
INNER JOIN ilg_rule_person as rp
    ON r.id = rp.rule_id
WHERE rp.person_id = '3'

SELECT r.id
FROM ilg_rule as r
INNER JOIN ilg_rule_enterprise as re
    ON r.id = re.rule_id
WHERE re.enterprise_id = '2'

____________________________________________________________________

ALTER TABLE `ilg_attendance`
ADD `LogStamp` varchar(20) COLLATE 'utf8_general_ci' NULL DEFAULT '' COMMENT 'Device TimeStamp' AFTER `verification_mode_id`,
COMMENT='';

ALTER TABLE `ilg_device`
ADD `ip_address_wan` varchar(100) COLLATE 'utf8_bin' NULL DEFAULT '' AFTER `ip_address`,
COMMENT=''; -- 0.728 s

ALTER TABLE `ilg_attendance`
ADD `hour_report_id` bigint(20) NULL AFTER `LogStamp`,
COMMENT=''; -- 10.312 s

ALTER TABLE `ilg_attendance`
ADD `processed` char(1) COLLATE 'utf8_general_ci' NULL COMMENT '\'T\': Procesado por la regla.  Otro:  Not Processed' AFTER `LogStamp`,
COMMENT=''; -- 10.312 s

UPDATE `ilg_attendance` SET
`processed` = 'T'; -- 0.414 s

ALTER TABLE `ilg_calendar_time`
ADD `enterprise_id` bigint(20) NOT NULL AFTER `name`,
COMMENT=''; -- 0.466 s

UPDATE `ilg_calendar_time` as ct
INNER JOIN ilg_calendar as ca
    ON ct.calendar_id = ca.id
SET
ct.enterprise_id = ca.enterprise_id


______________________________________________________________________


ALTER TABLE `ilg_config`
CHANGE `id` `id` bigint(20) NOT NULL AUTO_INCREMENT FIRST,
DROP `serial`,
CHANGE `sms` `sms` varchar(1) COLLATE 'latin1_swedish_ci' NOT NULL COMMENT 'Enable SMS' AFTER `id`,
CHANGE `sms_audio` `sms_audio` varchar(1) COLLATE 'latin1_swedish_ci' NOT NULL COMMENT 'Enable Mensaje de Audio' AFTER `sms`,
DROP `cell_phone`,
ADD `max_number_employees` bigint(20) NULL DEFAULT '0' COMMENT 'Licencias Maximo numero de empleados.  ',
ADD `max_number_devices` bigint(20) NULL DEFAULT '0' COMMENT 'Licencias Maximo numero de Dispositivos Biometricos' AFTER `max_number_employees`,
ADD `sms_ws_url` varchar(500) COLLATE 'latin1_swedish_ci' NULL DEFAULT 'http://localhost/ws/smsws.php' COMMENT 'url del web service para envio de sms' AFTER `max_number_devices`,
ADD `min_time_since_last_to_accept` int(16) NULL COMMENT 'Tiempo en minutos desde la ultima marcacion para aceptarla como valida' AFTER `sms_ws_url`,
ADD `max_time_to_notify` int(16) NULL COMMENT 'maximo lapso permitido en minutos entre la hora actual y la hora de la marcacion para notificar' AFTER `min_time_since_last_to_accept`,
COMMENT=''; -- 0.396 s


ALTER TABLE `ilg_config`
ADD `enterprise_id` bigint(20) NOT NULL AFTER `id`,
CHANGE `max_job_time` `max_job_time` varchar(16) COLLATE 'latin1_swedish_ci' NOT NULL COMMENT 'Maximo tiempo de trabajo permitido.' AFTER `sms_audio`,
CHANGE `max_number_employees` `max_number_employees` int(20) NULL COMMENT 'Licencias Maximo numero de empleados.  ' AFTER `rule_server_url_prefix`,
CHANGE `max_number_devices` `max_number_devices` varchar(20) COLLATE 'latin1_swedish_ci' NOT NULL COMMENT 'Licencias Maximo numero de Dispositivos Biometricos' AFTER `max_number_employees`,
COMMENT=''; -- 0.166 s


ALTER TABLE `ilg_config`
CHANGE `sms` `sms` varchar(1) COLLATE 'latin1_swedish_ci' NULL COMMENT 'Enable SMS' AFTER `enterprise_id`,
CHANGE `sms_audio` `sms_audio` varchar(1) COLLATE 'latin1_swedish_ci' NULL COMMENT 'Enable Mensaje de Audio' AFTER `sms`,
CHANGE `max_job_time` `max_job_time` varchar(16) COLLATE 'latin1_swedish_ci' NULL COMMENT 'Maximo tiempo de trabajo permitido.' AFTER `sms_audio`,
CHANGE `rule_server_url_prefix` `rule_server_url_prefix` varchar(500) COLLATE 'latin1_swedish_ci' NULL COMMENT 'prefijo de la url del servicio de reglas ej: http://localhost:8082/reglas/org.drools.guvnor.Guvnor/package/' AFTER `max_job_time`,
CHANGE `max_number_devices` `max_number_devices` varchar(20) COLLATE 'latin1_swedish_ci' NULL COMMENT 'Licencias Maximo numero de Dispositivos Biometricos' AFTER `max_number_employees`,
COMMENT=''; -- 0.170 s

UPDATE `ilg_config` SET
`id` = '1',
`enterprise_id` = '2',
`sms` = 'T',
`sms_audio` = 'F',
`max_job_time` = '16',
`rule_server_url_prefix` = 'http://cloudtimecontrol.com:8083/reglas/org.drools.guvnor.Guvnor/package/',
`max_number_employees` = '0',
`max_number_devices` = '0',
`sms_ws_url` = 'http://localhost/ws/smsws.php',
`min_time_since_last_to_accept` = NULL,
`max_time_to_notify` = NULL
WHERE `id` = '1'; -- 0.008 s

ALTER TABLE `ilg_config`
ADD UNIQUE `enterprise_id` (`enterprise_id`); -- 0.149 s

ALTER TABLE `ilg_config`
ADD `pre_tolerance_in_default` int(16) NULL COMMENT 'Tiempo en minutos antes de inicio de turno para considerar llegada temprano',
ADD `pre_tolerance_out_default` int(16) NULL COMMENT 'Tiempo en minutos despues de inicio de turno para considerar llegada tarde' AFTER `pre_tolerance_in_default`,
ADD `post_tolerance_in_default` int(16) NULL COMMENT 'Tiempo en minutos antes de finalizar turno para considerar salida temprano' AFTER `pre_tolerance_out_default`,
ADD `post_tolerance_out_default` int(16) NULL COMMENT 'Tiempo en minutos despues de finalizar turno para considerar salida tarde' AFTER `post_tolerance_in_default`,
COMMENT=''; -- 0.163 s

ALTER TABLE `ilg_schedule`
CHANGE `pre_tolerance` `pre_tolerance_in` int(11) NULL COMMENT 'Tiempo en minutos antes de inicio de turno para considerar llegada temprano' AFTER `apply_tolerance`,
CHANGE `post_tolerance` `post_tolerance_in` int(11) NULL COMMENT 'Tiempo en minutos antes de finalizar turno para considerar salida temprano' AFTER `pre_tolerance_in`,
ADD `pre_tolerance_out` int(11) NULL COMMENT 'Tiempo en minutos despues de inicio de turno para considerar llegada tarde' AFTER `post_tolerance_in`,
ADD `post_tolerance_out` int(11) NULL COMMENT 'Tiempo en minutos despues de finalizar turno para considerar salida tarde' AFTER `pre_tolerance_out`,
COMMENT=''; -- 1.532 s

ALTER TABLE `ilg_calendar_time`
ADD `apply_boundaries` tinyint(1) NULL COMMENT 'Aplicar hora minima y maxima para el turno' AFTER `end_time`,
ADD `min_in_time` int(11) NULL COMMENT 'Hora mínima de marcación para considerarla como entrada de este turno.' AFTER `apply_boundaries`,
ADD `max_out_time` int(11) NULL COMMENT 'Hora máxima de marcación para considerarla como salida de este turno.' AFTER `min_in_time`,
COMMENT=''; -- 0.582 s

ALTER TABLE `ilg_calendar_time`
CHANGE `start_time` `start_time` varchar(5) COLLATE 'utf8_general_ci' NULL AFTER `applies_all_years`,
CHANGE `end_time` `end_time` varchar(5) COLLATE 'utf8_general_ci' NULL AFTER `start_time`,
CHANGE `min_in_time` `min_in_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'Hora mínima de marcación para considerarla como entrada de este turno.' AFTER `apply_boundaries`,
CHANGE `max_out_time` `max_out_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'Hora máxima de marcación para considerarla como salida de este turno.' AFTER `min_in_time`,
COMMENT=''; -- 1.094 s

ALTER TABLE `ilg_attendance`
ADD `valid` char(1) COLLATE 'utf8_general_ci' NULL COMMENT '\'T\': Marcacion Valida.  Otro:  No Valida' AFTER `processed`,
COMMENT=''; -- 20.739 s

ALTER TABLE `ilg_rule`
DROP FOREIGN KEY `ilg_rule_ibfk_2`; -- 0.292 s

ALTER TABLE `ilg_rule`
DROP FOREIGN KEY `ilg_rule_person_ibfk_2`; -- 0.250 s

ALTER TABLE `ilg_hour_report`
ADD `notes` varchar(2000) COLLATE 'utf8_general_ci' NULL AFTER `shiftName`,
COMMENT=''; -- 10.958 s

_______________________________________________________________________________________________

CREATE TABLE `ilg_payroll_notice_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_payroll_notice_type_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

CREATE TABLE `ilg_payroll_notice` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `person_id` bigint(20) NOT NULL ,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `type_id` (`type_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_payroll_notice_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_payroll_notice_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  CONSTRAINT `ilg_payroll_notice_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `ilg_payroll_notice_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

INSERT INTO `ilg_payroll_notice_type` (`id`, `name`, `description`, `enterprise_id`) VALUES
(1,	'Personalizado',	'Descripción personalizada de la novedad.',	NULL),
(2,	'VACACIONES',	'El empleado se encuentra de vacaciones.',	NULL),
(3,	'CAPACITACION',	'El empleado se encuentra en capacitación.',	NULL);


________________________________________________________________________________________________

DROP TABLE IF EXISTS `ilg_personal_inside`;
CREATE TABLE IF NOT EXISTS `ilg_personal_inside` (
  `time_updated` datetime DEFAULT NULL,
  `area_id` bigint(20) DEFAULT NULL,
  `area_name` varchar(100) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `num_persons` bigint(20) NOT NULL,
  KEY `area_id` (`area_id`),
  KEY `enterprise_id` (`enterprise_id`),
  UNIQUE (`area_id` ,`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_interval_attendance`;
CREATE TABLE IF NOT EXISTS `ilg_interval_attendance` (
  `interval_started` datetime DEFAULT NULL,
  `area_id` 		bigint(20) DEFAULT NULL,
  `area_name` 		varchar(100) DEFAULT NULL,
  `enterprise_id` 	bigint(20) NOT NULL,
  `total`			bigint(20) NOT NULL,
  `total_in` 		bigint(20) NOT NULL,
  `total_out` 		bigint(20) NOT NULL,
  `out_late` 		bigint(20) NOT NULL,
  `out_on_time` 	bigint(20) NOT NULL,
  `out_early` 		bigint(20) NOT NULL,
  `in_late` 		bigint(20) NOT NULL,
  `in_on_time` 		bigint(20) NOT NULL,
  `in_early` 		bigint(20) NOT NULL,
  KEY `area_id` (`area_id`),
  KEY `enterprise_id` (`enterprise_id`),
  UNIQUE (`interval_started` ,`area_id`,`enterprise_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_personal_inside`;
CREATE TABLE IF NOT EXISTS `ilg_personal_inside` (
  `time_updated` datetime DEFAULT NULL,
  `area_id` bigint(20) DEFAULT NULL,
  `area_name` varchar(100) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL,
  KEY `area_id` (`area_id`),
  KEY `enterprise_id` (`enterprise_id`)
  KEY `person_id` (`person_id`),
  UNIQUE (`person_id` ,`area_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_log_leo`;
CREATE TABLE ilg_log_leo (timeleo datetime, tracelogleo varchar(255));
DROP TRIGGER IF EXISTS `consolidate_arrivals_date`;

/*!40000 ALTER TABLE `ilg_attendance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `consolidate_arrivals_date` AFTER INSERT ON `ilg_attendance`
 FOR EACH ROW BEGIN
	DECLARE nAddPerson INT DEFAULT 1; 
	declare areaId bigint(20);
	declare areaName varchar(200);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 

	
	select c.id, c.name into areaId, areaName from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id;

	if NEW.attendance_status_id = 0 then  
		-- Entrada
		SET n_total_in = 1;
		if NEW.attendance_type_id = 0 then  
			-- on_time
			SET n_in_on_time = 1;
		elseif NEW.attendance_type_id = 1 then  
			-- early
			SET n_in_early = 1;
		elseif NEW.attendance_type_id = 2 then 
			-- late
			SET n_in_late = 1;
		end if;			
	else		
		--  NEW.attendance_status_id 1 Salida
		SET n_total_out = 1;
		SET nAddPerson = -1;
		if NEW.attendance_type_id = 0 then 
			-- on_time
			SET n_out_on_time = 1;
		elseif NEW.attendance_type_id = 1 then 
			-- early
			SET n_out_early = 1;
		elseif NEW.attendance_type_id = 2 then
			-- late
			SET n_out_late = 1;
		end if;			
	end if;	
	
 	/*
	-- select count(*) from my_tables where table_name='ilg_log_leo';
	-- Print the rest of the phrase and a line return.
	INSERT INTO ilg_log_leo (timeleo, tracelogleo) values( now(), concat('areaId=', areaId ,
	' nAddPerson=', nAddPerson ,
	' enterprise_id=' , NEW.enterprise_id  ,
	' n_total_in=' ,        n_total_in  ,
	' n_total_out=' ,       n_total_out  ,
	' n_out_late=' ,        n_out_late  ,
	' n_out_on_time=' ,     n_out_on_time ,
	' n_out_early=' ,       n_out_early  ,
	' n_in_late=' ,         n_in_late  ,
	' n_in_on_time=' ,      n_in_on_time  ,
	' n_in_early=' ,        n_in_early  
	) );
	*/
	
	INSERT INTO  `ilg_interval_attendance` (
		  `interval_started`,
		  `area_id` 		,	
		  `area_name` 		,	
		  `enterprise_id` 	,	
		  `total`			,		
		  `total_in` 		,		
		  `total_out` 		,		
		  `out_late` 		,		
		  `out_on_time` 	,		
		  `out_early` 		,		
		  `in_late` 		,		
		  `in_on_time` 		,		
		  `in_early` 
		)
		VALUES (
			DATE_FORMAT(NEW.time, "%Y-%m-%d %H:00:00"),  areaId,  areaName,  
			NEW.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`
		) ON DUPLICATE KEY UPDATE 
			total=total+1 ,
			`total_in` =total_in+n_total_in,				
			`total_out`=total_out+n_total_out,			
			`out_late`=out_late+n_out_late,		
			`out_on_time`=out_on_time+n_out_on_time,	
			`out_early`=out_early+n_out_early,	
			`in_late`=in_late+n_in_late,
			`in_on_time`=in_on_time+n_in_on_time,	
			`in_early`=in_early+n_in_early	
			;    
	
	INSERT INTO  `ilg_personal_inside` (
		`time_updated` ,
		`area_id` ,
		`area_name` ,
		`enterprise_id` ,
		`num_persons`
		)
		VALUES (
			CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ),  areaId,  areaName,  NEW.enterprise_id,  1
		)ON DUPLICATE KEY UPDATE 
			num_persons=num_persons+nAddPerson;    
	
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

DELETE FROM `ilg_attendance` WHERE id = 999999;
INSERT INTO  `janus`.`ilg_attendance` (
`id` ,
`device_id` ,
`person_id` ,
`enterprise_id` ,
`time` ,
`attendance_status_id` ,
`attendance_type_id` ,
`verification_mode_id` ,
`work_code` ,
`reserved_1` ,
`reserved_2`
)
VALUES (
'999999',  '3',  '6',  '1',  '2013-11-02 12:10:08',  '1',  '1',  '0',  '1',  '1',  '1'
);
DELETE FROM `ilg_attendance` WHERE id = 999999;

select * from `ilg_log_leo`;
select * from ilg_personal_inside;
select * from ilg_interval_attendance;
delete from ilg_log_leo where 1;
DROP TABLE IF EXISTS `ilg_log_leo`;


_______________________________________________________________________________


-- sql de diana
select distinct(person) from (
select distinct(p.id) as person from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar cal on s.time_calendar_id = cal.id
inner join ilg_calendar_date cd on cd.calendar_id = cal.id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and cal.enterprise_id = 14 and cd.entry_date = date(now()) and 
not exists( select id from ilg_hour_report hr where hr.person_id = p.id and cd.name = hr.shiftName and date(hr.start_time) = date(now()))
union all
select distinct(p.id) as person  from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK(now()) = 1) or 
(ct.Monday= 'T' and DAYOFWEEK(now()) = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK(now()) = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK(now()) = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK(now()) = 5) or 
(ct.Friday = 'T' and DAYOFWEEK(now()) = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK(now()) = 7)) and 
(ct.initial_date is null or ct.initial_date <= now()) and 
(ct.end_date is null or ct.end_date >= now()) and
ct.start_time <= curtime() and ct.end_time >= curtime() and
not exists( select id from ilg_hour_report hr where hr.person_id = p.id and ct.name = hr.shiftName and date(hr.start_time) = date(now()))
) a


--   reporte de ausencias
select distinct a.Date as time, p.id  as personId , p.identification as identification  , s.name as shiftName , ct.name as intervalName,  ct.start_time as shiftTime
from 
(
  select '2014-01-01' + INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY as Date
  from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
  cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
  cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
) a, ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where 
a.Date <= '2014-04-01' 
and p.enterprise_id = 14 
and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK( a.Date) = 1) or 
(ct.Monday= 'T' and DAYOFWEEK( a.Date) = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK( a.Date) = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK( a.Date) = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK( a.Date) = 5) or 
(ct.Friday = 'T' and DAYOFWEEK( a.Date) = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK( a.Date) = 7)) and 
(ct.initial_date is null or ct.initial_date <=  a.Date) and 
(ct.end_date is null or ct.end_date >=  a.Date)
and not exists( 
	select id 
	from ilg_hour_report hr 
	where hr.person_id = p.id 
	and ct.name = hr.shiftName 
	and date(hr.start_time) = date( a.Date)
)
and not exists( 
	select id 
	from ilg_payroll_notice pn 
	where pn.person_id = p.id 
	and date( a.Date ) between date( pn.start_time ) and  date( pn.end_time ) 
)


select distinct(p.id) as person  from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 1) or 
(ct.Monday= 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 5) or 
(ct.Friday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 7)) and 
(ct.initial_date is null or ct.initial_date <= CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) and 
(ct.end_date is null or ct.end_date >= CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) and
ct.start_time <=  DATE_FORMAT( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ), '%H:%i')
and not exists( 
	select id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ))
)


--Esta es dashboard
select p.id as person, ct.start_time,
	( select count(*) from ilg_person pin 
		inner join ilg_schedule sin on pin.schedule_id = sin.id
		inner join ilg_calendar_time ctin on sin.time_calendar_id = ctin.calendar_id
		where ct.id = ctin.id
		) as totalEmp
from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 1) or 
(ct.Monday= 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 5) or 
(ct.Friday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 7)) and 
(ct.initial_date is null or ct.initial_date <= '2014-01-06 09:05:35') and 
(ct.end_date is null or ct.end_date >= '2014-01-06 09:05:35') and
ct.start_time <=  DATE_FORMAT( '2014-01-06 09:05:35', '%H:%i')
and not exists( 
	select id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date('2014-01-06 09:05:35')
)
and not exists( 
	select id from ilg_attendance att 
	where att.person_id = p.id
	and att.attendance_status_id = 0
	and date(att.time) = date('2014-01-06 09:05:35')
	and hour_report_id = null
	and ct.end_time > DATE_FORMAT( att.time , '%H:%i')
)

select count( distinct( p.id ) ) ,
	( select count(*) - count( distinct( p.id ) ) from ilg_person pin 	
		inner join ilg_schedule si on pin.schedule_id = si.id 	
		where pin.enterprise_id = 14 and (pto_id is null or pto_Id != 1) 
		and status_id = 1 
		) as totalEmp
from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 1) or 
(ct.Monday= 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 5) or 
(ct.Friday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 7)) and 
(ct.initial_date is null or ct.initial_date <= '2014-01-06 09:05:35') and 
(ct.end_date is null or ct.end_date >= '2014-01-06 09:05:35') and
ct.start_time <=  DATE_FORMAT( '2014-01-06 09:05:35', '%H:%i')
and not exists( 
	select id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date('2014-01-06 09:05:35')
)
and not exists( 
	select id from ilg_attendance att 
	where att.person_id = p.id
	and att.attendance_status_id = 0
	and date(att.time) = date('2014-01-06 09:05:35')
	and hour_report_id = null
	and ct.end_time > DATE_FORMAT( att.time , '%H:%i')
)



select count(p.id) as absence, ct.name as turno, ct.start_time as inicioTurno,
	( select count(*) from ilg_person pin 
		inner join ilg_schedule sin on pin.schedule_id = sin.id
		inner join ilg_calendar_time ctin on sin.time_calendar_id = ctin.calendar_id
		where ct.id = ctin.id
		) as totalEmpTurno
from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 1) or 
(ct.Monday= 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 5) or 
(ct.Friday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK('2014-01-06 09:05:35') = 7)) and 
(ct.initial_date is null or ct.initial_date <= '2014-01-06 09:05:35') and 
(ct.end_date is null or ct.end_date >= '2014-01-06 09:05:35') and
ct.start_time <=  DATE_FORMAT( '2014-01-06 09:05:35', '%H:%i')
and not exists( 
	select hr.id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date('2014-01-06 09:05:35')
)
and not exists( 
	select hr.id from ilg_attendance att 
	where att.person_id = p.id
	and att.attendance_status_id = 0
	and date(att.time) = date('2014-01-06 09:05:35')
	and hour_report_id = null
	and ct.end_time > DATE_FORMAT( att.time , '%H:%i')
)
group by ct.id

select p.id as person, ct.start_time, ct.name from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where p.enterprise_id = 14 and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 1) or 
(ct.Monday= 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 5) or 
(ct.Friday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) = 7)) and 
(ct.initial_date is null or ct.initial_date <= CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) and 
(ct.end_date is null or ct.end_date >= CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' )) and
ct.start_time <=  DATE_FORMAT( CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ), '%H:%i')
and not exists( 
	select id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ))
)
and not exists( 
	select id from ilg_attendance att 
	where att.person_id = p.id
	and att.attendance_status_id = 0
	and date(att.time) = date(CONVERT_TZ( NOW( ) ,  '-00:00',  '-05:00' ))
	and hour_report_id = null
	and ct.end_time > DATE_FORMAT( att.time , '%H:%i')
)



select  p.id AS id, CONCAT_WS(' ', p.name, p.last_name) as name, p.identification as identification
from ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where ct.name = 'L-VMañana'
and not exists( 
	select id from ilg_hour_report hr 
	where hr.person_id = p.id and ct.name = hr.shiftName 
	and date(hr.start_time) = date('2014-04-08 11:05:35')
)
and not exists( 
	select id from ilg_attendance att 
	where att.person_id = p.id
	and att.attendance_status_id = 0
	and date(att.time) = date('2014-04-08 11:05:35')
	and hour_report_id = null
	and ct.end_time > DATE_FORMAT( att.time , '%H:%i')
)

---  al determinar una salida como entrada se debe dejar el attendant con hour_report_id = null


---summary absence
select distinct ( p.id ) as personId , p.identification as identification , count(*)
from 
(
  select '2014-01-01' + INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY as Date
  from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
  cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
  cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
) a, ilg_person p 
inner join ilg_schedule s on p.schedule_id = s.id
inner join ilg_calendar_time ct on s.time_calendar_id = ct.calendar_id
where 
a.Date <= '2014-04-01' 
and p.enterprise_id = 14 
and (pto_id is null or pto_Id != 1) and ct.enterprise_id = 14 and
((ct.sunday = 'T' and DAYOFWEEK( a.Date) = 1) or 
(ct.Monday= 'T' and DAYOFWEEK( a.Date) = 2) or  
(ct.Tuesday = 'T' and DAYOFWEEK( a.Date) = 3) or 
(ct.Wednesday = 'T' and DAYOFWEEK( a.Date) = 4) or 
(ct.Thursday = 'T' and DAYOFWEEK( a.Date) = 5) or 
(ct.Friday = 'T' and DAYOFWEEK( a.Date) = 6) or 
(ct.Saturday = 'T' and DAYOFWEEK( a.Date) = 7)) and 
(ct.initial_date is null or ct.initial_date <=  a.Date) and 
(ct.end_date is null or ct.end_date >=  a.Date)
and not exists( 
	select id 
	from ilg_hour_report hr 
	where hr.person_id = p.id 
	and ct.name = hr.shiftName 
	and date(hr.start_time) = date( a.Date)
)
and not exists( 
	select id 
	from ilg_payroll_notice pn 
	where pn.person_id = p.id 
	and date( a.Date ) between date( pn.start_time ) and  date( pn.end_time ) 
) group by p.id

--------------------------- borrar areas , sucursales y tags sin borrar marcaciones

DELETE FROM ilg_branch_office WHERE enterprise_id IN ( 85     );
DELETE FROM ilg_payroll_period_sum WHERE enterprise_id IN ( 85     );
DELETE FROM ilg_area WHERE enterprise_id IN ( 85     );
DELETE FROM ilg_tag_category WHERE enterprise_id IN ( 85     );
DELETE FROM ilg_tag WHERE enterprise_id IN ( 85     );

DELETE ub from ilg_user_branchoff ub
where NOT EXISTS( select id from ilg_branch_office  where id = ub.branch_office_id)

Update ilg_person p
INNER JOIN ilg_contract as c ON c.person_id = p.id
SET p.start_date =  c.started_date
where p.enterprise_id = 39 and c.status_id = 1;

--------------------------- borrar empleado
delete from ilg_device_person where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456 ) );
delete from ilg_attendance where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456) );
delete from ilg_device_fingerprint where fingerprint_id in ( select id from ilg_fingerprint where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456) ));
delete from ilg_fingerprint where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456 ) );

delete from ilg_hour_report where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456 ) );
delete from ilg_hour_concept where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456 ) );
delete from ilg_payroll_notice where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456 ) );
delete from ilg_contract where person_id in ( select id from ilg_person where enterprise_id = 63 and identification in ( 123456) );

delete from ilg_person where enterprise_id = 63 and identification in (123456);

----------------------------------------------cloudtime BORRAR EMPRESA
DELETE ilg_att_report FROM ilg_att_report INNER JOIN ilg_person ON ilg_person.id = ilg_att_report.person_id
WHERE ilg_person.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM `ilg_attendance` WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_attendance FROM ilg_attendance INNER JOIN ilg_person ON ilg_person.id = ilg_attendance.person_id
WHERE ilg_person.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_operation_log FROM ilg_operation_log INNER JOIN ilg_device ON ilg_device.id = ilg_operation_log.device_id
WHERE ilg_device.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_device_cmd FROM ilg_device_cmd INNER JOIN ilg_device ON ilg_device.id = ilg_device_cmd.device_id
WHERE ilg_device.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_device_cmd FROM ilg_device_cmd INNER JOIN ilg_person ON ilg_person.id = ilg_device_cmd.person_id
WHERE ilg_person.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_device_person FROM ilg_device_person INNER JOIN ilg_person ON ilg_person.id = ilg_device_person.person_id
WHERE ilg_person.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_device_person FROM ilg_device_person INNER JOIN ilg_device ON ilg_device.id = ilg_device_person.device_id
WHERE ilg_device.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_device_fingerprint FROM ilg_device_fingerprint INNER JOIN ilg_device ON ilg_device.id = ilg_device_fingerprint.device_id
WHERE ilg_device.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_viewlevels_enterprise WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE ilg_fingerprint FROM ilg_fingerprint INNER JOIN ilg_person ON ilg_person.id = ilg_fingerprint.person_id
WHERE ilg_person.enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_hour_concept WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_hour_report WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_cost_center WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_concept WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_task WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM bi4cg_users WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_position WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_contract_detail WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_contract WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_contract_type WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_notification WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_calendar_date WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_calendar_time WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_branch_office WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_device WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_payroll_notice WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_payroll_notice_type WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_rule_enterprise WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_period WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_person_schedule WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_person WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_schedule WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_calendar WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_config_auto_period WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_config WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_payroll_period_sum WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_payroll_period WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_area WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_process_file WHERE enterprise_id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );
DELETE FROM ilg_enterprise WHERE id IN ( 70,72,73,76,83,85,87,88,89,91,92,93,94,95,96,97,98,99    );

delete hr
FROM `ilg_payroll_period_sum` hr
inner join ilg_area p on p.id = hr.area_id
where p.enterprise_id!= hr.enterprise_id;

delete hr
FROM `ilg_hour_report` hr
inner join ilg_person p on p.id = hr.person_id
where p.enterprise_id!= hr.enterprise_id;

UPDATE bi4cg_users
SET name = REPLACE(name, 'edevesa', 'evedesa') , username = REPLACE(username , 'edevesa', 'evedesa'), email = REPLACE(email, 'edevesa', 'evedesa');

---------- querys cloudtime

select * from ilg_hour_concept WHERE person_id IN ( select id from ilg_person where enterprise_id = 42);
select * from ilg_payroll_period_sum WHERE area_id IN ( select id from ilg_area where enterprise_id = 42);
UPDATE `ilg_person` SET `enterprise_id` = '18' WHERE `id` in ( 3128,'4014',3921,4018);
UPDATE `ilg_person` SET `schedule_id` = null WHERE `id` in ( 3128,'4014',3921,4018);


DELETE a
FROM ilg_device_cmd as a, ilg_device_cmd as b
WHERE
          (a.CmdContent   = b.CmdContent OR a.CmdContent IS NULL AND b.CmdContent IS NULL)
      AND (a.device_id = b.device_id OR a.device_id IS NULL AND b.device_id IS NULL)
      AND b.ID > a.ID;
	  
	  

---------  Borrar dispositivo
DELETE ilg_operation_log FROM ilg_operation_log INNER JOIN ilg_device ON ilg_device.id = ilg_operation_log.device_id
WHERE ilg_device.id IN (      54      );
DELETE ilg_device_cmd FROM ilg_device_cmd INNER JOIN ilg_device ON ilg_device.id = ilg_device_cmd.device_id
WHERE ilg_device.id IN (      54      );
DELETE ilg_device_cmd FROM ilg_device_cmd INNER JOIN ilg_person ON ilg_person.id = ilg_device_cmd.person_id
WHERE ilg_person.id IN (      54      );
DELETE ilg_device_person FROM ilg_device_person INNER JOIN ilg_person ON ilg_person.id = ilg_device_person.person_id
WHERE ilg_person.id IN (      54      );
DELETE ilg_device_person FROM ilg_device_person INNER JOIN ilg_device ON ilg_device.id = ilg_device_person.device_id
WHERE ilg_device.id IN (      54      );
DELETE ilg_device FROM ilg_device
WHERE ilg_device.id IN (      54      );

--------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `ilg_att_origin_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

INSERT INTO `ilg_att_origin_type` (`id`, `name`, `description`) VALUES
(1,	'DEVICE',	'Marcación del Dispositivo.'),
(2,	'MANUAL',	'Marcación realizada desde la página.'),
(3,	'AUTO',	'Marcación realizada automáticamente por el sistema.');

ALTER TABLE `ilg_attendance`
ADD `origin_type_id` bigint(20) NULL DEFAULT '1' COMMENT '1: Marcación por dispositivo \\\'2\\\': Marcación Manual.  3:  Marcación Automática por el Sistema.' AFTER `manual`,
COMMENT=''; 
ALTER TABLE `ilg_attendance`
ADD KEY `origin_type_id` (`origin_type_id`); 
ALTER TABLE `ilg_attendance`
ADD FOREIGN KEY (`origin_type_id`) REFERENCES `ilg_att_origin_type` (`id`); 
UPDATE `ilg_attendance` SET
`origin_type_id` = '2'
WHERE `manual` = 'T';
ALTER TABLE `ilg_attendance`
DROP `manual`,
COMMENT='';

ALTER TABLE `ilg_hour_report`
ADD `origin_type_id` bigint(20) NULL DEFAULT '1' COMMENT '1: Marcación por dispositivo \\\'2\\\': Marcación Manual.  3:  Marcación Automática por el Sistema.' AFTER `manual`,
COMMENT=''; 
ALTER TABLE `ilg_hour_report`
ADD KEY `origin_type_id` (`origin_type_id`); 
ALTER TABLE `ilg_hour_report`
ADD FOREIGN KEY (`origin_type_id`) REFERENCES `ilg_att_origin_type` (`id`); 
UPDATE `ilg_hour_report` SET
`origin_type_id` = '2'
WHERE `manual` = 'T';
ALTER TABLE `ilg_hour_report`
DROP `manual`,
COMMENT='';

ALTER TABLE `ilg_config`
ADD `ignore_middle_att` char(1) COLLATE 'utf8_general_ci' NULL COMMENT 'T: Ignora las marcaciones intermedias',
COMMENT='';

ALTER TABLE `ilg_hour_report`
ADD INDEX `end_time` (`end_time`); -- 7.230 s

ALTER TABLE `ilg_attendance`
ADD INDEX `hour_report_id` (`hour_report_id`); -- 41.127 s

ALTER TABLE `ilg_attendance` ADD INDEX `processed` (`processed`); 

INSERT INTO `ilg_attendance_status` (`id`, `name`, `description`)
VALUES ('10', 'in-between', 'Marcación entre el intervalo de entrada y salida del turno.'); -- 0.046 s

ALTER TABLE `ilg_config`
ADD `generate_auto_att` char(1) COLLATE 'utf8_general_ci' NULL COMMENT 'T: Genera automaticamente marcaciones a los empleados que no marcaron a la salida',
COMMENT=''; -- 0.188 s


-------------------------------------------------------------------------------------------



SELECT at.hour_report_id
FROM ilg_attendance at
LEFT JOIN ilg_hour_report hr ON at.hour_report_id = hr.id
WHERE hr.id IS NULL
and at.hour_report_id > 0

	
	


--- 0.1
SELECT *
FROM `ilg_attendance` at
inner join `ilg_hour_report` hr on hr.id = at.hour_report_id
inner join ilg_calendar_time ct on ct.name = hr.shiftName
WHERE hr.end_time < '2014-04-09 11:00:00' 
AND at.person_id = '2370'
and ( ( apply_boundaries = 1 
		and ct.min_in_time <=  DATE_FORMAT( '2014-04-09 11:00:00', '%H:%i')
		and ct.max_out_time >= DATE_FORMAT( '2014-04-09 11:00:00', '%H:%i')
		)  or
		( apply_boundaries = = or  apply_boundaries is null and (
			ct.start_time <=  DATE_FORMAT( '2014-04-09 11:00:00', '%H:%i')
			and ct.end_time >=  DATE_FORMAT( '2014-04-09 11:00:00', '%H:%i')
			)		
		)
	)
ORDER BY hr.end_time desc, at.time asc
LIMIT 4

--- demorado 0.7
SELECT *
FROM `ilg_attendance` at
inner join (
	select id from `ilg_hour_report` hr
	WHERE hr.person_id = 2370 and hr.end_time < '2014-04-09 11:00:00' 
	ORDER BY hr.end_time desc
	limit 1
) as hrt
on hrt.id = at.hour_report_id

	select id from `ilg_hour_report` hr
	WHERE hr.end_time < '2014-04-09 11:00:00' 
	ORDER BY hr.end_time desc
	limit 1

--0.6
SELECT *
FROM `ilg_attendance` at
where at.hour_report_id = 1041973 and
hr.

SELECT *
FROM `ilg_attendance` at
WHERE  at.hourReportId.id = 1042145
		AND at.time BETWEEN DATE_ADD( '2014-04-26 05:49:52', INTERVAL 2 MINUTE ) 
		AND  DATE_ADD( '2014-04-26 12:13:11' , INTERVAL -2 MINUTE ) 
		
		
select * 
from ilg_attendance at inner join ilg_hour_report hr on hr.id = at.hour_report_id
WHERE  at.enterprise_id = 14		
		and (	( at.time 
					BETWEEN  '2014-04-16 00:00:00' 
					AND  '2014-04-18 11:00:00' 
				)
				OR
				( ( hr.start_time 
				 	      BETWEEN  '2014-04-16 00:00:00'  
				         AND  '2014-04-18 11:00:00' )  OR
				 ( hr.end_time 
				 	      BETWEEN  '2014-04-16 00:00:00' 
				         AND  '2014-04-18 11:00:00' ) 
				)		 
			)
order by at.time asc		

select * 
from ilg_attendance at left join ilg_hour_report hr on hr.id = at.hour_report_id
WHERE 
		at.enterprise_id = 14		
		and (	( at.time 
					BETWEEN  '2014-04-16 00:00:00' 
					AND  '2014-04-18 11:00:00' 
				)
				OR
				( ( hr.start_time 
				 	      BETWEEN  '2014-04-16 00:00:00'  
				         AND  '2014-04-18 11:00:00' )  OR
				 ( hr.end_time 
				 	      BETWEEN  '2014-04-16 00:00:00' 
				         AND  '2014-04-18 11:00:00' ) 
				)		 
			)	
order by at.time asc	


		"UPDATE Attendance at left join HourReport hr on hr.id = at.hourReportId " +
		"SET at.hourReportId = NULL " +
		"at.processed = 'F' " +
		"	WHERE " +
		"		at.ilgEnterprise.id = :enterprise_id  " +
		"		and (	( at.time  " +
		"					BETWEEN  :startDate " + 
		"					AND  :endDate  " +
		"				) " +
		"				OR " +
		"				( ( hr.startTime " + 
		"				 	      BETWEEN  :startDate " + 
		"				         AND  :endDate )  OR " +
		"				 ( hr.endTime  " +
		"				 	      BETWEEN  :startDate " +
		"				         AND  :endDate )  " +
		"				)		  " +
		"			) " 

select * 
from ilg_attendance at 
WHERE 
at.processed = 'F'			








select * from ilg_calendar_date cd
where enterprise_id = 14
	AND date_type_id = 2
	AND ( (  CD.APPLIES_ALL_YEARS = 'F' AND  entry_date > '2025-04-02' - INTERVAL 3 DAY
			AND entry_date < '2025-04-02' + INTERVAL 3 DAY  )
		OR (  CD.APPLIES_ALL_YEARS = 'T'  
				AND DATE_FORMAT(CD.ENTRY_DATE, '%m-%d') > DATE_FORMAT( '2025-04-02' - INTERVAL 3 DAY  , '%m-%d' )
				AND DATE_FORMAT(CD.ENTRY_DATE, '%m-%d') < DATE_FORMAT( '2025-04-02' + INTERVAL 3 DAY   , '%m-%d' ) ) 		
	)
	

--------------------------------
SELECT hr.id as hour_report_id, hc.person_id as person_id, 
 SUM(hr.worked_hours) as worked_hours, 
 
 
 SUM(case when c.name = 'RN' then hc.hours else 0 end ) as RN,   
 SUM(case when c.name = 'HO' then hc.hours else 0 end ) as HO,   
 
 
 
 SUM( case when hr.origin_type_id = 2 then 1 else 0 end ) as manuales 
 FROM ilg_hour_concept hc
 INNER JOIN ilg_hour_report hr ON hc.hour_report_id = hr.id 
 INNER JOIN ilg_concept c ON hc.concept_id = c.id 
 INNER JOIN ilg_person p ON hc.person_id = p.id 
 WHERE  hc.enterprise_id = 14
 and p.status_id = 1 
 and c.status_id = 1 
 GROUP BY person_id 
 ORDER BY DATE_FORMAT(hr.start_time,'%Y-%m') desc
---------------------------------------
SELECT MONTH(hr.start_time) as month_id , SUM(`hr.worked_hours`) as Horas_Trabajadas, 

 SUM(case when c.name = 'RN' then hc.hours else 0 end ) as RN,   
 SUM(case when c.name = 'HO' then hc.hours else 0 end ) as HO,   
 
 SUM( case when origin_type_id = 2 then 1 else 0 end ) as manuales  			
 FROM `ilg_hour_report` hr 
 INNER JOIN ilg_hour_concept hc ON hc.hour_report_id = hr.id 
 INNER JOIN ilg_concept c ON hc.concept_id = c.id 
 INNER JOIN ilg_person p ON hr.person_id = p.id 						
 WHERE  hr.enterprise_id = $enterprise_id 
 and p.status_id = 1 		
 GROUP BY DATE_FORMAT(hr.start_time,'%Y-%m') 
 ORDER BY hr.start_time ASC


-------------------------------------
ALTER TABLE `ilg_hour_report`
DROP `regular_hour`,
DROP `night_recharge`,
DROP `extra_hour_day`,
DROP `extra_hour_night`,
DROP `holiday_recharge`,
DROP `holiday_night_recharge`,
DROP `holiday_extra_hour_day`,
DROP `holiday_extra_hour_night`,
COMMENT=''; -- 8.610 s

---  Hace referencia al concepto de las horas trabajadas
CREATE TABLE `ilg_concept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_concept_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_rule_asset`;
CREATE TABLE `ilg_rule_asset` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `package` varchar(100) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `concept_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `identification` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'UUID del asset de la regla a ejecutar para determinar este concepto',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_package` (`name`,`package`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `concept_id` (`concept_id`),
  CONSTRAINT `ilg_rule_asset_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_rule_asset_ibfk_2` FOREIGN KEY (`concept_id`) REFERENCES `ilg_concept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_hour_concept`;
CREATE TABLE `ilg_hour_concept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hour_report_id` bigint(20) NOT NULL,
  `concept_id` bigint(20) NOT NULL,
  `person_id` bigint(20) NOT NULL ,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `hour_report_id` (`hour_report_id`),
  KEY `concept_id` (`concept_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_concept_ibfk_11` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_concept_ibfk_21` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  CONSTRAINT `ilg_concept_ibfk_31` FOREIGN KEY (`concept_id`) REFERENCES `ilg_concept` (`id`),
  CONSTRAINT `ilg_concept_ibfk_41` FOREIGN KEY (`hour_report_id`) REFERENCES `ilg_hour_report` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

ALTER TABLE `ilg_hour_concept`
ADD `hours` decimal(10,2) NULL,
COMMENT=''; 


ALTER TABLE `ilg_rule`
CHANGE `url` `package` varchar(50) COLLATE 'utf8_general_ci' NULL COMMENT 'Guvnor URL' AFTER `description`,
ADD `version` varchar(50) COLLATE 'utf8_general_ci' NULL,
ADD `process` varchar(50) COLLATE 'utf8_general_ci' NULL COMMENT 'ATTENDANCE=Procesamiento de marcaciones,  PAYROLL=Reporte de pago de empleado' AFTER `version`,
COMMENT=''; 

UPDATE `ilg_rule` SET
`process` = 'ATTENDANCE'

ALTER TABLE `ilg_hour_report`
CHANGE `shiftName` `shiftName` varchar(100) COLLATE 'utf8_general_ci' NOT NULL COMMENT 'Nombre del intervalo de turno' AFTER `origin_type_id`,
ADD `calendar_id` bigint(20) NOT NULL COMMENT 'Intervalo de Turno' AFTER `shiftName`,
COMMENT='';

ALTER TABLE `ilg_hour_report`
ADD INDEX `calendar_id` (`calendar_id`); 

Update ilg_hour_report hr
INNER JOIN ilg_calendar_time as ct ON ct.name = hr.shiftName
SET hr.calendar_id = ct.id

Update ilg_hour_report hr
SET hr.calendar_id = 5
WHERE hr.calendar_id = 0;

ALTER TABLE `ilg_hour_report`
ADD FOREIGN KEY (`calendar_id`) REFERENCES `ilg_calendar_time` (`id`); 

ALTER TABLE `ilg_concept`
ADD `initial_date` date NULL AFTER `description`,
ADD `end_date` date NULL AFTER `initial_date`,
ADD `status_id` bigint(20) NOT NULL DEFAULT '1' AFTER `end_date`,
COMMENT=''; 

ALTER TABLE `ilg_concept`
ADD INDEX `status_id` (`status_id`); 

select person_id
from ilg_area_person
group by person_id
having count(*) >= 2



ALTER TABLE `ilg_concept`
ADD FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`); 

INSERT INTO `ilg_rule` (`person_id`, `name`, `description`, `package`, `version`, `process`)
VALUES (NULL, 'DataControl', NULL, 'Datacontrol', 'LATEST', 'PAYROLL'); 

--INSERT INTO `ilg_rule_enterprise` (`rule_id`, `enterprise_id`)
--VALUES ('0', '14'); -- 0.200 s

--INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`, `url`) VALUES ('REGULARHOUR', 'REGULARHOUR', NULL, NULL, '1', '14', NULL); 

DELETE FROM `ilg_calendar_date`;

ALTER TABLE `ilg_calendar_date`
ADD `enterprise_id` bigint(20) NOT NULL AFTER `status_id`,
COMMENT='';

ALTER TABLE `ilg_calendar_date`
ADD INDEX `enterprise_id` (`enterprise_id`);


ALTER TABLE `ilg_calendar_date`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`); -- 0.249 s

ALTER TABLE `ilg_hour_concept`
ADD `start_time` datetime NULL,
ADD `end_time` datetime NULL AFTER `start_time`,
COMMENT='';




ALTER TABLE `ilg_calendar_date`
CHANGE `start_time` `start_time` varchar(5) COLLATE 'utf8_general_ci' NULL DEFAULT '00:00' AFTER `end_entry_date`,
CHANGE `end_time` `end_time` varchar(5) COLLATE 'utf8_general_ci' NULL DEFAULT '23:59' AFTER `start_time`,
COMMENT=''; -- 0.560 s


ALTER TABLE `ilg_concept`
CHANGE `description` `description` varchar(2000) COLLATE 'utf8_bin' NULL AFTER `name`,
COMMENT=''; 

INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-01-01', 'Año Nuevo', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);		
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-01-12', 'Día de los Reyes Magos', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
--INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-03-17', 'Domingo de Ramos', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-03-23', 'Día de San José', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);	
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-04-02', 'Jueves Santo', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);	
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-04-03', 'Viernes Santo', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);	
--INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-04-31', 'Domingo de Resurrección', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-05-01', 'Día del Trabajo', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-05-18', 'Día de la Ascensión', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-06-08', 'Corpus Christi', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);	
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-06-15', 'Sagrado Corazón', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2015-06-29', 'San Pedro y San Pablo', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-07-20', 'Día de la Independencia', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-08-07', 'Batalla de Boyacá', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-08-17', 'La asunción de la Virgen', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-10-12', 'Día de la Raza', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-11-02', 'Todos los Santos', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-11-16', 'Independencia de Cartagena', NULL, NULL, NULL, 'F', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-12-08', 'Día de la Inmaculada Concepción', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);
INSERT INTO `ilg_calendar_date` (`calendar_id`,`entry_date`,  `name`, `end_entry_date`, `start_time`, `end_time`, `applies_all_years`, `date_type_id`, `status_id`, `enterprise_id`, `creation_date`, `change_status_date`) VALUES (NULL, '2014-12-25', 'Día de Navidad', NULL, NULL, NULL, 'T', '2', '1', '14', NULL, NULL);

INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HO', 'Horas Ordinarias', NULL, NULL, '1', '14'); -- 0.133 s

INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('RN', 'Recargo Nocturno, horas laboradas en horario nocturno', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HDD', 'Hora Dominical Diurna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HDN', 'Hora Dominical Nocturna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HFD', 'Hora Festiva Diurna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HFN', 'Hora Festiva Nocturna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HED', 'Hora extra diurna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HEN', 'Hora extra nocturna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HEDD', 'Hora extra dominical diurna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HEDN', 'Hora extra dominical nocturna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HEFD', 'Hora extra festiva diurna', NULL, NULL, '1', '14'); -- 0.133 s
INSERT INTO `ilg_concept` (`name`, `description`, `initial_date`, `end_date`, `status_id`, `enterprise_id`)
VALUES ('HEFN', 'Hora extra festiva nocturna', NULL, NULL, '1', '14'); -- 0.133 s

	
INSERT INTO `ilg_rule_asset` (`id`, `name`, `package`, `description`, `concept_id`, `enterprise_id`, `identification`) VALUES
(110,	'InicioSecuencia',	'Datacontrol',	'Regla de inicio de secuencia.',	100,	14,	'f79b129d-2cbb-421e-aadb-5a7afcf78af7'),
(112,	'HO',	'Datacontrol',	NULL,	100,	14,	'31a88c17-7e44-4349-aaf4-52c31a62d5ec'),
(113,	'RN',	'Datacontrol',	'Recargo Nocturno, horas laboradas en horario nocturno',	101,	14,	'2dd02379-2c5c-4965-98b2-22c7d46d34e4'),
(114,	'HDD',	'Datacontrol',	'Hora Dominical Diurna',	102,	14,	'ea5da045-e0a8-44a0-bc71-dd52fd3cea6d'),
(115,	'HDN',	'Datacontrol',	'Hora Dominical Nocturna',	103,	14,	'd33beb63-bfb9-4483-a745-406d008776fb'),
(116,	'HFD',	'Datacontrol',	'Hora Festiva Diurna',	104,	14,	'36cd1ba7-6abb-47e0-9966-589462d3e01f'),
(117,	'HFN',	'Datacontrol',	'Hora Festiva Nocturna',	105,	14,	'0bc8458a-bfb4-46ea-8697-8c4f2d03a731'),
(118,	'HED',	'Datacontrol',	'Hora extra diurna',	106,	14,	'e07d1389-ec72-43e7-bb64-920e49c2035a'),
(119,	'HEN',	'Datacontrol',	'Hora extra nocturna',	107,	14,	'6863e391-12ad-4aef-84a0-72aedc56b324'),
(120,	'HEDD',	'Datacontrol',	'Hora extra dominical diurna',	108,	14,	'add55fe6-4431-454e-be85-2a2c887fce76'),
(121,	'HEDN',	'Datacontrol',	'Hora extra dominical nocturna',	109,	14,	'231cbd1d-6bb4-472f-bd89-41f7a4d0a7b4'),
(122,	'HEFD',	'Datacontrol',	'Hora extra festiva diurna',	110,	14,	'6aa445df-48f1-4f17-8105-7c6cff1aaac6'),
(123,	'HEFN',	'Datacontrol',	'Hora extra festiva nocturna',	111,	14,	'4834a59a-e400-4aac-9493-cc7c5d25b7b6');	
	
DROP TRIGGER `consolidate_person_date`; -- 0.022 s

/*!40000 ALTER TABLE `ilg_hour_report` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `consolidate_person_date` BEFORE INSERT ON `ilg_hour_report`
 FOR EACH ROW BEGIN
	declare areaId bigint(20);
	declare areaName varchar(200);
	declare enterpriseId bigint(20);
	

	if NEW.worked_hours is null then
		SET NEW.worked_hours = 0;
	end if;	

	
	select c.id, c.name, c.enterprise_id into areaId, areaName, enterpriseId from ilg_person a inner join ilg_area_person b on b.person_id = a.id inner join ilg_area c on c.id = b.area_id where a.id = NEW.person_id;

	INSERT INTO  `ilg_hour_report_summary` (
		`person_id` ,
		`area_id` ,
		`area_name` ,
		`enterprise_id` ,
		`shiftName` ,
		`year_month` ,
		`worked_hours` 
		)
		VALUES (
			NEW.person_id,
			areaId,
			areaName,
			enterpriseId,
			NEW.shiftName,
			DATE_FORMAT(NEW.start_time, "%Y-%m-01 00:00:00"),
			NEW.worked_hours
		) ON DUPLICATE KEY UPDATE 
			worked_hours=worked_hours+NEW.worked_hours 	
			;    
	
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;


ALTER TABLE `ilg_hour_report_summary`
DROP `regular_hour`,
DROP `night_recharge`,
DROP `extra_hour_day`,
DROP `extra_hour_night`,
DROP `holiday_recharge`,
DROP `holiday_night_recharge`,
DROP `holiday_extra_hour_day`,
DROP `holiday_extra_hour_night`,
COMMENT=''; -- 2.757 s

ALTER TABLE `ilg_hour_report`
ADD `processed` char(1) NULL COMMENT '\'T\': Procesado por la regla. Otro: Not Processed',
COMMENT=''; -- 5.932 s


ALTER TABLE `ilg_hour_report`
CHANGE `calendar_id` `calendar_id` bigint(20) NULL COMMENT 'Intervalo de Turno' AFTER `shiftName`,
COMMENT=''; -- 5.508 s

ALTER TABLE `ilg_hour_concept`
DROP FOREIGN KEY `ilg_concept_ibfk_41`,
ADD FOREIGN KEY (`hour_report_id`) REFERENCES `ilg_hour_report` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

Update ilg_attendance at
LEFT JOIN ilg_hour_report hr ON at.hour_report_id = hr.id
SET at.hour_report_id = null
WHERE hr.id IS NULL
and at.hour_report_id > 0;


ALTER TABLE `ilg_attendance`
ADD INDEX `hour_report_id` (`hour_report_id`);
ALTER TABLE `ilg_attendance`
ADD FOREIGN KEY (`hour_report_id`) REFERENCES `ilg_hour_report` (`id`)  ON DELETE SET NULL ON UPDATE RESTRICT;


DROP TABLE IF EXISTS `ilg_branch_office`;
CREATE TABLE `ilg_branch_office` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_bo_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_bo_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_cost_center`;
CREATE TABLE `ilg_cost_center` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_cc_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_cc_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_position`;
CREATE TABLE `ilg_position` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_pos_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_pos_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

ALTER TABLE `ilg_person`
ADD `cost_center_id` bigint(20) NULL,
ADD `branch_office_id` bigint(20) NULL AFTER `cost_center_id`,
COMMENT=''; 

ALTER TABLE `ilg_person`
ADD `position_id` bigint(20) NULL,
COMMENT=''; -- 0.491 s


ALTER TABLE `ilg_person`
ADD INDEX `cost_center_id` (`cost_center_id`);
ALTER TABLE `ilg_person`
ADD FOREIGN KEY (`cost_center_id`) REFERENCES `ilg_cost_center` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `ilg_person`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_person`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `ilg_person`
ADD INDEX `position_id` (`position_id`);
ALTER TABLE `ilg_person`
ADD FOREIGN KEY (`position_id`) REFERENCES `ilg_position` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

------------------------------------

TRUNCATE TABLE `bi4cg_usergroups`;
INSERT INTO `bi4cg_usergroups` (`id`, `parent_id`, `lft`, `rgt`, `title`, `description`, `enterprise_id`) VALUES
(1,	0,	1,	30,	'Publico',	'',	0),
(2,	1,	8,	27,	'Registrado',	'',	0),
(3,	2,	9,	14,	'Autor',	'',	0),
(4,	3,	10,	13,	'Editor',	'',	0),
(5,	4,	11,	12,	'Publicador',	'',	0),
(6,	1,	2,	5,	'Gestor',	'',	0),
(7,	6,	3,	4,	'Administrador',	'',	0),
(8,	1,	28,	29,	'Super Usuarios',	'',	0),
(9,	1,	6,	7,	'Invitado',	'Invitado',	0),
(14,	2,	15,	26,	'Cliente CloudTime',	'Cliente CloudTime',	0),
(15,	14,	16,	17,	'Administrador Cloudtime',	'Administrador Cloudtime',	0),
(19,	14,	18,	19,	'Administrador Empresa',	'Administrador Empresa',	0),
(20,	14,	20,	21,	'Autorizador de Horas',	'Autorizador de Horas',	0),
(21,	14,	22,	23,	'Empleado',	'Empleado',	0),
(22,	14,	24,	25,	'Supervisor',	'Supervisor',	0);

TRUNCATE TABLE `bi4cg_viewlevels`;
INSERT INTO `bi4cg_viewlevels` (`id`, `title`, `description`, `ordering`, `rules`) VALUES
(1,	'Publico',	'Publico',	0,	'[8]'),
(2,	'Registrado',	'Registrado',	1,	'[8]'),
(3,	'Especial',	'Especial',	2,	'[8]'),
(4,	'assign-enterprise',	'Asignar Empresa',	2,	'[8,15]'),
(5,	'Invitado',	'Invitado',	0,	'[9]'),
(6,	'accesscontrol',	'Menu Usuarios',	2,	'[8,15]'),
(7,	'roles',	'Administrar Roles',	2,	'[8,15]'),
(8,	'ctc',	'Control de acceso',	2,	'[]'),
(9,	'dashboard',	'Menu Dashboard',	2,	'[8,15,19,22]'),
(10,	'area',	'Administrar Areas',	2,	'[15,8,19]'),
(11,	'empleados',	'Administrar Empleados',	2,	'[8,15,19,20]'),
(12,	'hours',	'Horas Trabajadas',	2,	'[8,15,19,20,22]'),
(13,	'dispositivos',	'Unidades Biométricas',	2,	'[8,15]'),
(14,	'arrivalreport',	'Reporte de Llegadas',	2,	'[15,8,19,20,22]'),
(15,	'report',	'Menu Reportes',	2,	'[8,15,19,20,22]'),
(16,	'departurereports',	'Reporte de Salidas',	2,	'[8,15,19,20,22]'),
(17,	'schedule',	'Administrar Turnos',	2,	'[8,15,19,20]'),
(18,	'users',	'Administrar Usuarios',	2,	'[8,15]'),
(19,	'payrollreports',	'Reporte de Nómina',	2,	'[8,15,19,20,22]'),
(21,	'enterprise',	'Administrar Empresas',	2,	'[8,15]'),
(22,	'Cliente CloudTime',	'Cliente CloudTime',	2,	'[8,15,19,20]'),
(23,	'Festivos',	'Administrar Festivos',	2,	'[8,15,19]'),
(24,	'Cargos',	'Administrar Cargos',	2,	'[8,15,19]'),
(25,	'Sucursales',	'Administrar Sucursales',	2,	'[8,15,19]'),
(26,	'Conceptos',	'Administrar Conceptos',	2,	'[8,15,19]'),
(27,	'Novedades',	'Administrar Novedades',	2,	'[8,15,19]'),
(28,	'Notificaciones',	'Administrar Notificaciones',	2,	'[8,15,19,21]'),
(29,	'Reprocesamiento',	'Reprocesamiento',	2,	'[8,15,19]'),
(30,	'costcenter',	'Centro de Costos',	2,	'[8,15,19]'),
(31,	'payrollreport',	'Reportes de Prenomina',	2,	'[8,15,19,20,22]'),
(32,	'attadmon',	'Gestión de Marcaciones',	2,	'[8,15,19,20]'),
(33,	'administracion',	'Menu Administracion',	2,	'[8,15,19,20]'),
(34,	'reporteAusencias',	'Reporte de Ausencias',	2,	'[8,15,19,20,22]'),
(35,	'reporteMarcaciones',	'Reporte de Marcaciones',	2,	'[8,15,19,20,22]'),
(36,	'reglas',	'Editar Reglas',	2,	'[8,15]');

TRUNCATE TABLE `bi4cg_usergroup_vl`;
INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(1,	8),
(2,	8),
(3,	8),
(4,	8),
(4,	15),
(5,	9),
(6,	8),
(6,	15),
(7,	8),
(7,	15),
(9,	8),
(9,	15),
(10,	15),
(10,	8),
(11,	8),
(11,	15),
(12,	8),
(12,	15),
(13,	8),
(13,	15),
(14,	15),
(14,	8),
(15,	8),
(15,	15),
(16,	8),
(16,	15),
(17,	8),
(17,	15),
(18,	8),
(18,	15),
(19,	8),
(19,	15),
(21,	8),
(21,	15),
(22,	8),
(22,	15),
(23,	8),
(23,	15),
(24,	8),
(24,	15),
(25,	8),
(25,	15),
(26,	8),
(26,	15),
(27,	8),
(27,	15),
(28,	8),
(28,	15),
(29,	8),
(29,	15),
(30,	8),
(30,	15),
(31,	8),
(31,	15),
(32,	8),
(32,	15),
(33,	8),
(33,	15),
(34,	8),
(34,	15),
(35,	8),
(35,	15),
(36,	8),
(36,	15),
(9,19),
(10,19),
(11,19),
(12,19),
(14,19),
(15,19),
(16,19),
(17,19),
(19,19),
(22,19),
(23,19),
(24,19),
(25,19),
(26,19),
(27,19),
(28,19),
(29,19),
(30,19),
(31,19),
(32,19),
(33,19),
(34,19),
(35,19),
(9,20),
(11,20),
(12,20),
(17,20),
(14,20),
(15,20),
(16,20),
(19,20),
(22,20),
(31,20),
(32,20),
(33,20),
(34,20),
(35,20),
(9,22),
(12,22),
(14,22),
(15,22),
(16,22),
(19,22),
(31,22),
(34,22),
(35,22);

INSERT INTO `bi4cg_menu` (`id`, `title`, `access`) VALUES
(184,	'Cargos',	24),
(183,	'Sucursales',	25),
(182,	'Centro de Costos',	30),
(181,	'Festivos',	23),
(180,	'Conceptos',	26),
(137,	'Resumen de Ausencias',	34),
(136,	'Reporte de Ausencias',	34),
(135,	'Diario de Ausencias',	34),
(134,	'Novedades',	27),
(133,	'Configuraciones',	21),
(132,	'Horas Trabajadas Por Estado',	31),
(131,	'Reprocesamiento',	29),
(130,	'Marcaciones',	35),
(129,	'Reglas',	36),
(128,	'Resumen de Marcaciones',	35),
(127,	'Reporte de Marcaciones',	35),
(126,	'Horas Trabajadas',	31),
(125,	'Prenómina por Fecha',	31),
(124,	'Diario Marcaciones',	9),
(123,	'Diario Areas',	9),
(122,	'Diario I',	9),
(120,	'Administración',	33),
(119,	'Notificaciones',	28),
(118,	'Reporte de Prenómina',	31),
(117,	'Usuarios',	18),
(116,	'Turnos',	17),
(115,	'Reporte de Salidas',	16),
(114,	'Reportes',	15),
(112,	'Reporte de Llegadas',	14),
(111,	'Unidades Biométricas',	13),
(110,	'Horas Trabajadas',	31),
(109,	'Empleados',	11),
(108,	'Areas',	10),
(107,	'Mensual',	9),
(106,	'Tablero de Control',	9),
(105,	'Roles',	7),
(104,	'Usuarios',	6),
(103,	'Empresas',	21),
(179,	'Contacto',	5),
(170,	'BIOPRW F20920',	5),
(169,	'G 400',	5),
(168,	'BIOPRW F 20870',	5),
(167,	'G150id',	5),
(166,	'BIOPRW F 20320',	5),
(157,	'Chat',	5),
(156,	'Soporte',	5),
(155,	'Periodo de Prueba',	5),
(154,	'Precios',	5),
(153,	'Ver Demo',	5),
(152,	'Pasos de Inicio ',	5),
(151,	'Portatiles',	5),
(150,	'Faciales',	5),
(149,	'Biométricos',	5),
(148,	'Preguntas Frecuentes',	5),
(147,	'Garantías',	5),
(146,	'Características',	5),
(145,	'Que es Cloud time',	5),
(144,	'Recursos',	5),
(143,	'Como Empezar',	5),
(142,	'Dispositivos de Control',	5),
(101,	'Inicio',	1) 
ON DUPLICATE KEY UPDATE  access=VALUES(access) ;


--------------------------------------

ALTER TABLE `ilg_concept`
ADD `require_authorization` char(1) COLLATE 'utf8_bin' NULL DEFAULT 'F' COMMENT 'Este concepto requiere autorización' AFTER `end_date`,
COMMENT=''; 

ALTER TABLE `ilg_hour_concept`
ADD `authorized` char(1) COLLATE 'utf8_bin' NULL DEFAULT 'F' COMMENT '\'T\' = Horas autorizadas' AFTER `hours`,
COMMENT=''; -- 0.414 s



ALTER TABLE `ilg_person`
ADD `area_id` bigint(20) NULL,
COMMENT=''; -- 0.144 s

ALTER TABLE `ilg_person`
ADD INDEX `area_id` (`area_id`);
ALTER TABLE `ilg_person`
ADD FOREIGN KEY (`area_id`) REFERENCES `ilg_area` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `target` varchar(200) NOT NULL,
  `t_class` varchar(200) DEFAULT NULL,
  `user_id` bigint(20)  NULL,
  `creation_date` datetime NOT NULL,
  `operation` char(1) NOT NULL,
  `extra` varchar(200) DEFAULT NULL,
  `before` longtext,
  `after` longtext,
  `person_id` bigint(20) NULL,
  `enterprise_id` bigint(20) NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `target` (`target`),
  KEY `creation_date` (`creation_date`),
  KEY `person_id` (`person_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_audit_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `bi4cg_users` (`id`),
  CONSTRAINT `ilg_audit_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  CONSTRAINT `ilg_audit_ibfk_5` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)  
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

-------------------------


ALTER TABLE `ilg_device`
ADD `auto_process` char(1) COLLATE 'utf8_general_ci' NULL DEFAULT 'F' COMMENT 'T: Procesar marcaciones automaticamente Otro:  No Procesar',
COMMENT=''; -- 0.639 s


--------------------------------------------------


DROP TABLE IF EXISTS `ilg_config_auto_period`;
CREATE TABLE `ilg_config_auto_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200)  NOT NULL,   
  `period_type` tinyint(4) NULL COMMENT 'EACH_DAY = 0,EACH_WEEK = 1,EACH_MONTH = 2, EACH_SPECIFIC_DAY =3',
  `specific_month_day` tinyint(4) NULL COMMENT '1-31',  
  `specific_week_day` varchar(50) NULL COMMENT 'MONDAY... ',
  `status_id` bigint(20) NOT NULL,
  `expiration_date` date NULL COMMENT 'NULL no expiration',
  `enterprise_id` bigint(20) NOT NULL,  
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `ilg_cap_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_cap_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_payroll_period`;
CREATE TABLE `ilg_payroll_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `initial_date` date NOT NULL,
  `end_date` date NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,  
  PRIMARY KEY (`id`),
  UNIQUE KEY `interval_started` (`initial_date`,`enterprise_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_prp_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_payroll_period_sum`;
CREATE TABLE `ilg_payroll_period_sum` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payroll_period_id` bigint(20) DEFAULT NULL,
  `hours_not_auth` int(10) NULL DEFAULT '0',  
  `hours_not_processed` int(10) NULL DEFAULT '0',  
  `worked_hours` decimal(10,2) NULL DEFAULT '0',  
  `att_not_processed` int(10) NULL DEFAULT '0', 
  `att_duplicated` int(10) NULL DEFAULT '0', 
  `att_automatic` int(10) NULL DEFAULT '0',
  `att_manual` int(10) NULL DEFAULT '0',
  `att_total` bigint(20) NOT NULL DEFAULT '0',
  `att_total_in` bigint(20) NOT NULL DEFAULT '0',
  `att_total_out` bigint(20) NOT NULL DEFAULT '0',
  `att_out_late` bigint(20) NOT NULL DEFAULT '0',
  `att_out_on_time` bigint(20) NOT NULL DEFAULT '0',
  `att_out_early` bigint(20) NOT NULL DEFAULT '0',
  `att_in_late` bigint(20) NOT NULL DEFAULT '0',
  `att_in_on_time` bigint(20) NOT NULL DEFAULT '0',
  `att_in_early` bigint(20) NOT NULL DEFAULT '0', 
  `area_id` bigint(20) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,  
  PRIMARY KEY (`id`),
  UNIQUE KEY `interval_started` (`payroll_period_id`,`area_id`,`enterprise_id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `area_id` (`area_id`),
  KEY `payroll_period_id` (`payroll_period_id`),
  CONSTRAINT `ilg_prps_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_prps_ibfk_4` FOREIGN KEY (`payroll_period_id`) REFERENCES `ilg_payroll_period` (`id`),
  CONSTRAINT `ilg_prps_ibfk_5` FOREIGN KEY (`area_id`) REFERENCES `ilg_area` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;



select prp.initial_date, prp.end_date,  count(*) as total,
SUM( case when at.valid != 'T' then 1 else 0 end ) as duplicated
 FROM ilg_payroll_period prp 
 INNER JOIN ilg_attendance at ON at.time >= prp.initial_date AND at.time <= prp.end_date and prp.enterprise_id = at.enterprise_id
 group by at.enterprise_id
 
 
select prp.id, per.area_id,
at.enterprise_id,
count(*) as total,
SUM( case when at.attendance_status_id = 0 then 1 else 0 end ) as total_in, 
SUM( case when at.attendance_status_id = 1 then 1 else 0 end ) as total_out, 
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde ,
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.processed != 'T' then 1 else 0 end ) as proccesed,
SUM( case when at.origin_type_id = 3 then 1 else 0 end ) as automatic, 
SUM( case when at.origin_type_id = 2 then 1 else 0 end ) as manual, 
SUM( case when at.valid != 'T' then 1 else 0 end ) as duplicated
from ilg_attendance at INNER JOIN ilg_payroll_period prp 
INNER JOIN ilg_person per ON per.id = at.person_id 	
where
at.time >= prp.initial_date AND at.time <= prp.end_date
and prp.enterprise_id = at.enterprise_id
group by at.enterprise_id, per.area_id, prp.initial_date

----at.time >= '2014-08-01' AND at.time <= '2014-08-31'

----  cloudtime regenerar resumenes 

ALTER TABLE  `ilg_hour_report` 
ADD INDEX `area_id` (`area_id`);

Update ilg_hour_report hr
INNER JOIN ilg_person p on hr.person_id = p.id
SET hr.area_id =  p.area_id;


ALTER TABLE  `ilg_hour_report` 
ADD FOREIGN KEY (`area_id`) REFERENCES `ilg_area` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

----  cloudtime periodo a att y hr

ALTER TABLE `ilg_attendance` 
ADD `payroll_period_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_attendance` 
ADD INDEX `payroll_period_id` (`payroll_period_id`);
ALTER TABLE `ilg_attendance` 
ADD FOREIGN KEY (`payroll_period_id`) REFERENCES `ilg_payroll_period` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

UPDATE ilg_attendance AT
SET at.payroll_period_id = (
	SELECT prp.id
	FROM ilg_payroll_period prp 
	WHERE prp.initial_date <= DATE(at.time) AND prp.end_date >= DATE(at.time) 
		AND prp.enterprise_id = at.enterprise_id
	LIMIT 1);


UPDATE ilg_attendance at
SET at.payroll_period_id = NULL;	
	
ALTER TABLE `ilg_hour_report` 
ADD `payroll_period_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_hour_report` 
ADD INDEX `payroll_period_id` (`payroll_period_id`);
ALTER TABLE `ilg_hour_report` 
ADD FOREIGN KEY (`payroll_period_id`) REFERENCES `ilg_payroll_period` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

UPDATE ilg_hour_report hr
SET hr.payroll_period_id = NULL;

ALTER TABLE `ilg_hour_concept` 
ADD `payroll_period_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_hour_concept` 
ADD INDEX `payroll_period_id` (`payroll_period_id`);
ALTER TABLE `ilg_hour_concept` 
ADD FOREIGN KEY (`payroll_period_id`) REFERENCES `ilg_payroll_period` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

UPDATE ilg_hour_concept hc
SET hc.payroll_period_id = NULL;

	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
select prp.id, per.area_id,
at.enterprise_id,
count(*) as total,
SUM( case when at.attendance_status_id = 0 then 1 else 0 end ) as total_in, 
SUM( case when at.attendance_status_id = 1 then 1 else 0 end ) as total_out, 
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde ,
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.processed != 'T' then 1 else 0 end ) as proccesed,
SUM( case when at.origin_type_id = 3 then 1 else 0 end ) as automatic, 
SUM( case when at.origin_type_id = 2 then 1 else 0 end ) as manual, 
SUM( case when at.valid != 'T' then 1 else 0 end ) as duplicated
from ilg_attendance at INNER JOIN ilg_payroll_period prp 
INNER JOIN ilg_person per ON per.id = at.person_id 	
where
DATE(at.time) >= prp.initial_date AND DATE(at.time) <= prp.end_date
and prp.enterprise_id = at.enterprise_id
group by at.enterprise_id, per.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			att_total=VALUES(att_total) ,
			`att_total_in` =VALUES(att_total_in),				
			`att_total_out`=VALUES(att_total_out),			
			`att_out_late`=VALUES(att_out_late),		
			`att_out_on_time`=VALUES(att_out_on_time),	
			`att_out_early`=VALUES(att_out_early),	
			`att_in_late`=VALUES(att_in_late),
			`att_in_on_time`=VALUES(att_in_on_time),	
			`att_in_early`=VALUES(att_in_early),
			`att_not_processed`=VALUES(att_not_processed),
			`att_automatic`=VALUES(att_automatic),
			`att_manual`=VALUES(att_manual),
			`att_duplicated`=VALUES(att_duplicated)
			; 

			
			
select prp.id, hr.area_id,
hr.enterprise_id,
SUM( case when hr.processed != 'T' then 1 else 0 end ) as notproccesed,
SUM( worked_hours ) as worked_hours
from ilg_hour_report hr INNER JOIN ilg_payroll_period prp 
where
(
    (
      DATE(hr.end_time) >= prp.initial_date 
      AND DATE(hr.end_time) <= prp.end_date
    ) 
    OR (
      hr.end_time IS NULL 
      AND DATE(hr.start_time) >= prp.initial_date 
      AND DATE(hr.start_time) <= prp.end_date
    )
) 
and prp.enterprise_id = hr.enterprise_id
group by hr.enterprise_id, hr.area_id, prp.initial_date;


		INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
select prp.id, hr.area_id,
hr.enterprise_id,
SUM( case when hr.processed != 'T' then 1 else 0 end ) as notproccesed,
SUM( worked_hours ) as worked_hours
from ilg_hour_report hr INNER JOIN ilg_payroll_period prp 
where
(
    (
      DATE(hr.end_time) >= prp.initial_date 
      AND DATE(hr.end_time) <= prp.end_date
    ) 
    OR (
      hr.end_time IS NULL 
      AND DATE(hr.start_time) >= prp.initial_date 
      AND DATE(hr.start_time) <= prp.end_date
    )
)
and prp.enterprise_id = hr.enterprise_id
group by hr.enterprise_id, hr.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =VALUES(hours_not_processed),
			worked_hours = VALUES(worked_hours)
			;    

			
select prp.id, per.area_id,
hc.enterprise_id,
SUM( case when hc.authorized != 'T' then 1 else 0 end ) as notauthorized
from ilg_hour_concept hc 
INNER JOIN ilg_hour_report hr ON hr.id = hc.hour_report_id 	
INNER JOIN ilg_person per ON per.id = hc.person_id 	
INNER JOIN ilg_payroll_period prp 
where
(
    (
      DATE(hr.end_time) >= prp.initial_date 
      AND DATE(hr.end_time) <= prp.end_date
    ) 
    OR (
      hr.end_time IS NULL 
      AND DATE(hr.start_time) >= prp.initial_date 
      AND DATE(hr.start_time) <= prp.end_date
    )
)
and prp.enterprise_id = hc.enterprise_id
group by hc.enterprise_id, per.area_id, prp.initial_date



	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
select prp.id, per.area_id,
ac.enterprise_id,
SUM( case when ac.authorized != 'T' then 1 else 0 end ) as notauthorized
from ilg_hour_concept hc
INNER JOIN ilg_hour_report hr ON hr.id = hc.hour_report_id 	
INNER JOIN ilg_person per ON per.id = hc.person_id 	
INNER JOIN ilg_payroll_period prp 
where
(
    (
      DATE(hr.end_time) >= prp.initial_date 
      AND DATE(hr.end_time) <= prp.end_date
    ) 
    OR (
      hr.end_time IS NULL 
      AND DATE(hr.start_time) >= prp.initial_date 
      AND DATE(hr.start_time) <= prp.end_date
    )
)
and prp.enterprise_id = hc.enterprise_id
group by ac.enterprise_id, per.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			`hours_not_auth` = VALUES(hours_not_auth)
			;    			



TRIGGER `consolidate_payroll` BEFORE INSERT ON `ilg_attendance` FOR EACH ROW
consolidate_payroll:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_automatic INT DEFAULT 0; 
	DECLARE n_manual INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) 
		AND enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	
	if NEW.person_id IS NULL then 
		LEAVE consolidate_payroll;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE consolidate_payroll;
	end if;	
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;

	if NEW.attendance_status_id = 0 then 		
		SET n_total_in = 1;
		if NEW.attendance_type_id = 0 then  			
			SET n_in_on_time = 1;
		elseif NEW.attendance_type_id = 1 then			
			SET n_in_early = 1;
		elseif NEW.attendance_type_id = 2 then		
			SET n_in_late = 1;
		end if;			
	else		
		SET n_total_out = 1;
		if NEW.attendance_type_id = 0 then 			
			SET n_out_on_time = 1;
		elseif NEW.attendance_type_id = 1 then 			
			SET n_out_early = 1;
		elseif NEW.attendance_type_id = 2 then			
			SET n_out_late = 1;
		end if;			
	end if;	
	
	if NEW.origin_type_id = 2 then 
		SET n_manual = 1;
	elseif NEW.origin_type_id = 3 then
		SET n_automatic = 1;
	end if;

	if NEW.valid = 'F' or NEW.valid IS NULL  then 
		SET n_duplicated = 1;
	end if;		
	
	if NEW.processed = 'F' or NEW.processed IS NULL  then 
		SET n_not_processed = 1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_automatic,
			n_manual,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			att_total=att_total+1 ,
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_automatic`=att_automatic+n_automatic,
			`att_manual`=att_manual+n_manual,
			`att_duplicated`=att_duplicated+n_duplicated
			;    
END



TRIGGER `att_modified_after_update` AFTER UPDATE ON `ilg_attendance` FOR EACH ROW
att_modified_after_update:
  BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	if NEW.person_id IS NULL then 
		LEAVE att_modified_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE att_modified_after_update;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;

	IF NEW.attendance_status_id <> OLD.attendance_status_id THEN
		if OLD.attendance_status_id = 0 then
			SET n_total_in = -1;
			SET n_total_out = 1;
		else
			SET n_total_in = 1;
			SET n_total_out = -1;
		end if;
		if OLD.attendance_status_id = 0 then  			
			if OLD.attendance_type_id = 0 then  			
				SET n_in_on_time = -1;				
			ELSEIF OLD.attendance_type_id = 1 then 			
				SET n_in_early = -1;				
			ELSEIF OLD.attendance_type_id = 2 then 				
				SET n_in_late = -1;
			end if;			
		else				
			if OLD.attendance_type_id = 0 then 				
				SET n_out_on_time = -1;
			ELSEIF OLD.attendance_type_id = 1 then 				
				SET n_out_early = -1;
			ELSEIF OLD.attendance_type_id = 2 then				
				SET n_out_late = -1;
			end if;			
		end if;
		if NEW.attendance_status_id = 0 then  		
			if NEW.attendance_type_id = 0 then  			
				SET n_in_on_time = 1;			
			ELSEIF NEW.attendance_type_id = 1 then 		
				SET n_in_early = 1;			
			ELSEIF NEW.attendance_type_id = 2 then 			
				SET n_in_late = 1;
			end if;			
		else		
			if NEW.attendance_type_id = 0 then 			
				SET n_out_on_time = 1;
			ELSEIF NEW.attendance_type_id = 1 then 			
				SET n_out_early = 1;
			ELSEIF NEW.attendance_type_id = 2 then			
				SET n_out_late = 1;
			end if;			
		end if;	
	ELSEIF NEW.attendance_type_id <> OLD.attendance_type_id THEN  	
		if OLD.attendance_status_id = 0 then  			
			if OLD.attendance_type_id = 0 then  
				SET n_in_on_time = -1;				
			ELSEIF OLD.attendance_type_id = 1 then 		
				SET n_in_early = -1;				
			ELSEIF OLD.attendance_type_id = 2 then 				
				SET n_in_late = -1;
			end if;			
		else				
			if OLD.attendance_type_id = 0 then 				
				SET n_out_on_time = -1;
			ELSEIF OLD.attendance_type_id = 1 then 				
				SET n_out_early = -1;
			ELSEIF OLD.attendance_type_id = 2 then				
				SET n_out_late = -1;
			end if;			
		end if;
		if NEW.attendance_status_id = 0 then  		
			if NEW.attendance_type_id = 0 then  			
				SET n_in_on_time = 1;			
			ELSEIF NEW.attendance_type_id = 1 then 		
				SET n_in_early = 1;			
			ELSEIF NEW.attendance_type_id = 2 then 			
				SET n_in_late = 1;
			end if;			
		else		
			if NEW.attendance_type_id = 0 then 			
				SET n_out_on_time = 1;
			ELSEIF NEW.attendance_type_id = 1 then 			
				SET n_out_early = 1;
			ELSEIF NEW.attendance_type_id = 2 then			
				SET n_out_late = 1;
			end if;			
		end if;	
	end if;	

	
	
	IF NEW.processed <> OLD.processed  then
		if OLD.processed = 'F' or OLD.processed IS NULL  then 
			SET n_not_processed = -1;
		end if;
		if NEW.processed = 'F' or NEW.processed IS NULL  then 
			SET n_not_processed = 1;
		end if;	
	end if;	
	IF NEW.valid <> OLD.valid  then
		if OLD.valid = 'F' or OLD.valid IS NULL  then 
			SET n_duplicated = -1;
		end if;
		if NEW.valid = 'F' or NEW.valid IS NULL  then 
			SET n_duplicated = 1;
		end if;	
	end if;
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_duplicated`=att_duplicated+n_duplicated
			;    
END

  
TRIGGER `att_modified_after_delete` AFTER DELETE ON `ilg_attendance` FOR EACH ROW 
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_automatic INT DEFAULT 0; 
	DECLARE n_manual INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= OLD.time && prp.end_date >= OLD.time
	limit 1;
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = OLD.person_id limit 1;

	if OLD.attendance_status_id = 0 then 		
		SET n_total_in = -1;
		if OLD.attendance_type_id = 0 then  			
			SET n_in_on_time = -1;
		elseif OLD.attendance_type_id = 1 then			
			SET n_in_early = -1;
		elseif OLD.attendance_type_id = 2 then		
			SET n_in_late = -1;
		end if;			
	else		
		SET n_total_out = -1;
		if OLD.attendance_type_id = 0 then 			
			SET n_out_on_time = -1;
		elseif OLD.attendance_type_id = 1 then 			
			SET n_out_early = -1;
		elseif OLD.attendance_type_id = 2 then			
			SET n_out_late = 1;
		end if;			
	end if;	
	
	if OLD.origin_type_id = 2 then 
		SET n_manual = -1;
	elseif OLD.origin_type_id = 3 then
		SET n_automatic = -1;
	end if;

	if OLD.valid = 'F' or OLD.valid IS NULL  then 
		SET n_duplicated = -1;
	end if;		
	
	if OLD.processed = 'F' or OLD.processed IS NULL  then 
		SET n_not_processed = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			OLD.enterprise_id,
			0,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_automatic,
			n_manual,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			att_total=att_total-1 ,
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_automatic`=att_automatic+n_automatic,
			`att_manual`=att_manual+n_manual,
			`att_duplicated`=att_duplicated+n_duplicated
			;    

	
  END 	


TRIGGER `hr_after_insert` BEFORE INSERT ON `ilg_hour_report` FOR EACH ROW
hr_after_insert:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;	

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where
	(
		(
		  DATE(NEW.end_time) >= prp.initial_date 
		  AND DATE(NEW.end_time) <= prp.end_date
		) 
		OR (
		  NEW.end_time IS NULL 
		  AND DATE(NEW.start_time) >= prp.initial_date 
		  AND DATE(NEW.start_time) <= prp.end_date
		)
	)
	AND enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	
	if NEW.person_id IS NULL then 
		LEAVE hr_after_insert;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_insert;
	end if;	

	if NEW.processed = 'F' or NEW.processed IS NULL  then 
		SET n_hours_not_processed = 1;
	end if;	

	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			NEW.area_id,  
			NEW.enterprise_id,
			`n_hours_not_processed`,
			NEW.worked_hours
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours + NEW.worked_hours
			;    

END

TRIGGER `hr_after_update` BEFORE UPDATE ON `ilg_hour_report` FOR EACH ROW
hr_after_update:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;
  
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where 
	(
		(
		  DATE(NEW.end_time) >= prp.initial_date 
		  AND DATE(NEW.end_time) <= prp.end_date
		) 
		OR (
		  NEW.end_time IS NULL 
		  AND DATE(NEW.start_time) >= prp.initial_date 
		  AND DATE(NEW.start_time) <= prp.end_date
		)
	)	
	AND enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	if NEW.person_id IS NULL then 
		LEAVE hr_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_update;
	end if;	
	
	IF NEW.processed <> OLD.processed  then
		if OLD.processed = 'F' or OLD.processed IS NULL  then 
			SET n_hours_not_processed = -1;
		end if;
		if NEW.processed = 'F' or NEW.processed IS NULL  then 
			SET n_hours_not_processed = 1;
		end if;	
	end if;	

	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			NEW.area_id,  
			NEW.enterprise_id,
			`n_hours_not_processed`,
			NEW.worked_hours
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours + NEW.worked_hours - OLD.worked_hours
			;	   
	
END

  
TRIGGER `hr_after_delete` AFTER DELETE ON `ilg_hour_report` FOR EACH ROW
hr_after_delete:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;

	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where 
	(
		(
		  DATE(OLD.end_time) >= prp.initial_date 
		  AND DATE(OLD.end_time) <= prp.end_date
		) 
		OR (
		  OLD.end_time IS NULL 
		  AND DATE(OLD.start_time) >= prp.initial_date 
		  AND DATE(OLD.start_time) <= prp.end_date
		)
	)
	AND enterprise_id = OLD.enterprise_id
	limit 1;
	
	if OLD.person_id IS NULL then 
		LEAVE hr_after_delete;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_delete;
	end if;	
	
	if OLD.processed = 'F' or OLD.processed IS NULL  then 
		SET n_hours_not_processed = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			OLD.area_id,  
			OLD.enterprise_id,
			`n_hours_not_processed`,
			0
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours - OLD.worked_hours
			;	
END
  

TRIGGER `hc_after_insert` BEFORE INSERT ON `ilg_hour_concept` FOR EACH ROW
hc_after_insert:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;


	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	INNER JOIN ilg_hour_report hr ON hr.id = NEW.hour_report_id 	
	where
	(
		(
		  DATE(hr.end_time) >= prp.initial_date 
		  AND DATE(hr.end_time) <= prp.end_date
		) 
		OR (
		  hr.end_time IS NULL 
		  AND DATE(hr.start_time) >= prp.initial_date 
		  AND DATE(hr.start_time) <= prp.end_date
		)
	)	
	AND prp.enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	if NEW.person_id IS NULL then 
		LEAVE hc_after_insert;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_insert;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;
	
	if NEW.authorized = 'F' or NEW.authorized IS NULL  then 
		SET n_hours_not_auth = 1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;    
	
END

TRIGGER `hc_after_update` BEFORE UPDATE ON `ilg_hour_concept` FOR EACH ROW
hc_after_update:  
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	INNER JOIN ilg_hour_report hr ON hr.id = NEW.hour_report_id 	
	where
	(
		(
		  DATE(hr.end_time) >= prp.initial_date 
		  AND DATE(hr.end_time) <= prp.end_date
		) 
		OR (
		  hr.end_time IS NULL 
		  AND DATE(hr.start_time) >= prp.initial_date 
		  AND DATE(hr.start_time) <= prp.end_date
		)
	)	
	AND prp.enterprise_id = NEW.enterprise_id
	limit 1;
	SET NEW.payroll_period_id = payrollPeriodId;
	if NEW.person_id IS NULL then 
		LEAVE hc_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_update;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;
	
	IF NEW.authorized <> OLD.authorized  then
		if OLD.authorized = 'F' or OLD.authorized IS NULL  then 
			SET n_hours_not_auth = -1;
		end if;
		if NEW.authorized = 'F' or NEW.authorized IS NULL  then 
			SET n_hours_not_auth = 1;
		end if;	
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;	
	
END

  
TRIGGER `hc_after_delete` AFTER DELETE ON `ilg_hour_concept` FOR EACH ROW
hc_after_delete:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;
  
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	INNER JOIN ilg_hour_report hr ON hr.id = OLD.hour_report_id 	
	where
	(
		(
		  DATE(hr.end_time) >= prp.initial_date 
		  AND DATE(hr.end_time) <= prp.end_date
		) 
		OR (
		  hr.end_time IS NULL 
		  AND DATE(hr.start_time) >= prp.initial_date 
		  AND DATE(hr.start_time) <= prp.end_date
		)
	)	
	AND prp.enterprise_id = OLD.enterprise_id
	limit 1;
	
	if OLD.person_id IS NULL then 
		LEAVE hc_after_delete;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_delete;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = OLD.person_id limit 1;
	
	if OLD.authorized = 'F' or OLD.authorized IS NULL  then 
		SET n_hours_not_auth = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			OLD.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;	
END



ALTER TABLE `ilg_attendance`
ADD `elapsedHours` decimal(10,2) NULL AFTER `attendance_type_id`,
COMMENT='';

---------------------------------   

ALTER TABLE `ilg_attendance`
ADD `device_att_status_id` bigint(20) NULL AFTER `attendance_status_id`,
COMMENT=''; 

update  `ilg_attendance`
set device_att_status_id = attendance_status_id;

-------------------------------------------------  TIMECONTROL  CONTRACT_TYPE

DROP TABLE IF EXISTS `ilg_contract_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ilg_contract_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_contract_type_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_contract_type_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

ALTER TABLE `ilg_person`
ADD `contract_type_id` bigint(20) NULL,
COMMENT=''; -- 0.491 s
ALTER TABLE `ilg_person`
ADD INDEX `contract_type_id` (`contract_type_id`);
ALTER TABLE `ilg_person`
ADD FOREIGN KEY (`contract_type_id`) REFERENCES `ilg_contract_type` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


--------------------------------  Cloudtime  Novedades

ALTER TABLE `ilg_payroll_notice`
ADD `range_type` tinyint(4) NULL,
COMMENT='';

ALTER TABLE `ilg_payroll_notice`
ADD `aux1` varchar(30) NULL,
ADD `aux2` varchar(30) NULL AFTER `aux1`,
ADD `aux3` varchar(30) NULL AFTER `aux2`,
COMMENT='';

update  `ilg_payroll_notice`
set aux1 = start_time,  aux2 = end_time;

ALTER TABLE `ilg_payroll_notice`
ADD `paid` char(1) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';


------------------------------------  CLOUDVOICE

ALTER TABLE `segment`
ADD `voiceprint_id` int(11) NULL,
COMMENT=''; 

ALTER TABLE `segment`
ADD INDEX `voiceprint_id` (`voiceprint_id`);
ALTER TABLE `segment`
ADD FOREIGN KEY (`voiceprint_id`) REFERENCES `voiceprint` (`id`); 

ALTER TABLE `voiceprint`
ADD `total` int(11) NULL,
COMMENT=''; 
ALTER TABLE `voiceprint`
ADD `accepted` int(11) NULL,
COMMENT=''; 
ALTER TABLE `voiceprint`
ADD `rejected` int(11) NULL,
COMMENT=''; 
ALTER TABLE `voiceprint`
ADD `un_speaker` int(11) NULL,
COMMENT=''; 
ALTER TABLE `voiceprint`
ADD `un_spoof` int(11) NULL,
COMMENT=''; 


DROP TABLE IF EXISTS `verification`;
CREATE TABLE `verification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `speaker_id` int(11) NULL,
  `name` varchar(200) NULL,
  `speech` float NULL,  
  `saturation` float NULL,  
  `ratio` float NULL,  
  `snr` float NULL,  
  `sid` float NULL,  
  `ivr` float NULL,  
  `lql` float NULL,  
  `mql` float NULL,  
  PRIMARY KEY (`id`),
  KEY `speaker_id` (`speaker_id`),
  CONSTRAINT `verif_ibfk_4` FOREIGN KEY (`speaker_id`) REFERENCES `speaker` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;


ALTER TABLE `verification`
ADD `outcome` enum('ACCEPTED', 'REJECTED', 'UNDECIDED_SPEAKER_ID', 'UNDECIDED_SPOOF_DETECTED') NULL AFTER `snr`,
COMMENT='';
 

ALTER TABLE `phrase`
ADD `channels_ivr_percent` tinyint(4) NOT NULL AFTER `enrollments`,
ADD `channels_ivr_valid` tinyint(4) NOT NULL AFTER `channels_ivr_percent`,
ADD `channels_ivr_can_recalibrate` tinyint(4) NOT NULL AFTER `channels_ivr_valid`,
ADD `channels_mobile_percent` tinyint(4) NOT NULL AFTER `channels_ivr_can_recalibrate`,
ADD `channels_mobile_can_recalibrate` tinyint(4) NOT NULL AFTER `channels_mobile_percent`,
ADD `channels_mobile_valid` tinyint(4) NOT NULL AFTER `channels_mobile_can_recalibrate`,
ADD `qualities_enrollment_net_speech` int NOT NULL AFTER `channels_mobile_valid`,
ADD `qualities_verification_net_speech` int NOT NULL AFTER `qualities_enrollment_net_speech`,
DROP `file_url`,
COMMENT='';

ALTER TABLE `phrase`
CHANGE `configuration_id` `configuration_id` bigint(20) NULL AFTER `identification`,
CHANGE `language` `language` varchar(255) COLLATE 'utf8_unicode_ci' NULL AFTER `configuration_id`,
CHANGE `channels_ivr_percent` `channels_ivr_percent` tinyint(4) NULL AFTER `enrollments`,
CHANGE `channels_ivr_valid` `channels_ivr_valid` tinyint(4) NULL AFTER `channels_ivr_percent`,
CHANGE `channels_ivr_can_recalibrate` `channels_ivr_can_recalibrate` tinyint(4) NULL AFTER `channels_ivr_valid`,
CHANGE `channels_mobile_percent` `channels_mobile_percent` tinyint(4) NULL AFTER `channels_ivr_can_recalibrate`,
CHANGE `channels_mobile_can_recalibrate` `channels_mobile_can_recalibrate` tinyint(4) NULL AFTER `channels_mobile_percent`,
CHANGE `channels_mobile_valid` `channels_mobile_valid` tinyint(4) NULL AFTER `channels_mobile_can_recalibrate`,
CHANGE `qualities_enrollment_net_speech` `qualities_enrollment_net_speech` int(11) NULL AFTER `channels_mobile_valid`,
CHANGE `qualities_verification_net_speech` `qualities_verification_net_speech` int(11) NULL AFTER `qualities_enrollment_net_speech`,
CHANGE `creation_date` `creation_date` datetime NULL AFTER `qualities_verification_net_speech`,
COMMENT='';

------------------------------  trasactiontype

CREATE TABLE `transaction_type` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `description` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8;

INSERT INTO  `transaction_type` (
`id` ,
`name` ,
`description` 
)
VALUES (0,  'Enrolamiento',  ''),
 ('1',  'Verificación',  ''),
 ('2',  'Segmento',  ''),
 ('3',  'Desenrolamiento',  ''),
 ('4',  'Está Entrenado?',  '');

ALTER TABLE `transaction`
ADD INDEX `type` (`type`);
ALTER TABLE `transaction`
ADD FOREIGN KEY (`type`) REFERENCES `transaction_type` (`id`); 

SELECT COUNT(*) as amount, tt.name FROM transaction t
INNER JOIN transaction_type as tt
ON tt.id = t.type 
where 1=1  
group by t.type


--------------------------------------------
ALTER TABLE `voiceprint`
CHANGE `file_url` `phrase_id` bigint(20) NOT NULL AFTER `speaker_id`,
COMMENT=''; -- 0.478 s

UPDATE `voiceprint` SET
`phrase_id` = '1';

ALTER TABLE `voiceprint`
ADD INDEX `phrase_id` (`phrase_id`);
ALTER TABLE `voiceprint`
ADD FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`); 

ALTER TABLE `segment`
ADD `creation_date` datetime NOT NULL AFTER `name`,
COMMENT=''; -- 0.288 s

update 
 `segment`  set creation_date = '2014-07-20 00:00:00'
WHERE `creation_date` = '0000-00-00 00:00:00'

ALTER TABLE `speaker`
ADD `creation_date` datetime NOT NULL AFTER `last_name`,
COMMENT=''; -- 0.243 s

update 
 `speaker`  set creation_date = '2014-07-20 00:00:00'
WHERE `creation_date` = '0000-00-00 00:00:00'

ALTER TABLE `speaker`
ADD `configuration_id` bigint(20) NOT NULL AFTER `last_name`,
COMMENT=''; -- 0.250 s

UPDATE `speaker` SET
`configuration_id` = '1';

ALTER TABLE `speaker`
ADD INDEX `configuration_id` (`configuration_id`);
ALTER TABLE `speaker`
ADD FOREIGN KEY (`configuration_id`) REFERENCES `configuration` (`id`); 


ALTER TABLE `segment`
ADD `phrase_id` bigint(20) NOT NULL AFTER `speaker_id`,
COMMENT=''; 

UPDATE `segment` SET
`phrase_id` = '1';

ALTER TABLE `segment`
ADD INDEX `phrase_id` (`phrase_id`);
ALTER TABLE `segment`
ADD FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`); 

ALTER TABLE `segment`
ADD `status_id` bigint(20) NOT NULL DEFAULT '1',
COMMENT='';

ALTER TABLE `segment`
ADD INDEX `status_id` (`status_id`);
ALTER TABLE `segment`
ADD FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`); 

ALTER TABLE `voiceprint`
ADD `status_id` bigint(20) NOT NULL DEFAULT '1',
COMMENT='';

ALTER TABLE `voiceprint`
ADD INDEX `status_id` (`status_id`);
ALTER TABLE `voiceprint`
ADD FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

ALTER TABLE `phrase`
ADD `identification` varchar(300) COLLATE 'utf8_general_ci' NOT NULL AFTER `description`,
COMMENT='';

UPDATE `phrase` SET
`identification` = name;

UPDATE `phrase` SET
`name` = 'VOICE KEY'
WHERE `id` = '1'

UPDATE `segment` SET
`file_url` = 'http://localhost/tmp/verify_01.wav'
WHERE `file_url` is null;

janus123=9a892e93f00143390a478910062d0199:2vRJq6u0MTQV0D9vYiB2mxSsrGpusQR9


ALTER TABLE `transaction`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE `transaction`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`); 

SELECT  DATE(creation_date) as cdate ,
SUM( case when tx.outcome = "NONE" then 1 else 0 end ) as NONE, 
SUM( case when tx.outcome = "ACCEPTED" then 1 else 0 end ) as ACCEPTED,
SUM( case when tx.outcome = "REJECTED" then 1 else 0 end ) as REJECTED, 
SUM( case when tx.outcome = "UNDECIDED_SPEAKER_ID" then 1 else 0 end ) as UNDECIDED_SPEAKER_ID, 
SUM( case when tx.outcome = "UNDECIDED_SPOOF_DETECTED" then 1 else 0 end ) as UNDECIDED_SPOOF_DETECTED
FROM transaction tx
WHERE enterprise_id = 2
AND type = 1
GROUP BY DATE(creation_date) 
ORDER BY creation_date DESC

------------------------------------  configuration phrase
ALTER TABLE `phrase`
DROP FOREIGN KEY `phrase_ibfk_11`;

ALTER TABLE `phrase`
DROP `configuration_id`,
COMMENT=''; 

ALTER TABLE `configuration`
ADD `phrase_id` bigint(20) NOT NULL AFTER `id`,
COMMENT=''; -- 0.250 s

UPDATE `configuration` SET
`phrase_id` = '1';

ALTER TABLE `configuration`
ADD INDEX `phrase_id` (`phrase_id`);
ALTER TABLE `configuration`
ADD FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`); 


-------------------------------------   dispositivos y fingerprint

ALTER TABLE `ilg_device`
CHANGE `TransTimes` `TransTimes` varchar(50) COLLATE 'utf8_general_ci' NULL DEFAULT '00:00;14:05' COMMENT 'Indicates the time (time: minute in a 24-hour format) to regularly check and transfer data. A semicolon is used to separate a maximum amount of ten time settings' AFTER `LastActivity`,
CHANGE `TransInterval` `TransInterval` int(11) NULL DEFAULT '2' COMMENT 'Indicates the interval (unit: minute) during which new data is checked and transferred' AFTER `TransTimes`,
ADD `error_delay` varchar(25) COLLATE 'utf8_general_ci' NULL DEFAULT '60' COMMENT 'Indicates the interval (unit: second) between attempts to reconnect to the server after a network connection failure occurs.',
ADD `delay` varchar(25) COLLATE 'utf8_general_ci' NULL DEFAULT '30' COMMENT 'Indicates the interval (unit: second) between attempts to connect to the server in the event of proper network connection.' AFTER `error_delay`,
ADD `realtime` varchar(25) COLLATE 'utf8_general_ci' NULL DEFAULT '1' COMMENT 'Indicates whether to realtime transfer new records. When Realtime=1, new data, if any, is transferred to the server. When Realtime=0, the data is transferred at the time specified by TransTimes and TransInterval.' AFTER `delay`,
ADD `encrypt` varchar(25) COLLATE 'utf8_general_ci' NULL DEFAULT '0' COMMENT 'Indicates whether to encrypt the transferred data (ZKSoftware-specified encryption algorithm is used for encrypted transfers)' AFTER `realtime`,
COMMENT='';


ALTER TABLE `ilg_fingerprint`
ADD `enterprise_id` bigint(20) NOT NULL AFTER `id`,
COMMENT='';

Update ilg_fingerprint fp
INNER JOIN ilg_person as p
    ON p.id = fp.person_id
SET fp.enterprise_id =  p.enterprise_id;

Update ilg_fingerprint fp
SET fp.enterprise_id =  2
where fp.enterprise_id = 0;

ALTER TABLE `ilg_fingerprint`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE `ilg_fingerprint`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`);

ALTER TABLE `ilg_fingerprint`
ADD INDEX `person_id` (`person_id`);

select *
from ilg_fingerprint fp
LEFT OUTER JOIN ilg_person as p ON p.id = fp.person_id
where p.id is null;

delete fp from ilg_fingerprint fp
LEFT OUTER JOIN ilg_person as p ON p.id = fp.person_id
where p.id is null;

ALTER TABLE `ilg_fingerprint`
ADD FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`);

ALTER TABLE `ilg_fingerprint`
ADD INDEX `device_id` (`device_id`);

select *
from ilg_fingerprint fp
LEFT OUTER JOIN ilg_device as p ON p.id = fp.device_id
where p.id is null;

delete fp from ilg_fingerprint fp
LEFT OUTER JOIN ilg_device as p ON p.id = fp.device_id
where p.id is null;


ALTER TABLE `ilg_fingerprint`
ADD FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`);

--------- voiceprint no phrase
ALTER TABLE `voiceprint`
DROP FOREIGN KEY `voiceprint_ibfk_2`;

ALTER TABLE `voiceprint`
DROP INDEX `phrase_id`;

Update voiceprint vp
INNER JOIN configuration as c ON c.phrase_id = vp.phrase_id
SET vp.phrase_id =  c.id;

ALTER TABLE `voiceprint`
CHANGE `phrase_id` `configuration_id` bigint(20) NOT NULL AFTER `speaker_id`,
COMMENT='';

ALTER TABLE `voiceprint`
ADD INDEX `configuration_id` (`configuration_id`);
ALTER TABLE `voiceprint`
ADD FOREIGN KEY (`configuration_id`) REFERENCES `configuration` (`id`); 

ALTER TABLE `speaker`
DROP FOREIGN KEY `speaker_ibfk_1`;

ALTER TABLE `speaker`
DROP INDEX `configuration_id`;

ALTER TABLE `speaker`
DROP `configuration_id`,
COMMENT='';


select s.* from segment s inner join voiceprint v on s.voiceprint_id = v.id
where v.phrase_id = 1;

--------- voiceprint no configuration
ALTER TABLE `voiceprint`
DROP FOREIGN KEY `voiceprint_ibfk_4`;

ALTER TABLE `voiceprint`
DROP INDEX `configuration_id`;

Update voiceprint vp
INNER JOIN configuration as c ON c.id = vp.configuration_id
SET vp.configuration_id =  c.phrase_id;

ALTER TABLE `voiceprint`
CHANGE `configuration_id` `phrase_id` bigint(20) NOT NULL AFTER `speaker_id`,
COMMENT='';

ALTER TABLE `voiceprint`
ADD INDEX `phrase_id` (`phrase_id`);
ALTER TABLE `voiceprint`
ADD FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`); 

---------------- phrase status_id


ALTER TABLE `phrase`
ADD `status_id` bigint(20) NOT NULL DEFAULT '1',
COMMENT='';

ALTER TABLE `phrase`
ADD INDEX `status_id` (`status_id`);
ALTER TABLE `phrase`
ADD FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

--------------------------------    asignar turnos


DROP TABLE IF EXISTS `ilg_person_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ilg_person_schedule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `initial_date` date NOT NULL,
  `person_id` bigint(20) NOT NULL,
  `schedule_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `schedule_id` (`schedule_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_person_schedule_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  CONSTRAINT `ilg_person_schedule_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `ilg_schedule` (`id`),
  CONSTRAINT `ilg_person_schedule_ibfk_3` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

-- cambio fw Ronald

ALTER TABLE `audit`
ADD `person_id` bigint(20) NULL,
ADD `enterprise_id` bigint(20) NULL AFTER `person_id`,
COMMENT='';


`--------------------------------cloudtime admin
DELETE
FROM `ilg_device_cmd`
WHERE `CmdContent` = 'INFO' OR `CmdContent` = 'CHECK'

-------------- cloudtime area tree

ALTER TABLE `ilg_area`
ADD `lft` smallint(5) NULL,
ADD `rgt` smallint(5) NULL AFTER `lft`,
COMMENT='';

UPDATE `ilg_area` SET
`lft` = '0',
`rgt` = '1'
WHERE `name` = 'Sin Asignar';

UPDATE `ilg_enterprise` SET
`status_id` = '1'
WHERE `id` = '39';

ALTER TABLE `ilg_enterprise`
ADD UNIQUE `name` (`name`);

-----  cloudvoice clear

DELETE audit FROM audit;
TRUNCATE TABLE `area`;
TRUNCATE TABLE `segment`;
TRUNCATE TABLE `transaction`;
TRUNCATE TABLE `log`;
TRUNCATE TABLE `verification`;
DELETE FROM `voiceprint`;
DELETE FROM `speaker`;
delete bi4cg_users from bi4cg_users where id not in (676,709,711,712);
delete bi4cg_user_usergroup_map from bi4cg_user_usergroup_map where user_id  not in (676,709,711,712);
truncate table trans_result_summary;
delete configuration from configuration  where id  not in (1);
delete phrase from phrase  where id  not in (1);

delete ilg_enterprise from ilg_enterprise  where id >= 3;
delete phrase_enterprise from phrase_enterprise where phrase_id >= 12 || enterprise_id >= 3;
--delete bi4cg_usergroups from bi4cg_usergroups  where id >= 23;
--delete bi4cg_usergroup_vl from bi4cg_usergroup_vl  where id >= 23;

-------------- cloudtime attphotos

ALTER TABLE `ilg_attendance`
ADD `photo` varchar(255) COLLATE 'utf8_general_ci' NULL COMMENT 'Photo file path',
COMMENT=''; 

ALTER TABLE `ilg_attendance`
CHANGE `person_id` `person_id` bigint(20) NULL AFTER `device_id`,
COMMENT=''; 

ALTER TABLE `ilg_config`
ADD `photo_path` varchar(500) COLLATE 'latin1_swedish_ci' NULL COMMENT 'path for saving photos' AFTER `sms_ws_url`,
COMMENT=''; 

INSERT INTO `ilg_verification_mode` (`id`, `name`, `description`)
VALUES ('52', 'PHOTO', 'Identification by photo'); 



---------  problemas triggers

DELETE FROM `ilg_payroll_period_sum` WHERE payroll_period_id IS NULL;

ALTER TABLE `ilg_payroll_period_sum`
CHANGE `payroll_period_id` `payroll_period_id` bigint(20) NOT NULL AFTER `id`,
COMMENT='';

consolidate_payroll:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_automatic INT DEFAULT 0; 
	DECLARE n_manual INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE consolidate_payroll;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE consolidate_payroll;
	end if;	
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;

	if NEW.attendance_status_id = 0 then 		
		SET n_total_in = 1;
		if NEW.attendance_type_id = 0 then  			
			SET n_in_on_time = 1;
		elseif NEW.attendance_type_id = 1 then			
			SET n_in_early = 1;
		elseif NEW.attendance_type_id = 2 then		
			SET n_in_late = 1;
		end if;			
	else		
		SET n_total_out = 1;
		if NEW.attendance_type_id = 0 then 			
			SET n_out_on_time = 1;
		elseif NEW.attendance_type_id = 1 then 			
			SET n_out_early = 1;
		elseif NEW.attendance_type_id = 2 then			
			SET n_out_late = 1;
		end if;			
	end if;	
	
	if NEW.origin_type_id = 2 then 
		SET n_manual = 1;
	elseif NEW.origin_type_id = 3 then
		SET n_automatic = 1;
	end if;

	if NEW.valid = 'F' or NEW.valid IS NULL  then 
		SET n_duplicated = 1;
	end if;		
	
	if NEW.processed = 'F' or NEW.processed IS NULL  then 
		SET n_not_processed = 1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			1,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_automatic,
			n_manual,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			att_total=att_total+1 ,
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_automatic`=att_automatic+n_automatic,
			`att_manual`=att_manual+n_manual,
			`att_duplicated`=att_duplicated+n_duplicated
			;    

	
  END


  att_modified_after_update:
  BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE att_modified_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE att_modified_after_update;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;

	IF NEW.attendance_status_id <> OLD.attendance_status_id THEN
		if OLD.attendance_status_id = 0 then
			SET n_total_in = -1;
			SET n_total_out = 1;
		else
			SET n_total_in = 1;
			SET n_total_out = -1;
		end if;
		if OLD.attendance_status_id = 0 then  			
			if OLD.attendance_type_id = 0 then  			
				SET n_in_on_time = -1;				
			ELSEIF OLD.attendance_type_id = 1 then 			
				SET n_in_early = -1;				
			ELSEIF OLD.attendance_type_id = 2 then 				
				SET n_in_late = -1;
			end if;			
		else				
			if OLD.attendance_type_id = 0 then 				
				SET n_out_on_time = -1;
			ELSEIF OLD.attendance_type_id = 1 then 				
				SET n_out_early = -1;
			ELSEIF OLD.attendance_type_id = 2 then				
				SET n_out_late = -1;
			end if;			
		end if;
		if NEW.attendance_status_id = 0 then  		
			if NEW.attendance_type_id = 0 then  			
				SET n_in_on_time = 1;			
			ELSEIF NEW.attendance_type_id = 1 then 		
				SET n_in_early = 1;			
			ELSEIF NEW.attendance_type_id = 2 then 			
				SET n_in_late = 1;
			end if;			
		else		
			if NEW.attendance_type_id = 0 then 			
				SET n_out_on_time = 1;
			ELSEIF NEW.attendance_type_id = 1 then 			
				SET n_out_early = 1;
			ELSEIF NEW.attendance_type_id = 2 then			
				SET n_out_late = 1;
			end if;			
		end if;	
	ELSEIF NEW.attendance_type_id <> OLD.attendance_type_id THEN  	
		if OLD.attendance_status_id = 0 then  			
			if OLD.attendance_type_id = 0 then  
				SET n_in_on_time = -1;				
			ELSEIF OLD.attendance_type_id = 1 then 		
				SET n_in_early = -1;				
			ELSEIF OLD.attendance_type_id = 2 then 				
				SET n_in_late = -1;
			end if;			
		else				
			if OLD.attendance_type_id = 0 then 				
				SET n_out_on_time = -1;
			ELSEIF OLD.attendance_type_id = 1 then 				
				SET n_out_early = -1;
			ELSEIF OLD.attendance_type_id = 2 then				
				SET n_out_late = -1;
			end if;			
		end if;
		if NEW.attendance_status_id = 0 then  		
			if NEW.attendance_type_id = 0 then  			
				SET n_in_on_time = 1;			
			ELSEIF NEW.attendance_type_id = 1 then 		
				SET n_in_early = 1;			
			ELSEIF NEW.attendance_type_id = 2 then 			
				SET n_in_late = 1;
			end if;			
		else		
			if NEW.attendance_type_id = 0 then 			
				SET n_out_on_time = 1;
			ELSEIF NEW.attendance_type_id = 1 then 			
				SET n_out_early = 1;
			ELSEIF NEW.attendance_type_id = 2 then			
				SET n_out_late = 1;
			end if;			
		end if;	
	end if;	

	
	
	IF NEW.processed <> OLD.processed  then
		if OLD.processed = 'F' or OLD.processed IS NULL  then 
			SET n_not_processed = -1;
		end if;
		if NEW.processed = 'F' or NEW.processed IS NULL  then 
			SET n_not_processed = 1;
		end if;	
	end if;	
	IF NEW.valid <> OLD.valid  then
		if OLD.valid = 'F' or OLD.valid IS NULL  then 
			SET n_duplicated = -1;
		end if;
		if NEW.valid = 'F' or NEW.valid IS NULL  then 
			SET n_duplicated = 1;
		end if;	
	end if;
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_duplicated`=att_duplicated+n_duplicated
			;    
	
  END
  
  att_modified_after_delete:
  BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_total_in INT DEFAULT 0; 
	DECLARE n_total_out INT DEFAULT 0; 
	DECLARE n_out_late INT DEFAULT 0; 
	DECLARE n_out_on_time INT DEFAULT 0; 
	DECLARE n_out_early INT DEFAULT 0; 
	DECLARE n_in_late INT DEFAULT 0; 
	DECLARE n_in_on_time INT DEFAULT 0; 
	DECLARE n_in_early INT DEFAULT 0; 
	DECLARE n_not_processed INT DEFAULT 0; 
	DECLARE n_automatic INT DEFAULT 0; 
	DECLARE n_manual INT DEFAULT 0; 
	DECLARE n_duplicated INT DEFAULT 0; 
	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(OLD.time) AND prp.end_date >= DATE(OLD.time) AND enterprise_id = OLD.enterprise_id
	limit 1;
	
	if OLD.person_id IS NULL then 
		LEAVE att_modified_after_delete;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE att_modified_after_delete;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = OLD.person_id limit 1;

	if OLD.attendance_status_id = 0 then 		
		SET n_total_in = -1;
		if OLD.attendance_type_id = 0 then  			
			SET n_in_on_time = -1;
		elseif OLD.attendance_type_id = 1 then			
			SET n_in_early = -1;
		elseif OLD.attendance_type_id = 2 then		
			SET n_in_late = -1;
		end if;			
	else		
		SET n_total_out = -1;
		if OLD.attendance_type_id = 0 then 			
			SET n_out_on_time = -1;
		elseif OLD.attendance_type_id = 1 then 			
			SET n_out_early = -1;
		elseif OLD.attendance_type_id = 2 then			
			SET n_out_late = 1;
		end if;			
	end if;	
	
	if OLD.origin_type_id = 2 then 
		SET n_manual = -1;
	elseif OLD.origin_type_id = 3 then
		SET n_automatic = -1;
	end if;

	if OLD.valid = 'F' or OLD.valid IS NULL  then 
		SET n_duplicated = -1;
	end if;		
	
	if OLD.processed = 'F' or OLD.processed IS NULL  then 
		SET n_not_processed = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			OLD.enterprise_id,
			0,
			`n_total_in` ,				
			`n_total_out` ,				
			`n_out_late` 	,			
			`n_out_on_time` ,			
			`n_out_early` 	,			
			`n_in_late` 	,			
			`n_in_on_time` 	,			
			`n_in_early`,
			n_not_processed,
			n_automatic,
			n_manual,
			n_duplicated
		) ON DUPLICATE KEY UPDATE 
			att_total=att_total-1 ,
			`att_total_in` =att_total_in+n_total_in,				
			`att_total_out`=att_total_out+n_total_out,			
			`att_out_late`=att_out_late+n_out_late,		
			`att_out_on_time`=att_out_on_time+n_out_on_time,	
			`att_out_early`=att_out_early+n_out_early,	
			`att_in_late`=att_in_late+n_in_late,
			`att_in_on_time`=att_in_on_time+n_in_on_time,	
			`att_in_early`=att_in_early+n_in_early,
			`att_not_processed`=att_not_processed+n_not_processed,
			`att_automatic`=att_automatic+n_automatic,
			`att_manual`=att_manual+n_manual,
			`att_duplicated`=att_duplicated+n_duplicated
			;    

	
  END
  
hr_after_insert:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;	

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.start_time) AND prp.end_date >= DATE(NEW.start_time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE hr_after_insert;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_insert;
	end if;	

	if NEW.processed = 'F' or NEW.processed IS NULL  then 
		SET n_hours_not_processed = 1;
	end if;	

	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			NEW.area_id,  
			NEW.enterprise_id,
			`n_hours_not_processed`,
			NEW.worked_hours
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours + NEW.worked_hours
			;    

END

hr_after_update:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;
  
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.start_time) AND prp.end_date >= DATE(NEW.start_time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE hr_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_update;
	end if;	
	
	IF NEW.processed <> OLD.processed  then
		if OLD.processed = 'F' or OLD.processed IS NULL  then 
			SET n_hours_not_processed = -1;
		end if;
		if NEW.processed = 'F' or NEW.processed IS NULL  then 
			SET n_hours_not_processed = 1;
		end if;	
	end if;	

	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			NEW.area_id,  
			NEW.enterprise_id,
			`n_hours_not_processed`,
			NEW.worked_hours
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours + NEW.worked_hours - OLD.worked_hours
			;	   
	
END

hr_after_delete:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_processed INT DEFAULT 0;

	
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(OLD.start_time) AND prp.end_date >= DATE(OLD.start_time) AND enterprise_id = OLD.enterprise_id
	limit 1;
	
	if OLD.person_id IS NULL then 
		LEAVE hr_after_delete;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hr_after_delete;
	end if;	
	
	if OLD.processed = 'F' or OLD.processed IS NULL  then 
		SET n_hours_not_processed = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
		VALUES (
			payrollPeriodId,  
			OLD.area_id,  
			OLD.enterprise_id,
			`n_hours_not_processed`,
			0
		) ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =hours_not_processed+n_hours_not_processed,
			worked_hours = worked_hours - OLD.worked_hours
			;	
END

hc_after_insert:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;


	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.start_time) AND prp.end_date >= DATE(NEW.start_time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE hc_after_insert;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_insert;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;
	
	if NEW.authorized = 'F' or NEW.authorized IS NULL  then 
		SET n_hours_not_auth = 1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;    
	
END
  
  
hc_after_update:  
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;

	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(NEW.start_time) AND prp.end_date >= DATE(NEW.start_time) AND enterprise_id = NEW.enterprise_id
	limit 1;
	
	if NEW.person_id IS NULL then 
		LEAVE hc_after_update;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_update;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = NEW.person_id limit 1;
	
	IF NEW.authorized <> OLD.authorized  then
		if OLD.authorized = 'F' or OLD.authorized IS NULL  then 
			SET n_hours_not_auth = -1;
		end if;
		if NEW.authorized = 'F' or NEW.authorized IS NULL  then 
			SET n_hours_not_auth = 1;
		end if;	
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			NEW.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;	
	
END  
 
hc_after_delete:
BEGIN
	DECLARE areaId bigint(20);
	DECLARE payrollPeriodId bigint(20);
	DECLARE n_hours_not_auth INT DEFAULT 0;

  
	select prp.id into payrollPeriodId
	from ilg_payroll_period prp 
	where prp.initial_date <= DATE(OLD.start_time) AND prp.end_date >= DATE(OLD.start_time) AND enterprise_id = OLD.enterprise_id
	limit 1;
	
	if OLD.person_id IS NULL then 
		LEAVE hc_after_delete;
	end if;	
	
	if payrollPeriodId IS NULL then 
		LEAVE hc_after_delete;
	end if;		
	
	select pe.area_id into areaId 
	from ilg_person pe
	where pe.id = OLD.person_id limit 1;
	
	if OLD.authorized = 'F' or OLD.authorized IS NULL  then 
		SET n_hours_not_auth = -1;
	end if;	
	
	INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
		VALUES (
			payrollPeriodId,  
			areaId,  
			OLD.enterprise_id,
			`n_hours_not_auth`
		) ON DUPLICATE KEY UPDATE 
			`hours_not_auth` =hours_not_auth+n_hours_not_auth
			;	
END

---------------  quala

DROP TABLE IF EXISTS `ilg_contract_detail`;
DROP TABLE IF EXISTS `ilg_contract`;
CREATE TABLE `ilg_contract_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_contract_det_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_contract_det_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ilg_contract` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL COMMENT 'who own this contract',
  `status_id` bigint(20) NOT NULL,
  `started_date` date NOT NULL,
  `expected_end_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `contract_detail_id` bigint(20) DEFAULT NULL,
  `contract_type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `person_id` (`person_id`),
  KEY `contract_detail_id` (`contract_detail_id`),
  KEY `contract_type_id` (`contract_type_id`),
  CONSTRAINT `ilg_contract_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_contract_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_contract_ibfk_3` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`),
  CONSTRAINT `ilg_contract_ibfk_4` FOREIGN KEY (`contract_detail_id`) REFERENCES `ilg_contract_detail` (`id`),
  CONSTRAINT `ilg_contract_ibfk_5` FOREIGN KEY (`contract_type_id`) REFERENCES `ilg_contract_type` (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `ilg_process_file`;
CREATE TABLE `ilg_process_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_url` varchar(200) DEFAULT NULL COMMENT 'URL del Archivo',
  `type` varchar(50) DEFAULT NULL COMMENT 'Tipo de Archivo  0=person 1=payrollnotice',
  `result` varchar(2000) DEFAULT NULL COMMENT 'Resultado Procesamiento' ,
  `processed_date` datetime NOT NULL COMMENT 'Processed datetime' ,
  `errors` varchar(2000) DEFAULT NULL COMMENT 'Reporte de Errores en el Procesamiento' ,
  `total_register` int(10) NULL DEFAULT '0' COMMENT 'Registros totales', 
  `inserts_processed` int(10) NULL DEFAULT '0' COMMENT 'Inserts realizados',   
  `updates_processed` int(10) NULL DEFAULT '0' COMMENT 'Updates realizados',
  `enterprise_id` bigint(20) NOT NULL,
  `result_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=NotProcessed, 1=OK,  2=FINISH WITH ERRORS 3=FAIL ',
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_processfile_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO ilg_contract (person_id, status_id, contract_type_id,enterprise_id,started_date) 
SELECT DISTINCT id, 1, contract_type_id,enterprise_id,start_date FROM ilg_person p

INSERT INTO ilg_contract (person_id, status_id, contract_type_id,enterprise_id,started_date) 
SELECT DISTINCT id, 1, 11,enterprise_id,start_date FROM ilg_person p
where p.enterprise_id = 39 and p.id not in ( Select cnt.person_id from ilg_contract cnt );

ALTER TABLE `ilg_person`
DROP FOREIGN KEY `ilg_person_ibfk_12`;

ALTER TABLE `ilg_person`
DROP INDEX `contract_type_id`;

ALTER TABLE `ilg_person`
DROP `contract_type_id`,
COMMENT='';

SELECT person_id, sum(hours) as worked_hours, 
SUM(case when name = 'HO' then hours else 0 end ) as HO,
SUM(case when name = 'RN' then hours else 0 end ) as RN,
SUM(case when name = 'HDD' then hours else 0 end ) as HDD,
SUM(case when name = 'HDN' then hours else 0 end ) as HDN,
SUM(case when name = 'HFD' then hours else 0 end ) as HFD,
SUM(case when name = 'HFN' then hours else 0 end ) as HFN,
SUM(case when name = 'HED' then hours else 0 end ) as HED,
SUM(case when name = 'HEN' then hours else 0 end ) as HEN,
SUM(case when name = 'HEDD' then hours else 0 end ) as HEDD,
SUM(case when name = 'HEDN' then hours else 0 end ) as HEDN,
SUM(case when name = 'HEFD' then hours else 0 end ) as HEFD,
SUM(case when name = 'HEFN' then hours else 0 end ) as HEFN,
 sum(manuales) as manuales 
from (  
		SELECT hr.start_time,
			hr.person_id,
			c.name,
			sum(hours) as hours,
			0 as manuales  
		FROM ilg_hour_concept hc  
		INNER JOIN ilg_hour_report hr ON hc.hour_report_id = hr.id  
		INNER JOIN ilg_person p ON hr.person_id = p.id  
		INNER JOIN ilg_contract ct ON ct.person_id = p.id  
		INNER JOIN ilg_concept c ON hc.concept_id = c.id  
		WHERE hr.enterprise_id = 18  
		and p.status_id = 1
		and ct.status_id = 1
		and ct.contract_type_id = '2'
		and DATE(hr.start_time) BETWEEN '2014-09-01' AND '2014-09-30'     
		and DATE(hr.start_time) >=  ct.started_date 
		GROUP BY hr.person_id,concept_id  
	union  
		select hri.start_time, 
			hri.person_id, 
			'Manuales' as name, 
			0, 
			SUM( case when hri.origin_type_id = 2 then 1 else 0 end )  
		FROM ilg_hour_report hri  where hri.enterprise_id = 18  
		and hri.start_time BETWEEN '2014-09-01' AND '2014-09-30'    
		GROUP BY hri.person_id 
) 
as tot GROUP BY person_id ORDER BY DATE_FORMAT(start_time,'%Y-%m') desc


SELECT person_id, sum(hours) as worked_hours, 
SUM(case when name = 'HO' then hours else 0 end ) as HO,
SUM(case when name = 'RN' then hours else 0 end ) as RN,
SUM(case when name = 'HDD' then hours else 0 end ) as HDD,
SUM(case when name = 'HDN' then hours else 0 end ) as HDN,
SUM(case when name = 'HFD' then hours else 0 end ) as HFD,
SUM(case when name = 'HFN' then hours else 0 end ) as HFN,
SUM(case when name = 'HED' then hours else 0 end ) as HED,
SUM(case when name = 'HEN' then hours else 0 end ) as HEN,
SUM(case when name = 'HEDD' then hours else 0 end ) as HEDD,
SUM(case when name = 'HEDN' then hours else 0 end ) as HEDN,
SUM(case when name = 'HEFD' then hours else 0 end ) as HEFD,
SUM(case when name = 'HEFN' then hours else 0 end ) as HEFN 
from (  
	SELECT hr.start_time, 
		hr.person_id, c.name, 
		sum(hours) as hours, 
		0 as manuales  
		FROM ilg_hour_concept hc  
		INNER JOIN ilg_hour_report hr ON hc.hour_report_id = hr.id  
		INNER JOIN ilg_person p ON hr.person_id = p.id  
		INNER JOIN ilg_concept c ON hc.concept_id = c.id  
		INNER JOIN ilg_contract ct ON ct.person_id = p.id  
		WHERE hr.enterprise_id = 18  
		and p.status_id = 1 
		and p.area_id = 1 
		and p.cost_center_id = 1 
		and p.branch_office_id = 1 
		and ct.status_id = 1     
		and DATE(hr.start_time) BETWEEN '2014-09-01' AND '2014-09-30'      
		and ct.contract_type_id = '2' 
		and DATE(hr.start_time) >= ct.started_date  
		GROUP BY hr.person_id,concept_id  
) as tot 
GROUP BY person_id ORDER BY DATE_FORMAT(start_time,'%Y-%m') desc

Update ilg_person p
INNER JOIN ilg_contract as c ON c.person_id = p.id
SET p.start_date =  c.started_date
where p.enterprise_id = 39 and c.status_id = 1;

-- personas que no tienen dispositivo
INSERT INTO ilg_device_person ( device_id, person_id ) 
select distinct 41,p.id from ilg_person p where p.enterprise_id = 39 and  p.id not in ( Select dp.person_id from ilg_device_person dp )

select count(*) from ilg_person p inner join ilg_device_person dp on p.id = dp.person_id
where p.enterprise_id = 39

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.111.173.92', '10.179.189.182')

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix,  '10.184.182.140','10.179.189.182');

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix,  '10.184.182.140','10.171.46.51');

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.179.189.182', 'cloudtimecontroltest.com');

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.179.189.182', '127.0.0.1');

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.0.0.141', '127.0.0.1');

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.184.182.140', 'cloudtimecontrol.com');
  
  ALTER TABLE `ilg_concept`
ADD `code` varchar(50) COLLATE 'utf8_bin' NULL AFTER `description`,
COMMENT=''; 

UPDATE ilg_config
SET rule_server_url_prefix = REPLACE(rule_server_url_prefix, '10.111.173.92', '10.179.189.182')



ALTER TABLE `ilg_rule`
ADD `username` varchar(50) COLLATE 'utf8_general_ci' NULL AFTER `version`,
ADD `password` varchar(50) COLLATE 'utf8_general_ci' NULL AFTER `username`,
COMMENT='';

ALTER TABLE `ilg_config`
ADD `pay_extras_after` int(10) NULL COMMENT '-1= Despues de intervalo de turno.  >0 Cantidad de horas ',
COMMENT=''; 

ALTER TABLE `ilg_payroll_notice_type`
ADD `code` varchar(100) COLLATE 'utf8_bin' NULL AFTER `description`,
COMMENT='';

ALTER TABLE `ilg_calendar_time`
DROP INDEX `name`;


DELETE FROM `ilg_device_cmd`
WHERE `device_id` = '41' AND ( `CmdContent` = 'INFO' OR   `CmdContent` = 'CHECK' );


ALTER TABLE `ilg_schedule`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';

ALTER TABLE `ilg_contract_type`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';

ALTER TABLE `ilg_position`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';

ALTER TABLE `ilg_branch_office`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';

ALTER TABLE `ilg_cost_center`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `description`,
COMMENT='';



------------ Reporte Prenomina

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(49,	8),
(49,	15),
(49,	19),
(49,	20);


----  cloudtime numero de huellas

ALTER TABLE `ilg_device`
ADD `numAtts` int(11) NULL DEFAULT '0' AFTER `TransInterval`,
ADD `numFPs` int(11) NULL DEFAULT '0' AFTER `numAtts`,
ADD `numUsers` int(11) NULL DEFAULT '0' AFTER `numFPs`,
ADD `numDevAtts` int(11) NULL DEFAULT '0' AFTER `TransInterval`,
ADD `numDevFPs` int(11) NULL DEFAULT '0' AFTER `numAtts`,
ADD `numDevUsers` int(11) NULL DEFAULT '0' AFTER `numFPs`,
COMMENT='';

DROP TABLE IF EXISTS `ilg_device_fingerprint`;
CREATE TABLE `ilg_device_fingerprint` (
  `device_id` bigint(20) NOT NULL,
  `fingerprint_id` bigint(20) NOT NULL,
  PRIMARY KEY (`fingerprint_id`,`device_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `ilg_device_fingerprint_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`),
  CONSTRAINT `ilg_device_fingerprint_ibfk_2` FOREIGN KEY (`fingerprint_id`) REFERENCES `ilg_fingerprint` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO ilg_device_fingerprint ( device_id, fingerprint_id ) 
select distinct f.device_id, f.id from ilg_fingerprint f;

ALTER TABLE `ilg_fingerprint`
DROP FOREIGN KEY `ilg_fingerprint_ibfk_3`;

ALTER TABLE `ilg_fingerprint`
DROP INDEX `device_id`;

ALTER TABLE `ilg_fingerprint`
DROP `device_id`,
COMMENT='';

update ilg_device d 
set numAtts = 
    (SELECT count(*) as numAtts
        FROM ilg_attendance at
        WHERE at.device_id = d.id );
update ilg_device d 		
set numDevAtts = 
    (SELECT count(*) as numDevAtts
        FROM ilg_attendance at
        WHERE at.device_id = d.id );
update ilg_device d 		
set numFPs = 
    (SELECT count(*) as numFPs
        FROM ilg_device_fingerprint df
        WHERE df.device_id = d.id );
update ilg_device d 		
set numDevFPs = 
    (SELECT count(*) as numDevFPs
        FROM ilg_device_fingerprint df
        WHERE df.device_id = d.id );
update ilg_device d 		
set numUsers = 
    (SELECT count(*) as numUsers
        FROM ilg_device_person dp
        WHERE dp.device_id = d.id );
update ilg_device d 		
set numDevUsers = 
    (SELECT count(*) as numDevUsers
        FROM ilg_device_person dp
        WHERE dp.device_id = d.id );
		
	
------   cloudtime festivo en calendario

ALTER TABLE `ilg_calendar_time`
ADD `holiday` char(1) COLLATE 'utf8_general_ci' NULL AFTER `sunday`,
COMMENT='';

ALTER TABLE `ilg_payroll_notice_type`
ADD `status_id` bigint(20) NOT NULL DEFAULT '1',
COMMENT='';

ALTER TABLE `ilg_payroll_notice_type`
ADD INDEX `status_id` (`status_id`);
ALTER TABLE `ilg_payroll_notice_type`
ADD FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`);

INSERT INTO ilg_contract (person_id, status_id, contract_type_id,enterprise_id,started_date) 
SELECT DISTINCT id, 1, 11,enterprise_id,start_date FROM ilg_person p
where p.enterprise_id = 39 and p.id not in ( Select cnt.person_id from ilg_contract cnt )
ON DUPLICATE KEY UPDATE enterprise_id=VALUES(enterprise_id) ,  start_date=VALUES(start_date) ;


------  payrollnoticetype workcode
ALTER TABLE `ilg_payroll_notice_type`
ADD `workcode` smallint(3) NULL AFTER `code`,
COMMENT='';

------  arreglar que solo inserte que no tengan contrato activo

INSERT INTO ilg_contract (person_id, status_id, contract_type_id,enterprise_id,started_date) 
SELECT DISTINCT id, 1, 11,enterprise_id,start_date FROM ilg_person p
ON DUPLICATE KEY UPDATE enterprise_id=VALUES(enterprise_id) , start_date=VALUES(start_date);



------------  cloudtime jerarquia empresa y sucursal

DROP TABLE IF EXISTS `ilg_user_enterprise`;
CREATE TABLE `ilg_user_enterprise` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`enterprise_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ilg_ue_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bi4cg_users` (`id`),
  CONSTRAINT `ilg_ue_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)    
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_user_branchoff`;
CREATE TABLE `ilg_user_branchoff` (
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__users.id',
  `branch_office_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`branch_office_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `ilg_ubo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bi4cg_users` (`id`),
  CONSTRAINT `ilg_ubo_ibfk_2` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ilg_user_enterprise ( user_id, enterprise_id ) 
select distinct p.id, p.enterprise_id from bi4cg_users p ;


UPDATE `bi4cg_usergroups` SET
`enterprise_id` = '0';

UPDATE `bi4cg_usergroups` SET
`enterprise_id` = '1'
WHERE `id` in ( 1,2,3,4,5,6,7,8,9,14,15 );

--- TODO hacer esto mismo en la creación de la empresa
INSERT INTO ilg_branch_office ( name, description, code, status_id, enterprise_id ) 
select distinct 'No Asignado','Renombrar esta sucursal.','',1,e.id from ilg_enterprise e where e.id not in ( Select dp.enterprise_id from ilg_branch_office dp );

INSERT INTO ilg_user_branchoff ( user_id, branch_office_id ) 
select distinct p.id, bo.id from bi4cg_users p 
inner join ilg_branch_office bo on p.enterprise_id = bo.enterprise_id ;


ALTER TABLE `audit`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `audit`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `audit`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `bi4cg_usergroups`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `bi4cg_usergroups`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `bi4cg_usergroups`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


--ALTER TABLE `bi4cg_users`
--ADD `branch_office_id` bigint(20) DEFAULT NULL,
--COMMENT=''; 
--ALTER TABLE `bi4cg_users`
--ADD INDEX `branch_office_id` (`branch_office_id`);
--ALTER TABLE `bi4cg_users`
--ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_area`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_area`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_area`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_area_category`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_area_category`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_area_category`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_attendance`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_attendance`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_attendance`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_calendar`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_calendar`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_calendar`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_calendar_date`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_calendar_date`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_calendar_date`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_calendar_time`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_calendar_time`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_calendar_time`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `ilg_config_auto_period`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_config_auto_period`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_config_auto_period`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_contract`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_contract`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_contract`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_contract_detail`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_contract_detail`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_contract_detail`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_contract_type`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_contract_type`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_contract_type`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_cost_center`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_cost_center`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_cost_center`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_date_type`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_date_type`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_date_type`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_device`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_device`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_device`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_device_data` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_device_data` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_device_data` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_doc_type`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_doc_type`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_doc_type`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_fingerprint`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_fingerprint`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_fingerprint`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_hour_concept`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_hour_concept`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_hour_concept`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_hour_report` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_hour_report` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_hour_report` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_hour_report_summary`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_hour_report_summary`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_hour_report_summary`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_interval_attendance`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_interval_attendance`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_interval_attendance`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_notification`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_notification`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_notification`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_payroll_notice`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_payroll_notice`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_payroll_notice`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_payroll_notice_type`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_payroll_notice_type`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_payroll_notice_type`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_payroll_period`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_payroll_period`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_payroll_period`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_payroll_period_sum`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_payroll_period_sum`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_payroll_period_sum`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_personal_inside`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_personal_inside`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_personal_inside`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_person_schedule` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_person_schedule` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_person_schedule` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_position` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_position` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_position` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_process_file`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_process_file`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_process_file`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_pto`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_pto`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_pto`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_pto_report`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_pto_report`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_pto_report`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE `ilg_rule_asset`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_rule_asset`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_rule_asset`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_schedule` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_schedule` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_schedule` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_table_modified`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_table_modified`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_table_modified`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_task_category`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_task_category`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_task_category`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_task_type` 
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_task_type` 
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_task_type` 
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


ALTER TABLE  `ilg_time_report`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `ilg_time_report`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE  `ilg_time_report`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 



Update audit au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );

Update bi4cg_usergroups au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
--Update bi4cg_users au
--SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_area au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_area_category au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_attendance au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_calendar au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_calendar_date au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_calendar_time au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
--Update ilg_concept au
--SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
--Update ilg_config au
--SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_config_auto_period au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_contract au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_contract_detail au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_contract_type au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_cost_center au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_date_type au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_device au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_device_data au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_doc_type au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_fingerprint au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_hour_concept au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_hour_report au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_hour_report_summary au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_interval_attendance au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_notification au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_payroll_notice au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_payroll_notice_type au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_payroll_period au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_payroll_period_sum au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_personal_inside au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_person_schedule au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_position au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_process_file au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_pto au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_pto_report au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_rule_asset au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_schedule au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_table_modified au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_task_category au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_task_type au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );
Update ilg_time_report au
SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );

ALTER TABLE `ilg_enterprise`
ADD `lft` smallint(5) NULL,
ADD `rgt` smallint(5) NULL AFTER `lft`,
COMMENT='';

UPDATE `ilg_enterprise` SET
`parent_enterprise_id` = '2'
WHERE ( `id` != '2' );

UPDATE `ilg_enterprise` SET
`lft` = '0',
`rgt` = '1'
WHERE `id` = '2';

ALTER TABLE `ilg_branch_office`
ADD `lft` smallint(5) NULL,
ADD `rgt` smallint(5) NULL AFTER `lft`,
COMMENT='';

ALTER TABLE `ilg_branch_office`
ADD `parent_branch_office_id` bigint(20) NULL,
COMMENT=''; -- 0.491 s
ALTER TABLE `ilg_branch_office`
ADD INDEX `parent_branch_office_id` (`parent_branch_office_id`);
ALTER TABLE `ilg_branch_office`
ADD FOREIGN KEY (`parent_branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


--UPDATE `bi4cg_viewlevels` SET`id` = '50',`title` = 'assign-branch',`description` = 'Asignar Sucursal',`ordering` = '2',`rules` = '[15,19,8]'WHERE `id` = '50';

INSERT INTO `bi4cg_viewlevels`  VALUES
('61','assign-branch', 'Asignar Sucursal','2', '[15,19,8]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('61', '15'),('61', '19'),('61', '8');

UPDATE `bi4cg_usergroups` SET
`id` = '19',
`parent_id` = '14',
`lft` = '18',
`rgt` = '19',
`title` = 'Administrador Empresa',
`description` = 'Administrador Empresa',
`enterprise_id` = '0',
`branch_office_id` = NULL
WHERE `id` = '19';

UPDATE `ilg_payroll_notice_type` SET
`enterprise_id` = '2'
WHERE `enterprise_id` IS NULL;

UPDATE `ilg_payroll_notice_type` SET
`code` = '0001'
WHERE `id` = '2';

UPDATE `ilg_payroll_notice_type` SET
`code` = '0002'
WHERE `id` = '3';

SELECT *
FROM `ilg_calendar_time`
WHERE `calendar_id` IS NULL
ORDER BY `id` DESC
LIMIT 50

DELETE FROM `ilg_calendar_time`
WHERE `calendar_id` IS NULL;
DELETE FROM `ilg_calendar_time`
WHERE `calendar_id` = '0';

DELETE FROM `ilg_schedule`
WHERE `time_calendar_id` IS NULL;

ALTER TABLE `ilg_calendar_time`
CHANGE `calendar_id` `calendar_id` bigint(20) NOT NULL AFTER `id`,
COMMENT='';

-------------  cloudtime reporte de hora de trabajo con dispositivos

ALTER TABLE `ilg_hour_report`
ADD `start_attendance_id` bigint(20) NULL,
COMMENT='';
ALTER TABLE `ilg_hour_report`
ADD INDEX `start_attendance_id` (`start_attendance_id`);
ALTER TABLE `ilg_hour_report`
ADD FOREIGN KEY (`start_attendance_id`) REFERENCES `ilg_attendance` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `ilg_hour_report`
ADD `end_attendance_id` bigint(20) NULL,
COMMENT='';
ALTER TABLE `ilg_hour_report`
ADD INDEX `end_attendance_id` (`end_attendance_id`);
ALTER TABLE `ilg_hour_report`
ADD FOREIGN KEY (`end_attendance_id`) REFERENCES `ilg_attendance` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

UPDATE 
  ilg_hour_report hr
INNER JOIN  
(  SELECT 
      at1.id, at1.time, at1.device_id, at1.hour_report_id
    FROM
      ilg_attendance AS at1 
      LEFT OUTER JOIN ilg_attendance AS at2 
        ON at1.hour_report_id = at2.hour_report_id 
        AND (
          at1.time < at2.time 
          OR (
            at1.time = at2.time 
            AND at1.id < at2.id
          )
        ) 
    WHERE at2.hour_report_id IS NULL 
) AS at1 
ON at1.hour_report_id = hr.id 
SET
  hr.end_attendance_id = at1.id;
  
 UPDATE 
  ilg_hour_report hr
INNER JOIN  
(  SELECT 
      at1.id, at1.time, at1.device_id, at1.hour_report_id
    FROM
      ilg_attendance AS at1 
      LEFT OUTER JOIN ilg_attendance AS at2 
        ON at1.hour_report_id = at2.hour_report_id 
        AND (
          at1.time > at2.time 
          OR ( at1.id > at2.id
          )
        ) 
    WHERE at2.hour_report_id IS NULL 
) AS at1 
ON at1.hour_report_id = hr.id 
SET
  hr.start_attendance_id = at1.id; 
  
ALTER TABLE `ilg_device`
ADD `FPVersion` varchar(10) COLLATE 'utf8_bin' NULL AFTER `language`,
COMMENT='';
ALTER TABLE `ilg_device`
CHANGE `description` `description` varchar(100) COLLATE 'utf8_bin' NULL AFTER `name`,
CHANGE `UpdateDB` `UpdateDB` varchar(200) COLLATE 'utf8_general_ci' NULL DEFAULT '1111100000' AFTER `LogStamp`,
ADD `info` varchar(4200) COLLATE 'utf8_general_ci' NULL,
COMMENT='';
ALTER TABLE `ilg_device`
ADD `speeding` char(1) COLLATE 'utf8_general_ci' NULL AFTER `auto_process`,
COMMENT='';
  

-----------------------  cloudtime crear administrador sucursal
--- crear usergroup con admin
UPDATE `bi4cg_usergroups` SET
`id` = '444',
`parent_id` = '14',
`lft` = '28',
`rgt` = '29',
`title` = 'Administrador Sucursal',
`description` = 'Administrador Sucursal',
`enterprise_id` = '0',
`branch_office_id` = NULL
WHERE `id` = '444';

UPDATE `bi4cg_viewlevels` SET
`id` = '21',
`title` = 'enterprise',
`description` = 'Administrar Empresas',
`ordering` = '2',
`rules` = '[8,15,19]'
WHERE `id` = '21';

UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, '8', '8,19')
WHERE id in ( 18 ,21 );

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(18,	19),
(21,	19);

UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, '19', '19,444')
WHERE title != 'assign-branch' && title != 'Sucursales' && title != 'enterprise';

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
SELECT `id`,444
FROM `bi4cg_viewlevels`
WHERE `rules` LIKE '%444%'


UPDATE `bi4cg_viewlevels` SET
`id` = '8',
`title` = 'configuration',
`description` = 'Configuración de Empresa',
`ordering` = '2',
`rules` = '[8,15]'
WHERE `id` = '8';

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('8', '8'),('8', '15');

UPDATE `bi4cg_menu` SET
`access` = '8'
WHERE `id` = '133';




------------------- cloudtime problema fechas

UPDATE `ilg_person` SET
`start_date` = '2014-12-22'
WHERE `start_date` = '0000-00-00';

---------- cloudvoice administracion de empresas

UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, '[2,8]', '[2,8,38,37]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('6', '38'),('6', '37');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('6', '38'),('6', '37'),
('7',  '38'),('7', '37'),
('8',  '38'),('8', '37'),
('9',  '38'),('9', '37'),
('10', '38'),('10', '37'),
('11', '38'),('11', '37'),
('12', '38'),('12', '37'),
('13', '38'),('13', '37'),
('14', '38'),('14', '37'),
('15', '38'),('15', '37'),
('16', '38'),('16', '37'),
('17', '38'),('17', '37'),
('18', '38'),('18', '37'),
('19', '38'),('19', '37'),
('21', '38'),('21', '37'),
('22', '38'),('22', '37'),
('25', '38'),('25', '37'),
('26', '38'),('26', '37'),

ALTER TABLE  `area`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `area`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `area`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update area au
SET au.enterprise_id = 2;


ALTER TABLE  `configuration`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `configuration`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `configuration`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update configuration au
SET au.enterprise_id = 2;




ALTER TABLE  `phrase`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `phrase`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `phrase`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update phrase au
SET au.enterprise_id = 2;




ALTER TABLE  `segment`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `segment`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `segment`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update segment au
SET au.enterprise_id = 2;




ALTER TABLE  `verification`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `verification`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `verification`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update verification au
SET au.enterprise_id = 2;




ALTER TABLE  `voiceprint`
ADD `enterprise_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `voiceprint`
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE  `voiceprint`
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 
Update voiceprint au
SET au.enterprise_id = 2;


DROP TABLE IF EXISTS `phrase_enterprise`;
CREATE TABLE `phrase_enterprise` (
  `phrase_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`phrase_id`,`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO phrase_enterprise ( phrase_id, enterprise_id ) 
select distinct p.id, p.enterprise_id from phrase p ;

ALTER TABLE `phrase`
DROP FOREIGN KEY `phrase_ibfk_2`;
ALTER TABLE `phrase`
DROP INDEX `enterprise_id`;
ALTER TABLE `phrase`
DROP `enterprise_id`,
COMMENT='';


-----------   Cloudtime Control  password`
ALTER TABLE `bi4cg_users`
ADD `pass_changed` int(1) NULL DEFAULT '0',
ADD `last_pass` longtext COLLATE 'utf8_general_ci' NULL AFTER `pass_changed`,
COMMENT='';

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('49', '2'),('49', '3'),
('49',  '4'),('49', '5'),
('49', '14'),('49', '15'),
('49',  '19'),('49', '20'),
('49', '21'),('49', '8'),
('49',  '23');

UPDATE `bi4cg_viewlevels` SET
`id` = '6',
`title` = 'accesscontrol',
`description` = 'Menu Usuarios',
`ordering` = '2',
`rules` = '[2,3,4,5,14,15,19,20,21,8,23]'
WHERE `id` = '6';

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('6', '2'),('6', '8'),
('6', '15'),('6', '22'),
('6', '24'),('6', '25'),
('6',  '4'),('6', '5'),
('6', '14'),('6', '23'),
('6',  '19'),('6', '20'),
('6', '21'),('6', '26');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES ('22', '2'),
('22', '22'),
('22', '24'),('22', '25'),
('22',  '4'),('22', '5'),
('22', '14'),('22', '23'),
('22', '21'),('22', '26');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES 
(50,7),(50,15),(50,19),(50,8),(50,23),(50,24),(50,25),
(51,7),(51,15),(51,19),(51,22),(51,8),(51,25),
(52,7),(52,15),(52,19),(52,22),(52,25);

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES 
(53,7),(53,15),(53,19),(53,22),(53,8),(53,25),(53,26),
(52,8),(52,26);

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`)
VALUES 
(53,7),(53,15),(53,19),(53,22),(53,8),(53,25),(53,26);


---------------- cloudtime  intevalos de turnos

ALTER TABLE `ilg_calendar_time`
ADD `max_in_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'Hora máxima de marcación para considerarla como entrada de este turno.' AFTER `min_in_time`,
ADD `min_out_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'Hora mínima de marcación para considerarla como salida de este turno.' AFTER `max_in_time`,
COMMENT='';

UPDATE `ilg_device` SET
`device_type_id` = '1';

UPDATE `ilg_device_type` SET
`id` = '1',
`name` = 'ENROLLER_ATT',
`description` = 'Dispositivo para enrolamiento y marcación por huella o tarjeta.'
WHERE `id` = '1';

INSERT INTO `ilg_device_type` (`id`, `name`, `description`)
VALUES ('2', 'ENROLLER_ONLY', 'Dispositivo unicamente para enrolamiento de huellas o tarjetas.   Descarta las marcaciones recibidas.');

INSERT INTO `ilg_device_type` (`id`, `name`, `description`)
VALUES ('3', 'ATT_ONLY', 'Dispositivo unicamente para marcaciones de huellas o tarjetas.   Descarta las huellas y tarjetas recibidas.');


-------- cloudtimecontrol   arreglar los periodos

INSERT INTO `ilg_payroll_period` (`initial_date`, `end_date`, `enterprise_id`)
VALUES ( '2014-09-01', '2014-09-30', '39' ),
( '2014-08-01', '2014-08-31', '39');


INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `att_total`			,		
		  `att_total_in` 		,		
		  `att_total_out` 		,		
		  `att_out_late` 		,		
		  `att_out_on_time` 	,		
		  `att_out_early` 		,		
		  `att_in_late` 		,		
		  `att_in_on_time` 		,		
		  `att_in_early` ,
		  att_not_processed,
		  att_automatic,
		  att_manual,
		  att_duplicated
		)
select prp.id, per.area_id,
at.enterprise_id,
count(*) as total,
SUM( case when at.attendance_status_id = 0 then 1 else 0 end ) as total_in, 
SUM( case when at.attendance_status_id = 1 then 1 else 0 end ) as total_out, 
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde ,
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,
SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, 
SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, 
SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,
SUM( case when at.processed != 'T' then 1 else 0 end ) as proccesed,
SUM( case when at.origin_type_id = 3 then 1 else 0 end ) as automatic, 
SUM( case when at.origin_type_id = 2 then 1 else 0 end ) as manual, 
SUM( case when at.valid != 'T' then 1 else 0 end ) as duplicated
from ilg_attendance at INNER JOIN ilg_payroll_period prp 
INNER JOIN ilg_person per ON per.id = at.person_id 	
where
DATE(at.time) >= prp.initial_date AND DATE(at.time) <= prp.end_date
and at.enterprise_id = 39
and prp.enterprise_id = at.enterprise_id
group by at.enterprise_id, per.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			att_total=VALUES(att_total) ,
			`att_total_in` =VALUES(att_total_in),				
			`att_total_out`=VALUES(att_total_out),			
			`att_out_late`=VALUES(att_out_late),		
			`att_out_on_time`=VALUES(att_out_on_time),	
			`att_out_early`=VALUES(att_out_early),	
			`att_in_late`=VALUES(att_in_late),
			`att_in_on_time`=VALUES(att_in_on_time),	
			`att_in_early`=VALUES(att_in_early),
			`att_not_processed`=VALUES(att_not_processed),
			`att_automatic`=VALUES(att_automatic),
			`att_manual`=VALUES(att_manual),
			`att_duplicated`=VALUES(att_duplicated)
			; 
			
INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_processed` ,
		  worked_hours
		)
select prp.id, hr.area_id,
hr.enterprise_id,
SUM( case when hr.processed != 'T' then 1 else 0 end ) as notproccesed,
SUM( worked_hours ) as worked_hours
from ilg_hour_report hr INNER JOIN ilg_payroll_period prp 
where
DATE(hr.start_time) >= prp.initial_date AND DATE(hr.start_time) <= prp.end_date
and hr.enterprise_id = 39
and prp.enterprise_id = hr.enterprise_id
group by hr.enterprise_id, hr.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			`hours_not_processed` =VALUES(hours_not_processed),
			worked_hours = VALUES(worked_hours)
			;    


INSERT INTO  `ilg_payroll_period_sum` (
		  `payroll_period_id`,
		  `area_id` 		,	
		  `enterprise_id` 	,	
		  `hours_not_auth` 
		)
select prp.id, per.area_id,
ac.enterprise_id,
SUM( case when ac.authorized != 'T' then 1 else 0 end ) as notauthorized
from ilg_hour_concept ac INNER JOIN ilg_payroll_period prp 
INNER JOIN ilg_person per ON per.id = ac.person_id 	
where
DATE(ac.start_time) >= prp.initial_date AND DATE(ac.start_time) <= prp.end_date
and ac.enterprise_id = 39
and prp.enterprise_id = ac.enterprise_id
group by ac.enterprise_id, per.area_id, prp.initial_date
		ON DUPLICATE KEY UPDATE 
			`hours_not_auth` = VALUES(hours_not_auth)
			;    
			


			
-----------   cloudvoice koala
			
ALTER TABLE `transaction`
CHANGE `outcome` `outcome` enum('NONE','ACCEPTED','REJECTED','UNDECIDED_SPEAKER_ID','UNDECIDED_SPOOF_DETECTED','SPOOF_DETECTED') COLLATE 'utf8_general_ci' NULL AFTER `snr`,
COMMENT='';			


ALTER TABLE `transaction`
ADD `asd` float NULL AFTER `outcome`,
COMMENT='';



-----------------------  cloudtime leftday novedades

$queryPayEmplDate =  <<<Q
select a.person as person_id, DATE(a.Date) as date_arr , 
	time_arr, 
	time_left,
	$conceptsSqlNames
	NOVEDADES,
	worked_hours,
	a.empl_name
    from
	(
		select perdate.person, 
			a.Date,
			perdate.empl_name as empl_name
		from
		(   
			select  NOW() - INTERVAL 1 YEAR
				  + INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY as Date 
			from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a 
			cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b 
			cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c  
		) as a  ,
		(
			SELECT distinct p.id as person	, p.name as  empl_name
			FROM ilg_person p
			LEFT JOIN ilg_contract ct ON ct.person_id = p.id
	@nofilter_area_id@ ,  ilg_area AS node, ilg_area AS parent     @filter_area_id@ 
			WHERE  p.enterprise_id = $enterprise_id
	@nofilter_status_id@and p.status_id @filter_status_id@
	@nofilter_status_id@and ct.status_id @filter_status_id@
	@nofilter_area_id@ and node.lft BETWEEN parent.lft AND parent.rgt  AND parent.id = @value_area_id@ @filter_area_id@ 
				 @nofilter_area_id@ and p.area_id  = node.id @filter_area_id@ 		
				 @nofilter_cost_center_id@ and p.cost_center_id @filter_cost_center_id@ 
				 @nofilter_branch_office_id@ and p.branch_office_id @filter_branch_office_id@ 		
				 @nofilter_person_id@ and p.id @filter_person_id@ 
				 @nofilter_contract_type_id@ and ct.contract_type_id @filter_contract_type_id@ 	
		) as perdate
		where @nofilter_start_time@ a.Date @filter_start_time@ 
) as a left join
(	
	SELECT person_id,
		date(start_time) as date_arr,
		time(start_time) as time_arr,
		time(end_time) as time_left,
		$conceptsSql
		SUM(case when conceptName = 'NOVEDADES' then hours else 0 end ) as NOVEDADES,
		worked_hours,
		empl_name
	FROM
	(
		SELECT hr.id,
		hr.start_time,
		hr.end_time,
		hr.worked_hours,
				hr.person_id,
				c.name as conceptName,
				sum(hours) AS hours,
				p.name as empl_name
		   FROM ilg_hour_concept hc
		   INNER JOIN ilg_hour_report hr ON hc.hour_report_id = hr.id
		   INNER JOIN ilg_person p ON hr.person_id = p.id
		   INNER JOIN ilg_concept c ON hc.concept_id = c.id
		   INNER JOIN ilg_contract ct ON ct.person_id = p.id
	@nofilter_area_id@ ,  ilg_area AS node, ilg_area AS parent     @filter_area_id@ 
		   WHERE  hr.enterprise_id = $enterprise_id
	@nofilter_status_id@and p.status_id @filter_status_id@
	@nofilter_status_id@and ct.status_id @filter_status_id@
@nofilter_area_id@ and node.lft BETWEEN parent.lft AND parent.rgt  AND parent.id = @value_area_id@ @filter_area_id@ 	
				@nofilter_area_id@ and p.area_id  = node.id @filter_area_id@ 		
				@nofilter_cost_center_id@ and p.cost_center_id @filter_cost_center_id@ 
				@nofilter_branch_office_id@ and p.branch_office_id @filter_branch_office_id@ 		
				@nofilter_authorized@ and hc.authorized @filter_authorized@ 	
				@nofilter_start_time@ and hr.start_time @filter_start_time@  
				@nofilter_person_id@ and hr.person_id @filter_person_id@ 
				@nofilter_origin_type_id@ and hr.origin_type_id  @filter_origin_type_id@
				@nofilter_contract_type_id@ and ct.contract_type_id @filter_contract_type_id@ 	
			 AND DATE(hr.start_time) >= ct.started_date
		   GROUP BY hr.id, hr.person_id, concept_id
UNION
			SELECT prn.id,
				  prn.start_time,
				  prn.end_time,
				  0,
				  prn.person_id,
				  "NOVEDADES" as conceptName, 
				  TIMESTAMPDIFF(SQL_TSI_MINUTE, prn.start_time, prn.end_time ) /60 AS hours,
				  p.name AS empl_name
		    FROM ilg_payroll_notice prn
			LEFT JOIN ilg_person p ON prn.person_id = p.id
			LEFT JOIN ilg_payroll_notice_type nt ON prn.type_id = nt.id
		    INNER JOIN ilg_contract ct ON ct.person_id = p.id
@nofilter_area_id@ ,  ilg_area AS node, ilg_area AS parent     @filter_area_id@ 		
		    WHERE prn.enterprise_id = 39
	@nofilter_status_id@and p.status_id @filter_status_id@
	@nofilter_status_id@and ct.status_id @filter_status_id@
@nofilter_area_id@ and node.lft BETWEEN parent.lft AND parent.rgt  AND parent.id = @value_area_id@ @filter_area_id@ 	
		@nofilter_area_id@ and p.area_id  = node.id @filter_area_id@ 		
		@nofilter_cost_center_id@ and p.cost_center_id @filter_cost_center_id@ 
		@nofilter_branch_office_id@ and p.branch_office_id @filter_branch_office_id@ 		
		@nofilter_start_time@ and prn.start_time @filter_start_time@  
		@nofilter_person_id@ and prn.person_id @filter_person_id@ 
		@nofilter_contract_type_id@ and ct.contract_type_id @filter_contract_type_id@ 	
		and DATE(prn.start_time) >=  ct.started_date 	
	
	) AS tot
	GROUP BY id, person_id
) as hrs 	
ON date_arr = DATE( a.Date ) AND hrs.person_id = a.person		 
ORDER BY  a.empl_name ASC , a.Date ASC 




$queryPayEmplDate =  <<<Q
SELECT '@value_start_time@' as startCutDate,'@value_start_time_bt@' as endCutDate,
	emplStarted,emplEnd, contract_type_id,person_id,
	$conceptsSql
	group_concat( DISTINCT GC_NOVEDADES SEPARATOR '-' ) as GC_NOVEDADES,
	sum(worked_hours) as worked_hours
FROM
  (SELECT hr.id,
 hr.start_time,
hr.end_time,
hr.worked_hours,
        hr.person_id,
        c.name,
        sum(hours) AS hours,
		p.name as empl_name,
        ct.started_date as emplStarted,
        ct.end_date as emplEnd,
        ct.contract_type_id,
		"" as GC_NOVEDADES
   FROM ilg_hour_concept hc
   INNER JOIN ilg_hour_report hr ON hc.hour_report_id = hr.id
   INNER JOIN ilg_person p ON hr.person_id = p.id
   INNER JOIN ilg_concept c ON hc.concept_id = c.id
   INNER JOIN ilg_contract ct ON ct.person_id = p.id
@nofilter_area_id@ ,  ilg_area AS node, ilg_area AS parent     @filter_area_id@ 	
   WHERE  hr.enterprise_id = $enterprise_id
	@nofilter_status_id@and p.status_id @filter_status_id@
	@nofilter_status_id@and ct.status_id @filter_status_id@
@nofilter_area_id@ and node.lft BETWEEN parent.lft AND parent.rgt  AND parent.id = @value_area_id@ @filter_area_id@ 	
		@nofilter_area_id@ and p.area_id  = node.id @filter_area_id@ 		
		@nofilter_cost_center_id@ and p.cost_center_id @filter_cost_center_id@ 
		@nofilter_branch_office_id@ and p.branch_office_id @filter_branch_office_id@ 		
		@nofilter_authorized@ and hc.authorized @filter_authorized@ 	
		@nofilter_start_time@ and hr.start_time @filter_start_time@  
		@nofilter_person_id@ and hr.person_id @filter_person_id@ 
		@nofilter_origin_type_id@ and hr.origin_type_id  @filter_origin_type_id@
		@nofilter_contract_type_id@ and ct.contract_type_id @filter_contract_type_id@ 	
		and DATE(hr.start_time) >=  ct.started_date 
		GROUP BY hr.id, hr.person_id, concept_id
	UNION
			(SELECT prn.id,
				  prn.start_time,
				  prn.end_time,
				  0,
				  prn.person_id,
				  "GC_NOVEDADES" as name, 
				  0,
				  p.name AS empl_name,
				  ct.started_date AS emplStarted,
				  ct.end_date AS emplEnd,
				  ct.contract_type_id,
				  nt.name as GC_NOVEDADES
		   FROM ilg_payroll_notice prn
		LEFT JOIN ilg_person p ON prn.person_id = p.id
		LEFT JOIN ilg_payroll_notice_type nt ON prn.type_id = nt.id
		   INNER JOIN ilg_contract ct ON ct.person_id = p.id
@nofilter_area_id@ ,  ilg_area AS node, ilg_area AS parent     @filter_area_id@ 		
		   WHERE prn.enterprise_id = 39
	@nofilter_status_id@and p.status_id @filter_status_id@
	@nofilter_status_id@and ct.status_id @filter_status_id@
@nofilter_area_id@ and node.lft BETWEEN parent.lft AND parent.rgt  AND parent.id = @value_area_id@ @filter_area_id@ 	
		@nofilter_area_id@ and p.area_id  = node.id @filter_area_id@ 		
		@nofilter_cost_center_id@ and p.cost_center_id @filter_cost_center_id@ 
		@nofilter_branch_office_id@ and p.branch_office_id @filter_branch_office_id@ 		
		@nofilter_start_time@ and prn.start_time @filter_start_time@  
		@nofilter_person_id@ and prn.person_id @filter_person_id@ 
		@nofilter_contract_type_id@ and ct.contract_type_id @filter_contract_type_id@ 	
		and DATE(prn.start_time) >=  ct.started_date limit 3)  ) as tot	
GROUP BY  person_id
ORDER BY  empl_name , start_time ASC 
Q;


--------------------  cloudtime sincronizacion dispositivos

UPDATE `ilg_device_type` SET
`id` = '1',
`name` = 'ENROLLER_ATT',
`description` = 'Dispositivo para enrolamiento y marcación por huella o tarjeta.'
WHERE `id` = '1';

UPDATE `ilg_device_type` SET
`id` = '2',
`name` = 'ENROLLER_ONLY',
`description` = 'Dispositivo unicamente para enrolamiento de huellas o tarjetas.   Descarta las marcaciones recibidas.'
WHERE `id` = '2';


INSERT INTO `ilg_device_type` (`id`, `name`, `description`)
VALUES ('3', 'ATT_ONLY', 'Dispositivo unicamente para marcaciones de huellas o tarjetas.   Descarta las huellas y tarjetas recibidas.');



INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(54,	19),
(54,	15),
(54,	22),
(54,	8);



------- cloudtime actualizar ilg_device_fingerprint

INSERT IGNORE INTO ilg_device_fingerprint ( device_id, fingerprint_id ) 
select distinct dp.device_id, f.id from ilg_fingerprint f inner join ilg_device_person dp on f.person_id = dp.person_id;		
	

-------------------- cloudtime comandos de huellas

ALTER TABLE `ilg_fingerprint`
ADD `size` smallint(6) NULL AFTER `Valid`,
COMMENT='';
ALTER TABLE `ilg_fingerprint`
ADD `valid_size` char(1) COLLATE 'utf8_general_ci' NULL AFTER `size`,
COMMENT='';

SELECT f.template
FROM `ilg_fingerprint` f
WHERE ( p.identification = '1024505390' and f.FingerId = 3 )

SELECT p.id
FROM `ilg_person` p
WHERE ( p.identification = '1024505390' )


DELETE ilg_device_person FROM ilg_device_person INNER JOIN ilg_person p ON p.id = ilg_device_person.person_id
where device_id = 23744 AND (
( p.identification = '1024505390' )  OR

Update ilg_fingerprint f
INNER JOIN ilg_person p on f.person_id = p.id
SET f.template =  CONCAT( f.template, '=' )
WHERE ( p.identification = '1024505390' and f.FingerId = 3 )  OR;

INSERT INTO ilg_device_person ( device_id, person_id ) 
select distinct 23745,p.id from ilg_person p where 

DELETE f FROM ilg_fingerprint f INNER JOIN ilg_person p ON p.id = f.person_id


DELETE  df FROM  ilg_device_fingerprint df 
INNER JOIN ilg_fingerprint f ON df.fingerprint_id = f.id
INNER JOIN ilg_person p ON p.id = f.person_id
WHERE
( p.identification = '79525169' and f.FingerId = 7	 )  OR

UPDATE `ilg_device_cmd` SET
`device_id` = '23739',
`CmdContent` = 'DATA UPDATE USERINFO PIN=53890710\tName=YAZMIN\tPri=0\tPasswd=\tCard=[0000000000]\tTZ=1000000000000000\tGrp=1',
`CmdCommitTime` = '2015-01-27 17:50:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415327';	
	
UPDATE `ilg_device_cmd` SET
`device_id` = '23739',
`CmdContent` = 'DATA UPDATE FINGERTMP PIN=53890710\tFID=0\tSize=1740\tValid=1\tTMP=TFtTUzIxAAAFGBoECAUHCc7QAAAdGWkBAAAAhcUuihgbAHYPSADtAOsXWgAoAGcPDwAvGAwPZgAuADQPkxg/AHUPjwCVAGIXowBmAGIPlQBqGFsPfABzAJEPIxh4AFcPOwC8ANgX/AB7ACkPZAB4GDwPgACHAI8PjxiUAD8PZABSAFUXmQCkADEP/wCtGNQPaAC5AI8P/Bi ACgPSwAHAFwX1gDCACUPuwDNGCgPcwDLAP4P9xjTAKcPkwATALUXGQDgANwPhwDpGN0PggDuAGAMKhjuAF8PgwDFAYoVpQADAZwPNQAGGZ4PZgAEAcYMcRgEAYMMRADCAeMXUwALAfcO3QAKGeAP1wAUAVwPbxg4AXwPLAD/AfAXsgA8AY8PggBAGfoP3ABVAU8PFBhXAfcPRgG hIYKlIme/M X6XucYRLy55r/mxqrIZcbBH98XREDAUcP6PU9B24WpCbE55MSlX6eB 8LYBVfFToaKX3n/16dJImRhucIXgOqH56HBd6mAH/1WBTw aL86fSgESccHwhuCTISNPXz8hv21nyeh6r4ZAlQI6rwqYETBRobHxDShDIit4Bf5Y6LzPNxejTjOQ/w8VaNqYG3hBoQaIopD151eH 3G b8HX3h xflHAEwJ7X3HYV8h0NgZAyx7W2Prwx74mYYSgin G57hJjwDXl3gYA09ND7pPBZDz6I0BB47Yd1eoaa/6YE1 R2/kcOeoF2hcrhnP/uAjsUzgTW4qr3FQt6gT4GiuS288Pvaga6/koDvNfr8eEQ5U4EGs0ktwMAP8Rtxx4BUQFwwlnMAGcZcXR4wAsAswJx2XnAwMJlA8W AB7 DwCWCH0Fi47nfVwGAKEMxUbFHAGLGH2VCcWTH U3R8EDAIvYd8cVAeogjGn/t4nEEQFXKHCHwqcFBdYpCf7B/QjFxiyRwMDBiQsAnixi2MP wmpuB8XOKxc8NQwAYjGh/37aWXkJAJI9RcTE2cBtCgCaPsY7PSAGAJRCd8EGwIAXAYxRa8LBBX76ekIEAJ5kcG4OBb5nCftAwMGOwYccAaBqZ6URxX9qxv/8/CNGZARcDBhNcGCESv/TARRoqH7BwmnBuYNq2MEMAFFzWq/D djB/8L9AwC9c1/aBwB9d1PAB1sAGCN5XG0GAOJ9VufBYAMBAX3l/wEY/X8tbwwAZYFF233AZnEeAdCHrGht/pPC/8IGaXtjUlkGAHyJisLF2cMFAIKKSaoFBZ ZRo0MAIxdPcRoiP DBABgXFdyHwFlm0zA/wQrCxiWoLr /P0w kPZ/mgZADukEsDF2Er///vC/Tg7TkJXDgCcpy2iWXDlwP4PAJao8nd b0v/BQBkvInA ecNAGq8QCQFwEpwBwDUvq3BnQ8FsYYxgf7BwATBU0MJAEfCWsAFOvoQAdvCImVWwQD/2yZkBABNxpNUDRjXxinAcFnDAHnTNcN CQCCDinGWnUgARPGpwRExdjAwXnDwsQHwMRmVEr//n8ExSvqemsEAD/vXvgDBXnwacIDAIU0HscbATDzXv8E1X8Hl6oLEIcDEIdlbhERqAYcd/ TBxVWDXSFVg8Qkw3/K8H ZW1tBNXbEg5WDhAxOfA7O/pzUv8JEGU5RcLH5cPBwcEOEHU6lWvD/pOUwBbVAjj1ZcAx/8D9OsHF5cNkXQwQTIH6xeY7//9xEhDSVfLZ/FvB sNoBcHHZQgQall9/gb aNsEEHJcBmbGECd//P8=\r\n',
`CmdCommitTime` = '2015-01-27 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415328';	
	
	
UPDATE `ilg_device_cmd` SET
`device_id` = '23739',
`CmdContent` = 'DATA UPDATE FINGERTMP PIN=53890710\tFID=1\tSize=1171\tValid=1\tTMP=SitTUzIxAAADaGoECAUHCc7QAAAbaWkBAAAAg5Uat2h5AAwPcgC+APpnswB/AIIPEwCDaI0PdgChAD4PpmigAIAPqgBjAAln1QCnABUPkgCyaG0P5ACzAFEPzmjEABgPpgAPAAxn2wDhAJQPVwABaRcPZQAFASsPfGgJAf0P7ADJASlnjAAZARwOUAAoaS0MYQA1ARsP1GhCATEPkQCDAUdjPgBJAdoPYABWabcMkABWAYcLemhYAWMOwI67gcXnxwLfj6N7DXoBkU8FfoF2Df968flDBod8IHoXAUEaGY6+/UKKQIG1lC+KAnHrd8rviulQfzcATYf3BJnsNwVu+jKSW3wcBLYA3Rm1/m/umpun15Lbeels4gp7Bpin+wcXUPEKSiwKBRGd69caDW7Pf2fww33aC8yHgARZkgUbV/6wE37vSXVldo9XAmg8jbniGSLHIMXvIEEhACAvxAINc4cDAJ5TBgULA79okH7Aif8GDQOzdZPCcsNnBWgGaK54hnwGAHN8E6lSCgCvgIa5eF9nAUOK8GjBOEtCAgIAoZ2AwcAAqskB/jESADZh6/yowT7+wMD+lEAFaKCkgHPDCcWtpG7+/sBP/wTF16R7XhEAM63wBVb9LkFT/wMAU3Vr/HoBNrXwwMAF/0xW/sH//VwExVa2AUsHANDGFwU+w20BqcoM//4EFQJn56LBwIvAvYPD+FMVACrj5wT+wij+//7A//4FwCxTDgB66PT+ODU2XzkWACL43Ps+P5bD/f/9wf86wFd5EWcB5/4sOv4zLFIKEJYCFvU7aH4RIgTaPv+OMMKV/v82/1wQ1WkEgf7/+/4p/jpSNH4RKgjcVP4FO/2XN//B/VT/1hDrYKPBfHXBxAWAwpfD/wcQYQmbwmGWBRDwDiI1zhCfeI3Ewp/A/QX7C3ieEBr+/jc6BBODESlNCBCR3hP/Q3AXEQYfp7WBaaqQesB0wA3VYzKy/vz+/Pz99HMFeIQzZMP/KtIQM17N/VP//sA7/vyU/sD+/ztTwBCBVlH9/f8EEE1ASkEVEENG2nM6/D+T/P///v//O34AeNZGLf8YEOhH46xH/0H9wP04//yW/jhYAxCOj0z9eBE1W/TCwgf/wpb8+P38//9EDRMtXu2C//7405hRKgELQwEAAM5FAAAAAAAAAAA',
`CmdCommitTime` = '2015-01-27 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415329';	
	

UPDATE `ilg_device_cmd` SET
`device_id` = '23739',
`CmdContent` = 'DATA UPDATE FINGERTMP PIN=53890710\tFID=2\tSize=1854\tValid=1\tTMP=TCtTUzIxAAAFaGoECAUHCc7QAAAdaWkBAAAAhZU6omg7APYPlACSAG1npABZAAQPWwBjaAUP2QBnANIPXmhwAFYP0gBHACdm5ACFACQODQCOaCkPlQCMADoOZWiOAE4PwABcADxmYwCeAD8PFgCaaDkPkQCgADEOq2ijAFIOVgBuAEZncACuACAOcACraFIOOwCxAIkP42iyADYPSgBzAEFnXwC8ACwPFAC4aEsP3gDCAPgPkWjGAIsPuAAJAMhnxwDMAFsPIQDRaEYPPgDdAIgNXmjiALEOSQAhACVlfQDmAJQPcADvaN0PpQDuALMPx2jwAGoP3wA2AFpnMAD8AOkNTQD6aH4P3wADAQoPb2gFAYYPjwDNAfFnNwATAQAO/wAbaQYPygAgASkO22grAXAN4QD1AellnQA0AfUP8wA5aQ8OZAA9AcMPsWhFAfUP6QCBAWJm3ABGAWkO/ABMaSANpwBJAbMPumhQAXUPjwCXAfNnJQBZAbwPC/Tn+df3HWRBZTd11GgAnEIQUQDgncNutPea9L7yowhicG4XwP9lAewP4G3X/LbsPAto8ICayA2irE7+qBCHZO/4HRBVAXDp+Jig/WUi1QEwEmxvVPWRp/7VnAAYcbBjoQAdBagZBIrI9uXf2QDEHm/gQAgtC0IhZPi8huwDyfgdAIwZAIHg6T0ORQxU8SB+1PQZCHn5O8Gz8lP6tXSdh7d8oPgAERUj7Q0b/MOETS8+nIZliJFfDNcc+NddcQc5HH9z5EYRuXTYaG94AJwRD3b5aJAcZ5z3YZCl9y8Y1IJrnXrJKI9073uQcHBKZQ7lMwjXnavVMHdqgddxtZM4GsL2LAsH+DdJqH6tA24d+Yag7lALQH7FhhiGvOqkA94AqO//CM898+f/+I8QOIC06CQDlAPJfgz7FW/gftn7FBcAZyd3/IC5ghkCdICcav8MfYNeALsCrPefsZe30YxH4BG0HAEgRQECTx5BZQGfJHR+wqDD+ggPAKQqdHei/8cCwQYAfittB2sKaK4vdGqD/wR0fXkBozt0wcEHZHsFwMH+BQCr+QD7WwcAkVhrjAQEBcNZACcYAOmdl3D5wYOLwGpr/RUFh2OTwGyWwAfCx6hdasMGAKGj/fmo/cIEANtr38D7cQHva5rD/lTFWat4w//FwcYBxcf+CgBZdFpwBf9+qA4Azn6cwwShx/3ExMfGBQATghldBADUhiLA8wQFjYgiNAQAl0/0EmIByo4i//45w/qXKAcAXJJQqcDGYAFhk0yEwm4RBZWSonTAwsIGwpflww0AxJs0O/7+lsH9/f/BJsEAuvQ7LAMApp+xwQ5ohaDQ/v38P/34ljALAGKjRmLDw6qeEQCIpNc5/PyR//39/v39OP/5lf0HAKqkSTn7/5T6CwDTpDA7/cWV/v79NBUAZqd1qPT5+/4g/e0wxZZtBQBVrkYHwcZsAXCxMMTGwwA/3E3AwDsEACC2NSgFAEm5Rn7BAMqpTTANANTBg//5ljNLPhEA3wA9+Jf9Qf4+R3XBAMG4ViwOAPDkhf3+l0HAS8H+B8VN43/FbP8HAKM3bS1WBQC/9GlCywDenV//M1X//qEPBYj2Vv01REEFwPpsAVX7Bm4D1fAGP/oGEGYEgzrBxqoFEFgIg4jNEJ5lgsNAbwcQKxtslV3+BBDGI7VNAHgyJwzBwf/PEN5DcUf+wjAJ1TIqZ4bB/4MEEBgzdS4CEB00LfzDEPNfe3j9BBAr/TQkYhE6OwzBSQXExZMGEDZAF5S2BBVzQD19BhDZgHfHlH8DEPJHWgcLFVRNF5lRxFbDENQlZi/BBhBBnAx5llNCAAtDAcUADi1TAAAAAAAAAA',
`CmdCommitTime` = '2015-01-27 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415330';	

UPDATE `ilg_device_cmd` SET
`device_id` = '23739',
`CmdContent` = 'DATA UPDATE FINGERTMP PIN=53890710\tFID=3\tSize=1302\tValid=1\tTMP=SpNTUzIxAAAD0NMECAUHCc7QAAAb0WkBAAAAg30fmtAjAAAOnwDrAHzehQAvAP4PFgA20IwPpQA9AM8O5NA8ABoPogCQAIPfcgBeAGsPSwBq0AIPaQB8ADcP99B+AJsPWABYAOffZwCyAFMPdwCw0CMPcgC3ACsPitC2AA4PmgAKACDedQDRAPAOvwDh0EMOkgDiAPQOr9DjAKQORwArAEDfjgDuADoOnwD50CgPeQAFAX4OgNANAa4OiADcAaPe2QAbAawPXgAe0bUPVQAlAd4Pu9BJAZsPrIMsBrEosYMxdIGDqAKCU5f1BXZvhL4RKly8jiYM9Y4uE6BTxHphf74C4GtlqA7sXYcNmy8TXVjjEX7zn4NSE0irxJK++XL1+WfWol9lvgHeFmKAJ0+U4tED9SJc783wrPWBgwUXALFO12/k8VVBEpAKmysgEdHyXXe4g028VB43ASdW1QveKjuY8epmcPvq49/sHqaAbPfAEO4vkPTp7YXm6hJUK3oLVRVlC6P7KSdKYFNtj+kG8oQvziULCCA1xAI5y/oFAL4VDDlvBdCvGIB4wArFnRzQw/z9/sHD4gUDRSN9wmUFAFglABEiBACjLgP9BANQLnp4BgDX/Rf9Ef/BCgCqPsP+wy3B/8BZBAAvPhSQEQBdQPTAO/7CEikrTBEAV4jt/C7+/sH8wv46/sIv/koIAJ5SRsF6UgYAplYJ/zv+XtQBnld9dQTFb1+ggg8ASmLi60FFL//AwAQAcKdre9UBkmb9/i/MAIm6e5KE/wgAc3ETEEFUDACOcsUzTBBHCwCId3cG/8dVwYQMAIp3w8H+lDRXEgBZmiUz/5H+wDj//lvQADl210//Qf5BOMD+EsE+BQCusFaeCdC3shwwXTDWAGZlV3SQw8TCBML9L8HAcAsAjXIJJxDBWMAJALNyIkeEwAMAlsyMAwwDo8zc/Pj+/zn9wRB8CwCb0ycE/vxRagYAcNVTBsPFERYAONvQTDr+/C///v07wf79/0raAZbjKf10BmIP0JDmMELCwq8nG9D+66nAWYsEwJQTwMJ8wMGMyABEIUeOwMX/wgf8cNQBkPE9jBfF+/F5wcDAwcHBB8DBQsKAfnEQALD+rin8/Pj6/v46/8ARwMDACgBaOjDGEcIuewMQgMLGwdsBiupA/8MBdmvzEfsJt8RYOsPDWMLCwcTEwaPCwhHGwsLB+8EFwMD6FhB4Epf9O/oo9P39/f1WN7YDEwweJP4JEFfsHH0tbgcQUDsaBcLDkwcQS0cP/bsDE+pXCfxSQgDOQwLQAQtFUg',
`CmdCommitTime` = '2015-01-27 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415331';	

------------------------

UPDATE `ilg_device_cmd` SET
`device_id` = '61',
`CmdContent` = 'DATA USER PIN=53890710\tName=YAZMIN\tPri=0\tPasswd=\tCard=[0000000000]\tTZ=1000000000000000\tGrp=1',
`CmdCommitTime` = '2015-01-28 17:50:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415327';	
	
UPDATE `ilg_device_cmd` SET
`device_id` = '61',
`CmdContent` = 'DATA FP PIN=53890710\tFID=0\tSize=1740\tValid=1\tTMP=TFtTUzIxAAAFGBoECAUHCc7QAAAdGWkBAAAAhcUuihgbAHYPSADtAOsXWgAoAGcPDwAvGAwPZgAuADQPkxg/AHUPjwCVAGIXowBmAGIPlQBqGFsPfABzAJEPIxh4AFcPOwC8ANgX/AB7ACkPZAB4GDwPgACHAI8PjxiUAD8PZABSAFUXmQCkADEP/wCtGNQPaAC5AI8P/Bi ACgPSwAHAFwX1gDCACUPuwDNGCgPcwDLAP4P9xjTAKcPkwATALUXGQDgANwPhwDpGN0PggDuAGAMKhjuAF8PgwDFAYoVpQADAZwPNQAGGZ4PZgAEAcYMcRgEAYMMRADCAeMXUwALAfcO3QAKGeAP1wAUAVwPbxg4AXwPLAD/AfAXsgA8AY8PggBAGfoP3ABVAU8PFBhXAfcPRgG hIYKlIme/M X6XucYRLy55r/mxqrIZcbBH98XREDAUcP6PU9B24WpCbE55MSlX6eB 8LYBVfFToaKX3n/16dJImRhucIXgOqH56HBd6mAH/1WBTw aL86fSgESccHwhuCTISNPXz8hv21nyeh6r4ZAlQI6rwqYETBRobHxDShDIit4Bf5Y6LzPNxejTjOQ/w8VaNqYG3hBoQaIopD151eH 3G b8HX3h xflHAEwJ7X3HYV8h0NgZAyx7W2Prwx74mYYSgin G57hJjwDXl3gYA09ND7pPBZDz6I0BB47Yd1eoaa/6YE1 R2/kcOeoF2hcrhnP/uAjsUzgTW4qr3FQt6gT4GiuS288Pvaga6/koDvNfr8eEQ5U4EGs0ktwMAP8Rtxx4BUQFwwlnMAGcZcXR4wAsAswJx2XnAwMJlA8W AB7 DwCWCH0Fi47nfVwGAKEMxUbFHAGLGH2VCcWTH U3R8EDAIvYd8cVAeogjGn/t4nEEQFXKHCHwqcFBdYpCf7B/QjFxiyRwMDBiQsAnixi2MP wmpuB8XOKxc8NQwAYjGh/37aWXkJAJI9RcTE2cBtCgCaPsY7PSAGAJRCd8EGwIAXAYxRa8LBBX76ekIEAJ5kcG4OBb5nCftAwMGOwYccAaBqZ6URxX9qxv/8/CNGZARcDBhNcGCESv/TARRoqH7BwmnBuYNq2MEMAFFzWq/D djB/8L9AwC9c1/aBwB9d1PAB1sAGCN5XG0GAOJ9VufBYAMBAX3l/wEY/X8tbwwAZYFF233AZnEeAdCHrGht/pPC/8IGaXtjUlkGAHyJisLF2cMFAIKKSaoFBZ ZRo0MAIxdPcRoiP DBABgXFdyHwFlm0zA/wQrCxiWoLr /P0w kPZ/mgZADukEsDF2Er///vC/Tg7TkJXDgCcpy2iWXDlwP4PAJao8nd b0v/BQBkvInA ecNAGq8QCQFwEpwBwDUvq3BnQ8FsYYxgf7BwATBU0MJAEfCWsAFOvoQAdvCImVWwQD/2yZkBABNxpNUDRjXxinAcFnDAHnTNcN CQCCDinGWnUgARPGpwRExdjAwXnDwsQHwMRmVEr//n8ExSvqemsEAD/vXvgDBXnwacIDAIU0HscbATDzXv8E1X8Hl6oLEIcDEIdlbhERqAYcd/ TBxVWDXSFVg8Qkw3/K8H ZW1tBNXbEg5WDhAxOfA7O/pzUv8JEGU5RcLH5cPBwcEOEHU6lWvD/pOUwBbVAjj1ZcAx/8D9OsHF5cNkXQwQTIH6xeY7//9xEhDSVfLZ/FvB sNoBcHHZQgQall9/gb aNsEEHJcBmbGECd//P8=',
`CmdCommitTime` = '2015-01-28 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415328';	
	
	
UPDATE `ilg_device_cmd` SET
`device_id` = '61',
`CmdContent` = 'DATA FP PIN=53890710\tFID=1\tSize=1171\tValid=1\tTMP=SitTUzIxAAADaGoECAUHCc7QAAAbaWkBAAAAg5Uat2h5AAwPcgC+APpnswB/AIIPEwCDaI0PdgChAD4PpmigAIAPqgBjAAln1QCnABUPkgCyaG0P5ACzAFEPzmjEABgPpgAPAAxn2wDhAJQPVwABaRcPZQAFASsPfGgJAf0P7ADJASlnjAAZARwOUAAoaS0MYQA1ARsP1GhCATEPkQCDAUdjPgBJAdoPYABWabcMkABWAYcLemhYAWMOwI67gcXnxwLfj6N7DXoBkU8FfoF2Df968flDBod8IHoXAUEaGY6+/UKKQIG1lC+KAnHrd8rviulQfzcATYf3BJnsNwVu+jKSW3wcBLYA3Rm1/m/umpun15Lbeels4gp7Bpin+wcXUPEKSiwKBRGd69caDW7Pf2fww33aC8yHgARZkgUbV/6wE37vSXVldo9XAmg8jbniGSLHIMXvIEEhACAvxAINc4cDAJ5TBgULA79okH7Aif8GDQOzdZPCcsNnBWgGaK54hnwGAHN8E6lSCgCvgIa5eF9nAUOK8GjBOEtCAgIAoZ2AwcAAqskB/jESADZh6/yowT7+wMD+lEAFaKCkgHPDCcWtpG7+/sBP/wTF16R7XhEAM63wBVb9LkFT/wMAU3Vr/HoBNrXwwMAF/0xW/sH//VwExVa2AUsHANDGFwU+w20BqcoM//4EFQJn56LBwIvAvYPD+FMVACrj5wT+wij+//7A//4FwCxTDgB66PT+ODU2XzkWACL43Ps+P5bD/f/9wf86wFd5EWcB5/4sOv4zLFIKEJYCFvU7aH4RIgTaPv+OMMKV/v82/1wQ1WkEgf7/+/4p/jpSNH4RKgjcVP4FO/2XN//B/VT/1hDrYKPBfHXBxAWAwpfD/wcQYQmbwmGWBRDwDiI1zhCfeI3Ewp/A/QX7C3ieEBr+/jc6BBODESlNCBCR3hP/Q3AXEQYfp7WBaaqQesB0wA3VYzKy/vz+/Pz99HMFeIQzZMP/KtIQM17N/VP//sA7/vyU/sD+/ztTwBCBVlH9/f8EEE1ASkEVEENG2nM6/D+T/P///v//O34AeNZGLf8YEOhH46xH/0H9wP04//yW/jhYAxCOj0z9eBE1W/TCwgf/wpb8+P38//9EDRMtXu2C//7405hRKgELQwEAAM5FAAAAAAAAAAA',
`CmdCommitTime` = '2015-01-28 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415329';	
	

UPDATE `ilg_device_cmd` SET
`device_id` = '61',
`CmdContent` = 'DATA FP PIN=53890710\tFID=2\tSize=1854\tValid=1\tTMP=TCtTUzIxAAAFaGoECAUHCc7QAAAdaWkBAAAAhZU6omg7APYPlACSAG1npABZAAQPWwBjaAUP2QBnANIPXmhwAFYP0gBHACdm5ACFACQODQCOaCkPlQCMADoOZWiOAE4PwABcADxmYwCeAD8PFgCaaDkPkQCgADEOq2ijAFIOVgBuAEZncACuACAOcACraFIOOwCxAIkP42iyADYPSgBzAEFnXwC8ACwPFAC4aEsP3gDCAPgPkWjGAIsPuAAJAMhnxwDMAFsPIQDRaEYPPgDdAIgNXmjiALEOSQAhACVlfQDmAJQPcADvaN0PpQDuALMPx2jwAGoP3wA2AFpnMAD8AOkNTQD6aH4P3wADAQoPb2gFAYYPjwDNAfFnNwATAQAO/wAbaQYPygAgASkO22grAXAN4QD1AellnQA0AfUP8wA5aQ8OZAA9AcMPsWhFAfUP6QCBAWJm3ABGAWkO/ABMaSANpwBJAbMPumhQAXUPjwCXAfNnJQBZAbwPC/Tn+df3HWRBZTd11GgAnEIQUQDgncNutPea9L7yowhicG4XwP9lAewP4G3X/LbsPAto8ICayA2irE7+qBCHZO/4HRBVAXDp+Jig/WUi1QEwEmxvVPWRp/7VnAAYcbBjoQAdBagZBIrI9uXf2QDEHm/gQAgtC0IhZPi8huwDyfgdAIwZAIHg6T0ORQxU8SB+1PQZCHn5O8Gz8lP6tXSdh7d8oPgAERUj7Q0b/MOETS8+nIZliJFfDNcc+NddcQc5HH9z5EYRuXTYaG94AJwRD3b5aJAcZ5z3YZCl9y8Y1IJrnXrJKI9073uQcHBKZQ7lMwjXnavVMHdqgddxtZM4GsL2LAsH+DdJqH6tA24d+Yag7lALQH7FhhiGvOqkA94AqO//CM898+f/+I8QOIC06CQDlAPJfgz7FW/gftn7FBcAZyd3/IC5ghkCdICcav8MfYNeALsCrPefsZe30YxH4BG0HAEgRQECTx5BZQGfJHR+wqDD+ggPAKQqdHei/8cCwQYAfittB2sKaK4vdGqD/wR0fXkBozt0wcEHZHsFwMH+BQCr+QD7WwcAkVhrjAQEBcNZACcYAOmdl3D5wYOLwGpr/RUFh2OTwGyWwAfCx6hdasMGAKGj/fmo/cIEANtr38D7cQHva5rD/lTFWat4w//FwcYBxcf+CgBZdFpwBf9+qA4Azn6cwwShx/3ExMfGBQATghldBADUhiLA8wQFjYgiNAQAl0/0EmIByo4i//45w/qXKAcAXJJQqcDGYAFhk0yEwm4RBZWSonTAwsIGwpflww0AxJs0O/7+lsH9/f/BJsEAuvQ7LAMApp+xwQ5ohaDQ/v38P/34ljALAGKjRmLDw6qeEQCIpNc5/PyR//39/v39OP/5lf0HAKqkSTn7/5T6CwDTpDA7/cWV/v79NBUAZqd1qPT5+/4g/e0wxZZtBQBVrkYHwcZsAXCxMMTGwwA/3E3AwDsEACC2NSgFAEm5Rn7BAMqpTTANANTBg//5ljNLPhEA3wA9+Jf9Qf4+R3XBAMG4ViwOAPDkhf3+l0HAS8H+B8VN43/FbP8HAKM3bS1WBQC/9GlCywDenV//M1X//qEPBYj2Vv01REEFwPpsAVX7Bm4D1fAGP/oGEGYEgzrBxqoFEFgIg4jNEJ5lgsNAbwcQKxtslV3+BBDGI7VNAHgyJwzBwf/PEN5DcUf+wjAJ1TIqZ4bB/4MEEBgzdS4CEB00LfzDEPNfe3j9BBAr/TQkYhE6OwzBSQXExZMGEDZAF5S2BBVzQD19BhDZgHfHlH8DEPJHWgcLFVRNF5lRxFbDENQlZi/BBhBBnAx5llNCAAtDAcUADi1TAAAAAAAAAA',
`CmdCommitTime` = '2015-01-28 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415330';	

UPDATE `ilg_device_cmd` SET
`device_id` = '61',
`CmdContent` = 'DATA FP PIN=53890710\tFID=3\tSize=1302\tValid=1\tTMP=SpNTUzIxAAAD0NMECAUHCc7QAAAb0WkBAAAAg30fmtAjAAAOnwDrAHzehQAvAP4PFgA20IwPpQA9AM8O5NA8ABoPogCQAIPfcgBeAGsPSwBq0AIPaQB8ADcP99B+AJsPWABYAOffZwCyAFMPdwCw0CMPcgC3ACsPitC2AA4PmgAKACDedQDRAPAOvwDh0EMOkgDiAPQOr9DjAKQORwArAEDfjgDuADoOnwD50CgPeQAFAX4OgNANAa4OiADcAaPe2QAbAawPXgAe0bUPVQAlAd4Pu9BJAZsPrIMsBrEosYMxdIGDqAKCU5f1BXZvhL4RKly8jiYM9Y4uE6BTxHphf74C4GtlqA7sXYcNmy8TXVjjEX7zn4NSE0irxJK++XL1+WfWol9lvgHeFmKAJ0+U4tED9SJc783wrPWBgwUXALFO12/k8VVBEpAKmysgEdHyXXe4g028VB43ASdW1QveKjuY8epmcPvq49/sHqaAbPfAEO4vkPTp7YXm6hJUK3oLVRVlC6P7KSdKYFNtj+kG8oQvziULCCA1xAI5y/oFAL4VDDlvBdCvGIB4wArFnRzQw/z9/sHD4gUDRSN9wmUFAFglABEiBACjLgP9BANQLnp4BgDX/Rf9Ef/BCgCqPsP+wy3B/8BZBAAvPhSQEQBdQPTAO/7CEikrTBEAV4jt/C7+/sH8wv46/sIv/koIAJ5SRsF6UgYAplYJ/zv+XtQBnld9dQTFb1+ggg8ASmLi60FFL//AwAQAcKdre9UBkmb9/i/MAIm6e5KE/wgAc3ETEEFUDACOcsUzTBBHCwCId3cG/8dVwYQMAIp3w8H+lDRXEgBZmiUz/5H+wDj//lvQADl210//Qf5BOMD+EsE+BQCusFaeCdC3shwwXTDWAGZlV3SQw8TCBML9L8HAcAsAjXIJJxDBWMAJALNyIkeEwAMAlsyMAwwDo8zc/Pj+/zn9wRB8CwCb0ycE/vxRagYAcNVTBsPFERYAONvQTDr+/C///v07wf79/0raAZbjKf10BmIP0JDmMELCwq8nG9D+66nAWYsEwJQTwMJ8wMGMyABEIUeOwMX/wgf8cNQBkPE9jBfF+/F5wcDAwcHBB8DBQsKAfnEQALD+rin8/Pj6/v46/8ARwMDACgBaOjDGEcIuewMQgMLGwdsBiupA/8MBdmvzEfsJt8RYOsPDWMLCwcTEwaPCwhHGwsLB+8EFwMD6FhB4Epf9O/oo9P39/f1WN7YDEwweJP4JEFfsHH0tbgcQUDsaBcLDkwcQS0cP/bsDE+pXCfxSQgDOQwLQAQtFUg',
`CmdCommitTime` = '2015-01-28 16:41:00',
`CmdTransTime` = NULL,
`CmdOverTime` = NULL,
`CmdReturn` = NULL,
`person_id` = NULL
WHERE `id` = '415331';	





--------------------  cloudtime quala feb 5

ALTER TABLE `ilg_device`
CHANGE `device_type_id` `device_type_id` bigint(20) NOT NULL DEFAULT '1' COMMENT '1= ENROLL_ATT 2=ENROLL 3 = ATT' AFTER `id`,
COMMENT='';

ALTER TABLE `ilg_device`
CHANGE `cmdPermissions` `cmdPermissions` varchar(255) COLLATE 'utf8_general_ci' NOT NULL DEFAULT 'INFO;CHECK;DATA;REBOOT;QUERY' COMMENT 'Commandos permitidos para enviar al dispositivo' AFTER `status_id`,
CHANGE `TransTimes` `TransTimes` varchar(50) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '00:00;14:05' COMMENT 'Indicates the time (time: minute in a 24-hour format) to regularly check and transfer data. A semicolon is used to separate a maximum amount of ten time settings' AFTER `LastActivity`,
CHANGE `TransInterval` `TransInterval` int(11) NOT NULL DEFAULT '2' COMMENT 'Indicates the interval (unit: minute) during which new data is checked and transferred' AFTER `TransTimes`,
CHANGE `numDevAtts` `numDevAtts` int(11) NOT NULL DEFAULT '0' AFTER `TransInterval`,
CHANGE `numAtts` `numAtts` int(11) NOT NULL DEFAULT '0' AFTER `numDevAtts`,
CHANGE `numDevFPs` `numDevFPs` int(11) NOT NULL DEFAULT '0' AFTER `numAtts`,
CHANGE `numFPs` `numFPs` int(11) NOT NULL DEFAULT '0' AFTER `numDevFPs`,
CHANGE `numDevUsers` `numDevUsers` int(11) NOT NULL DEFAULT '0' AFTER `numFPs`,
CHANGE `numUsers` `numUsers` int(11) NOT NULL DEFAULT '0' AFTER `numDevUsers`,
CHANGE `LogStamp` `LogStamp` varchar(20) COLLATE 'utf8_general_ci' NOT NULL DEFAULT 'None' AFTER `numUsers`,
CHANGE `UpdateDB` `UpdateDB` varchar(200) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '1111100000' AFTER `LogStamp`,
CHANGE `OpLogStamp` `OpLogStamp` varchar(20) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '0' AFTER `UpdateDB`,
CHANGE `PhotoStamp` `PhotoStamp` varchar(20) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '0' AFTER `OpLogStamp`,
CHANGE `TZAdj` `TZAdj` smallint(6) NOT NULL DEFAULT '-5' AFTER `PhotoStamp`,
CHANGE `auto_process` `auto_process` char(1) COLLATE 'utf8_general_ci' NOT NULL DEFAULT 'T' COMMENT 'T: Procesar marcaciones automaticamente Otro:  No Procesar' AFTER `FPVersion`,
CHANGE `error_delay` `error_delay` varchar(25) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '60' COMMENT 'Indicates the interval (unit: second) between attempts to reconnect to the server after a network connection failure occurs.' AFTER `speeding`,
CHANGE `delay` `delay` varchar(25) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '30' COMMENT 'Indicates the interval (unit: second) between attempts to connect to the server in the event of proper network connection.' AFTER `error_delay`,
CHANGE `realtime` `realtime` varchar(25) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '1' COMMENT 'Indicates whether to realtime transfer new records. When Realtime=1, new data, if any, is transferred to the server. When Realtime=0, the data is transferred at the time specified by TransTimes and TransInterval.' AFTER `delay`,
CHANGE `encrypt` `encrypt` varchar(25) COLLATE 'utf8_general_ci' NOT NULL DEFAULT '0' COMMENT 'Indicates whether to encrypt the transferred data (ZKSoftware-specified encryption algorithm is used for encrypted transfers)' AFTER `realtime`,
COMMENT='';


UPDATE `ilg_person` SET
`area_id` = '431'
WHERE `area_id` IN (302);

DELETE FROM `ilg_payroll_period_sum`
WHERE `area_id` IN (431);

UPDATE `ilg_payroll_period_sum` SET
`area_id` = '431'
WHERE `area_id` IN (302);

DELETE FROM `ilg_area`
WHERE `id` = '302';


-----------------------   Cloudvoice  id 8 characters transaction 

ALTER TABLE `transaction`
ADD `an_id` varchar(10) NULL AFTER `id`,
COMMENT='';


ALTER TABLE  `transaction` 
ADD `phrase_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE  `transaction` 
ADD INDEX `phrase_id` (`phrase_id`);
ALTER TABLE  `transaction` 
ADD FOREIGN KEY (`phrase_id`) REFERENCES `phrase` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

Update transaction t
INNER JOIN configuration c on t.configuration_id = c.id
SET t.phrase_id =  c.phrase_id;

----------------------- cloudvoice agregar nivel y agregar menu  report@speaker

INSERT INTO `bi4cg_viewlevels` VALUES 
(27,	'speakerreport',	'Reporte de Empleados',	2,	'[19,38,37,8]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(27,	19),
(27,	38),
(27,	37),
(27,	8);

------------------  cloudvoice crea perfil mesa de ayuda,  quitar Generar huella

INSERT INTO `bi4cg_viewlevels` VALUES 
(28,	'speakerreport',	'Reporte de Empleados',	2,	'[19,38,37,8]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
(28,	19),
(28,	38),
(28,	37),
(28,	8);

UPDATE `bi4cg_viewlevels` SET
`id` = '8',
`title` = 'speakers',
`description` = 'Hablantes',
`ordering` = '2',
`rules` = '[8,19,37,38]'
WHERE `id` = '8';

DELETE FROM `bi4cg_usergroup_vl`
WHERE `id` = '39' AND `vl_id` = '8' AND `id` = '39' LIMIT 1;

UPDATE `bi4cg_viewlevels` SET
`id` = '10',
`title` = 'area',
`description` = 'Areas',
`ordering` = '2',
`rules` = '[8,19,37,38]'
WHERE `id` = '10';

DELETE FROM `bi4cg_usergroup_vl`
WHERE `id` = '39' AND `vl_id` = '10' AND `id` = '39' LIMIT 1;


-----------------------  cloudvoice reportes


---------------------  cloudtime novedades en medio

ALTER TABLE `ilg_payroll_notice_type`
ADD `paid` char(1) COLLATE 'utf8_general_ci' NULL DEFAULT 'F' AFTER `workcode`,
COMMENT='';

 UPDATE ilg_payroll_notice_type pnt 
 INNER JOIN  ilg_payroll_notice pn on pn.type_id = pnt.id
 SET pnt.paid = pn.paid;
 
 ALTER TABLE `ilg_payroll_notice`
DROP `paid`,
COMMENT='';

ALTER TABLE `ilg_payroll_notice` 
ADD `hour_report_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_payroll_notice` 
ADD INDEX `hour_report_id` (`hour_report_id`);
ALTER TABLE `ilg_payroll_notice` 
ADD FOREIGN KEY (`hour_report_id`) REFERENCES `ilg_hour_report` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 

ALTER TABLE `ilg_payroll_notice`
ADD `user_ended` char COLLATE 'utf8_general_ci' NULL DEFAULT 'F',
COMMENT='';

UPDATE `ilg_payroll_notice_type` SET
`paid` = 'F'
WHERE `paid` IS NULL;

UPDATE `ilg_payroll_notice_type` SET
`code` = id
WHERE `code` IS NULL;

UPDATE `ilg_concept` SET
`code` = id
WHERE `code` IS NULL;

--muestra novedades que fueron creadas desde dispositivo
SELECT prn.*
FROM ilg_payroll_notice prn  
INNER JOIN ilg_attendance at ON ( at.time = prn.start_time  or at.time = prn.end_time )
where at.work_code is not null and at.work_code != 0 and prn.hour_report_id is null;

DELETE a
FROM bi4cg_users as a, bi4cg_users as b
WHERE
(a.username = b.username OR a.username  IS NULL AND b.username IS NULL)
      AND b.ID < a.ID;

ALTER TABLE `bi4cg_users`
ADD UNIQUE `unique_username` (`username`);

---------------------   cloudtime encontrar personas que tienen mas de un contrato activo, arreglar
SELECT person_id,count(person_id) as c
FROM ilg_contract
where status_id = 1
group by person_id
HAVING c > 1;

select count( * ) from ilg_contract  c
inner join ilg_person p on p.id = c.person_id
where c.branch_office_id is null;


SELECT t1.*
FROM ilg_contract AS t1 
LEFT OUTER JOIN ilg_contract AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.status_id > t2.status_id
	OR (
		t1.status_id = t2.status_id
		AND t1.id < t2.id
	)
)
where t2.person_id IS NULL and  t1.status_id = 1 and  t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) ;

update ilg_contract t1
LEFT OUTER JOIN ilg_contract AS t2 ON 
t1.person_id = t2.person_id
AND (
	t1.status_id > t2.status_id
	OR (
		t1.status_id = t2.status_id
		AND t1.id < t2.id
	)
)
set t1.status_id = 2
where t2.person_id IS NULL and  t1.status_id = 1 and  t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) ;

select c.*
from ilg_contract c
inner join ilg_person p on p.id = c.person_id
where p.branch_office_id != c.branch_office_id
AND c.status_id = 1;

update ilg_contract  c
inner join ilg_person p on p.id = c.person_id
set c.branch_office_id = p.branch_office_id
where p.branch_office_id != c.branch_office_id
AND c.status_id = 1;













SELECT t1.*, p.branch_office_id
FROM ilg_contract AS t1
inner join ilg_person p on p.id = t1.person_id
LEFT OUTER JOIN ilg_contract AS t2 ON t1.person_id = t2.person_id
AND (
	t1.started_date > t2.started_date
	OR (
		t1.started_date = t2.started_date
		AND t1.id > t2.id
	) OR (
		p.branch_office_id != t1.branch_office_id
	)
)
where t2.person_id IS NULL and t1.status_id = 1 and t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) order by t1.person_id;

SELECT distinct t1.*
FROM ilg_contract AS t1 
LEFT OUTER JOIN ilg_contract AS t2 ON t1.status_id = 1 and t1.person_id = t2.person_id
AND (
	t1.started_date < t2.started_date
	OR (
		t1.started_date = t2.started_date
		AND t1.id < t2.id
	)
)
where t2.person_id IS NULL and  t1.status_id = 1 and  t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) order by t1.person_id;


update ilg_contract  c
inner join ilg_person p on p.id = c.person_id
set c.branch_office_id = p.branch_office_id
where c.branch_office_id is null;


update ilg_contract t1
inner join ilg_person p on p.id = t1.person_id
LEFT OUTER JOIN ilg_contract AS t2 ON t1.person_id = t2.person_id
AND (
	t1.started_date > t2.started_date
	OR (
		t1.started_date = t2.started_date
		AND t1.id > t2.id
	) OR (
		p.branch_office_id != t1.branch_office_id
	)
)
set t1.status_id = 2
where t2.person_id IS NULL and t1.status_id = 1 and t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) ;

update ilg_contract t1
LEFT OUTER JOIN ilg_contract AS t2 ON t1.status_id = 1 and t1.person_id = t2.person_id
AND (
	t1.started_date < t2.started_date
	OR (
		t1.started_date = t2.started_date
		AND t1.id < t2.id
	)
)
set t1.status_id = 2
where t2.person_id IS NULL and  t1.status_id = 1 and  t1.person_id in ( 
	select person_id from (
		SELECT person_id,count(person_id) as c
		FROM ilg_contract
		where status_id = 1
		group by person_id
		HAVING c > 1
	) as inn1 
) ;



-----------------  cloudtime auditoria dispositivo
SELECT target, date( creation_date ) as d, count(*) as c
FROM `audit`
where target = 'Dispositivo'
group by target, date( creation_date )
order by d desc
LIMIT 50


ALTER TABLE `ilg_config` 
ADD INDEX `enterprise_id` (`enterprise_id`);
ALTER TABLE `ilg_config` 
ADD FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enteprise` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT; 


----  cloudvoice helpdesk editspeaker

INSERT INTO `bi4cg_viewlevels` (`title`, `description`, `ordering`, `rules`)
SELECT 'editspeaker', 'Crear, Editar y Borrar Hablante', '2', '[19,38,37,8]'
FROM `bi4cg_viewlevels`
WHERE ((`id` = '27'));

INSERT INTO `bi4cg_usergroup_vl` VALUES 
(28,	19),
(28,	38),
(28,	37),
(28,	8);

------ cloudtime admin report
UPDATE `ilg_enterprise` SET
`expiration_date` = now() + interval 1 year
WHERE `expiration_date` IS NULL

INSERT INTO `bi4cg_viewlevels` (`title`, `description`, `ordering`, `rules`) VALUES
('adminreport', 'Reporte Administración', '2', '[8,15]' );

INSERT INTO `bi4cg_usergroup_vl` VALUES 
(59,	15),
(59,	8);


SELECT e.name , 
	e.expiration_date,
	( SELECT count(*)
		FROM ilg_device dev
		WHERE dev.enterprise_id = e.id
		AND dev.status_id = 1 
	) as numdev,
	( SELECT SUM( case when TIMESTAMPDIFF(SECOND, dev.LastActivity, NOW() ) > 120  then 0 
				when dev.LastActivity IS NULL  then 0 else 1 end	)
		FROM ilg_device dev	
		WHERE dev.enterprise_id = e.id
		AND dev.status_id = 1	
	) as numonline,
	c.max_number_devices,
	( SELECT count(*)
		FROM ilg_attendance att
		WHERE DATE(att.time) = DATE(now())
			and att.enterprise_id = e.id
	)		as numattday,
	( SELECT substring_index( group_concat( concat(name , ",", DATE(lastvisitDate ) ) ), ',',4 )
			 FROM bi4cg_users u
			 WHERE u.enterprise_id = e.id 
				AND u.name NOT LIKE '%soporte%'
				AND u.block = 0
			 ORDER BY lastvisitDate  DESC			 
	) as lastlogins,
	( SELECT count(*)
		FROM ilg_person p
		WHERE p.enterprise_id = e.id
		AND p.status_id = 1 
	) as numempl,
	c.max_number_employees	
FROM ilg_enterprise e
INNER JOIN ilg_config c ON c.enterprise_id = e.id
WHERE e.status_id = 1
ORDER BY e.expiration_date 


SELECT e.name , 
	( SELECT SUM( case when TIMESTAMPDIFF(SECOND, dev.LastActivity, NOW() ) > 120  then 0 
				when dev.LastActivity IS NULL  then 0 else 1 end	)
		FROM ilg_device dev	
		WHERE dev.enterprise_id = e.id
		AND dev.status_id = 1	
	) as numonline
FROM ilg_enterprise e
INNER JOIN ilg_config c ON c.enterprise_id = e.id
WHERE e.status_id = 1
ORDER BY e.expiration_date 



SELECT e.name , 
	( SELECT count(*)
		FROM ilg_person p
		WHERE p.enterprise_id = e.id
		AND p.status_id = 1 
	) as numempl
FROM ilg_enterprise e
INNER JOIN ilg_config c ON c.enterprise_id = e.id
WHERE e.status_id = 1
ORDER BY e.expiration_date 


---------------  cloudtime cambios quala
UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, ',8,', ',8,26,') 
where title = 'hours';

INSERT INTO `bi4cg_usergroup_vl` VALUES 
(12,	26);

UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, ',26', ',') 
where title = 'hourconceptreport';

DELETE ug FROM `bi4cg_usergroup_vl` ug  
where vl_id = 48 and  id = 26;

------------  cloudtime agregar reprocess_large
INSERT INTO `bi4cg_viewlevels` (`title`, `description`, `ordering`, `rules`) VALUES
( 'reprocess_large', 'Reprocesar entre fechas.', '2', '[8,15,28]' );

INSERT INTO `bi4cg_usergroup_vl` VALUES 
(60,	8),
(60,	15),
(60,	28);



----- duplicados cloudtime


SELECT distinct p1.* FROM ilg_hour_report p1 inner join ilg_hour_report p2 WHERE 
p1.id < p2.id 
and p1.enterprise_id = 63
and p1.start_time > '2015-02-01 00:00:00'
and p1.person_id = p2.person_id 
and p1.start_time = p2.start_time 
and p1.end_time = p2.end_time 
and p1.start_attendance_id = p2.start_attendance_id 
and p1.end_attendance_id = p2.end_attendance_id 
and p1.enterprise_id = p2.enterprise_id 
order by p1.person_id, p1.start_time desc;




SELECT distinct p1.* FROM ilg_hour_concept p1 inner join ilg_hour_concept p2 WHERE 
p1.id < p2.id 
and p1.enterprise_id = 63
and p1.start_time > '2015-03-01 00:00:00'
and p1.person_id = p2.person_id 
and p1.concept_id = p2.concept_id 
and p1.hours = p2.hours 
and p1.start_time = p2.start_time 
and p1.end_time = p2.end_time 
and p1.enterprise_id = p2.enterprise_id 
order by p1.person_id, p1.start_time desc;


SELECT distinct p1.* FROM ilg_payroll_notice p1 inner join ilg_payroll_notice p2 WHERE 
p1.id < p2.id 
and p1.start_time > '2015-03-01 00:00:00'
and p1.enterprise_id = 63
and p1.person_id = p2.person_id 
and p1.start_time = p2.start_time 
and p1.end_time = p2.end_time 
and p1.enterprise_id = p2.enterprise_id 
order by p1.person_id, p1.start_time desc;


-----------  cloudtime  mensajes a empresa

ALTER TABLE `ilg_enterprise`
ADD `days_to_message` smallint(5) NULL DEFAULT '8',
ADD `expiration_message` varchar(2000) COLLATE 'utf8_bin' NULL DEFAULT 'Restan %DAYS% días para que expire su subscripción.' AFTER `days_to_message`,
COMMENT='';

-----------  cloudtime notificaciones correo reportes
ALTER TABLE `ilg_notification`
ADD `description` varchar(500) COLLATE 'utf8_general_ci' NULL AFTER `name`,
COMMENT='';

ALTER TABLE `ilg_config`
ADD `mess_mail` varchar(1) COLLATE 'utf8_general_ci' NULL COMMENT 'Habilitar las notificaciones por correo' AFTER `sms_audio`,
COMMENT='';


ALTER TABLE `ilg_notification`
DROP FOREIGN KEY `ilg_notification_ibfk_2`,
ADD FOREIGN KEY (`period_id`) REFERENCES `ilg_period` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT;

DELETE FROM `ilg_period`
WHERE ((`id` = '1') OR (`id` = '2'));

-- Adminer 4.1.0 MySQL dump
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';
DROP TABLE IF EXISTS `ilg_period`;
CREATE TABLE `ilg_period` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `period_type` tinyint(4) DEFAULT NULL COMMENT 'EACH_DAY = 0,EACH_WEEK = 1,EACH_MONTH = 2, EACH_SPECIFIC_DAY =3',
  `specific_month_day` tinyint(4) DEFAULT NULL COMMENT '1-31',
  `specific_week_day` varchar(50) DEFAULT NULL COMMENT 'MONDAY... ',
  `status_id` bigint(20) NOT NULL,
  `initial_date` date DEFAULT NULL COMMENT '',
  `expiration_date` date DEFAULT NULL COMMENT 'NULL no expiration',
  `last_execution` date DEFAULT NULL COMMENT 'NULL no execution',
  `enterprise_id` bigint(20) NOT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),
  KEY `branch_office_id` (`branch_office_id`),
  CONSTRAINT `ilg_period_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ilg_period_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `ilg_priod_ibfk_3` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `ilg_period`
ADD `execution_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'hora de ejecucion del reporte' AFTER `last_execution`,
COMMENT='';

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';
DROP TABLE IF EXISTS `ilg_task_category`;
CREATE TABLE `ilg_task_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `ilg_task`;
CREATE TABLE `ilg_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `result` varchar(2000) DEFAULT NULL,
  `creation_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `start_date` datetime NOT NULL,
  `finish_date` datetime DEFAULT NULL,
  `files_path` varchar(200) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `type` tinyint(4) NOT NULL,
  `progress` tinyint(4) NOT NULL DEFAULT '0',
  `created_by` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,
  `object_id` bigint(20) DEFAULT NULL,
  `notify_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `branch_office_id` (`branch_office_id`),
  KEY `object_id` (`object_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `ilg_task_category` (`id`),
  CONSTRAINT `task_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `bi4cg_users` (`id`),
  CONSTRAINT `task_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`),
  CONSTRAINT `task_ibfk_5` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `ilg_notification`
ADD `rule_parameters` varchar(2000) COLLATE 'utf8_general_ci' NULL AFTER `rule_data`,
COMMENT='';


INSERT INTO `ilg_task_category` (`id`, `name`, `description`)
VALUES ('1', 'REPORTE', 'Generación y Envío de Reporte');


ALTER TABLE `bi4cg_users`
ADD `cellphone` varchar(100) COLLATE 'utf8_general_ci' NULL AFTER `email`,
COMMENT='';


UPDATE bi4cg_users
SET lastResetTime = REPLACE(lastResetTime, '0000-00-00 00:00:00', '1970-01-01 00:00:00');

UPDATE bi4cg_users
SET lastvisitDate = REPLACE(lastvisitDate, '0000-00-00 00:00:00', '1970-01-01 00:00:00');

INSERT INTO `bi4cg_viewlevels`  VALUES
('62','tasks', 'Administrar Tareas','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('62', '15'),('62', '19'),('62', '8'),
('62', '29'),('62', '25'),('62', '28');

SELECT *
FROM `ilg_person`
WHERE `identification` IN (1,1234,9988,111111,437637,441331,453038,1137703,2234909,2969283,3029358,3070322,3070479,3103780,3212728,3251873,3251961,4546894,5820322,5826359,7175202,7186347,7536338,7634393,7719104,9087082,9390006,10026269,10965302,11187905,11224491,11276842,11276878,11325131,11685420,11705910,13526232,14296785,14297708,14327354,14838571,16090131,16376567,16629046,18882129,20892384,20911238,20965243,21022864,21057533,23755814,27604281,28869913,28968291,31309242,31579914,32208052,35421622,35421682,35422159,35423504,35424187,35424846,35428416,35428516,37507101,39626928,39726475,39804543,40610886,41960474,43148537,45646091,46458117,51571484,52150655,52158003,52198220,52234368,52275082,52290985,52360122,52458711,52469270,52488018,52615624,52666655,52708125,52708981,52709820,52725792,52727038,52743938,52747676,52750173,52755692,52757795,52759393,52761023,52761451,52761696,52772893,52777675,52780166,52822687,52840723,52842527,52851423,52888390,52898506,52916913,52917402,52928910,52930292,52932807,52956444,52977378,52979595,52982842,52987022,52992782,52999108,53004620,53004905,53037580,53037650,53039051,53039907,53041198,53044535,53048748,53049547,53051103,53053491,53062343,53064491,53083088,53089080,53091721,53092139,53094038,53094134,53099893,53100670,53102227,53117376,53117621,53128963,53132430,53167553,53890417,53891413,53892492,53892703,53893737,53911498,53925186,53935007,60393528,63438397,64553072,64894199,65709674,69802438,72003948,72282299,72329935,72357421,73009625,73159837,73166988,73191132,73208911,74081354,74334955,74366090,74378303,77093820,79217105,79221310,79222308,79222635,79223305,79223389,79223592,79319916,79381168,79467537,79525169,79580422,79639423,79701935,79702840,79722370,79722372,79726359,79816731,79871221,79883280,79903495,79921565,79956576,79983114,79994744,80005485,80010786,80026023,80037718,80038074,80050881,80054670,80063825,80072975,80108198,80119305,80128478,80132290,80137614,80142637,80142968,80147892,80156106,80159006,80162161,80164817,80171067,80171961,80175493,80192233,80201971,80204617,80209790,80209984,80211450,80212353,80212947,80213259,80215353,80216651,80225897,80231301,80239080,80248682,80249932,80357187,80492738,80538884,80543545,80543705,80545394,80545672,80546084,80547638,80548338,80548855,80549207,80549338,80549363,80549898,80550098,80550432,80657135,80722139,80738038,80738784,80743130,80745125,80746533,80749720,80751199,80751606,80751853,80763742,80771774,80772427,80774223,80774613,80792526,80792535,80797986,80798041,80804430,80811569,80811788,80813187,80813274,80816743,80817053,80824840,80824908,80825499,80828395,80830030,80833839,80844616,80850755,80853387,80859543,80870743,80872307,80874636,80878911,80879333,80879412,80879750,80881669,80882363,80896728,80897464,80903332,80903833,80904556,80912658,80921264,81715425,84450319,85166498,86078926,86082074,86084721,87062667,88030540,91519403,92547236,93155198,93236639,93295148,93299549,94533788,98671904,101236979,102238188,102294431,102299651,102451187,102453114,103057049,103238750,106942810,107210050,107381226,110708973,111819692,149684580,527143721,1000118966,1000158496,1000222672,1000805058,1000987766,1001183197,1001832217,1003801094,1003895049,1004612783,1004638118,1005460799,1005929436,1005929831,1006086662,1007098471,1007370118,1007662129,1007710539,1007787148,1010167057,1010169135,1010178929,1010179472,1010179681,1010180295,1010188129,1010189886,1010193362,1010193451,1010197120,1010199157,1010208937,1010211014,1010216792,1012321847,1012328237,1012328589,1012328989,1012330329,1012332734,1012333515,1012334684,1012337356,1012341875,1012342127,1012347208,1012347426,1012348591,1012348703,1012349467,1012349811,1012350579,1012351224,1012353832,1012354202,1012354727,1012359307,1012359552,1012360447,1012360698,1012361594,1012367563,1012368267,1012368306,1012369719,1012370227,1012370289,1012371083,1012375694,1012375742,1012376564,1012377435,1012378581,1012380760,1012388552,1012388866,1012389495,1012393866,1012395015,1012397281,1012398589,1012401296,1012401406,1012402316,1012403189,1012403294,1012404138,1012406705,1012408379,1012409066,1012409294,1012410482,1012411140,1012411184,1012411772,1012413102,1012413214,1012418632,1012420722,1012421090,1012421099,1013579853,1013583041,1013584738,1013585435,1013587016,1013603320,1013603510,1013610092,1013618552,1013625616,1013626080,1013629705,1013632941,1013634040,1013634119,1013640130,1013640537,1013641320,1013642268,1013644056,1013650917,1013652298,1013652905,1013658634,1013660118,1014197709,1014202338,1014209520,1014212448,1014219405,1014220820,1014226654,1014233007,1014234071,1014237100,1014238295,1014239346,1014243755,1014250595,1014251282,1014259677,1014262602,1014878302,1015395018,1015395991,1015401989,1015403612,1015409299,1015411486,1015413777,1015415035,1015416322,1015417302,1015418124,1015418800,1015418850,1015428840,1015431573,1015434269,1015992579,1015996851,1016001408,1016008495,1016009320,1016009763,1016017429,1016020177,1016027108,1016029024,1016034540,1016038740,1016040835,1016042717,1016070652,1016070870,1016083136,1017147471,1017168618,1018410303,1018416742,1018418943,1018422487,1018423919,1018434524,1018448584,1018454037,1018459663,1018461971,1018465258,1018474585,1018477137,1019014650,1019018149,1019022292,1019028627,1019028652,1019029323,1019030147,1019032484,1019042608,1019043727,1019055224,1019055678,1019056780,1019063634,1019077975,1019096399,1019097578,1019110627,1019234071,1020423289,1020426862,1020722082,1020722282,1020724473,1020724955,1020725149,1020731136,1020736564,1020748945,1020752923,1020755642,1020768101,1020771084,1020774444,1020779763,1020791043,1022323209,1022327405,1022330648,1022333220,1022336969,1022338955,1022339270,1022339423,1022341834,1022342990,1022349085,1022349886,1022353031,1022355728,1022356394,1022364743,1022370931,1022381245,1022381880,1022381965,1022383404,1022383974,1022384222,1022384287,1022384623,1022389653,1022389942,1022390435,1022392321,1022392789,1022393975,1022395408,1022407195,1022924477,1022924516,1022928313,1022934051,1022934999,1022935524,1022940294,1022942076,1022942365,1022944624,1022944696,1022956229,1022956302,1022957023,1022958115,1022959720,1022961533,1022962158,1022962370,1022963061,1022965819,1022966033,1022967340,1022970046,1022977287,1022978760,1022982783,1022982805,1022982832,1022983609,1022987019,1022990007,1022990215,1022994361,1022999981,1023000799,1023001464,1023002048,1023864156,1023866759,1023866898,1023868130,1023870555,1023874480,1023874800,1023876143,1023881365,1023884014,1023887367,1023888218,1023888233,1023889576,1023892753,1023892930,1023893526,1023895036,1023901047,1023901205,1023901585,1023903614,1023905265,1023910277,1023913707,1023914665,1023915820,1023915821,1023915836,1023917011,1023917321,1023924869,1023925549,1023927987,1023928943,1023930512,1023930997,1023931265,1023932116,1023932542,1023932548,1023935121,1023936676,1023937295,1023937715,1023940569,1023941407,1023941891,1023945047,1023948160,1023950002,1024462223,1024462329,1024465964,1024467935,1024468666,1024471242,1024473464,1024473580,1024476717,1024478563,1024479087,1024479797,1024480868,1024482403,1024483170,1024485863,1024487814,1024489110,1024491969,1024492636,1024495326,1024496083,1024496853,1024497593,1024498843,1024500586,1024500696,1024500792,1024502820,1024502980,1024504467,1024505410,1024505491,1024505786,1024505825,1024506763,1024507061,1024514149,1024514174,1024516474,1024516566,1024516957,1024518257,1024518438,1024518907,1024520307,1024520752,1024521654,1024523631,1024524421,1024525309,1024525313,1024526842,1024528235,1024528772,1024529178,1024529337,1024529510,1024531874,1024532462,1024533536,1024533996,1024534607,1024536880,1024537621,1024539871,1024540468,1024542027,1024544429,1024544786,1024548096,1024548545,1024549714,1024551622,1024551904,1024552390,1024554145,1024555658,1024556268,1024558574,1024560187,1024562125,1024569397,1024570006,1026263705,1026265365,1026270039,1026270879,1026271409,1026279264,1026280017,1026283765,1026286712,1026287470,1026295454,1026558110,1026563272,1026566303,1026569746,1026573613,1026580434,1027954220,1028006727,1030521692,1030525651,1030526808,1030530913,1030531263,1030531390,1030531745,1030533348,1030541040,1030544257,1030545467,1030546384,1030546887,1030548340,1030549439,1030549767,1030550521,1030551150,1030552612,1030554717,1030560115,1030564486,1030564612,1030567068,1030567509,1030568750,1030568752,1030570479,1030573188,1030577628,1030579131,1030581282,1030581846,1030583362,1030586079,1030587077,1030589035,1030589971,1030592070,1030593516,1030593760,1030594635,1030596620,1030598911,1030600361,1030601125,1030601277,1030602794,1030607940,1030608907,1030609083,1030610916,1030614681,1030615769,1030615778,1030617062,1030620252,1030620638,1030622455,1030622544,1030624540,1030630387,1030632627,1030632661,1030634185,1030639891,1030639916,1030640300,1030641022,1030647098,1030648734,1030650519,1030652021,1030669193,1031123890,1031124430,1031124668,1031129288,1031129783,1031132173,1031136479,1031136596,1031137985,1031138631,1031138645,1031138948,1031140808,1031143384,1031146133,1031146896,1031150225,1031150480,1031151219,1031151385,1031151773,1031151981,1031152893,1031155150,1031157458,1031159568,1031163904,1032357549,1032362659,1032363951,1032364171,1032364999,1032369086,1032373401,1032388929,1032402192,1032402409,1032403398,1032404208,1032408220,1032412558,1032413485,1032416238,1032421925,1032422905,1032423747,1032442115,1032450389,1032454814,1032459816,1032460850,1032461256,1032656034,1033679199,1033681046,1033685947,1033687385,1033692591,1033692809,1033701370,1033706006,1033707404,1033708907,1033709701,1033713997,1033715008,1033715016,1033715751,1033717642,1033717681,1033718213,1033718468,1033719227,1033720753,1033722255,1033723811,1033724365,1033725184,1033725749,1033726208,1033726533,1033728182,1033728701,1033729333,1033732671,1033732851,1033732935,1033733587,1033736091,1033736127,1033737670,1033739130,1033739176,1033739284,1033740405,1033742884,1033751131,1033751544,1033752674,1033756173,1033756572,1033756750,1033757835,1033758057,1033758087,1033758135,1033759454,1033759590,1033762388,1033764190,1033765340,1033765922,1033767594,1033770212,1033770728,1033772239,1033774356,1033776416,1033776930,1033779464,1033780192,1033785478,1033788838,1040357451,1041087014,1042762374,1044500660,1044614983,1045668834,1045676028,1045721733,1047219460,1048293309,1048849367,1049322555,1049796753,1049796760,1049825219,1049825667,1050723249,1051210745,1051316628,1051473570,1051475051,1051568226,1052382506,1052984860,1053330327,1053331265,1053337740,1053338558,1053764383,1053773729,1054538895,1054658747,1055550887,1055552060,1056028756,1056506231,1056954547,1057014509,1057184289,1057215031,1060103574,1060416525,1060594529,1061431104,1061624307,1061687506,1061742539,1063806007,1064312532,1064486153,1064708849,1064836732,1065373513,1065586217,1065593980,1065614660,1066733781,1067404154,1067843765,1067897934,1067899722,1067902658,1068656145,1068926810,1068928358,1069053066,1069053283,1069078648,1069099316,1069099714,1069099809,1069099817,1069100006,1069100185,1069174907,1069257892,1069261750,1069262424,1069262725,1069264096,1069432573,1069432810,1069433139,1069483947,1069735617,1069740401,1069852556,1069925091,1070004330,1070005964,1070007676,1070304506,1070306558,1070586119,1070594113,1070610464,1070808419,1070945944,1070954459,1071142822,1071328074,1071328286,1071328873,1071329205,1071329333,1071329435,1071329995,1071330062,1071330078,1071330164,1071330244,1071330287,1071330504,1071330612,1071330664,1071330873,1071349657,1071580656,1071608408,1071914850,1072188661,1072189035,1072190054,1072190260,1072190990,1072191819,1072191913,1072192258,1072192385,1072193706,1072194051,1072338693,1072366061,1072493119,1073159806,1073160873,1073230870,1073233512,1073236109,1073238266,1073305508,1073532211,1073532486,1073532504,1073532517,1073532869,1073533017,1073533225,1073533286,1073533351,1073533374,1073534030,1073603417,1073669429,1073670991,1073672077,1073672091,1073672471,1073673748,1073674184,1073678834,1073681467,1073681548,1073681566,1073682032,1073684012,1073684867,1073684948,1073685809,1073685816,1073686813,1073686842,1073686932,1073687615,1073688427,1073689043,1073689629,1073692233,1073692426,1073694760,1073701196,1073704771,1073706751,1073812260,1073998126,1074186930,1074576716,1074960063,1074960093,1075072106,1075228413,1075278591,1075541048,1075650433,1075651321,1075652596,1075652919,1075653720,1075654562,1075655216,1075655847,1075656095,1075657557,1075657806,1075659303,1075659677,1075660250,1075660798,1075661056,1075661232,1075661250,1075661431,1075661460,1075662071,1075662355,1075662519,1075662748,1075662755,1075662779,1075663338,1075663637,1075664184,1075664218,1075664584,1075665570,1075666605,1075667507,1075667554,1075667570,1075668044,1075668462,1075669020,1075669156,1075669212,1075670603,1075670811,1075671011,1075671246,1075675249,1075675515,1075675518,1075870744,1075871351,1075873290,1075874516,1076220509,1076220770,1076650891,1076657065,1076659068,1077083430,1077083616,1077083979,1077084470,1077084902,1077085066,1077085497,1077085519,1077085703,1077086010,1077086099,1077086347,1077086519,1077086841,1077087034,1077087046,1077087940,1077088003,1077146884,1077147744,1077148349,1077433669,1077470627,1077940911,1077941696,1078346442,1078346546,1078346726,1078346866,1078347331,1078347384,1078347495,1078347524,1078347594,1078347792,1078347859,1078348057,1078348130,1078348253,1078348259,1078348552,1078348562,1078348697,1078348880,1078348989,1079033479,1079174544,1079175538,1079409103,1080180458,1080185501,1080293540,1081152514,1081182679,1081393378,1081402638,1081916888,1082126862,1082850566,1082852752,1082935174,1082945460,1082983916,1083570463,1083897018,1083911157,1084257221,1084731609,1085269634,1085298885,1085306155,1086725256,1088236802,1090336984,1090393695,1090410759,1090434244,1093218846,1093756163,1094887324,1094895893,1094910904,1094916901,1095820844,1095930289,1096183243,1096197592,1096204684,1096484199,1096947706,1096950810,1097032969,1097033693,1097664754,1097666167,1098650875,1098670050,1099212818,1099552509,1100482123,1101812708,1101816107,1103215659,1103218245,1104706022,1104707774,1105058219,1105058262,1105058956,1105059465,1105306184,1105687913,1105783963,1105784288,1105786177,1106306381,1106396959,1106452927,1106768744,1106769563,1106772690,1106779338,1106780470,1106784337,1106860739,1106891391,1107052998,1108934796,1109001247,1109069978,1109383511,1109416308,1109492118,1109493892,1109494542,1109843498,1110176409,1110176666,1110176764,1110470836,1110492216,1110517901,1110524596,1110553283,1111196088,1111779138,1112773647,1113308343,1113620987,1113622774,1113627500,1113782771,1114118657,1114208722,1115073211,1115850940,1115947790,1116547658,1116800195,1118168974,1118299582,1118532166,1119215614,1120355157,1121834999,1121849210,1121876434,1121899631,1121912440,1122118985,1122120470,1122647206,1122678040,1124216479,1126449921,1128056970,1129520113,1129533355,1129575388,1130599643,1130607327,1130623331,1130643463,1130662495,1130681087,1130945211,1130946277,1133684912,1136059381,1136879818,1136909371,1140814010,1140840503,1140859331,1143831166,1143960628,1144024419,1144041144,1144044358,1147687814,1149684501,1149684580,1151938327,1152689956) AND `enterprise_id` = '63'

ALTER TABLE `ilg_person`
ADD `code` varchar(5) COLLATE 'utf8_bin' NULL AFTER `cell_phone`,
COMMENT='';

ALTER TABLE `ilg_device`
ADD `device_model` tinyint(4) NULL DEFAULT '1' COMMENT 'null o 1 = ZTE, 2 = CELLPHONE' AFTER `device_type_id`,
COMMENT='';
ALTER TABLE `ilg_device`
CHANGE `device_status_id` `device_status_id` bigint(20) NULL DEFAULT '2' AFTER `expiration_date`,
COMMENT='';

ALTER TABLE `ilg_attendance`
ADD `gps_position` varchar(50) COLLATE 'utf8_bin' NULL COMMENT 'Posicion GPS' AFTER `photo`,
COMMENT='';

INSERT INTO `ilg_verification_mode` (`id`, `name`, `description`)
VALUES ('51', 'VOICE', 'VOICE');


DROP TABLE IF EXISTS `ilg_value_variable`;
CREATE TABLE `ilg_value_variable` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL,
  `field_label` varchar(100) NOT NULL,
  `field_oper` varchar(20) NOT NULL,
  `field_name` varchar(50) NOT NULL,
  `field_value` varchar(500) NOT NULL,
  `field_type` varchar(30) NOT NULL,
  `range_type` tinyint(4) DEFAULT NULL,
  `start_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'hora de inicio del reporte' ,
  `end_time` varchar(5) COLLATE 'utf8_general_ci' NULL COMMENT 'hora de finalización del reporte' ,
  `notification_id` bigint(20) DEFAULT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `branch_office_id` (`branch_office_id`),  
  KEY `notification_id` (`notification_id`),  
  CONSTRAINT `vv_ibfk_3` FOREIGN KEY (`notification_id`) REFERENCES `ilg_notification` (`id`) ON DELETE CASCADE,
  CONSTRAINT `vv_ibfk_4` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)ON DELETE CASCADE,
  CONSTRAINT `vv_ibfk_5` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-------- Cloudtime  Incomplete report

INSERT INTO `bi4cg_viewlevels`  VALUES
('63','incompletehr', 'Horas Trabajadas Incompletas','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('63', '15'),('63', '19'),('63', '8'),
('63', '29'),('63', '25'),('63', '28');


--------  cloudtime agregar funcionalidades por empresa

UPDATE bi4cg_viewlevels
SET rules = REPLACE(rules, '8', '8,28')
WHERE id in ( 11 );
INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('11', '28');

DROP TABLE IF EXISTS `ilg_viewlevels_enterprise`;
CREATE TABLE `ilg_viewlevels_enterprise` (
  `viewlevels_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Foreign Key to #__viewlevels.id',
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`viewlevels_id`,`enterprise_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_vle_ibfk_1` FOREIGN KEY (`viewlevels_id`) REFERENCES `bi4cg_viewlevels` (`id`),
  CONSTRAINT `ilg_vle_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
select distinct vl.id, e.id from bi4cg_viewlevels vl
inner join ilg_enterprise e;

INSERT INTO `bi4cg_viewlevels`  VALUES
('64','massive_notification', 'Notificaciones Masivas','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('64', '15'),('64', '19'),('64', '8'),
('64', '29'),('64', '25'),('64', '28');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) VALUES
('64','2');


ALTER TABLE `ilg_notification`
ADD `send_to_type` tinyint(4) NULL DEFAULT '1',
ADD `send_to_id` bigint(20) NULL AFTER `send_to_type`,
COMMENT='';

ALTER TABLE `ilg_config`
DROP `branch_office_id`;


----- codigo en lapsos de turnos

ALTER TABLE `ilg_calendar_time`
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL AFTER `name`,
COMMENT='';

UPDATE `ilg_calendar_time` SET
`code` = id
WHERE `code` IS NULL;

ALTER TABLE `ilg_calendar_time`
ADD `pay_extras_after` int(10) NULL COMMENT ' -2=Despues de horas de intervalo de turno  -1= Despues de intervalo de turno.  >0 Cantidad de horas ',
COMMENT=''; 

UPDATE `ilg_enterprise` SET
`status_id` = '1'
WHERE `id` = '34';

ALTER TABLE `ilg_calendar_time`
ADD `week_pos` int(10) NOT NULL DEFAULT '0' COMMENT 'ordinalidad en el numero de semanas en la que este turno aplica',
ADD `each_week` int(10) NOT NULL DEFAULT '1' COMMENT 'turno aplica cada este numero de semanas' AFTER `week_pos`;

ALTER TABLE `ilg_calendar_time`
ADD `mode` tinyint(4) NULL DEFAULT '1' COMMENT '1=REGULAR 2= FLEXIBLE';

ALTER TABLE `ilg_calendar_time`
ADD `flex_duration` varchar(5) COLLATE 'utf8_general_ci' NULL;

---------------  SubconceptItem

Los Conceptos tienen los subconceptitems asociados y no asociados
La empresa tiene los subconceptitems por defecto
Schedule tambien tiene el listado de subconceptitems
CalendarTime tambien tiene listado de subconceptitems



DROP TABLE IF EXISTS `ilg_sub_concept_item`;
CREATE TABLE `ilg_sub_concept_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alias_name` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,  
  `description` varchar(100) DEFAULT NULL,
  `type` tinyint(4) DEFAULT NULL COMMENT '1=rango de tiempo 2=tiempo despues de finalizado turno 3=todo el dia 3=tiempo' ,
  `param1` varchar(500) DEFAULT NULL,
  `param2` varchar(500) DEFAULT NULL,
  `param3` varchar(500) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `branch_office_id` (`branch_office_id`),  
  KEY `status_id` (`status_id`),  
  CONSTRAINT `sci_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sci_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `sci_ibfk_4` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `bi4cg_viewlevels`  VALUES
('65','subconcepts', 'Subconceptos','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('65', '15'),('65', '19'),('65', '8'),
('65', '29'),('65', '25'),('65', '28');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 65, id FROM ilg_enterprise;

DROP TABLE IF EXISTS `ilg_subconcepts_enterprise`;
CREATE TABLE `ilg_subconcepts_enterprise` (
  `subconceptitem_id` bigint(20) NOT NULL COMMENT '',
  `enterprise_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subconceptitem_id`,`enterprise_id`),
  KEY `enterprise_id` (`enterprise_id`),
  CONSTRAINT `ilg_sce_ibfk_1` FOREIGN KEY (`subconceptitem_id`) REFERENCES `ilg_sub_concept_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_sce_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`)  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_subconcepts_calendar_time`;
CREATE TABLE `ilg_subconcepts_calendar_time` (
  `subconceptitem_id` bigint(20) NOT NULL COMMENT '',
  `calendar_time_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subconceptitem_id`,`calendar_time_id`),
  KEY `calendar_time_id` (`calendar_time_id`),
  CONSTRAINT `ilg_scct_ibfk_1` FOREIGN KEY (`subconceptitem_id`) REFERENCES `ilg_sub_concept_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_scct_ibfk_2` FOREIGN KEY (`calendar_time_id`) REFERENCES `ilg_calendar_time` (`id`) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_subconcepts_schedule`;
CREATE TABLE `ilg_subconcepts_schedule` (
  `subconceptitem_id` bigint(20) NOT NULL COMMENT '',
  `schedule_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subconceptitem_id`,`schedule_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `ilg_scs_ibfk_1` FOREIGN KEY (`subconceptitem_id`) REFERENCES `ilg_sub_concept_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_scs_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `ilg_schedule` (`id`)  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_subconcepts_concept`;
CREATE TABLE `ilg_subconcepts_concept` (
  `subconceptitem_id` bigint(20) NOT NULL  COMMENT '',
  `concept_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subconceptitem_id`,`concept_id`),
  KEY `concept_id` (`concept_id`),
  CONSTRAINT `ilg_scc_ibfk_1` FOREIGN KEY (`subconceptitem_id`) REFERENCES `ilg_sub_concept_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_scc_ibfk_2` FOREIGN KEY (`concept_id`) REFERENCES `ilg_concept` (`id`)  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_not_subconcepts_concept`;
CREATE TABLE `ilg_not_subconcepts_concept` (
  `subconceptitem_id` bigint(20) NOT NULL  COMMENT '',
  `concept_id` bigint(20) NOT NULL,
  PRIMARY KEY (`subconceptitem_id`,`concept_id`),
  KEY `concept_id` (`concept_id`),
  CONSTRAINT `ilg_nscc_ibfk_1` FOREIGN KEY (`subconceptitem_id`) REFERENCES `ilg_sub_concept_item` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_nscc_ibfk_2` FOREIGN KEY (`concept_id`) REFERENCES `ilg_concept` (`id`)   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

---------------- License Manager

INSERT INTO `bi4cg_viewlevels`  VALUES
('66','license_manager', 'Adminitracion de Licencias','2', '[8,15]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('66', '15'),('66', '8');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) VALUES
('66','2');

ALTER TABLE `ilg_config`
ADD `hours_per_period` int(10) NOT NULL DEFAULT '240' COMMENT 'Tiempo de trabajo al mes en horas. 240 Por defecto.';

ALTER TABLE `ilg_person`
DROP `fingerprint`;

ALTER TABLE `ilg_person`
ADD `salary_month` decimal(11,2) NOT NULL DEFAULT '0',
ADD `salary_hour` decimal(11,2) NOT NULL DEFAULT '0' AFTER `salary_month`;

ALTER TABLE `ilg_concept`
ADD `surcharge` decimal(5,3) NOT NULL DEFAULT '1';

update ilg_concept c
set c.surcharge = 1.25
where c.name = 'HED';

update ilg_concept c
set c.surcharge = 1.35
where c.name = 'RN';

update ilg_concept c
set c.surcharge = 1.75
where c.name = 'HEN';

update ilg_concept c
set c.surcharge = 1.75
where c.name = 'HDD';

update ilg_concept c
set c.surcharge = 1.75
where c.name = 'HFD';

update ilg_concept c
set c.surcharge = 2
where c.name = 'HEDD';

update ilg_concept c
set c.surcharge = 2
where c.name = 'HEFD';

update ilg_concept c
set c.surcharge = 2.1
where c.name = 'HDN';

update ilg_concept c
set c.surcharge = 2.1
where c.name = 'HFN';

update ilg_concept c
set c.surcharge = 2.5
where c.name = 'HEDN';

update ilg_concept c
set c.surcharge = 2.5
where c.name = 'HEFN';

----------   etiquetas

DROP TABLE IF EXISTS `ilg_tag_category`;
CREATE TABLE `ilg_tag_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),  
  KEY `branch_office_id` (`branch_office_id`),  
  CONSTRAINT `tagcat_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tagcat_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `tagcat_ibfk_4` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_tag`;
CREATE TABLE `ilg_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `tag_category_id` bigint(20) NOT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `tag_category_id` (`tag_category_id`),  
  KEY `status_id` (`status_id`),  
  KEY `branch_office_id` (`branch_office_id`),  
  CONSTRAINT `tag_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tag_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `tag_ibfk_4` FOREIGN KEY (`tag_category_id`) REFERENCES `ilg_tag_category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tag_ibfk_5` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ilg_person_tags`;
CREATE TABLE `ilg_person_tags` (
  `person_id` bigint(20) NOT NULL  COMMENT '',
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`tag_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `ilg_pt_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_pt_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `ilg_tag` (`id`)   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `bi4cg_viewlevels`  VALUES
('67','tags', 'Etiquetas','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('67', '15'),('67', '19'),('67', '8'),
('67', '29'),('67', '25'),('67', '28');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 67, id FROM ilg_enterprise;

----------------  jefe de area


ALTER TABLE `ilg_area` 
ADD `head_person_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_area` 
ADD INDEX `head_person_id` (`head_person_id`);
ALTER TABLE `ilg_area` 
ADD FOREIGN KEY (`head_person_id`) REFERENCES `ilg_person` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 


------------------  Novedades a Conceptos

Un concepto puede ser pagado o no
Un concepto puede ser creado para una sucursal exclusivamente

ALTER TABLE `ilg_concept`
ADD `type` tinyint(4) NOT NULL DEFAULT 0,
COMMENT='';


ALTER TABLE `ilg_concept`
ADD `workcode` smallint(3) DEFAULT NULL,
COMMENT='';

ALTER TABLE `ilg_concept`
ADD `paid` char(1) COLLATE 'utf8_general_ci' DEFAULT 'T',
COMMENT='';

ALTER TABLE `ilg_concept`
ADD `branch_office_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_concept`
ADD INDEX `branch_office_id` (`branch_office_id`);
ALTER TABLE `ilg_concept`
ADD FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

ALTER TABLE `ilg_concept`
CHANGE `description` `description` varchar(2000) COLLATE 'utf8_bin' NULL AFTER `name`;

ALTER TABLE `ilg_hour_concept`
CHANGE `hour_report_id` `hour_report_id` bigint(20) NULL AFTER `id`;

ALTER TABLE `ilg_hour_concept`
ADD `type` tinyint(4) DEFAULT 0,
COMMENT='';


--Update ilg_concept au
--SET au.branch_office_id = ( select bo.id from ilg_branch_office bo where au.enterprise_id = bo.enterprise_id limit 1 );

--INSERT INTO `ilg_concept` (`name`, `description`, `code`, `initial_date`, `end_date`, `require_authorization`, `status_id`, `enterprise_id`, `report_order`, `surcharge`, `type`, `workcode`, `paid`, `branch_office_id`)
--SELECT `name`, `description`, `code`,  NULL, NULL,'F', `status_id`, `enterprise_id`, '0', '1.000', 1, `workcode`, `paid`, `branch_office_id`
--FROM `ilg_payroll_notice_type`;

ALTER TABLE `ilg_concept`
CHANGE `description` `description` varchar(2000) COLLATE 'utf8_bin' NULL AFTER `name`;

ALTER TABLE `ilg_hour_concept`
ADD `description` tinytext COLLATE 'utf8_general_ci' DEFAULT NULL AFTER `id`;

ALTER TABLE `ilg_hour_concept`
ADD `range_type` tinyint(4) NULL,
COMMENT='';

ALTER TABLE `ilg_hour_concept`
ADD `aux1` varchar(30) NULL,
ADD `aux2` varchar(30) NULL AFTER `aux1`,
ADD `aux3` varchar(30) NULL AFTER `aux2`,
COMMENT='';

Update ilg_hour_concept hc
SET hc.range_type = 1 ,  hc.aux1 = hc.start_time , hc.aux2 = hc.end_time
where hc.hour_report_id is not null ;

UPDATE `ilg_concept` SET
`paid` = 'T'
WHERE `paid` IS NULL;

UPDATE `ilg_concept` SET
`require_authorization` = 'F'
WHERE `require_authorization` IS NULL;

ALTER TABLE `ilg_hour_concept`
ADD `user_ended` char COLLATE 'utf8_general_ci' NULL DEFAULT 'F',
COMMENT='';

select *
from ilg_attendance at
where at.time > (select min(at2.time) from ilg_attendance as at2 where at2.person_id = at.person_id and at.processed != 'T' );





------------  problemas encontrados
select *
from ilg_attendance at 
INNER JOIN ( select at2.person_id, min(at2.time) as mintime from ilg_attendance as at2 where at2.processed != 'T' group by at2.person_id 
) as at2 on at.person_id = at2.person_id  and at.time >= at2.mintime

ALTER TABLE `ilg_calendar_time`
CHANGE `calendar_id` `calendar_id` bigint(20) NOT NULL AFTER `id`,
CHANGE `name` `name` varchar(100) COLLATE 'utf8_general_ci' NOT NULL AFTER `calendar_id`,
COMMENT='';

--ALTER TABLE `task`
--ADD `location_id` bigint(20) NULL AFTER `user_id`,
--ADD FOREIGN KEY (`location_id`) REFERENCES `location` (`id`);

-----------  asignacion de intervalos de turnos a turnos

DROP TABLE IF EXISTS `ilg_schedule_calendar_time`;
CREATE TABLE `ilg_schedule_calendar_time` (
  `schedule_id` bigint(20) NOT NULL  COMMENT '',
  `calendar_time_id` bigint(20) NOT NULL,
  PRIMARY KEY (`schedule_id`,`calendar_time_id`),
  KEY `schedule_id` (`schedule_id`),
  CONSTRAINT `ilg_sct_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `ilg_schedule` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ilg_sct_ibfk_2` FOREIGN KEY (`calendar_time_id`) REFERENCES `ilg_calendar_time` (`id`)   ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ilg_schedule_calendar_time ( schedule_id, calendar_time_id )
select sc.id , ct.id from ilg_calendar_time ct
inner join ilg_schedule sc on sc.time_calendar_id = ct.calendar_id;


ALTER TABLE `ilg_schedule`
DROP FOREIGN KEY `ilg_schedule_ibfk_1`;

ALTER TABLE `ilg_schedule`
DROP FOREIGN KEY `ilg_schedule_ibfk_3`;

ALTER TABLE `ilg_schedule`
DROP FOREIGN KEY `ilg_schedule_ibfk_2`;

ALTER TABLE `ilg_schedule`
DROP INDEX `time_calendar_id`,
DROP INDEX `extra_hour_type_id`,
DROP INDEX `extra_calendar_id`;

ALTER TABLE `ilg_schedule`
DROP `time_calendar_id`,
DROP `extra_hour_type_id`,
DROP `extra_calendar_id`,
DROP `min_hours`,
DROP `apply_extra_vigency`,
DROP `extra_vigency`;

ALTER TABLE `ilg_calendar_time`
DROP `days_duration`;

ALTER TABLE `ilg_calendar_time`
DROP FOREIGN KEY `ilg_calendar_time_ibfk_1`;

ALTER TABLE `ilg_calendar_time`
DROP INDEX `calendar_id`;

ALTER TABLE `ilg_calendar_time`
DROP `calendar_id`;

DROP TABLE IF EXISTS `ilg_calendar_time_category`;
CREATE TABLE `ilg_calendar_time_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `by_default` char(1) COLLATE 'utf8_general_ci' DEFAULT 'F',
  `description` varchar(200) DEFAULT NULL,
  `status_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,  
  PRIMARY KEY (`id`),
  KEY `enterprise_id` (`enterprise_id`),
  KEY `status_id` (`status_id`),  
  KEY `branch_office_id` (`branch_office_id`),  
  CONSTRAINT `ctcatt_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `ilg_enterprise` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ctcatt_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`),
  CONSTRAINT `ctcatt_ibfk_4` FOREIGN KEY (`branch_office_id`) REFERENCES `ilg_branch_office` (`id`) ON DELETE CASCADE  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO ilg_calendar_time_category ( name, by_default, description , status_id , enterprise_id )
select 'Sin Clasificar', 'T', 'Elementos No clasificados',1,e.id from ilg_enterprise e

ALTER TABLE `ilg_calendar_time` 
ADD `category_id` bigint(20) DEFAULT NULL,
COMMENT=''; 
ALTER TABLE `ilg_calendar_time` 
ADD INDEX `category_id` (`category_id`);
ALTER TABLE `ilg_calendar_time` 
ADD FOREIGN KEY (`category_id`) REFERENCES `ilg_calendar_time_category` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT; 

Update ilg_calendar_time ct
INNER JOIN ilg_calendar_time_category as ctc ON ctc.enterprise_id = ct.enterprise_id and ctc.by_default = 'T'
SET ct.category_id = ctc.id

INSERT INTO `bi4cg_viewlevels`  VALUES
('68','calendartime', 'Intervalos','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('68', '15'),('68', '19'),('68', '8'),
('68', '29'),('68', '25'),('68', '28');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 68, id FROM ilg_enterprise;


ALTER TABLE `ilg_device_type`
DROP FOREIGN KEY `ilg_device_type_ibfk_2`;
ALTER TABLE `ilg_device_type`
DROP FOREIGN KEY `ilg_device_type_ibfk_1`;
ALTER TABLE `ilg_device_type`
DROP INDEX `branch_office_id`;
ALTER TABLE `ilg_device_type`
DROP INDEX `enterprise_id`;
ALTER TABLE `ilg_device_type`
DROP `enterprise_id`;
ALTER TABLE `ilg_device_type`
DROP `branch_office_id`;

ALTER TABLE `ilg_date_type`
DROP FOREIGN KEY `ilg_date_type_ibfk_2`;
ALTER TABLE `ilg_date_type`
DROP FOREIGN KEY `ilg_date_type_ibfk_1`;
ALTER TABLE `ilg_date_type`
DROP FOREIGN KEY `ilg_date_type_ibfk_3`;
ALTER TABLE `ilg_date_type`
DROP INDEX `branch_office_id`;
ALTER TABLE `ilg_date_type`
DROP INDEX `enterprise_id`;
ALTER TABLE `ilg_date_type`
DROP `enterprise_id`;
ALTER TABLE `ilg_date_type`
DROP `branch_office_id`;
ALTER TABLE `ilg_date_type`
DROP INDEX `status_id`;

UPDATE `ilg_calendar_time` SET
`date_type_id` = '1'
WHERE `date_type_id` IS NULL;


ALTER TABLE `ilg_calendar_time`
DROP FOREIGN KEY `ilg_calendar_time_ibfk_2`;

ALTER TABLE `ilg_calendar_time`
CHANGE `date_type_id` `date_type_id` bigint(20) NOT NULL DEFAULT '1' AFTER `max_out_time`;


UPDATE `ilg_concept` SET
`type` = '0'
WHERE `type` IS NULL;

ALTER TABLE `ilg_concept`
CHANGE `type` `type` tinyint(4) NOT NULL DEFAULT '0' AFTER `surcharge`;



-----------------  partitioning

SELECT enterprise_id, COUNT(*)
FROM `ilg_attendance`
WHERE `enterprise_id` > '75'
group by enterprise_id
LIMIT 50

SELECT *
FROM
  information_schema.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_NAME = 'ilg_hour_concept';


--- EXPLAIN PARTITIONS SELECT * FROM `ilg_attendance` WHERE `category` = 0 or `category` = 4;

ALTER TABLE `ilg_att_report`
DROP FOREIGN KEY `ilg_att_report_att_ibfk_3`,
DROP FOREIGN KEY `ilg_att_report_ibfk_3`;

ALTER TABLE `ilg_att_report`
DROP FOREIGN KEY `ilg_att_report_ibfk_2`;
ALTER TABLE `ilg_att_report`
DROP FOREIGN KEY `ilg_att_report_person_ibfk_2`;


ALTER TABLE `ilg_hour_report`
ADD PRIMARY KEY `id_enterprise_id_start_time` (`id`, `enterprise_id`, `start_time`),
DROP INDEX `PRIMARY`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_1`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_2`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_3`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_4`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_5`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_6`,
DROP FOREIGN KEY `ilg_hour_report_ibfk_7`;

ALTER TABLE `ilg_payroll_notice`
DROP FOREIGN KEY `ilg_payroll_notice_ibfk_4`;

ALTER TABLE `ilg_hour_concept`
DROP FOREIGN KEY `ilg_hour_concept_ibfk_1`,
ADD PRIMARY KEY `id_enterprise_id_start_time` (`id`, `enterprise_id`, `start_time`),
DROP INDEX `PRIMARY`,
DROP FOREIGN KEY `ilg_concept_ibfk_11`,
DROP FOREIGN KEY `ilg_concept_ibfk_21`,
DROP FOREIGN KEY `ilg_concept_ibfk_31`,
DROP FOREIGN KEY `ilg_hour_concept_ibfk_2`,
DROP FOREIGN KEY `ilg_hour_concept_ibfk_3`;

ALTER TABLE `ilg_attendance`
ADD UNIQUE `person_id_time_enterprise_id` (`person_id`, `time`, `enterprise_id`),
DROP INDEX `person_id_time`,
ADD PRIMARY KEY `id_enterprise_id_time` (`id`, `enterprise_id`, `time`),
DROP INDEX `PRIMARY`,
DROP INDEX `enterprise_id`,
DROP FOREIGN KEY `ilg_attendance_ibfk_1`,
DROP FOREIGN KEY `ilg_attendance_ibfk_4`,
DROP FOREIGN KEY `ilg_attendance_ibfk_5`,
DROP FOREIGN KEY `ilg_attendance_ibfk_6`,
DROP FOREIGN KEY `ilg_attendance_ibfk_7`,
DROP FOREIGN KEY `ilg_attendance_ibfk_8`,
DROP FOREIGN KEY `ilg_attendance_ibfk_9`,
DROP FOREIGN KEY `ilg_attendance_ibfk_10`;

ALTER TABLE `ilg_attendance`
DROP INDEX `person_id`;



ALTER TABLE `ilg_hour_report`
partition by range (to_days(start_time))
SUBPARTITION BY hash(enterprise_id) subpartitions 50 (
	PARTITION pempty VALUES LESS THAN (0),
	PARTITION oldatt VALUES LESS THAN (to_days('2015-03-01' )),
    PARTITION newatt VALUES LESS THAN MAXVALUE 
);	

select partition_name, subpartition_name as sub, partition_method as method,   partition_description ,table_rows 
from information_schema.partitions 
where table_name='ilg_hour_report';

EXPLAIN PARTITIONS SELECT *
FROM `ilg_hour_report`
WHERE `enterprise_id` = '94' and start_time > '2015-03-02'
ORDER BY `enterprise_id` DESC
LIMIT 50

ALTER TABLE `ilg_attendance`
partition by range (to_days(time))
SUBPARTITION BY hash(enterprise_id) subpartitions 50 (
	PARTITION pempty VALUES LESS THAN (0),
	PARTITION oldatt VALUES LESS THAN (to_days('2015-03-01' )),
    PARTITION newatt VALUES LESS THAN MAXVALUE 
);	 

select partition_name, subpartition_name as sub, partition_method as method,   partition_description ,table_rows 
from information_schema.partitions 
where table_name='ilg_attendance';

SELECT at.person_id as person_id , at.person_id as p2 ,DATE( at.time ) as ATDAY, count(*) as COUNT  
FROM ilg_attendance at   
	INNER JOIN ilg_person p ON at.person_id = p.id     
	INNER JOIN ilg_contract ct ON ct.person_id = p.id      
WHERE ( at.enterprise_id IN ( 18 )) 
	and origin_type_id = 1  and at.valid != 'F'  
	and at.attendance_status_id != 10               
	and at.time <= '2015-06-24'   AND at.time >= '2015-03-01'                  
	and p.status_id = 1  and ct.status_id = 1  
group by at.person_id, DATE( at.time )  
ORDER BY time DESC 
limit 0,50

-- ent=6
-- 7
-- 0.2
-- 0.2


-- ent=18
-- 45
-- 13.7
-- 13

-- 8
-- 0.6
-- 0.6
--  0.014

ALTER TABLE ilg_attendance
 REORGANIZE PARTITION newatt INTO (
	PARTITION oldattmar VALUES LESS THAN  (to_days('2015-04-01' )) ,
    PARTITION newatt VALUES LESS THAN MAXVALUE);
	

ALTER TABLE `ilg_hour_concept`
partition by range (to_days(start_time))
SUBPARTITION BY hash(enterprise_id) subpartitions 50 (
	PARTITION emptyhc VALUES LESS THAN (0),
	PARTITION oldhc VALUES LESS THAN (to_days('2015-03-01' )),
    PARTITION newhc VALUES LESS THAN MAXVALUE 
);	

select partition_name, subpartition_name as sub, partition_method as method,   partition_description ,table_rows 
from information_schema.partitions 
where table_name='ilg_hour_concept';
	
EXPLAIN PARTITIONS SELECT *
FROM `ilg_hour_concept`
WHERE `enterprise_id` = '94' and start_time > '2015-03-01'
ORDER BY `enterprise_id` DESC
LIMIT 50

-------------     resumenes periodo

DROP TABLE IF EXISTS `ilg_period_summary`;
CREATE TABLE `ilg_period_summary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 0,
  `name` varchar(30) NOT NULL,
  `s_value` varchar(2000) DEFAULT NULL,
  `i_value` bigint(20) DEFAULT NULL,
  `d_value` decimal(10,2) DEFAULT NULL,
  `payroll_period_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,  
  PRIMARY KEY (`id`,enterprise_id,type),
  KEY `type` (`type`),
  KEY `payroll_period_id` (`payroll_period_id`),  
  KEY `person_id` (`person_id`), 
  KEY `branch_office_id` (`branch_office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
PARTITION BY RANGE (enterprise_id)
SUBPARTITION BY hash(type) subpartitions 5 (
    PARTITION e17 VALUES LESS THAN (17),
    PARTITION e19 VALUES LESS THAN (19),
    PARTITION e23 VALUES LESS THAN (23),
	PARTITION e34 VALUES LESS THAN (34),
	PARTITION e37 VALUES LESS THAN (37),
	PARTITION e38 VALUES LESS THAN (38),
	PARTITION e53 VALUES LESS THAN (  53),
	PARTITION e54 VALUES LESS THAN (  54),
	PARTITION e55 VALUES LESS THAN (  55),
	PARTITION e56 VALUES LESS THAN (  56),
	PARTITION e57 VALUES LESS THAN (  57),
	PARTITION e60 VALUES LESS THAN (  60),
	PARTITION e63 VALUES LESS THAN (63),
	PARTITION e64 VALUES LESS THAN (64),
	PARTITION e68 VALUES LESS THAN (  68),
	PARTITION e69 VALUES LESS THAN (  69),
	PARTITION e70 VALUES LESS THAN (  70),
	PARTITION e74  VALUES LESS THAN ( 74),
	PARTITION e75  VALUES LESS THAN ( 75),
    PARTITION emax VALUES LESS THAN MAXVALUE
);

select partition_name, subpartition_name as sub, partition_method as method,   partition_description ,table_rows 
from information_schema.partitions 
where table_name='ilg_period_summary';


------------------  pasar marcaciones a otro usuario

UPDATE `ilg_attendance` 
SET `person_id` = 25507
WHERE person_id = 12724;

UPDATE `ilg_fingerprint` 
SET `person_id` = 25507
WHERE person_id = 12724;
UPDATE `ilg_hour_concept` 
SET `person_id` = 25507
WHERE person_id = 12724;
UPDATE `ilg_hour_report` 
SET `person_id` = 25507
WHERE person_id = 12724;
UPDATE `ilg_hour_report_summary` 
SET `person_id` = 25507
WHERE person_id = 12724;
UPDATE `ilg_payroll_notice` 
SET `person_id` = 25507
WHERE person_id = 12724;

UPDATE `ilg_person` 
SET `device_user_id` = '12343245678'
WHERE id = 12724;

UPDATE `ilg_person` 
SET `device_user_id` = identification
WHERE id = 25507;

DELETE FROM `ilg_contract` 
WHERE person_id = 12724;  

DELETE FROM `ilg_person` 
WHERE id = 12724;  



-------------------- PersonSchedule 
ALTER TABLE `ilg_person_schedule`
ADD `end_date` date NOT NULL AFTER `initial_date`;

update `ilg_person_schedule`
set end_date = initial_date




------------------  agregar todas las sucursales a un usuarioINSERT INTO ilg_user_branchoff ( user_id, branch_office_id ) 
INSERT INTO ilg_user_branchoff ( user_id, branch_office_id ) 
SELECT 1396,id
FROM `ilg_branch_office`
WHERE `enterprise_id` = '85'



------------------------  administrar tipos de novedad
INSERT INTO `bi4cg_viewlevels`  VALUES
('69','tiponovedad', 'Administrar Tipo Novedad','2', '[8,19,29,15,25,28]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('69', '15'),('69', '19'),('69', '8'),
('69', '29'),('69', '25'),('69', '28');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 69, id FROM ilg_enterprise;

-------------------------   round concept
ALTER TABLE `ilg_concept`
ADD `round_min` varchar(8) COLLATE 'utf8_general_ci' NULL COMMENT 'Minuto al cual se redondea' AFTER `paid`,
ADD `round_mode` tinyint(4) NULL COMMENT 'Modo redondeo,  HALF_DOWN...' AFTER `round_min`;


---------------- periodos
ALTER TABLE `ilg_payroll_period`
ADD UNIQUE `initial_date_enterprise_id_branch_office_id` (`initial_date`, `enterprise_id`, `branch_office_id`),
DROP INDEX `interval_started`;


---------------------  usuario creados invalidos
SELECT *
FROM `ilg_attendance`
WHERE `enterprise_id` = '63' AND `time` LIKE '%2015-08-21%'


 select count(*) from ilg_attendance where person_id in ( 
 SELECT p1.id
FROM ilg_person p1
WHERE date( p1.`creation_date` ) BETWEEN '2015-08-28' AND '2015-08-29'
and enterprise_id = 81

 );



SELECT p1.*
FROM ilg_person p1 inner join ilg_person p2 
WHERE date( p1.`creation_date` ) BETWEEN '2015-08-28' AND '2015-08-29' AND p1.`name` = 'UNKNOWN'
and p1.id > p2.id and p1.identification = p2.identification 

ORDER BY `id` DESC
LIMIT 500


and not exists( select id from ilg_attendance at where at.person_id = p.id )



SELECT p1.*
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%'  OR p1.`creation_date` LIKE '%2015-08-29%' )
 AND p1.`name` = 'UNKNOWN'
LIMIT 50


delete from ilg_device_person where person_id in ( select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )
 );

 delete from ilg_device_fingerprint where fingerprint_id in ( select id from ilg_fingerprint where person_id in (

 select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )
 )
 );
 
delete from ilg_fingerprint where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )
); 
 
 
 
delete from ilg_hour_report where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )

);
delete from ilg_hour_concept where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )

 );
delete from ilg_payroll_notice where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )

 );
delete from ilg_contract where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )
 );
 
 
delete p1
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
and not exists( select id from ilg_attendance at where at.person_id = p1.id )

---------------------  borrar todos


delete from ilg_device_person where person_id in ( select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'

 );

 delete from ilg_device_fingerprint where fingerprint_id in ( select id from ilg_fingerprint where person_id in (

 select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'

 )
 );
 
delete from ilg_fingerprint where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'

); 
 
 
 
delete from ilg_hour_report where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'


);
delete from ilg_hour_concept where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'


 );
delete from ilg_payroll_notice where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'


 );
delete from ilg_contract where person_id in ( 
select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'

 );
 
 delete from ilg_attendance where person_id in ( select p1.id 
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'
 );
 
 delete p1
FROM ilg_person p1 inner join ilg_person p2 on  p1.identification = p2.identification 
WHERE p2.id < p1.id
 and ( p1.`creation_date` LIKE '%2015-08-28%' OR p1.`creation_date` LIKE '%2015-08-29%'   )
AND p1.`name` = 'UNKNOWN'

---------------------- mantenimiento inconsistencias

SELECT at.calendar_id, count(at.id) as countc, max( at.start_time ) as maxt
FROM `ilg_hour_report` at
WHERE  not exists ( select id from ilg_calendar_time bo where at.calendar_id = bo.id )
and   at.calendar_id is not null
group by at.calendar_id
order by countc desc;

---------------------  mantenimiento

SHOW PROCESSLIST;


DELETE FROM `ilg_device_cmd`
WHERE `CmdCommitTime` < '2015-09-02 00:00:00' AND `CmdReturn` = '0';


DELETE FROM `ilg_device_cmd`
WHERE `CmdCommitTime` < '2015-09-02 00:00:00';

DELETE FROM `bi4cg_session`;

DELETE FROM `ilg_attendance`
WHERE `time` < '2015-01-01 00:00:00';

DELETE FROM `ilg_hour_report`
WHERE `start_time` < '2015-01-01 00:00:00';



SELECT time, at.person_id, attendance_type_id, elapsedHours , at.work_code as workcode 
from ilg_attendance at   
INNER JOIN ilg_person p ON at.person_id = p.id         
INNER JOIN ilg_contract ct ON ct.person_id = p.id             
where at.enterprise_id = 63  and at.valid != 'F' 
and at.attendance_status_id != 10      
and at.time BETWEEN '2015-09-01 00:00' AND '2015-09-04 23:59'  



SELECT  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount ,p.*
FROM `ilg_person`  p
WHERE `identification` = '20740070'


SELECT  distinct (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount ,p.*
FROM ilg_person p inner join ilg_person p2 on  p.identification = p2.identification 
where p.id != p2.id
order by p.identification,fingcount,  attcount
limit 50



SELECT distinct (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount ,p.*
FROM `ilg_person`  p 
where
p.identification in ( 
	select p1.identification
	FROM `ilg_person`  p1
	inner join ilg_person p2 on  p1.identification = p2.identification 
	WHERE p1.`creation_date` LIKE '%2015-09-04%'
	and p1.id != p2.id and p1.enterprise_id = 71
)
order by p.identification



SELECT  distinct dev.id, (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount ,p.*
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
inner join ilg_device dev on dev.enterprise_id = p.enterprise_id
where p.id > p2.id and  p.enterprise_id = 71 and p.creation_date > "2015-08-27"
having attcount = 0
order by p.identification,fingcount,  attcount


SELECT  distinct dev.id, p.identification,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
inner join ilg_device dev on dev.enterprise_id = p.enterprise_id
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
order by p.identification,  attcount


SELECT  distinct  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount, p.*
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
order by p.identification,  attcount


SELECT  distinct  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount, p.*
FROM ilg_person p 
where p.enterprise_id = 74 and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
order by p.identification,  attcount


SELECT  distinct dev.id, p.identification
FROM ilg_person p 
inner join ilg_device dev on dev.enterprise_id = p.enterprise_id
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
and dev.status_id = 1
order by p.identification

SELECT  distinct  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount,p.*
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
order by p.identification

SELECT distinct  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount, p.id,p.name,p.identification,p.creation_date,p.enterprise_id
FROM ilg_person p inner join ilg_person p2 on  p.identification = p2.identification 
where p.id != p2.id
order by p.identification, p.creation_date

SELECT count(distinct p.id )
FROM ilg_person p inner join ilg_person p2 on  p.identification = p2.identification 
where p.id != p2.id
order by p.identification, p.creation_date

INSERT INTO `ilg_device_cmd` ( `device_id`, `CmdContent`, `CmdCommitTime`, `CmdTransTime`, `CmdOverTime`, `CmdReturn`, `person_id`) VALUES
(	175,	'DATA DELETE USERINFO PIN=1016014613',	'2015-09-03 09:18:00',	null,	null,	0,	NULL);

SELECT  distinct dev.id, p.identification,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
 inner join ilg_person p2 on  p.identification = p2.identification 
inner join ilg_device dev on dev.enterprise_id = p.enterprise_id
where p.id != p2.id and p.creation_date > "2015-08-28"
and dev.status_id = 1
having attcount = 0
order by p.identification

SELECT distinct  (select count(*) from ilg_fingerprint where person_id = p.id ) as fingcount ,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount, p.id,p.name,p.identification,p.creation_date,p.enterprise_id
FROM ilg_person p inner join ilg_person p2 on  p.identification = p2.identification 
where p.id != p2.id and p.creation_date > "2015-08-28"
having attcount = 0
order by p.identification



delete from ilg_device_person where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
 );

 delete from ilg_device_fingerprint where fingerprint_id in ( select id from ilg_fingerprint where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
) );
 
delete from ilg_fingerprint where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
); 
 
 
 
delete from ilg_hour_report where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
);


delete from ilg_hour_concept where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
 );
 
delete from ilg_contract where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
 );
 
 delete from ilg_attendance where person_id in ( select p.id 
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
 );
 
 delete p
FROM ilg_person p 
where p.enterprise_id != 74  and p.enterprise_id != 71
and p.creation_date > "2015-08-27" and p.creation_date < "2015-08-30"
;



update
 ilg_device dev 
 set LogStamp = 0 , OpLogStamp = 0, PhotoStamp = 0
 where id in (176,241,75,240,156,184,52,242,111,108,102,104,101,103,100,163,166,164,126,162,120,224,222,118,221,115,223,117,220,114,217,116,113,167,219,110,218,112,109,165,91,92,93,94,95,89,90,175,174,173,133,131,132,53,87,134,88,54,84,83,82,129,216,25,59,86,38,209,211,208);



----------------------------


delete from ilg_device_person where person_id in ( select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1

 );

 delete from ilg_device_fingerprint where fingerprint_id in ( select id from ilg_fingerprint where person_id in ( select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1)
 );
 
delete from ilg_fingerprint where person_id in ( 
select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1
); 
 
 
 
delete from ilg_hour_report where person_id in ( 
select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1
);


delete from ilg_hour_concept where person_id in ( 
select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1
 );
 
delete from ilg_contract where person_id in ( 
select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1
 );
 
 delete from ilg_attendance where person_id in ( select p1.id 
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1
 );
 
 delete p
FROM ilg_person p
where p.id in (
select p1.id
from (
SELECT  distinct p.id,
(select count(*) from ilg_attendance where person_id = p.id ) as attcount
FROM ilg_person p 
inner join ilg_person p2 on  p.identification = p2.identification 
where p.id > p2.id and p.creation_date > "2015-08-28"
having attcount = 0
) as p1

)





-----------------------------   reprocesar
SELECT count(*) FROM ilg_attendance at WHERE  at.enterprise_id IN ( 85 )
              and at.processed != 'T'                 and (   (
at.time                                     
 BETWEEN  '2015-09-01'                                   
 AND  '2015-09-10' )                       ) 

SELECT count(*)          from ilg_hour_report hr         WHERE hr.enterprise_id IN ( 85 )          and hr.processed != 'T'                 and (                                    ( hr.end_time                     BETWEEN  '2015-09-01'                                          AND  '2015-09-10' )                        ) 

 SELECT hr.id   from ilg_hour_report hr         WHERE hr.enterprise_id IN (85 )  and hr.start_time > '2015-03-01'                and hr.processed != 'T'                 and (                                 ( hr.end_time                                        BETWEEN  '2015-08-01 00:00:00'                                         AND  '2015-09-14 00:00:00' )     ) order by hr.start_time asc

 
-------------------------------  personas sin sucursal
update 
`ilg_person` p  inner join ilg_branch_office bo on p.enterprise_id = bo.enterprise_id and bo.lft = 0
set p.branch_office_id = bo.id
WHERE p.`branch_office_id` IS NULL;

update 
`ilg_attendance` at  inner join ilg_person p on at.person_id = p.id
set at.branch_office_id = p.branch_office_id 
WHERE at.`branch_office_id` IS NULL;

update 
`ilg_attendance` at  inner join ilg_person p on at.person_id = p.id
set at.branch_office_id = p.branch_office_id 
WHERE at.`branch_office_id` != p.branch_office_id;

update 
`ilg_hour_concept` at  inner join ilg_person p on at.person_id = p.id
set at.branch_office_id = p.branch_office_id 
WHERE at.`branch_office_id` != p.branch_office_id OR at.`branch_office_id` IS NULL;

update 
`ilg_hour_report` at  inner join ilg_person p on at.person_id = p.id
set at.branch_office_id = p.branch_office_id 
WHERE at.`branch_office_id` != p.branch_office_id OR at.`branch_office_id` IS NULL;
 
 

------------------------------   turnos flexibles periodicos
ALTER TABLE `ilg_notification`
DROP FOREIGN KEY `ilg_notification_ibfk_6`,
ADD FOREIGN KEY (`period_id`) REFERENCES `ilg_period` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;


ALTER TABLE `ilg_schedule`
ADD `period_id` bigint(20) NULL,
ADD `period_hours_complete` decimal(10,2)  NULL COMMENT 'hours that must complete for period'  AFTER `period_id`,
ADD `period_concept_id` bigint(20) NULL COMMENT 'concept that must complete before extras' AFTER `period_hours_complete`,
ADD FOREIGN KEY (`period_concept_id`) REFERENCES `ilg_concept` (`id`) ON DELETE RESTRICT,
ADD FOREIGN KEY (`period_id`) REFERENCES `ilg_period` (`id`) ON DELETE RESTRICT;

DROP TABLE IF EXISTS `ilg_ct_concept_discount_order`;
DROP TABLE IF EXISTS `ilg_sc_concept_discount_order`;
CREATE TABLE `ilg_sc_concept_discount_order` (
  `concept_id` bigint(20) NOT NULL,
  `ordering` tinyint(4) NOT NULL COMMENT 'Orden de descuento de los conceptos',
  `schedule_id` bigint(20) NOT NULL,
  PRIMARY KEY (`concept_id`,`schedule_id`),
  KEY `concept_id` (`concept_id`),
  CONSTRAINT `ilg_ctco_ibfk_1` FOREIGN KEY (`concept_id`) REFERENCES `ilg_concept` (`id`)  ON DELETE CASCADE,
  CONSTRAINT `ilg_ctco_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `ilg_schedule` (`id`) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ilg_hour_period_concept`;
CREATE TABLE `ilg_hour_period_concept` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `person_id` bigint(20) NOT NULL,
  `enterprise_id` bigint(20) NOT NULL,
  `schedule_id` bigint(20) DEFAULT NULL COMMENT 'Turno',
  `area_id` bigint(20) DEFAULT NULL,
  `period_id` bigint(20) DEFAULT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `worked_hours` decimal(10,2) DEFAULT NULL,
  `processed` char(1) DEFAULT NULL COMMENT '''T'': Procesado. Otro: Not Processed',
  `payroll_period_id` bigint(20) DEFAULT NULL,
  `branch_office_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`enterprise_id`,`start_time`),
  KEY `person_id` (`person_id`),
  KEY `end_time` (`end_time`),
  KEY `schedule_id` (`schedule_id`),
  KEY `area_id` (`area_id`),
  KEY `payroll_period_id` (`payroll_period_id`),
  KEY `branch_office_id` (`branch_office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `ilg_hour_period_concept`
partition by range (to_days(start_time))
SUBPARTITION BY hash(enterprise_id) subpartitions 50 (
	PARTITION pempty VALUES LESS THAN (0),
	PARTITION oldatt VALUES LESS THAN (to_days('2015-03-01' )),
    PARTITION newatt VALUES LESS THAN MAXVALUE 
);	

ALTER TABLE `ilg_hour_concept`
ADD `hour_period_concept_id` bigint(20) NULL;




-----------------------------    Unir lapsos de trabajo

DROP TABLE IF EXISTS `ilg_ct_ct_merge`;
CREATE TABLE `ilg_ct_ct_merge` (
  `calendar_time_id` bigint(20) NOT NULL,
  `calendar_time_id_merge` bigint(20) NOT NULL,
  PRIMARY KEY (`calendar_time_id`,`calendar_time_id_merge`),
  KEY `calendar_time_id` (`calendar_time_id`),
  CONSTRAINT `ilg_ctct_ibfk_1` FOREIGN KEY (`calendar_time_id`) REFERENCES `ilg_calendar_time` (`id`)  ON DELETE CASCADE,
  CONSTRAINT `ilg_ctct_ibfk_2` FOREIGN KEY (`calendar_time_id_merge`) REFERENCES `ilg_calendar_time` (`id`) ON DELETE CASCADE 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--- agregar campo en ilg_hour_report para guardar el lapso con el que se unio.

ALTER TABLE `ilg_hour_report`
ADD `merged_hour_report_id` bigint(20) NULL COMMENT 'merged with';

---- agregar campo en  config para busqueda de lapso para union por defecto


ALTER TABLE `ilg_calendar_time`
ADD `max_time_to_search` decimal(10,2) NULL COMMENT 'maximo de horas para buscar por el anterior lapso y unirlos';

ALTER TABLE `ilg_config`
ADD `max_time_to_search` decimal(10,2) NULL COMMENT 'maximo de horas para buscar por el anterior lapso y unirlos';


----------   comandos count
ALTER TABLE `ilg_device_cmd`
ADD `sended_count` int(11) NOT NULL DEFAULT '0',
COMMENT='';


--------------  fecha de extensión  Y CODIGO NOVEDADES
ALTER TABLE `ilg_hour_concept`
ADD `extension_time` datetime NULL AFTER `end_time`,
ADD `code` varchar(20) COLLATE 'utf8_general_ci' NULL
PARTITION BY RANGE(to_days(start_time)) (
  PARTITION `pempty` VALUES LESS THAN (0),
  PARTITION `oldatt` VALUES LESS THAN (736023),
  PARTITION `newatt` VALUES LESS THAN (MAXVALUE)
);

----------------  redondeo inicio dependiendo de tarde o temprano
ALTER TABLE `ilg_sub_concept_item`
ADD `param4` varchar(500) COLLATE 'utf8_general_ci' NULL AFTER `param3`;


------------------------   codigo sucursal duplicado problemas
 SELECT name, count(name), (
SELECT GROUP_CONCAT(`id`)
FROM `ilg_branch_office`l
WHERE l.`name` = l2.name
) as dupli FROM ilg_branch_office l2
 GROUP BY name, enterprise_id HAVING COUNT(name) > 1
order by count(name) desc

 SELECT code, count(code), (
SELECT GROUP_CONCAT(`id`)
FROM `ilg_branch_office`l
WHERE l.`code` = l2.code
) as dupli FROM ilg_branch_office l2
 GROUP BY code, enterprise_id HAVING COUNT(code) > 1
order by count(code) desc



 SELECT name, count(name) FROM ilg_branch_office
 GROUP BY name, enterprise_id HAVING COUNT(name) > 1
order by count(name) desc;

 
 
SELECT count(*) AS duplicate_count
FROM (
 SELECT name FROM ilg_branch_office
 GROUP BY name, enterprise_id HAVING COUNT(name) > 1
) AS t;

SELECT distinct p1.name
FROM ilg_branch_office p1 
inner join ilg_branch_office p2 
WHERE 
p1.id < p2.id 
and p1.name = p2.name
and p1.enterprise_id = p2.enterprise_id ;

SELECT *
FROM `ilg_attendance` at
WHERE  not exists ( select id from ilg_branch_office bo where at.branch_office_id = bo.id )


SELECT GROUP_CONCAT(`id`)
FROM `ilg_branch_office`
WHERE `name` = 'CENC0002BA00100002078';

update `ilg_branch_office`
set code = name
WHERE  (`name` LIKE '%CENC0%' ) and name != code



ALTER TABLE `ilg_branch_office`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_calendar_time`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_concept`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;


ALTER TABLE `ilg_contract_type`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_cost_center`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_device`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_payroll_notice_type`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_person`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_position`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_schedule`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;

ALTER TABLE `ilg_task`
CHANGE `code` `code` varchar(200) COLLATE 'utf8_general_ci' DEFAULT NULL;


UPDATE
ilg_hour_period_concept
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );


UPDATE
ilg_person 
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
ilg_hour_report 
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_attendance
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_fingerprint
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_hour_concept
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_payroll_notice
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_contract
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_schedule
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_process_file
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_position
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_person_schedule
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_personal_inside
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_payroll_period_sum
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_payroll_period
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_payroll_notice_type
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_payroll_notice
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_notification
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_hour_report_summary
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_device
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_cost_center
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_contract
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_calendar_time
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_calendar
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_position
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_area
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

UPDATE
 ilg_process_file
SET branch_office_id = 1430
where branch_office_id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );

delete from ilg_branch_office where id IN ( 1570,1597,1614,1630,1750,1758,1809,1819,1827,1831,1835,1839,1843,1847,1851,1855,1859,1863,1867,1876,1883,1890,1924,1931,1948,2036,2042,2110 );



----------------------   contraints

SELECT hr.calendar_id, count(hr.id) as countc
FROM `ilg_hour_report` hr
WHERE  not exists ( select id from ilg_calendar_time bo where hr.calendar_id = bo.id )
and   hr.calendar_id is not null
group by hr.calendar_id
order by countc desc;

INSERT INTO ilg_calendar_time ( id, name, enterprise_id, branch_office_id, status_id,monday,		
                                                                                     tuesday,		
                                                                                     wednesday,	
                                                                                     thursday,	
                                                                                     friday,		
                                                                                     saturday,	
                                                                                     sunday,		
																					 start_time,		
																					 end_time,		
																					 date_type_id,	
                                                                                     creation_date,	
                                                                                     week_pos,		
                                                                                     each_week,		
                                                                                     mode )
SELECT hr.calendar_id, hr.shiftName, hr.enterprise_id, hr.branch_office_id, 2, 'T',
                                                                               'T',
                                                                              	 'T',
                                                                              	 'T',
                                                                               'T',
                                                                              	 'T',
                                                                               'T',
                                                                              	 '09:00',
                                                                              	 '17:00',
                                                                              		 '1',
                                                                              		 '2015-11-04 13:51:59',
                                                                              	 '0',
                                                                              	 '1',
                                                                               '1'
FROM `ilg_hour_report` hr
WHERE  not exists ( select id from ilg_calendar_time bo where hr.calendar_id = bo.id )
and   hr.calendar_id is not null
group by hr.calendar_id;

DELIMITER $$

CREATE TRIGGER caltime_before_delete
BEFORE DELETE
ON ilg_calendar_time
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM ilg_hour_report WHERE calendar_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;
END
$$

DELIMITER ;

SELECT *
FROM `ilg_hour_report` at
WHERE  not exists ( select id from ilg_branch_office bo where at.branch_office_id = bo.id );
SELECT *
FROM `ilg_hour_concept` at
WHERE  not exists ( select id from ilg_branch_office bo where at.branch_office_id = bo.id );
SELECT *
FROM `ilg_attendance` at
WHERE  not exists ( select id from ilg_branch_office bo where at.branch_office_id = bo.id );

DELIMITER $$

CREATE TRIGGER bo_before_delete
BEFORE DELETE
ON ilg_branch_office
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM ilg_hour_report WHERE branch_office_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;
  IF (SELECT COUNT(*) FROM ilg_hour_concept WHERE branch_office_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;  
  IF (SELECT COUNT(*) FROM ilg_attendance WHERE branch_office_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;    
END
$$

DELIMITER $$
CREATE TRIGGER area_before_delete
BEFORE DELETE
ON ilg_area
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM ilg_hour_report WHERE area_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;
END
$$

DELIMITER ;
DELIMITER $$
DROP TRIGGER IF EXISTS person_before_delete;
CREATE TRIGGER person_before_delete
BEFORE DELETE
ON ilg_person
FOR EACH ROW
BEGIN
	IF @disable_triggers IS NULL THEN
		IF (SELECT COUNT(*) FROM ilg_hour_report WHERE person_id = old.id ) > 0 THEN
			CALL cannot_delete_error; -- raise an error to prevent deleting from the table
		END IF;
		IF (SELECT COUNT(*) FROM ilg_hour_concept WHERE person_id = old.id ) > 0 THEN
			CALL cannot_delete_error; -- raise an error to prevent deleting from the table
		END IF;  
		IF (SELECT COUNT(*) FROM ilg_attendance WHERE person_id = old.id ) > 0 THEN
			CALL cannot_delete_error; -- raise an error to prevent deleting from the table
		END IF;    
	END IF; 
END
$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER concept_before_delete
BEFORE DELETE
ON ilg_concept
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM ilg_hour_concept WHERE concept_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;  

END
$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER device_before_delete
BEFORE DELETE
ON ilg_device
FOR EACH ROW
BEGIN
  IF (SELECT COUNT(*) FROM ilg_attendance WHERE device_id = old.id ) > 0 THEN
    CALL cannot_delete_error; -- raise an error to prevent deleting from the table
  END IF;  

END
$$

DELIMITER ;


--------------- cloudtime principal arreglo novedades

INSERT INTO `ilg_payroll_notice` VALUES 
(37062,380,NULL,'2015-09-04 00:00:00','2015-09-08 23:59:00',50130,91,3,'2015-09-04','2015-09-08',NULL,NULL,'F'),
(37412,381,'Dilegencia personal','2015-09-01 15:00:00','2015-09-01 17:00:00',50045,91,2,'2015-09-01','15:00','17:00',NULL,'F'),
(37427,382,NULL,'2015-08-07 00:00:00','2015-08-16 23:59:00',11556,47,3,'2015-08-07','2015-08-16',NULL,NULL,'F'),
(37645,381,'Diligencia relacionada con la Superintendencia','2015-09-17 08:00:00','2015-09-17 17:00:00',50090,91,2,'2015-09-17','08:00','17:00',NULL,'F'),
(37655,381,'SERVICIOS MEDICOS','2015-09-08 11:00:00','2015-09-08 12:00:00',50121,91,2,'2015-09-08','11:00','12:00',NULL,'F'),
(37657,381,'SERVICIOS MEDICOS','2015-09-07 13:00:00','2015-09-07 16:00:00',50150,91,2,'2015-09-07','13:00','16:00',NULL,'F'),
(37658,381,'DILIGENCIA PERSONAL','2015-09-08 16:00:00','2015-09-08 17:00:00',50132,91,2,'2015-09-08','16:00','17:00',NULL,'F'),
(37661,381,'DILIGENCIA PERSONAL','2015-09-08 14:00:00','2015-09-08 16:00:00',50088,91,2,'2015-09-08','14:00','16:00',NULL,'F'),
(37663,381,'SERVICIOS MEDICOS','2015-09-08 13:00:00','2015-09-08 14:00:00',50088,91,2,'2015-09-08','13:00','14:00',NULL,'F'),
(37664,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-04 13:00:00','2015-09-04 17:00:00',50091,91,2,'2015-09-04','13:00','17:00',NULL,'F'),
(37665,381,'SERVICIOS MEDICOS','2015-09-02 10:00:00','2015-09-02 12:00:00',50122,91,2,'2015-09-02','10:00','12:00',NULL,'F'),
(37667,381,'DILIGENCIA PERSONAL','2015-09-01 08:00:00','2015-09-01 10:00:00',50013,91,2,'2015-09-01','08:00','10:00',NULL,'F'),
(37668,381,'DILIGENCIA PERSONAL','2015-09-01 13:00:00','2015-09-01 16:00:00',50088,91,2,'2015-09-01','13:00','16:00',NULL,'F'),
(37669,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-01 11:00:00','2015-09-01 12:00:00',50140,91,2,'2015-09-01','11:00','12:00',NULL,'F'),
(37671,381,'DILIGENCIA PERSONAL','2015-09-01 10:00:00','2015-09-01 13:00:00',50107,91,2,'2015-09-01','10:00','13:00',NULL,'F'),
(37672,381,'COMPENSATORIO ORDENADO POR EL SUPERINTENDENTE','2015-09-02 13:00:00','2015-09-02 17:00:00',53030,91,2,'2015-09-02','13:00','17:00',NULL,'F'),
(37673,381,'SERVICIOS MEDICOS','2015-09-01 14:00:00','2015-09-01 17:00:00',50157,91,2,'2015-09-01','14:00','17:00',NULL,'F'),
(37674,381,'DILIGENCIA PERSONAL','2015-09-02 14:00:00','2015-09-02 16:00:00',50100,91,2,'2015-09-02','14:00','16:00',NULL,'F'),
(37675,381,'SERVICIOS MEDICOS','2015-09-01 14:00:00','2015-09-01 16:00:00',50121,91,2,'2015-09-01','14:00','16:00',NULL,'F'),
(37676,381,'DILIGENCIA PERSONAL','2015-09-04 15:00:00','2015-09-04 17:00:00',50095,91,2,'2015-09-04','15:00','17:00',NULL,'F'),
(37678,381,'DILIGENCIA PERSONAL','2015-09-03 14:00:00','2015-09-03 17:00:00',50006,91,2,'2015-09-03','14:00','17:00',NULL,'F'),
(37679,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-03 07:00:00','2015-09-03 10:00:00',50140,91,2,'2015-09-03','07:00','10:00',NULL,'F'),
(37680,381,'SSERVICIOS MEDICOS','2015-09-03 07:00:00','2015-09-03 08:40:00',50150,91,2,'2015-09-03','07:00','08:40',NULL,'F'),
(37706,383,NULL,'2015-08-11 00:00:00','2015-11-16 00:00:00',23592,77,NULL,'2015-08-11 00:00','2015-11-16 00:00',NULL,NULL,'F'),
(37716,385,NULL,'2015-08-12 00:00:00','2015-09-10 00:00:00',27115,77,NULL,'2015-08-12 00:00','2015-09-10 00:00',NULL,NULL,'F'),
(37802,386,'AO9','2015-09-02 00:00:00','2015-09-04 23:59:00',50152,91,3,'2015-09-02','2015-09-04',NULL,NULL,'F'),
(37803,386,'I890','2015-09-03 00:00:00','2015-09-04 23:59:00',50121,91,3,'2015-09-03','2015-09-04',NULL,NULL,'F'),
(37808,386,'Y442','2015-09-04 00:00:00','2015-09-05 23:59:00',50150,91,3,'2015-09-04','2015-09-05',NULL,NULL,'F'),
(37812,386,'G439','2015-09-01 00:00:00','2015-09-03 23:59:00',50142,91,3,'2015-09-01','2015-09-03',NULL,NULL,'F'),
(37814,386,'G432','2015-09-07 00:00:00','2015-09-09 23:59:00',50142,91,3,'2015-09-07','2015-09-09',NULL,NULL,'F'),
(38112,381,'SERVICIOS MEDICOS','2015-09-08 07:00:00','2015-09-08 10:30:00',50091,91,2,'2015-09-08','07:00','10:30',NULL,'F'),
(38115,381,'DILIGENCIA PERSONAL','2015-09-08 14:30:00','2015-09-08 17:00:00',50106,91,2,'2015-09-08','14:30','17:00',NULL,'F'),
(38116,381,'DILIGENCIA PERSONAL','2015-09-04 15:00:00','2015-09-04 17:00:00',50157,91,2,'2015-09-04','15:00','17:00',NULL,'F'),
(38117,381,'PERMISO REMUNERADO','2015-09-04 08:00:00','2015-09-04 17:00:00',50071,91,2,'2015-09-04','08:00','17:00',NULL,'F'),
(38118,381,'DILIGENCIA PERSONAL','2015-09-07 07:00:00','2015-09-07 10:00:00',50131,91,2,'2015-09-07','07:00','10:00',NULL,'F'),
(38119,381,'DILIGENCIA PERSONAL','2015-09-08 07:00:00','2015-09-08 08:00:00',50100,91,2,'2015-09-08','07:00','08:00',NULL,'F'),
(38120,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-09 08:00:00','2015-09-09 12:00:00',50004,91,2,'2015-09-09','08:00','12:00',NULL,'F'),
(38121,381,'DILIGENCIA PERSONAL ','2015-09-11 14:00:00','2015-09-11 17:00:00',50046,91,2,'2015-09-11','14:00','17:00',NULL,'F'),
(38122,381,'DILIGENCIA PERSONAL','2015-09-07 08:00:00','2015-09-07 10:00:00',50122,91,2,'2015-09-07','08:00','10:00',NULL,'F'),
(38130,381,'DILIGENCIA PERSONAL','2015-09-07 08:00:00','2015-09-07 17:00:00',50008,91,2,'2015-09-07','08:00','17:00',NULL,'F'),
(38131,381,'COMPENSATORIO ORDENADO POR EL SUPERINTNDENTE','2015-09-07 08:00:00','2015-09-07 12:00:00',50115,91,2,'2015-09-07','08:00','12:00',NULL,'F'),
(38136,381,'SERVICIOS MEDICOS','2015-09-07 15:30:00','2015-09-07 17:00:00',50045,91,2,'2015-09-07','15:30','17:00',NULL,'F'),
(38138,381,'DILIGENCIA PERSONAL','2015-09-10 14:00:00','2015-09-10 17:00:00',50006,91,2,'2015-09-10','14:00','17:00',NULL,'F'),
(38139,381,'PERMISO SINDICAL','2015-09-03 00:00:00','2015-09-03 23:59:00',50010,91,3,'2015-09-03','2015-09-03',NULL,NULL,'F'),
(38140,381,'PERMISO SINDICAL','2015-09-10 00:00:00','2015-09-10 23:59:00',50010,91,3,'2015-09-10','2015-09-10',NULL,NULL,'F'),
(38141,381,'PERMISO SINDICAL','2015-09-17 00:00:00','2015-09-17 23:59:00',50010,91,3,'2015-09-17','2015-09-17',NULL,NULL,'F'),
(38142,381,'PERMISO SINDICAL','2015-09-24 00:00:00','2015-09-24 23:59:00',50010,91,3,'2015-09-24','2015-09-24',NULL,NULL,'F'),
(38144,387,'PERMISO DEL 8/09/2015 2.5 HORAS','2015-09-10 17:00:00','2015-09-10 18:30:00',50106,91,2,'2015-09-10','17:00','18:30',NULL,'F'),
(38145,387,'PERMISO DEL 8/09/2015 2.5 HORAS','2015-09-11 17:00:00','2015-09-11 18:30:00',50106,91,2,'2015-09-11','17:00','18:30',NULL,'F'),
(38146,387,'PERMISO DEL 4/09/2015 2 HORAS','2015-09-07 17:00:00','2015-09-07 19:00:00',50157,91,2,'2015-09-07','17:00','19:00',NULL,'F'),
(38147,387,'PERMISO DEL 7/09/2015 3 HORAS','2015-09-08 16:00:00','2015-09-08 19:00:00',50131,91,2,'2015-09-08','16:00','19:00',NULL,'F'),
(38148,387,'PERMISO DEL 8/09/2015 1 HORAS','2015-09-09 16:00:00','2015-09-09 17:00:00',50100,91,2,'2015-09-09','16:00','17:00',NULL,'F'),
(38150,387,'PERMISO DEL 11/09/2015 3 HORAS','2015-09-09 07:00:00','2015-09-09 08:00:00',50046,91,2,'2015-09-09','07:00','08:00',NULL,'F'),
(38151,387,'PERMISO DEL 11/09/2015 3 HORAS','2015-09-15 17:00:00','2015-09-15 19:00:00',50046,91,2,'2015-09-15','17:00','19:00',NULL,'F'),
(38152,387,'PERMISO DEL 7/09/2015 2 HORAS','2015-09-08 07:00:00','2015-09-08 08:00:00',50122,91,2,'2015-09-08','07:00','08:00',NULL,'F'),
(38154,387,'PERMISO DEL 7/09/2015 2 HORAS','2015-09-09 07:00:00','2015-09-09 08:00:00',50122,91,2,'2015-09-09','07:00','08:00',NULL,'F'),
(38158,387,'Permiso del 10/09/2015 3 horas','2015-09-11 06:00:00','2015-09-11 08:00:00',50006,91,2,'2015-09-11','06:00','08:00',NULL,'F'),
(38159,387,'Permiso del 10/09/2015 3 horas','2015-09-14 06:00:00','2015-09-14 08:00:00',50006,91,2,'2015-09-14','06:00','08:00',NULL,'F'),
(38160,387,'Permiso del 1/09/2015 2 horas','2015-09-02 17:00:00','2015-09-02 18:00:00',50045,91,2,'2015-09-02','17:00','18:00',NULL,'F'),
(38161,387,'Permiso del 3/09/2015 3 horas','2015-09-07 06:30:00','2015-09-07 08:00:00',50006,91,2,'2015-09-07','06:30','08:00',NULL,'F'),
(38162,387,'Permiso del 3/09/2015 3 horas','2015-09-08 06:30:00','2015-09-08 08:00:00',50006,91,2,'2015-09-08','06:30','08:00',NULL,'F'),
(38163,387,'Permiso del 4/09/2015 2 horas','2015-08-31 17:00:00','2015-08-31 19:00:00',50095,91,2,'2015-08-31','17:00','19:00',NULL,'F'),
(38165,387,'Permiso del 2/09/2015 2 horas','2015-08-03 16:00:00','2015-08-03 18:00:00',50100,91,2,'2015-08-03','16:00','18:00',NULL,'F'),
(38173,387,'Permiso del 1/09/2015 3 horas','2015-09-02 17:00:00','2015-09-02 18:30:00',50157,91,2,'2015-09-02','17:00','18:30',NULL,'F'),
(38174,387,'Permiso del 1/09/2015 3 horas','2015-09-03 17:00:00','2015-09-03 18:30:00',50157,91,2,'2015-09-03','17:00','18:30',NULL,'F'),
(38175,387,'Permiso del 1/09/2015 3 horas','2015-09-01 17:00:00','2015-09-01 17:30:00',50107,91,2,'2015-09-01','17:00','17:30',NULL,'F'),
(38178,387,'Permiso del 1/09/2015 3 horas','2015-09-02 17:00:00','2015-09-02 17:30:00',50107,91,2,'2015-09-02','17:00','17:30',NULL,'F'),
(38181,387,'Permiso del 1/09/2015 3 horas','2015-09-03 17:00:00','2015-09-03 17:30:00',50107,91,2,'2015-09-03','17:00','17:30',NULL,'F'),
(38182,387,'Permiso del 1/09/2015 3 horas','2015-08-31 17:00:00','2015-08-31 20:00:00',50088,91,2,'2015-08-31','17:00','20:00',NULL,'F'),
(38183,387,'Permiso del 1/09/2015 2 horas','2015-09-02 17:00:00','2015-09-02 19:00:00',50013,91,2,'2015-09-02','17:00','19:00',NULL,'F'),
(38185,387,'Permiso del 08/09/2015 2 horas','2015-09-10 16:00:00','2015-09-10 18:00:00',50088,91,2,'2015-09-10','16:00','18:00',NULL,'F'),
(38186,387,'Permiso del 7/09/2015 1 horas','2015-09-08 17:00:00','2015-09-08 18:00:00',50132,91,2,'2015-09-08','17:00','18:00',NULL,'F'),
(39254,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-10 16:00:00','2015-09-10 17:00:00',50132,91,2,'2015-09-10','16:00','17:00',NULL,'F'),
(39256,381,'DILIGENCIA PERSONAL','2015-09-09 07:00:00','2015-09-09 10:00:00',50131,91,2,'2015-09-09','07:00','10:00',NULL,'F'),
(39257,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-09 14:00:00','2015-09-09 16:00:00',50121,91,2,'2015-09-09','14:00','16:00',NULL,'F'),
(39259,381,'SERVICIOS MEDICOS','2015-09-10 07:00:00','2015-09-10 09:00:00',50121,91,2,'2015-09-10','07:00','09:00',NULL,'F'),
(39260,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-09 08:00:00','2015-09-09 17:00:00',50014,91,2,'2015-09-09','08:00','17:00',NULL,'F'),
(39262,387,'PERMISO SOLICITADO EL 09/09/2015','2015-09-09 16:00:00','2015-09-09 19:00:00',50131,91,2,'2015-09-09','16:00','19:00',NULL,'F'),
(39264,381,'DILIGENCIA PERSONAL','2015-09-09 16:30:00','2015-09-09 17:00:00',50019,91,2,'2015-09-09','16:30','17:00',NULL,'F'),
(39266,387,'PERMISO SOLICITADO EL 09/09/2015','2015-09-11 17:00:00','2015-09-11 17:30:00',50019,91,2,'2015-09-11','17:00','17:30',NULL,'F'),
(39270,381,'DILIGENCIA PERSONAL','2015-09-08 14:50:00','2015-09-08 16:00:00',50016,91,2,'2015-09-08','14:50','16:00',NULL,'F'),
(39277,386,'JO6','2015-09-10 00:00:00','2015-09-10 23:59:00',50019,91,3,'2015-09-10','2015-09-10',NULL,NULL,'F'),
(39728,389,'CALI','2015-09-14 00:00:00','2015-09-18 23:59:00',53030,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39730,389,'CALI','2015-09-14 00:00:00','2015-09-18 23:59:00',50160,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39731,389,'ENVIGADO','2015-09-14 00:00:00','2015-09-18 23:59:00',50157,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39732,389,'ENVIGADO','2015-09-14 00:00:00','2015-09-18 23:59:00',50135,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39733,389,'TOCA - BOYACA','2015-09-14 00:00:00','2015-09-18 23:59:00',50106,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39734,389,'TOCA BOYACA','2015-09-14 00:00:00','2015-09-18 23:59:00',50128,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39735,389,'BUCARAMANGA','2015-09-14 00:00:00','2015-09-18 23:59:00',50009,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39736,389,'BUCARAMANGA','2015-09-14 00:00:00','2015-09-18 23:59:00',50098,91,3,'2015-09-14','2015-09-18',NULL,NULL,'F'),
(39737,389,'CARTAGENA','2015-09-07 00:00:00','2015-09-11 23:59:00',50151,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39738,389,'CARTAGENA','2015-09-07 00:00:00','2015-09-11 23:59:00',50129,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39739,389,'MEDELLIN','2015-09-07 00:00:00','2015-09-11 23:59:00',50148,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39740,389,'MEDELLIN','2015-09-07 00:00:00','2015-09-11 23:59:00',50117,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39741,389,'CALI','2015-09-07 00:00:00','2015-09-11 23:59:00',50125,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39742,389,'CALI','2015-09-07 00:00:00','2015-09-11 23:59:00',50076,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39743,389,'BARRANQUILLA','2015-09-07 00:00:00','2015-09-11 23:59:00',50137,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39744,389,'BARRANQUILLA','2015-09-07 00:00:00','2015-09-11 23:59:00',50144,91,3,'2015-09-07','2015-09-11',NULL,NULL,'F'),
(39745,389,'BARRANQUILLA','2015-09-03 00:00:00','2015-09-03 23:59:00',50076,91,3,'2015-09-03','2015-09-03',NULL,NULL,'F'),
(39746,389,'MEDELLIN','2015-09-04 00:00:00','2015-09-06 23:59:00',53030,91,3,'2015-09-04','2015-09-06',NULL,NULL,'F'),
(39747,389,'MEDELLIN','2015-09-04 00:00:00','2015-09-06 23:59:00',50137,91,3,'2015-09-04','2015-09-06',NULL,NULL,'F'),
(39748,389,'MEDELLIN','2015-09-04 00:00:00','2015-09-06 23:59:00',50135,91,3,'2015-09-04','2015-09-06',NULL,NULL,'F'),
(39749,389,'MEDELLIN','2015-09-04 00:00:00','2015-09-06 23:59:00',50117,91,3,'2015-09-04','2015-09-06',NULL,NULL,'F'),
(39750,389,'MEDELLIN','2015-09-04 00:00:00','2015-09-06 23:59:00',50144,91,3,'2015-09-04','2015-09-06',NULL,NULL,'F'),
(39789,381,'PERMISO SINDICAL','2015-08-20 08:00:00','2015-08-20 17:00:00',50010,91,2,'2015-08-20','08:00','17:00',NULL,'F'),
(39790,381,'SERVICIOS MEDICOS','2015-09-11 07:00:00','2015-09-11 09:00:00',50085,91,2,'2015-09-11','07:00','09:00',NULL,'F'),
(39791,381,'PERMISO SINDICAL','2015-08-27 08:00:00','2015-08-27 17:00:00',50010,91,2,'2015-08-27','08:00','17:00',NULL,'F'),
(39792,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-10 10:30:00','2015-09-10 12:30:00',50077,91,2,'2015-09-10','10:30','12:30',NULL,'F'),
(39793,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-10 10:30:00','2015-09-10 12:30:00',50114,91,2,'2015-09-10','10:30','12:30',NULL,'F'),
(39797,386,'JOOX','2015-09-09 08:00:00','2015-09-09 17:00:00',50100,91,2,'2015-09-09','08:00','17:00',NULL,'F'),
(39799,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-10 16:00:00','2015-09-10 17:00:00',50004,91,2,'2015-09-10','16:00','17:00',NULL,'F'),
(39803,381,'DILIGENCIA PERSONAL','2015-09-15 10:00:00','2015-09-15 12:00:00',50088,91,2,'2015-09-15','10:00','12:00',NULL,'F'),
(39804,387,'PERMISO DEL 15/09/2015 DE 3.15 HORAS','2015-09-10 18:00:00','2015-09-10 20:00:00',50088,91,2,'2015-09-10','18:00','20:00',NULL,'F'),
(39805,381,'DILIGENCIA PERSONAL','2015-09-11 08:00:00','2015-09-11 10:00:00',50107,91,2,'2015-09-11','08:00','10:00',NULL,'F'),
(39806,387,'PERMISO DEL 11/09/2015 DE 2 HORAS','2015-09-11 17:00:00','2015-09-11 18:00:00',50107,91,2,'2015-09-11','17:00','18:00',NULL,'F'),
(39808,387,'PERMISO DEL 11/09/2015 DE 2 HORAS','2015-09-14 17:00:00','2015-09-14 18:00:00',50107,91,2,'2015-09-14','17:00','18:00',NULL,'F'),
(39809,386,'G432','2015-09-11 00:00:00','2015-09-12 23:59:00',50045,91,3,'2015-09-11','2015-09-12',NULL,NULL,'F'),
(39810,386,'A084','2015-09-10 00:00:00','2015-09-10 23:59:00',50015,91,3,'2015-09-10','2015-09-10',NULL,NULL,'F'),
(39811,386,'G439','2015-09-10 00:00:00','2015-09-11 23:59:00',50142,91,3,'2015-09-10','2015-09-11',NULL,NULL,'F'),
(40079,381,'SERVICIOS MEDICOS','2015-09-14 14:30:00','2015-09-14 17:00:00',50018,91,2,'2015-09-14','14:30','17:00',NULL,'F'),
(40109,381,'SERVICIOS MEDICOS','2015-09-14 14:30:00','2015-09-14 17:00:00',50101,91,2,'2015-09-14','14:30','17:00',NULL,'F'),
(40120,381,'SERVICIOS MEDICOS','2015-09-14 14:00:00','2015-09-14 16:00:00',50091,91,2,'2015-09-14','14:00','16:00',NULL,'F'),
(40135,381,'CALAMIDAD DOMSTICA','2015-09-14 14:00:00','2015-09-14 17:00:00',50114,91,2,'2015-09-14','14:00','17:00',NULL,'F'),
(40177,381,'DILIGENCIA PERSONAL','2015-09-14 15:00:00','2015-09-14 17:00:00',50144,91,2,'2015-09-14','15:00','17:00',NULL,'F'),
(40178,387,'PERMISO SOLICITADO EL 14/09/2015 2 HORAS','2015-09-15 17:00:00','2015-09-15 18:00:00',50144,91,2,'2015-09-15','17:00','18:00',NULL,'F'),
(40179,387,'PERMISO SOLICITADO EL 14/09/2015 2 HORAS','2015-09-16 17:00:00','2015-09-16 18:00:00',50144,91,2,'2015-09-16','17:00','18:00',NULL,'F'),
(40180,381,'DILIGENCIA PERSONAL','2015-09-10 14:30:00','2015-09-10 17:00:00',50157,91,2,'2015-09-10','14:30','17:00',NULL,'F'),
(40181,387,'PERMISO SOLICITADO EL 10/09/2015 2,5 HORAS','2015-09-14 17:00:00','2015-09-14 19:00:00',50157,91,2,'2015-09-14','17:00','19:00',NULL,'F'),
(40182,387,'PERMISO SOLICITADO EL 10/09/2015 2,5 HORAS','2015-09-15 17:00:00','2015-09-15 19:00:00',50157,91,2,'2015-09-15','17:00','19:00',NULL,'F'),
(40183,381,'COMPENSATORIO ORDENADO POR EL SUPERINTENDENTE','2015-09-10 13:00:00','2015-09-10 16:00:00',50149,91,2,'2015-09-10','13:00','16:00',NULL,'F'),
(40184,381,'SERVICIOS MEDICOS ','2015-09-10 13:00:00','2015-09-10 15:00:00',50135,91,2,'2015-09-10','13:00','15:00',NULL,'F'),
(40186,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-14 16:00:00','2015-09-14 17:00:00',50132,91,2,'2015-09-14','16:00','17:00',NULL,'F'),
(40187,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-14 16:00:00','2015-09-14 17:00:00',50004,91,2,'2015-09-14','16:00','17:00',NULL,'F'),
(40188,381,'DILIGENCIA PERSONAL','2015-09-14 15:30:00','2015-09-14 16:00:00',49994,91,2,'2015-09-14','15:30','16:00',NULL,'F'),
(40189,387,'PERMISO SOLICITADO EL 14/09/2015 DE 0.5 HORAS','2015-09-14 13:30:00','2015-09-14 16:00:00',49994,91,2,'2015-09-14','13:30','16:00',NULL,'F'),
(40190,381,'SERVICIOS MEDICOS','2015-09-14 14:30:00','2015-09-14 16:00:00',50121,91,2,'2015-09-14','14:30','16:00',NULL,'F'),
(40191,381,'DILIGENCIA PERSONAL','2015-09-16 07:00:00','2015-09-16 16:00:00',50078,91,2,'2015-09-16','07:00','16:00',NULL,'F'),
(40192,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-14 16:00:00','2015-09-14 17:00:00',50078,91,2,'2015-09-14','16:00','17:00',NULL,'F'),
(40193,387,'PERMISO DEL 16/09/2015 8 HORAS','2015-09-15 16:00:00','2015-09-15 17:00:00',50078,91,2,'2015-09-15','16:00','17:00',NULL,'F'),
(40196,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-17 16:00:00','2015-09-17 17:00:00',50078,91,2,'2015-09-17','16:00','17:00',NULL,'F'),
(40200,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-18 16:00:00','2015-09-18 17:00:00',50078,91,2,'2015-09-18','16:00','17:00',NULL,'F'),
(40204,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-19 08:00:00','2015-09-19 12:00:00',50078,91,2,'2015-09-19','08:00','12:00',NULL,'F'),
(40206,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-09 08:00:00','2015-09-09 12:00:00',50140,91,2,'2015-09-09','08:00','12:00',NULL,'F'),
(40207,381,'COMPENSATORIO ORDENADO POR EL SUPERINTENDENTE','2015-09-14 12:00:00','2015-09-14 16:00:00',50014,91,2,'2015-09-14','12:00','16:00',NULL,'F'),
(40345,392,NULL,'2015-09-09 00:00:00','2015-09-10 23:59:00',51068,79,3,'2015-09-09','2015-09-10',NULL,NULL,'F'),
(40358,381,'SERVICIOS MEDICOS','2015-09-15 08:00:00','2015-09-15 08:20:00',50013,91,2,'2015-09-15','08:00','08:20',NULL,'F'),
(40623,392,'presenta soporte de defunción de familiar.','2015-09-14 00:00:00','2015-09-14 23:59:00',25031,79,3,'2015-09-14','2015-09-14',NULL,NULL,'F'),
(40649,381,'SERVICIOS MEDICOS','2015-09-16 00:00:00','2015-09-16 23:59:00',50155,91,3,'2015-09-16','2015-09-16',NULL,NULL,'F'),
(40651,381,'SEVICIOS MEDICOS','2015-09-16 07:00:00','2015-09-16 10:30:00',50150,91,2,'2015-09-16','07:00','10:30',NULL,'F'),
(40653,381,'SERVICIOS MEDICOS','2015-09-15 14:00:00','2015-09-15 16:00:00',50121,91,2,'2015-09-15','14:00','16:00',NULL,'F'),
(40660,387,'PERMISO SOLICITADO EL 08/09/2015 DE 1 HORA 10 MINUTOS','2015-09-09 16:00:00','2015-09-09 16:40:00',50016,91,2,'2015-09-09','16:00','16:40',NULL,'F'),
(40661,387,'PERMISO DEL 08/09/2015 DE 1 HORA 10 MINUTOS','2015-09-10 16:00:00','2015-09-10 16:40:00',50016,91,2,'2015-09-10','16:00','16:40',NULL,'F'),
(40663,381,'DILIGENCIA PERSONAL','2015-09-15 10:00:00','2015-09-15 12:00:00',50016,91,2,'2015-09-15','10:00','12:00',NULL,'F'),
(40664,387,'PERMISO DEL 15/09/2015 DE 2 HORAS','2015-09-16 16:00:00','2015-09-16 16:30:00',50016,91,2,'2015-09-16','16:00','16:30',NULL,'F'),
(40665,387,'PERMISO DEL 15/09/2015 DE 2 HORAS','2015-09-17 16:00:00','2015-09-17 16:30:00',50016,91,2,'2015-09-17','16:00','16:30',NULL,'F'),
(40666,387,'PERMISO DEL 15/09/2015 DE 2 HORAS','2015-09-18 16:00:00','2015-09-18 16:30:00',50016,91,2,'2015-09-18','16:00','16:30',NULL,'F'),
(40667,387,'PERMISO DEL 15/09/2015 DE 2 HORAS','2015-09-21 16:00:00','2015-09-21 16:30:00',50016,91,2,'2015-09-21','16:00','16:30',NULL,'F'),
(40668,387,'PERMISO DEL 15/09/2015 DE 2 HORAS','2015-09-22 16:00:00','2015-09-22 16:30:00',50016,91,2,'2015-09-22','16:00','16:30',NULL,'F'),
(40670,387,'PERMISO DEL 15/09/2015 DE 3.15 HORAS','2015-09-15 16:00:00','2015-09-15 17:15:00',50088,91,2,'2015-09-15','16:00','17:15',NULL,'F'),
(40726,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-18 08:00:00','2015-09-18 12:00:00',50090,91,2,'2015-09-18','08:00','12:00',NULL,'F'),
(40961,395,'Soporte OK','2015-09-17 07:00:00','2015-09-17 17:00:00',12320,54,NULL,'2015-09-17 07:00','2015-09-17 17:00',NULL,NULL,'F'),
(41087,381,'SERVICIOS MEDICOS','2015-09-21 07:00:00','2015-09-21 10:30:00',50150,91,2,'2015-09-21','07:00','10:30',NULL,'F'),
(41089,381,'COMPENSATORIO ORDENADO POR EL SUPERINTENDENTE','2015-09-17 13:00:00','2015-09-17 17:00:00',50118,91,2,'2015-09-17','13:00','17:00',NULL,'F'),
(41091,381,'DILIGENCIA PERSONAL','2015-09-18 13:00:00','2015-09-18 17:00:00',50095,91,2,'2015-09-18','13:00','17:00',NULL,'F'),
(41092,387,'PERMISO SOLICITADO EL 18/09/2015 4 HORAS','2015-09-16 17:00:00','2015-09-16 21:00:00',50095,91,2,'2015-09-16','17:00','21:00',NULL,'F'),
(41094,381,'DILIGENCIA PERSONAL','2015-09-16 08:00:00','2015-09-16 11:00:00',50147,91,2,'2015-09-16','08:00','11:00',NULL,'F'),
(41095,387,'PERMISO SOLICITADO EL 16/09/2015','2015-09-17 17:00:00','2015-09-17 18:30:00',50147,91,2,'2015-09-17','17:00','18:30',NULL,'F'),
(41096,381,'PERMISO SOLICITADO L 16/09/2015 DE 3 HORAS','2015-09-18 17:00:00','2015-09-18 18:30:00',50147,91,2,'2015-09-18','17:00','18:30',NULL,'F'),
(41097,381,'DILIGENCIA PERSONAL','2015-09-16 14:00:00','2015-09-16 17:00:00',50147,91,2,'2015-09-16','14:00','17:00',NULL,'F'),
(41098,387,'PERMISO DEL 16/09/2015 DE 3 HORAS','2015-09-21 17:00:00','2015-09-21 18:00:00',50147,91,2,'2015-09-21','17:00','18:00',NULL,'F'),
(41100,387,'PERMISO DEL 16/09/2015 DE 3 HORAS','2015-09-22 17:00:00','2015-09-22 18:00:00',50147,91,2,'2015-09-22','17:00','18:00',NULL,'F'),
(41101,387,'PERMISO DEL 16/09/2015 DE 3 HORAS','2015-09-23 17:00:00','2015-09-23 18:00:00',50147,91,2,'2015-09-23','17:00','18:00',NULL,'F'),
(41317,381,'DILIGENCIA PERSONAL','2015-09-16 08:00:00','2015-09-16 17:00:00',50146,91,2,'2015-09-16','08:00','17:00',NULL,'F'),
(41318,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-17 17:00:00','2015-09-17 18:00:00',50146,91,2,'2015-09-17','17:00','18:00',NULL,'F'),
(41319,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-18 17:00:00','2015-09-18 18:00:00',50146,91,2,'2015-09-18','17:00','18:00',NULL,'F'),
(41320,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-21 17:00:00','2015-09-21 18:00:00',50146,91,2,'2015-09-21','17:00','18:00',NULL,'F'),
(41321,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-22 17:00:00','2015-09-22 18:00:00',50146,91,2,'2015-09-22','17:00','18:00',NULL,'F'),
(41322,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-23 17:00:00','2015-09-23 18:00:00',50146,91,2,'2015-09-23','17:00','18:00',NULL,'F'),
(41323,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-24 17:00:00','2015-09-24 18:00:00',50146,91,2,'2015-09-24','17:00','18:00',NULL,'F'),
(41324,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-25 17:00:00','2015-09-25 18:00:00',50146,91,2,'2015-09-25','17:00','18:00',NULL,'F'),
(41325,387,'PERMISO DEL 16/09/2015 DE 8 HORAS','2015-09-28 17:00:00','2015-09-28 18:00:00',50146,91,2,'2015-09-28','17:00','18:00',NULL,'F'),
(41326,381,'SERVICIOS MEDICOS','2015-09-14 07:00:00','2015-09-14 08:00:00',53028,91,2,'2015-09-14','07:00','08:00',NULL,'F'),
(41327,381,'DILIGENCIA PERSONAL','2015-09-18 08:00:00','2015-09-18 17:00:00',50107,91,2,'2015-09-18','08:00','17:00',NULL,'F'),
(41328,387,'ÉRMISO DEL 18/09/2015 DE 8 HORAS','2015-09-21 17:00:00','2015-09-21 17:30:00',50107,91,2,'2015-09-21','17:00','17:30',NULL,'F'),
(41329,387,'PERMISO DEL 18/09/2015 DE 8 HORAS','2015-09-22 17:00:00','2015-09-22 17:30:00',50107,91,2,'2015-09-22','17:00','17:30',NULL,'F'),
(41330,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-23 17:00:00','2015-09-23 17:30:00',50107,91,2,'2015-09-23','17:00','17:30',NULL,'F'),
(41331,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-24 17:00:00','2015-09-24 17:30:00',50107,91,2,'2015-09-24','17:00','17:30',NULL,'F'),
(41332,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-25 17:00:00','2015-09-25 17:30:00',50107,91,2,'2015-09-25','17:00','17:30',NULL,'F'),
(41333,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-28 17:00:00','2015-09-28 17:30:00',50107,91,2,'2015-09-28','17:00','17:30',NULL,'F'),
(41334,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-29 17:00:00','2015-09-29 17:30:00',50107,91,2,'2015-09-29','17:00','17:30',NULL,'F'),
(41335,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-09-30 17:00:00','2015-09-30 17:30:00',50107,91,2,'2015-09-30','17:00','17:30',NULL,'F'),
(41337,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-01 17:00:00','2015-10-01 17:30:00',50107,91,2,'2015-10-01','17:00','17:30',NULL,'F'),
(41338,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-02 17:00:00','2015-10-02 17:30:00',50107,91,2,'2015-10-02','17:00','17:30',NULL,'F'),
(41339,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-05 17:00:00','2015-10-05 17:30:00',50107,91,2,'2015-10-05','17:00','17:30',NULL,'F'),
(41340,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-06 17:00:00','2015-10-06 17:30:00',50107,91,2,'2015-10-06','17:00','17:30',NULL,'F'),
(41341,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-07 17:00:00','2015-10-07 17:30:00',50107,91,2,'2015-10-07','17:00','17:30',NULL,'F'),
(41342,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-08 17:00:00','2015-10-08 17:30:00',50107,91,2,'2015-10-08','17:00','17:30',NULL,'F'),
(41343,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-09 17:00:00','2015-10-09 17:30:00',50107,91,2,'2015-10-09','17:00','17:30',NULL,'F'),
(41344,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-12 17:00:00','2015-10-12 17:30:00',50107,91,2,'2015-10-12','17:00','17:30',NULL,'F'),
(41345,387,'PERMISO DEL 18/09/2015 DE 8 HORAS ','2015-10-13 17:00:00','2015-10-13 17:30:00',50107,91,2,'2015-10-13','17:00','17:30',NULL,'F'),
(41346,381,'SERVICIOS MEDICOS','2015-09-17 16:00:00','2015-09-17 17:00:00',50046,91,2,'2015-09-17','16:00','17:00',NULL,'F'),
(41347,381,'DILIGENCIA PERSONAL','2015-09-17 15:00:00','2015-09-17 16:00:00',50006,91,2,'2015-09-17','15:00','16:00',NULL,'F'),
(41348,387,'PERMISO DEL 17/09/2015 DE 1 HORA','2015-09-18 06:00:00','2015-09-18 07:00:00',50006,91,2,'2015-09-18','06:00','07:00',NULL,'F'),
(41349,381,'DILIGENCIA PERSONAL','2015-09-18 08:00:00','2015-09-18 12:00:00',50115,91,2,'2015-09-18','08:00','12:00',NULL,'F'),
(41350,387,NULL,'2015-09-21 17:00:00','2015-09-21 18:00:00',50115,91,2,'2015-09-21','17:00','18:00',NULL,'F'),
(41351,387,NULL,'2015-09-22 17:00:00','2015-09-22 18:00:00',50115,91,2,'2015-09-22','17:00','18:00',NULL,'F'),
(41352,387,'PERMISO DEL 18/09/2015 DE 4 HORAS ','2015-09-23 17:00:00','2015-09-23 18:00:00',50115,91,2,'2015-09-23','17:00','18:00',NULL,'F'),
(41353,387,'PERMISO DEL 18/09/2015 DE 4 HORAS ','2015-09-24 17:00:00','2015-09-24 18:00:00',50115,91,2,'2015-09-24','17:00','18:00',NULL,'F'),
(41354,387,'PERMISO DEL 18/09/2015 DE 4 HORAS ','2015-09-25 17:00:00','2015-09-25 18:00:00',50115,91,2,'2015-09-25','17:00','18:00',NULL,'F'),
(41355,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA DE 8:00 A 5:00 PM','2015-09-21 00:00:00','2015-09-23 23:59:00',50004,91,3,'2015-09-21','2015-09-23',NULL,NULL,'F'),
(41356,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-17 08:00:00','2015-09-17 17:00:00',50004,91,2,'2015-09-17','08:00','17:00',NULL,'F'),
(41357,381,'SERVICIOS MEDICOS','2015-09-18 14:30:00','2015-09-18 16:00:00',50121,91,2,'2015-09-18','14:30','16:00',NULL,'F'),
(41358,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50006,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41359,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50088,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41360,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50095,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41361,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50122,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41362,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50008,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41363,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50078,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41364,389,'IBAGUE','2015-09-21 00:00:00','2015-09-25 23:59:00',50045,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41365,389,'IBAGUE','2015-09-23 00:00:00','2015-09-25 23:59:00',50153,91,3,'2015-09-23','2015-09-25',NULL,NULL,'F'),
(41366,389,'PITALITO ','2015-09-21 00:00:00','2015-09-26 23:59:00',50115,91,3,'2015-09-21','2015-09-26',NULL,NULL,'F'),
(41367,389,'PITALITO ','2015-09-21 00:00:00','2015-09-26 23:59:00',50146,91,3,'2015-09-21','2015-09-26',NULL,NULL,'F'),
(41368,389,'PITALITO ','2015-09-23 00:00:00','2015-09-26 23:59:00',53028,91,3,'2015-09-23','2015-09-26',NULL,NULL,'F'),
(41369,389,'ACACIAS','2015-09-25 00:00:00','2015-09-26 23:59:00',50140,91,3,'2015-09-25','2015-09-26',NULL,NULL,'F'),
(41370,389,'ACACIAS','2015-09-25 00:00:00','2015-09-26 23:59:00',50132,91,3,'2015-09-25','2015-09-26',NULL,NULL,'F'),
(41372,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50151,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41374,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50129,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41375,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50148,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41376,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50117,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41377,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50069,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41378,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50076,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41379,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50137,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41380,389,'BOGOTÁ','2015-09-21 00:00:00','2015-09-25 23:59:00',50144,91,3,'2015-09-21','2015-09-25',NULL,NULL,'F'),
(41381,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',50157,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41382,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',50135,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41383,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',53030,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41384,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',50160,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41385,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',50106,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41386,389,'BOGOTÁ','2015-09-28 00:00:00','2015-10-02 23:59:00',50128,91,3,'2015-09-28','2015-10-02',NULL,NULL,'F'),
(41387,389,'BOGOTÁ','2015-10-05 00:00:00','2015-10-09 23:59:00',50009,91,3,'2015-10-05','2015-10-09',NULL,NULL,'F'),
(41388,389,'BOGOTÁ','2015-10-05 00:00:00','2015-10-09 23:59:00',50098,91,3,'2015-10-05','2015-10-09',NULL,NULL,'F'),
(41405,386,'T269','2015-09-15 00:00:00','2015-09-17 23:59:00',50007,91,3,'2015-09-15','2015-09-17',NULL,NULL,'F'),
(41406,381,'M544','2015-09-15 00:00:00','2015-09-17 23:59:00',50132,91,3,'2015-09-15','2015-09-17',NULL,NULL,'F'),
(41407,386,'G43.9','2015-09-16 00:00:00','2015-09-18 23:59:00',50071,91,3,'2015-09-16','2015-09-18',NULL,NULL,'F'),
(41459,381,'SERVICIOS MEDICOS ','2015-09-21 12:00:00','2015-09-21 17:00:00',50010,91,2,'2015-09-21','12:00','17:00',NULL,'F'),
(41460,381,'SERVICIOS MEDICOS','2015-09-18 14:00:00','2015-09-18 17:00:00',50017,91,2,'2015-09-18','14:00','17:00',NULL,'F'),
(41461,381,'DILIGENCIA RELACIONADA CON LA SUPERINTNDENCIA','2015-09-25 08:00:00','2015-09-25 17:00:00',50077,91,2,'2015-09-25','08:00','17:00',NULL,'F'),
(41567,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-09-28 17:00:00','2015-09-28 18:00:00',50077,91,2,'2015-09-28','17:00','18:00',NULL,'F'),
(41568,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-09-29 17:00:00','2015-09-29 18:00:00',50077,91,2,'2015-09-29','17:00','18:00',NULL,'F'),
(41569,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-09-30 17:00:00','2015-09-30 18:00:00',50077,91,2,'2015-09-30','17:00','18:00',NULL,'F'),
(41570,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-10-01 17:00:00','2015-10-01 18:00:00',50077,91,2,'2015-10-01','17:00','18:00',NULL,'F'),
(41571,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-10-02 17:00:00','2015-10-02 18:00:00',50077,91,2,'2015-10-02','17:00','18:00',NULL,'F'),
(41670,387,'PERMISO DEL 25/09/2015 DE 8 HORAS','2015-10-03 09:00:00','2015-10-03 12:00:00',50077,91,2,'2015-10-03','09:00','12:00',NULL,'F'),
(41672,386,'H105','2015-10-21 00:00:00','2015-10-22 23:59:00',50010,91,3,'2015-10-21','2015-10-22',NULL,NULL,'F'),
(41673,381,'DILIGENCIA PERSONAL','2015-10-21 15:00:00','2015-10-21 17:00:00',50009,91,2,'2015-10-21','15:00','17:00',NULL,'F'),
(41674,387,'PERMISO DEL 21/09/2015 DE 2 HORAS','2015-09-24 17:00:00','2015-09-24 18:00:00',50009,91,2,'2015-09-24','17:00','18:00',NULL,'F'),
(41675,387,'PERMISO DEL 21/09/2015 DE 2 HORAS','2015-09-25 17:00:00','2015-09-25 18:00:00',50009,91,2,'2015-09-25','17:00','18:00',NULL,'F'),
(41676,381,'DILIGENCIA RELACIONADA CON LA SUPERINTENDENCIA','2015-09-14 16:00:00','2015-09-14 17:00:00',50141,91,2,'2015-09-14','16:00','17:00',NULL,'F'),
(41677,381,'COMPENSATORIO ORDENADO POR EL SUPERINTENDENTE','2015-09-25 07:00:00','2015-09-25 11:00:00',50159,91,2,'2015-09-25','07:00','11:00',NULL,'F'),
(41679,381,'SERVICIOS MEDICOS','2015-09-22 12:30:00','2015-09-22 16:00:00',50106,91,2,'2015-09-22','12:30','16:00',NULL,'F'),
(41689,381,'DILIGENCIA RELACIONADA CON LA SUPERINTNDENCIA','2015-09-18 14:00:00','2015-09-18 16:00:00',50140,91,2,'2015-09-18','14:00','16:00',NULL,'F'),
(42103,381,'SERVICIOS MEDICOS','2015-09-22 13:30:00','2015-09-22 15:00:00',50091,91,2,'2015-09-22','13:30','15:00',NULL,'F'),
(42117,397,NULL,'2015-09-12 14:00:00','2015-09-12 17:00:00',17631,64,1,'2015-09-12 14:00','2015-09-12 17:00',NULL,NULL,'F'),
(42120,397,NULL,'2015-09-14 14:00:00','2015-09-14 18:00:00',53039,64,1,'2015-09-14 14:00','2015-09-14 18:00',NULL,NULL,'F'),
(42121,397,NULL,'2015-09-21 14:00:00','2015-09-21 18:30:00',26932,64,1,'2015-09-21 14:00','2015-09-21 18:30',NULL,NULL,'F'),
(42122,397,NULL,'2015-09-24 14:00:00','2015-09-24 18:30:00',13437,64,1,'2015-09-24 14:00','2015-09-24 18:30',NULL,NULL,'F'),
(42126,397,NULL,'2015-09-25 14:00:00','2015-09-25 18:00:00',13462,64,1,'2015-09-25 14:00','2015-09-25 18:00',NULL,NULL,'F'),
(42141,397,'Se tomo este día para cruzar con el 31 de julio q no había podido tomar.','2015-09-16 14:00:00','2015-09-16 18:00:00',13464,64,1,'2015-09-16 14:00','2015-09-16 18:00',NULL,NULL,'F'),
(42502,392,'NO SE REALIZÓ PAGO DE SALARIO A TIEMPO','2015-09-22 00:00:00','2015-09-22 23:59:00',50945,79,5,'2015-09-22','1',NULL,NULL,'F'),
(42505,392,'licencia no remunerada','2015-09-23 00:00:00','2015-09-23 23:59:00',24273,79,3,'2015-09-23','2015-09-23',NULL,NULL,'F'),
(42753,392,'LICENCIA POR 3 DIAS POR ENFERMEDAD DE HIJO','2015-09-16 00:00:00','2015-09-18 23:59:00',24791,79,3,'2015-09-16','2015-09-18',NULL,NULL,'F'),
(44146,381,'Servicios médicos','2015-09-18 14:00:00','2015-09-18 17:00:00',50017,91,2,'2015-09-18','14:00','17:00',NULL,'F'),
(44148,387,'compensación de permiso del 18/09/2015','2015-09-25 17:00:00','2015-09-25 19:30:00',50017,91,2,'2015-09-25','17:00','19:30',NULL,'F'),
(44149,387,'Reponer tiempo de permiso 18/09/2015','2015-09-28 17:00:00','2015-09-28 19:29:00',50017,91,2,'2015-09-28','17:00','19:29',NULL,'F'),
(44150,381,'Diligencia Personal','2015-09-22 08:00:00','2015-09-22 09:15:00',50017,91,2,'2015-09-22','08:00','09:15',NULL,'F'),
(44151,387,'Compensación por permiso de hora y 15 minutos el 22/09/2015','2015-09-29 17:00:00','2015-09-29 18:30:00',50017,91,2,'2015-09-29','17:00','18:30',NULL,'F'),
(44152,381,'No remunerado','2015-10-01 00:00:00','2015-10-06 23:59:00',50082,91,5,'2015-10-01','6',NULL,NULL,'F'),
(44154,381,'permiso remunerado por calamidad doméstica','2015-09-30 00:00:00','2015-10-02 23:59:00',50018,91,5,'2015-09-30','3',NULL,NULL,'F'),
(44164,381,'Diligencias de la Supersolidaria','2015-09-19 00:00:00','2015-09-19 23:59:00',50140,91,5,'2015-09-19','1',NULL,NULL,'F'),
(44165,381,NULL,'2015-09-28 08:00:00','2015-09-28 11:00:00',50077,91,2,'2015-09-28','08:00','11:00',NULL,'F'),
(44166,387,'Por permiso del 28/09/2015','2015-10-03 12:00:00','2015-10-03 15:00:00',50077,91,2,'2015-10-03','12:00','15:00',NULL,'F'),
(44168,381,'Diligencia Personal','2015-10-24 14:00:00','2015-10-24 17:00:00',50157,91,2,'2015-10-24','14:00','17:00',NULL,'F'),
(44169,387,'Por permiso del 24/09/2015','2015-09-28 17:00:00','2015-09-28 19:00:00',50157,91,2,'2015-09-28','17:00','19:00',NULL,'F'),
(44172,387,'De permiso 24/09/2015','2015-09-29 17:00:00','2015-09-29 19:00:00',50157,91,2,'2015-09-29','17:00','19:00',NULL,'F'),
(44173,381,'Cita médica','2015-09-28 08:00:00','2015-09-28 10:00:00',50117,91,2,'2015-09-28','08:00','10:00',NULL,'F'),
(44174,381,'Diligencia personal','2015-09-28 09:00:00','2015-09-28 12:00:00',50122,91,2,'2015-09-28','09:00','12:00',NULL,'F'),
(44175,387,'Por permiso del 28/09/2015','2015-09-29 07:00:00','2015-09-29 08:00:00',50122,91,2,'2015-09-29','07:00','08:00',NULL,'F'),
(44176,387,'Permiso 28/09/2015','2015-09-30 07:00:00','2015-09-30 08:00:00',50122,91,2,'2015-09-30','07:00','08:00',NULL,'F'),
(44177,387,'por permiso 28/09/15','2015-10-01 07:00:00','2015-10-01 08:00:00',50122,91,2,'2015-10-01','07:00','08:00',NULL,'F'),
(44178,381,'Examenes de laboratorio','2015-10-28 08:00:00','2015-10-28 09:00:00',50138,91,2,'2015-10-28','08:00','09:00',NULL,'F'),
(44179,380,'Cumpleaños','2015-10-02 12:00:00','2015-10-02 16:00:00',49994,91,2,'2015-10-02','12:00','16:00',NULL,'F'),
(44180,381,'médico','2015-09-25 14:00:00','2015-09-25 16:00:00',50142,91,2,'2015-09-25','14:00','16:00',NULL,'F'),
(44181,381,'servicios médicos','2015-09-22 07:00:00','2015-09-22 10:00:00',50121,91,2,'2015-09-22','07:00','10:00',NULL,'F'),
(44182,381,'Servicios médicos','2015-09-21 15:30:00','2015-09-21 16:00:00',50121,91,2,'2015-09-21','15:30','16:00',NULL,'F'),
(44183,381,'Sindicato','2015-09-24 00:00:00','2015-09-24 23:59:00',50019,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44184,381,'personal','2015-09-29 08:00:00','2015-09-29 08:30:00',50019,91,2,'2015-09-29','08:00','08:30',NULL,'F'),
(44186,387,'de permiso del 29/09/2015','2015-09-30 07:30:00','2015-09-30 08:00:00',50019,91,2,'2015-09-30','07:30','08:00',NULL,'F'),
(44187,381,'Capacitación Jurado de votación ','2015-10-07 13:00:00','2015-10-07 17:00:00',50132,91,2,'2015-10-07','13:00','17:00',NULL,'F'),
(44188,380,'Compensatorio por sabado laboradora en jornada de servicio al ciudadano el 26/09/2015','2015-10-13 00:00:00','2015-10-13 23:59:00',50132,91,5,'2015-10-13','1',NULL,NULL,'F'),
(44189,381,'Diligencia Personal','2015-10-01 13:00:00','2015-10-01 17:00:00',50132,91,2,'2015-10-01','13:00','17:00',NULL,'F'),
(44190,387,'por permiso del 01/10/2015','2015-10-02 17:00:00','2015-10-02 18:30:00',50132,91,2,'2015-10-02','17:00','18:30',NULL,'F'),
(44191,387,'Por permiso del 01/10/2015','2015-10-05 17:00:00','2015-10-05 18:30:00',50132,91,2,'2015-10-05','17:00','18:30',NULL,'F'),
(44194,387,'Por permiso del 01/10/2015','2015-10-06 17:00:00','2015-10-06 18:30:00',50132,91,2,'2015-10-06','17:00','18:30',NULL,'F'),
(44195,381,'Agencia Juridica','2015-09-30 08:00:00','2015-09-30 13:00:00',50132,91,2,'2015-09-30','08:00','13:00',NULL,'F'),
(44196,381,'Diligencias personales','2015-09-25 14:00:00','2015-09-25 17:00:00',50009,91,2,'2015-09-25','14:00','17:00',NULL,'F'),
(44197,387,'Por permiso del 25/09/2015','2015-09-29 17:00:00','2015-09-29 18:00:00',50009,91,2,'2015-09-29','17:00','18:00',NULL,'F'),
(44198,387,'Por permiso del 25/09/2015','2015-09-30 17:00:00','2015-09-30 18:00:00',50009,91,2,'2015-09-30','17:00','18:00',NULL,'F'),
(44199,387,'Por permiso del 25/09/2015','2015-10-01 17:00:00','2015-10-01 18:00:00',50009,91,2,'2015-10-01','17:00','18:00',NULL,'F'),
(44204,381,'Diligencia Personal','2015-09-22 10:00:00','2015-09-22 13:00:00',50014,91,2,'2015-09-22','10:00','13:00',NULL,'F'),
(44205,387,'Por permiso del 22/09/2015','2015-09-23 06:30:00','2015-09-23 08:00:00',50014,91,2,'2015-09-23','06:30','08:00',NULL,'F'),
(44206,387,'Por permiso del 22/09/2015','2015-09-23 17:30:00','2015-09-23 19:00:00',50014,91,2,'2015-09-23','17:30','19:00',NULL,'F'),
(44207,381,'Diligencia personal','2015-09-28 13:00:00','2015-09-28 17:00:00',50006,91,2,'2015-09-28','13:00','17:00',NULL,'F'),
(44208,387,'Por permiso del 28/09/15','2015-09-29 06:00:00','2015-09-29 07:00:00',50006,91,2,'2015-09-29','06:00','07:00',NULL,'F'),
(44209,387,'Por permiso del 28/09/2015','2015-09-30 06:00:00','2015-09-30 07:00:00',50006,91,2,'2015-09-30','06:00','07:00',NULL,'F'),
(44210,387,'por permiso del 28/09/2015','2015-10-01 06:00:00','2015-10-01 07:00:00',50006,91,2,'2015-10-01','06:00','07:00',NULL,'F'),
(44211,387,'Por permiso del 28/09/2015','2015-10-02 06:00:00','2015-10-02 07:00:00',50006,91,2,'2015-10-02','06:00','07:00',NULL,'F'),
(44212,381,'Audiencia de conciliación','2015-09-23 09:30:00','2015-09-23 13:00:00',50132,91,2,'2015-09-23','09:30','13:00',NULL,'F'),
(44213,381,'Entrenamiento equipo de futbol femenino de la Super.','2015-09-24 16:00:00','2015-09-24 17:00:00',50004,91,2,'2015-09-24','16:00','17:00',NULL,'F'),
(44214,381,'Diligencia Personal','2015-09-24 13:15:00','2015-09-24 14:15:00',50100,91,2,'2015-09-24','13:15','14:15',NULL,'F'),
(44215,387,'Por permiso del 24/09/2015','2015-09-24 16:00:00','2015-09-24 17:00:00',50100,91,2,'2015-09-24','16:00','17:00',NULL,'F'),
(44216,381,'sindicato','2015-09-24 12:00:00','2015-09-24 16:00:00',50015,91,2,'2015-09-24','12:00','16:00',NULL,'F'),
(44217,381,'Servicios médicos','2015-09-25 15:00:00','2015-09-25 17:00:00',50046,91,2,'2015-09-25','15:00','17:00',NULL,'F'),
(44218,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50098,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44219,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50119,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44220,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50147,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44221,381,'Partido de futbol función pública','2015-09-23 16:00:00','2015-09-23 17:00:00',50147,91,2,'2015-09-23','16:00','17:00',NULL,'F'),
(44222,381,'Diligencia Personal','2015-09-25 08:00:00','2015-09-25 10:00:00',50147,91,2,'2015-09-25','08:00','10:00',NULL,'F'),
(44223,387,'Por permiso del 25/09/2015','2015-10-01 17:00:00','2015-10-01 18:00:00',50147,91,2,'2015-10-01','17:00','18:00',NULL,'F'),
(44224,387,'Permiso del 25/09/15','2015-10-02 17:00:00','2015-10-02 18:00:00',50147,91,2,'2015-10-02','17:00','18:00',NULL,'F'),
(44226,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50158,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44227,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50120,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44228,381,'Sindical','2015-09-24 00:00:00','2015-09-24 23:59:00',50150,91,5,'2015-09-24','1',NULL,NULL,'F'),
(44229,381,'Servicios médicos','2015-09-29 08:00:00','2015-09-29 11:00:00',50101,91,2,'2015-09-29','08:00','11:00',NULL,'F'),
(44274,397,NULL,'2015-09-30 14:00:00','2015-09-30 18:30:00',13468,64,1,'2015-09-30 14:00','2015-09-30 18:30',NULL,NULL,'F'),
(44419,381,'Sindical','2015-10-01 00:00:00','2015-10-01 23:59:00',50150,91,5,'2015-10-01','1',NULL,NULL,'F'),
(44420,381,'Diligencia relacionada con la Superintendencia','2015-09-30 08:00:00','2015-09-30 12:00:00',50077,91,2,'2015-09-30','08:00','12:00',NULL,'F'),
(44421,381,'Diligencia personal','2015-09-30 13:00:00','2015-09-30 14:30:00',50088,91,2,'2015-09-30','13:00','14:30',NULL,'F'),
(44422,381,'Diligencia personal','2015-09-30 08:00:00','2015-09-30 12:00:00',50119,91,2,'2015-09-30','08:00','12:00',NULL,'F'),
(44423,387,'Por permiso del 30/09/15','2015-10-05 17:00:00','2015-10-05 18:00:00',50119,91,2,'2015-10-05','17:00','18:00',NULL,'F'),
(44425,387,'Por permiso del 30/09/2015','2015-10-06 17:00:00','2015-10-06 18:00:00',50119,91,2,'2015-10-06','17:00','18:00',NULL,'F'),
(44426,387,'Por permiso del 30/09/2015','2015-10-07 17:00:00','2015-10-07 18:00:00',50119,91,2,'2015-10-07','17:00','18:00',NULL,'F'),
(44427,387,'Por permiso del 30/09/2015','2015-10-08 17:00:00','2015-10-08 18:00:00',50119,91,2,'2015-10-08','17:00','18:00',NULL,'F'),
(44428,381,'Diligencia personal','2015-09-29 08:00:00','2015-09-29 09:00:00',50137,91,2,'2015-09-29','08:00','09:00',NULL,'F'),
(44429,387,'Por permiso del 29/09/2015','2015-09-30 17:00:00','2015-09-30 18:00:00',50137,91,2,'2015-09-30','17:00','18:00',NULL,'F'),
(44430,381,'Diligencia personal','2015-09-30 14:00:00','2015-09-30 16:00:00',50100,91,2,'2015-09-30','14:00','16:00',NULL,'F'),
(44431,387,'Por permiso del 30/09/15','2015-10-05 16:00:00','2015-10-05 18:00:00',50100,91,2,'2015-10-05','16:00','18:00',NULL,'F'),
(44432,380,'Cumpleaños','2015-10-02 13:00:00','2015-10-02 17:00:00',50124,91,2,'2015-10-02','13:00','17:00',NULL,'F'),
(44433,381,'Servicios médicos','2015-09-30 08:00:00','2015-09-30 08:40:00',50068,91,2,'2015-09-30','08:00','08:40',NULL,'F'),
(44434,381,'Diligencia Personal','2015-09-30 14:00:00','2015-09-30 17:00:00',50008,91,2,'2015-09-30','14:00','17:00',NULL,'F'),
(44435,387,'Por permiso del 30/09/2015','2015-10-01 17:00:00','2015-10-01 19:00:00',50008,91,2,'2015-10-01','17:00','19:00',NULL,'F'),
(44436,387,'Por permiso del 30/09/2015','2015-10-02 17:00:00','2015-10-02 19:00:00',50008,91,2,'2015-10-02','17:00','19:00',NULL,'F'),
(44439,381,'Diligencia personal','2015-09-30 16:00:00','2015-09-30 17:00:00',50122,91,2,'2015-09-30','16:00','17:00',NULL,'F'),
(44440,387,'Por permiso del 30/09/2015','2015-10-02 07:00:00','2015-10-02 08:00:00',50122,91,2,'2015-10-02','07:00','08:00',NULL,'F'),
(44441,381,'Diligencia Personal','2015-09-23 08:00:00','2015-09-23 10:00:00',50108,91,2,'2015-09-23','08:00','10:00',NULL,'F'),
(44442,387,'Por permiso del 23/09/2015','2015-09-24 17:00:00','2015-09-24 19:00:00',50108,91,2,'2015-09-24','17:00','19:00',NULL,'F'),
(44443,381,'Servicios médicos','2015-09-25 08:00:00','2015-09-25 09:30:00',50108,91,2,'2015-09-25','08:00','09:30',NULL,'F'),
(44445,381,'Servicios médicos','2015-09-30 15:00:00','2015-09-30 16:00:00',50091,91,2,'2015-09-30','15:00','16:00',NULL,'F'),
(44452,385,NULL,'2015-09-14 00:00:00','2015-09-17 00:00:00',23782,77,NULL,'2015-09-14 00:00','2015-09-17 00:00',NULL,NULL,'F'),
(44453,385,NULL,'2015-09-17 12:42:00','2015-10-10 12:42:00',23918,77,NULL,'2015-09-17 12:42','2015-10-10 12:42',NULL,NULL,'F'),
(44768,392,NULL,'2015-10-01 00:00:00','2015-10-01 23:59:00',24535,79,5,'2015-10-01','1',NULL,NULL,'F'),
(45058,392,'Recupera 6 horas','2015-09-29 07:00:00','2015-09-29 14:00:00',24245,79,2,'2015-09-29','07:00','14:00',NULL,'F'),
(45060,392,'Recupera 6 horas','2015-09-30 07:00:00','2015-09-30 14:00:00',24245,79,2,'2015-09-30','07:00','14:00',NULL,'F'),
(46610,380,'Por cumpleaños','2015-10-13 07:00:00','2015-10-13 12:00:00',50010,91,2,'2015-10-13','07:00','12:00',NULL,'F'),
(46614,381,'Diligencia personal','2015-10-08 00:00:00','2015-10-08 23:59:00',50177,91,5,'2015-10-08','1',NULL,NULL,'F'),
(46615,387,'Permiso del 08/10/15','2015-10-07 17:00:00','2015-10-07 19:00:00',50177,91,2,'2015-10-07','17:00','19:00',NULL,'F'),
(46617,387,'Por permiso del 08/10/2015','2015-10-09 17:00:00','2015-10-09 19:00:00',50177,91,2,'2015-10-09','17:00','19:00',NULL,'F'),
(46618,387,'de permiso 08/10/2015','2015-10-13 17:00:00','2015-10-13 19:00:00',50177,91,2,'2015-10-13','17:00','19:00',NULL,'F'),
(46619,387,'Por permiso del 08/10/15','2015-10-14 17:00:00','2015-10-14 19:00:00',50177,91,2,'2015-10-14','17:00','19:00',NULL,'F'),
(46620,387,'Por permiso del 08/10/2015','2015-10-15 17:00:00','2015-10-15 19:00:00',50177,91,2,'2015-10-15','17:00','19:00',NULL,'F'),
(46622,387,'Por permiso del 08/10/2015','2015-10-16 17:00:00','2015-10-16 19:00:00',50177,91,2,'2015-10-16','17:00','19:00',NULL,'F'),
(46623,387,'Por permiso del 08/10','2015-10-19 17:00:00','2015-10-19 19:00:00',50177,91,2,'2015-10-19','17:00','19:00',NULL,'F'),
(46624,387,'por permiso del 08/10','2015-10-20 17:00:00','2015-10-20 19:00:00',50177,91,2,'2015-10-20','17:00','19:00',NULL,'F'),
(46625,381,'diligencia personal','2015-10-21 08:00:00','2015-10-21 17:00:00',50177,91,2,'2015-10-21','08:00','17:00',NULL,'F'),
(46626,381,'Diligencia personal','2015-10-09 00:00:00','2015-10-09 23:59:00',50157,91,5,'2015-10-09','1',NULL,NULL,'F'),
(46627,387,'Por permiso del 09/10','2015-10-13 17:00:00','2015-10-13 19:00:00',50157,91,2,'2015-10-13','17:00','19:00',NULL,'F'),
(46628,387,'Por permiso del 09/10','2015-10-14 17:00:00','2015-10-14 19:00:00',50157,91,2,'2015-10-14','17:00','19:00',NULL,'F'),
(46629,387,'Por permiso del 09/10','2015-10-15 17:00:00','2015-10-15 19:00:00',50157,91,2,'2015-10-15','17:00','19:00',NULL,'F'),
(46631,387,'Por permiso del 09/10','2015-10-16 17:00:00','2015-10-16 19:00:00',50157,91,2,'2015-10-16','17:00','19:00',NULL,'F'),
(46632,387,'Por permiso del 09/10/15','2015-10-19 17:00:00','2015-10-19 19:00:00',50157,91,2,'2015-10-19','17:00','19:00',NULL,'F'),
(46633,387,'Por permiso del 09/10','2015-10-20 17:00:00','2015-10-20 19:00:00',50157,91,2,'2015-10-20','17:00','19:00',NULL,'F'),
(46639,381,'Diligencia personal','2015-10-07 14:00:00','2015-10-07 15:00:00',50117,91,2,'2015-10-07','14:00','15:00',NULL,'F'),
(46640,387,'Por permiso del 07/10','2015-10-07 17:00:00','2015-10-07 17:30:00',50117,91,2,'2015-10-07','17:00','17:30',NULL,'F'),
(46642,387,'por permiso del 07/10','2015-10-08 17:00:00','2015-10-08 17:30:00',50117,91,2,'2015-10-08','17:00','17:30',NULL,'F'),
(46646,381,'Sindical','2015-10-08 08:30:00','2015-10-08 16:00:00',50150,91,2,'2015-10-08','08:30','16:00',NULL,'F'),
(46647,381,'Servicios médicos','2015-10-20 07:00:00','2015-10-20 11:00:00',50150,91,2,'2015-10-20','07:00','11:00',NULL,'F'),
(46648,381,'Servicios médicos','2015-10-16 07:00:00','2015-10-16 12:00:00',50150,91,2,'2015-10-16','07:00','12:00',NULL,'F'),
(46649,381,'Servicios médicos','2015-10-08 07:00:00','2015-10-08 09:00:00',50121,91,2,'2015-10-08','07:00','09:00',NULL,'F'),
(46650,381,'Capacitación jurado de votación','2015-10-07 13:00:00','2015-10-07 16:00:00',50015,91,2,'2015-10-07','13:00','16:00',NULL,'F'),
(46651,381,'Servicios médicos','2015-10-07 14:00:00','2015-10-07 16:00:00',50088,91,2,'2015-10-07','14:00','16:00',NULL,'F'),
(46652,381,'Servicios médicos','2015-10-07 15:00:00','2015-10-07 17:00:00',50046,91,2,'2015-10-07','15:00','17:00',NULL,'F'),
(46653,381,'Servicios médicos','2015-10-01 08:00:00','2015-10-01 08:35:00',50017,91,2,'2015-10-01','08:00','08:35',NULL,'F'),
(46654,381,'Servicios médicos','2015-10-09 07:00:00','2015-10-09 09:30:00',50091,91,2,'2015-10-09','07:00','09:30',NULL,'F'),
(46655,381,'Diligencia relacionada de la Superintendencia - Foro SST','2015-10-07 00:00:00','2015-10-08 23:59:00',50091,91,5,'2015-10-07','2',NULL,NULL,'F'),
(46656,381,'Diligencias relacionada con la Superintendencia - Foro SST','2015-10-07 00:00:00','2015-10-08 23:59:00',49994,91,5,'2015-10-07','2',NULL,NULL,'F'),
(46657,381,'Diligencia relacionada con la Superintendencia - Foro SST','2015-10-07 00:00:00','2015-10-08 23:59:00',50002,91,5,'2015-10-07','2',NULL,NULL,'F'),
(46659,381,'servicios médicos','2015-10-07 15:30:00','2015-10-07 16:00:00',50121,91,2,'2015-10-07','15:30','16:00',NULL,'F'),
(46660,381,'Diligencia personal','2015-10-05 07:00:00','2015-10-05 08:00:00',50016,91,2,'2015-10-05','07:00','08:00',NULL,'F'),
(46661,387,'Por permiso del 05/10','2015-10-06 16:00:00','2015-10-06 16:30:00',50016,91,2,'2015-10-06','16:00','16:30',NULL,'F'),
(46662,381,'Por permiso del 05/10','2015-10-07 16:00:00','2015-10-07 16:30:00',50016,91,2,'2015-10-07','16:00','16:30',NULL,'F'),
(46664,381,'Diligencia personal','2015-09-21 07:00:00','2015-09-21 08:30:00',50016,91,2,'2015-09-21','07:00','08:30',NULL,'F'),
(46666,387,'Por permiso del 21/09/15','2015-09-21 16:00:00','2015-09-21 16:30:00',50016,91,2,'2015-09-21','16:00','16:30',NULL,'F'),
(46669,387,'Por permiso del 21/09/15','2015-09-22 16:00:00','2015-09-22 16:30:00',50016,91,2,'2015-09-22','16:00','16:30',NULL,'F'),
(46670,387,'Por permiso del 21/09/15','2015-09-23 16:00:00','2015-09-23 16:30:00',50016,91,2,'2015-09-23','16:00','16:30',NULL,'F'),
(46673,381,'Servicios médicos','2015-09-16 07:00:00','2015-09-16 08:30:00',50016,91,2,'2015-09-16','07:00','08:30',NULL,'F'),
(46674,381,'Diligencia personal','2015-10-05 08:30:00','2015-10-05 11:30:00',49994,91,2,'2015-10-05','08:30','11:30',NULL,'F'),
(46676,387,'por permiso del 05/10/15','2015-10-14 16:00:00','2015-10-14 17:30:00',49994,91,2,'2015-10-14','16:00','17:30',NULL,'F'),
(46677,387,'por permiso del 05/10/15','2015-10-16 16:00:00','2015-10-16 17:30:00',49994,91,2,'2015-10-16','16:00','17:30',NULL,'F'),
(46682,381,'Diligencia relacionada con la Super- Audiencia','2015-10-06 08:00:00','2015-10-06 12:00:00',50017,91,2,'2015-10-06','08:00','12:00',NULL,'F'),
(46684,381,'Diligencia personal','2015-10-09 14:00:00','2015-10-09 17:00:00',50068,91,2,'2015-10-09','14:00','17:00',NULL,'F'),
(46685,387,'Por permiso del 09/10/15','2015-10-06 17:00:00','2015-10-06 18:00:00',50068,91,2,'2015-10-06','17:00','18:00',NULL,'F'),
(46687,387,'Por pemiso del 09/10/2015','2015-10-07 17:00:00','2015-10-07 18:00:00',50068,91,2,'2015-10-07','17:00','18:00',NULL,'F'),
(46688,387,'Por permiso del 09/10/15','2015-10-08 17:00:00','2015-10-08 18:00:00',50068,91,2,'2015-10-08','17:00','18:00',NULL,'F'),
(46689,381,'Diligencia personal','2015-10-09 13:00:00','2015-10-09 17:00:00',50095,91,2,'2015-10-09','13:00','17:00',NULL,'F'),
(46691,387,'Por permiso del 09/10/15','2015-10-05 17:00:00','2015-10-05 21:00:00',50095,91,2,'2015-10-05','17:00','21:00',NULL,'F'),
(46694,381,'Diligencia Personal','2015-10-05 08:00:00','2015-10-05 08:45:00',50114,91,2,'2015-10-05','08:00','08:45',NULL,'F'),
(46695,387,'Por permiso del 05/10/15','2015-10-05 17:00:00','2015-10-05 17:45:00',50114,91,2,'2015-10-05','17:00','17:45',NULL,'F'),
(46705,381,'Diligencia personal','2015-10-13 08:00:00','2015-10-13 12:00:00',50004,91,2,'2015-10-13','08:00','12:00',NULL,'F'),
(46706,387,'Por permiso del 13/10/2015','2015-10-05 07:00:00','2015-10-05 08:00:00',50004,91,2,'2015-10-05','07:00','08:00',NULL,'F'),
(46707,387,'Por permiso del 13/10/2015','2015-10-06 17:00:00','2015-10-06 19:00:00',50004,91,2,'2015-10-06','17:00','19:00',NULL,'F'),
(46708,387,'Por permiso del 13/10/2015','2015-10-08 17:00:00','2015-10-08 18:00:00',50004,91,2,'2015-10-08','17:00','18:00',NULL,'F'),
(46709,381,'Servicios médicos','2015-10-16 14:29:00','2015-10-16 17:00:00',50101,91,2,'2015-10-16','14:29','17:00',NULL,'F'),
(46710,381,'Diligencia personal','2015-10-09 13:00:00','2015-10-09 17:00:00',50101,91,2,'2015-10-09','13:00','17:00',NULL,'F'),
(46713,387,'Por permiso del 09/10/13','2015-10-06 07:30:00','2015-10-06 08:00:00',50101,91,2,'2015-10-06','07:30','08:00',NULL,'F'),
(46716,387,'Por permiso del 09/10/15','2015-10-07 07:30:00','2015-10-07 08:00:00',50101,91,2,'2015-10-07','07:30','08:00',NULL,'F'),
(46719,387,'Por permiso del 09/10/15','2015-10-08 07:30:00','2015-10-08 08:00:00',50101,91,2,'2015-10-08','07:30','08:00',NULL,'F'),
(46722,387,'por permiso del 09/10/15','2015-10-13 07:30:00','2015-10-13 08:00:00',50101,91,2,'2015-10-13','07:30','08:00',NULL,'F'),
(46725,387,'Por permiso del 09/10/15','2015-10-09 07:30:00','2015-10-09 08:00:00',50101,91,2,'2015-10-09','07:30','08:00',NULL,'F'),
(46728,387,'Por permiso del 09/10/15','2015-10-15 07:30:00','2015-10-15 08:00:00',50101,91,2,'2015-10-15','07:30','08:00',NULL,'F'),
(46731,387,'Por permiso del 09/10/15','2015-10-16 07:30:00','2015-10-16 08:00:00',50101,91,2,'2015-10-16','07:30','08:00',NULL,'F'),
(46737,381,'Diligencias personales','2015-10-02 07:00:00','2015-10-02 11:00:00',49994,91,2,'2015-10-02','07:00','11:00',NULL,'F'),
(46738,387,'Por permiso del 02/10/15','2015-10-05 16:00:00','2015-10-05 17:00:00',49994,91,2,'2015-10-05','16:00','17:00',NULL,'F'),
(46739,387,'Por permiso del 02/10/15','2015-10-06 16:00:00','2015-10-06 17:00:00',49994,91,2,'2015-10-06','16:00','17:00',NULL,'F'),
(46741,387,'Por permiso del 02/10/15','2015-10-09 16:00:00','2015-10-09 17:00:00',49994,91,2,'2015-10-09','16:00','17:00',NULL,'F'),
(46744,381,'Servicios médicos','2015-09-29 00:00:00','2015-09-29 23:59:00',49994,91,5,'2015-09-29','1',NULL,NULL,'F'),
(46746,381,'Servicios médicos','2015-10-05 13:00:00','2015-10-05 16:00:00',50091,91,2,'2015-10-05','13:00','16:00',NULL,'F'),
(46754,381,'Diligencia personal','2015-10-05 08:00:00','2015-10-05 09:00:00',50071,91,2,'2015-10-05','08:00','09:00',NULL,'F'),
(46756,387,'Por permiso del 05/10/15','2015-10-06 17:00:00','2015-10-06 18:00:00',50071,91,2,'2015-10-06','17:00','18:00',NULL,'F'),
(46759,381,'Diligencia personal','2015-10-05 10:00:00','2015-10-05 12:00:00',50009,91,2,'2015-10-05','10:00','12:00',NULL,'F'),
(46761,387,'Por permiso del 05/10/2015','2015-10-06 17:00:00','2015-10-06 18:00:00',50009,91,2,'2015-10-06','17:00','18:00',NULL,'F'),
(46763,387,'Por permiso del 05/10/2015','2015-10-07 17:00:00','2015-10-07 18:00:00',50009,91,2,'2015-10-07','17:00','18:00',NULL,'F'),
(46770,381,'Servicios médicos','2015-10-05 07:00:00','2015-10-05 08:30:00',50151,91,2,'2015-10-05','07:00','08:30',NULL,'F'),
(46785,381,'Capacitación jurado de votación','2015-10-02 14:00:00','2015-10-02 17:00:00',50123,91,2,'2015-10-02','14:00','17:00',NULL,'F'),
(46788,381,'Capacitación jurado de votación','2015-10-05 09:30:00','2015-10-05 12:00:00',50151,91,2,'2015-10-05','09:30','12:00',NULL,'F'),
(46793,380,'Cumpleaños','2015-10-01 08:00:00','2015-10-01 12:00:00',50117,91,2,'2015-10-01','08:00','12:00',NULL,'F'),
(46798,381,'Servicios médicos','2015-09-30 14:00:00','2015-09-30 16:00:00',50098,91,2,'2015-09-30','14:00','16:00',NULL,'F'),
(46800,381,'Dilgiencia personal','2015-10-01 08:00:00','2015-10-01 10:00:00',50071,91,2,'2015-10-01','08:00','10:00',NULL,'F'),
(46803,387,'Por permiso 01/10/2015','2015-10-01 17:00:00','2015-10-01 18:00:00',50071,91,2,'2015-10-01','17:00','18:00',NULL,'F'),
(46805,387,'Por permiso del 01/10/15','2015-10-02 17:00:00','2015-10-02 18:00:00',50071,91,2,'2015-10-02','17:00','18:00',NULL,'F'),
(46811,381,'Capacitación Jurado de votación','2015-10-01 13:00:00','2015-10-01 17:00:00',50009,91,2,'2015-10-01','13:00','17:00',NULL,'F'),
(46813,380,'Por asistir a laborar el 26/09/15 feria ciudadana','2015-10-09 00:00:00','2015-10-09 23:59:00',50140,91,5,'2015-10-09','1',NULL,NULL,'F'),
(46816,381,'Diligencia personal','2015-10-02 15:00:00','2015-10-02 16:00:00',50129,91,2,'2015-10-02','15:00','16:00',NULL,'F'),
(46819,387,'Por permiso del 02/10/2015','2015-10-05 06:00:00','2015-10-05 07:00:00',50129,91,2,'2015-10-05','06:00','07:00',NULL,'F'),
(46825,381,'Servicios médicos','2015-10-05 15:00:00','2015-10-05 17:00:00',50121,91,2,'2015-10-05','15:00','17:00',NULL,'F'),
(46827,381,'Servicios médicos','2015-10-02 07:00:00','2015-10-02 09:30:00',50088,91,2,'2015-10-02','07:00','09:30',NULL,'F'),
(46830,381,'Diligencia personal','2015-10-02 15:00:00','2015-10-02 17:00:00',50153,91,2,'2015-10-02','15:00','17:00',NULL,'F'),
(46831,387,'Por permiso del 02/10/2015','2015-10-05 16:00:00','2015-10-05 17:00:00',50153,91,2,'2015-10-05','16:00','17:00',NULL,'F'),
(46834,381,'Diligencia personal','2015-10-01 07:00:00','2015-10-01 10:00:00',50131,91,2,'2015-10-01','07:00','10:00',NULL,'F'),
(46836,387,'de permiso  del 01/10/2015','2015-10-02 16:00:00','2015-10-02 19:00:00',50131,91,2,'2015-10-02','16:00','19:00',NULL,'F'),
(46840,381,'Diligencia personal','2015-10-01 13:00:00','2015-10-01 16:00:00',50100,91,2,'2015-10-01','13:00','16:00',NULL,'F'),
(46841,387,'Por permiso del 01/10/15','2015-10-06 16:00:00','2015-10-06 19:00:00',50100,91,2,'2015-10-06','16:00','19:00',NULL,'F'),
(46842,381,'Hijo','2015-09-30 00:00:00','2015-10-02 23:59:00',50018,91,5,'2015-09-30','3',NULL,NULL,'F'),
(46843,381,'Diligencia personal','2015-09-30 16:00:00','2015-09-30 17:00:00',50114,91,2,'2015-09-30','16:00','17:00',NULL,'F'),
(46844,387,'Por permiso del 30/09/2015','2015-09-01 07:00:00','2015-09-01 08:00:00',50114,91,2,'2015-09-01','07:00','08:00',NULL,'F'),
(46845,381,'Servicios médicos','2015-09-02 15:00:00','2015-09-02 17:00:00',50091,91,2,'2015-09-02','15:00','17:00',NULL,'F'),
(46846,381,'Diligencia personal','2015-10-09 13:00:00','2015-10-09 17:00:00',50076,91,2,'2015-10-09','13:00','17:00',NULL,'F'),
(46847,387,'Permiso 09/10/2015','2015-10-13 17:00:00','2015-10-13 18:00:00',50076,91,2,'2015-10-13','17:00','18:00',NULL,'F'),
(46848,387,'Permiso del 09/10/15','2015-10-14 17:00:00','2015-10-14 18:00:00',50076,91,2,'2015-10-14','17:00','18:00',NULL,'F'),
(46849,387,'Permiso del 09/10/2015','2015-10-15 17:00:00','2015-10-15 18:00:00',50076,91,2,'2015-10-15','17:00','18:00',NULL,'F'),
(46850,387,'permiso del 09/10/15','2015-10-16 17:00:00','2015-10-16 18:00:00',50076,91,2,'2015-10-16','17:00','18:00',NULL,'F'),
(46857,381,'Diligencia personal','2015-10-09 00:00:00','2015-10-13 23:59:00',50123,91,5,'2015-10-09','5',NULL,NULL,'F'),
(46861,387,'de permiso del 9 y 13/10/15','2015-10-01 07:30:00','2015-10-01 08:00:00',50123,91,2,'2015-10-01','07:30','08:00',NULL,'F'),
(46864,387,'del permiso del 9 al 13/10/15','2015-10-01 17:00:00','2015-10-01 18:00:00',50123,91,2,'2015-10-01','17:00','18:00',NULL,'F'),
(46865,387,'de permiso del 09 al 13/10/15','2015-10-02 07:30:00','2015-10-02 08:00:00',50123,91,2,'2015-10-02','07:30','08:00',NULL,'F'),
(46866,387,'permiso del 09 y 13/10/15','2015-10-02 17:00:00','2015-10-02 18:00:00',50123,91,2,'2015-10-02','17:00','18:00',NULL,'F'),
(46867,387,'Permiso del 09 y 13/10/15','2015-10-05 07:30:00','2015-10-05 09:00:00',50123,91,2,'2015-10-05','07:30','09:00',NULL,'F'),
(46869,387,'de permiso del 9 a 13/10/15','2015-10-05 16:00:00','2015-10-05 18:00:00',50123,91,2,'2015-10-05','16:00','18:00',NULL,'F'),
(46874,387,'de permiso del 09 al 13/10/15','2015-10-06 07:30:00','2015-10-06 08:00:00',50123,91,2,'2015-10-06','07:30','08:00',NULL,'F'),
(46875,387,'de permiso del 9 y 13/10/2015','2015-10-06 17:00:00','2015-10-06 18:00:00',50123,91,2,'2015-10-06','17:00','18:00',NULL,'F'),
(46876,387,'de permiso del 9 a 13/10/15','2015-10-07 07:30:00','2015-10-07 08:00:00',50123,91,2,'2015-10-07','07:30','08:00',NULL,'F'),
(46877,387,'de permiso 9 y 13/10/15','2015-10-07 17:00:00','2015-10-07 18:00:00',50123,91,2,'2015-10-07','17:00','18:00',NULL,'F'),
(46878,387,'de permiso de 9 y 13/10/15','2015-10-08 07:30:00','2015-10-08 08:00:00',50123,91,2,'2015-10-08','07:30','08:00',NULL,'F'),
(46880,387,'De permiso del 9 y 13/10/2015','2015-10-08 17:00:00','2015-10-08 18:00:00',50123,91,2,'2015-10-08','17:00','18:00',NULL,'F'),
(46881,387,'de permiso del 9 y 13/10/2015','2015-10-14 07:30:00','2015-10-14 08:00:00',50123,91,2,'2015-10-14','07:30','08:00',NULL,'F'),
(46882,387,'De permiso del 9 y 13/10/2015','2015-10-14 17:00:00','2015-10-14 18:00:00',50123,91,2,'2015-10-14','17:00','18:00',NULL,'F'),
(46883,387,'De permiso del 9 y 13/10/15','2015-10-15 07:30:00','2015-10-15 08:00:00',50123,91,2,'2015-10-15','07:30','08:00',NULL,'F'),
(46884,387,'De permiso del 09 y 13/10/15','2015-10-15 17:00:00','2015-10-15 18:00:00',50123,91,2,'2015-10-15','17:00','18:00',NULL,'F'),
(46886,387,'De permiso de 9 y 13/10/2015','2015-10-16 07:30:00','2015-10-16 08:00:00',50123,91,2,'2015-10-16','07:30','08:00',NULL,'F'),
(46887,387,'De permiso del 9 y 13/10/15','2015-10-16 17:00:00','2015-10-16 18:00:00',50123,91,2,'2015-10-16','17:00','18:00',NULL,'F'),
(46888,381,'Diligencia personal','2015-10-09 14:00:00','2015-10-09 17:00:00',50128,91,2,'2015-10-09','14:00','17:00',NULL,'F'),
(46889,387,'De permiso del 9/10/15','2015-10-13 17:00:00','2015-10-13 18:00:00',50128,91,2,'2015-10-13','17:00','18:00',NULL,'F'),
(46890,387,'De permiso del 09/10/15','2015-10-14 17:00:00','2015-10-14 18:00:00',50128,91,2,'2015-10-14','17:00','18:00',NULL,'F'),
(46891,387,'De permiso del 09/10/2015','2015-10-15 17:00:00','2015-10-15 18:00:00',50128,91,2,'2015-10-15','17:00','18:00',NULL,'F'),
(46892,381,'Diligencia personal','2015-10-06 08:00:00','2015-10-06 09:00:00',50071,91,2,'2015-10-06','08:00','09:00',NULL,'F'),
(46894,387,'De permiso del 06/10','2015-10-07 17:00:00','2015-10-07 18:00:00',50071,91,2,'2015-10-07','17:00','18:00',NULL,'F'),
(46895,381,'Dilgiencia personal','2015-10-07 08:00:00','2015-10-07 08:30:00',50071,91,2,'2015-10-07','08:00','08:30',NULL,'F'),
(46897,381,'Diligencia personal','2015-10-08 08:00:00','2015-10-08 08:30:00',50071,91,2,'2015-10-08','08:00','08:30',NULL,'F'),
(46899,387,'De permiso del 07/10/15','2015-10-08 17:00:00','2015-10-08 17:30:00',50071,91,2,'2015-10-08','17:00','17:30',NULL,'F'),
(46901,387,'de permiso del 08/10/15','2015-10-09 17:00:00','2015-10-09 17:30:00',50071,91,2,'2015-10-09','17:00','17:30',NULL,'F');


---------------------------   max_number_users

ALTER TABLE `ilg_config`
ADD `max_number_users` int(20) NULL AFTER `max_number_employees`;


----------------------------  performance


ALTER TABLE `ilg_hour_report`
DROP INDEX `area_id`,
DROP INDEX `payroll_period_id`;


ALTER TABLE `ilg_hour_concept`
ADD INDEX `authorized` (`authorized`),
DROP INDEX `enterprise_id`,
DROP INDEX `payroll_period_id`;


ALTER TABLE `ilg_person`
ADD INDEX `identification` (`identification`);

ALTER TABLE `ilg_person`
DROP FOREIGN KEY `ilg_person_ibfk_3`;

ALTER TABLE `ilg_person`
DROP INDEX `doc_type_id`;

ALTER TABLE ilg_hour_concept REMOVE PARTITIONING;

select partition_name, subpartition_name as sub, partition_method as method,   partition_description ,table_rows 
from information_schema.partitions 
where table_name='ilg_hour_concept';
	

ALTER TABLE `ilg_hour_concept`
partition by range (to_days(start_time))
SUBPARTITION BY hash(enterprise_id) subpartitions 50 (
	PARTITION emptyhc VALUES LESS THAN (0),
	PARTITION oldhc VALUES LESS THAN (to_days('2015-03-01' )),
    PARTITION newhc VALUES LESS THAN MAXVALUE 
);	


DELETE FROM `ilg_hour_concept`
WHERE `start_time` = '0000-00-00 00:00:00';

-----------------------  timezone
DELIMITER $$

CREATE PROCEDURE mysql.store_time_zone ()  
   IF NOT (POSITION('rdsadmin@' IN CURRENT_USER()) = 1) THEN     
       SET SESSION time_zone = '-5:00';
   END IF 

$$
DELIMITER ;

GRANT EXECUTE ON PROCEDURE mysql.store_time_zone TO `master`@`%`;

----------------------- period

INSERT INTO `bi4cg_viewlevels`  VALUES
('70','period', 'Períodos','2', '[8,19,29,15,25,28,33]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('70', '15'),('70', '19'),('70', '8'),
('70', '29'),('70', '25'),('70', '28'),('70', '33');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 70, id FROM ilg_enterprise;



INSERT INTO `bi4cg_viewlevels`  VALUES
('71','view_all_notifications', 'Ver Todas Las Notificaciones','2', '[8,19,29,15,25,28,33]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('71', '15'),('71', '19'),('71', '8'),
('71', '29'),('71', '25'),('71', '28'),('71', '33');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 71, id FROM ilg_enterprise;


-----------------------  notificaciones 



INSERT INTO `ilg_period` (`id`, `name`, `description`, `period_type`, `specific_month_day`, `specific_week_day`, `status_id`, `initial_date`, `expiration_date`, `last_execution`, `execution_time`, `enterprise_id`, `branch_office_id`)
VALUES( '1', 'Inmediato', "El estado debe estar deactivado.", NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, '2', NULL );


UPDATE ilg_notification
SET rule_data = REPLACE(rule_data, ',', ';');




------------------------ telegram

DROP TABLE IF EXISTS `tgram_auth`;
CREATE TABLE `tgram_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) DEFAULT NULL,
  `number` varchar(30) NOT NULL,
  `code` varchar(4) DEFAULT NULL,
  `validated` smallint(4) NOT NULL DEFAULT '0',
  `product_id` int(11) DEFAULT NULL,
  `notifications` smallint(4) NOT NULL DEFAULT '0',
  `enterprise_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-------------------   mejora reportes

ALTER TABLE `ilg_attendance`
ADD INDEX `valid` (`valid`);


ALTER TABLE `ilg_attendance`
ADD INDEX `processed` (`processed`);


ALTER TABLE `ilg_hour_report`
ADD INDEX `processed` (`processed`);


ALTER TABLE `ilg_hour_period_concept`
ADD INDEX `processed` (`processed`);


ALTER TABLE `ilg_attendance`
DROP INDEX `payroll_period_id`;

ALTER TABLE `ilg_attendance` ADD INDEX `time` (`time`);

ALTER TABLE `ilg_hour_period_concept`
DROP INDEX `payroll_period_id`;

ALTER TABLE `ilg_device_person`
DROP FOREIGN KEY `ilg_device_person_ibfk_1`,
ADD FOREIGN KEY (`device_id`) REFERENCES `ilg_device` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `ilg_device_person`
DROP FOREIGN KEY `ilg_device_person_ibfk_2`,
ADD FOREIGN KEY (`person_id`) REFERENCES `ilg_person` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;






--------------------  problema turnos
select count(*) 
from ilg_person p
inner join ilg_schedule s on p.schedule_id = s.id
where s.pto_id = 1 and ( p.enterprise_id = 85 OR p.enterprise_id = 92 OR p.enterprise_id = 102 );

select count(*) 
from ilg_hour_report hr
inner join ilg_calendar_time ct on hr.calendar_id = ct.id
where ct.date_type_id = 3 and ( ct.enterprise_id = 85 OR ct.enterprise_id = 92 OR ct.enterprise_id = 102 );

 select * from ilg_schedule
 WHERE ( enterprise_id = 85 OR enterprise_id = 92 OR enterprise_id = 102 ) and
 pto_id = 1 ;

 select * FROM `ilg_calendar_time`
WHERE ( enterprise_id = 85 OR enterprise_id = 92 OR enterprise_id = 102 ) AND `date_type_id` = '3';


select hr.*
from ilg_hour_report hr
inner join ilg_calendar_time ct on hr.calendar_id = ct.id
where ct.date_type_id = 3 and ( ct.enterprise_id = 85 OR ct.enterprise_id = 92 OR ct.enterprise_id = 102 )

update
ilg_person p
inner join ilg_schedule s on p.schedule_id = s.id
set p.schedule_id = null
where s.pto_id = 1 and ( p.enterprise_id = 85 OR p.enterprise_id = 92 OR p.enterprise_id = 102 );


delete  from ilg_schedule
 WHERE ( enterprise_id = 85 OR enterprise_id = 92 OR enterprise_id = 102 ) and
 pto_id = 1 ;

DELETE FROM `ilg_calendar_time`
WHERE ( enterprise_id = 85 OR enterprise_id = 92 OR enterprise_id = 102 ) AND `date_type_id` = '3';


update
ilg_hour_report hr
inner join ilg_calendar_time ct on hr.calendar_id = ct.id
set hr.calendar_id = null
where ct.date_type_id = 3 and ( ct.enterprise_id = 85 OR ct.enterprise_id = 92 OR ct.enterprise_id = 102 );


INSERT INTO `ilg_schedule` (`name`, `description`, `code`, `apply_time_control`, `apply_extra_hours`, `apply_tolerance`, `pre_tolerance_in`, `post_tolerance_in`, `pre_tolerance_out`, `post_tolerance_out`, `apply_pto`, `pto_id`, `creation_date`, `enterprise_id`, `branch_office_id`, `period_id`, `period_hours_complete`, `period_concept_id`)
SELECT concat('Abierto_',e.name), 'Turno por defecto.  Por favor cambiar el nombre y la descripción', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', now(), e.id, NULL, NULL, '0.00', NULL
FROM `ilg_enterprise` e
where not exists ( select id from ilg_schedule where enterprise_id = e.id and pto_id = 1 and branch_office_id is null );


update
ilg_schedule s
inner join ilg_enterprise e on s.enterprise_id = e.id
inner join ilg_branch_office bo on s.branch_office_id = bo.id
set s.name = concat_ws('_', 'Abierto',e.name,bo.name)
where s.name = 'Abierto';

update
ilg_schedule s
inner join ilg_enterprise e on s.enterprise_id = e.id
set s.name = concat_ws('_', 'Abierto',e.name)
where s.name = 'Abierto' and  s.branch_office_id is null;



INSERT INTO `ilg_calendar_time` (`name`, `code`, `enterprise_id`, `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday`, `sunday`, `holiday`, `initial_date`, `end_date`, `applies_all_years`, `start_time`, `end_time`, `apply_boundaries`, `min_in_time`, `max_in_time`, `min_out_time`, `max_out_time`, `date_type_id`, `status_id`, `creation_date`, `change_status_date`, `branch_office_id`, `pay_extras_after`, `week_pos`, `each_week`, `mode`, `flex_duration`, `category_id`, `max_time_to_search`)
SELECT distinct concat('IntervaloAbierto_',e.name), NULL, e.id, 'T', 'T', 'T', 'T', 'T', 'T', 'T', 'T', NULL, NULL, NULL, '00:00', '23:59', NULL, NULL, NULL, NULL, NULL, '3', '1', now(), NULL, NULL, NULL, '0', '1', NULL, NULL, 
(
SELECT ctc.id FROM  ilg_calendar_time_category ctc
	WHERE  ctc.enterprise_id =  e.id
		AND  ctc.branch_office_id IS NULL 
		AND  ctc.by_default = 'T' limit 1
),
'0.00'
FROM `ilg_enterprise` e
where not exists ( select id from ilg_calendar_time where enterprise_id = e.id and date_type_id = 3 and branch_office_id is null );


select s.id as sci, ct.id as cti,  ct.enterprise_id as ei
from ilg_schedule s
inner join ilg_calendar_time ct on ct.enterprise_id = s.enterprise_id and ct.branch_office_id is null and s.branch_office_id is null
where s.pto_id = 1 and ct.date_type_id = 3
and not exists ( select schedule_id from ilg_schedule_calendar_time where schedule_id = s.id and calendar_time_id = ct.id );


INSERT INTO `ilg_schedule_calendar_time` 
select s.id as sci, ct.id as cti
from ilg_schedule s
inner join ilg_calendar_time ct on ct.enterprise_id = s.enterprise_id and ct.branch_office_id is null and s.branch_office_id is null
where s.pto_id = 1 and ct.date_type_id = 3
and not exists ( select schedule_id from ilg_schedule_calendar_time where schedule_id = s.id and calendar_time_id = ct.id );



update
ilg_person p
inner join ilg_schedule s on s.enterprise_id = p.enterprise_id and s.pto_id = 1 and s.branch_office_id is null 
set p.schedule_id = s.id
where p.schedule_id is null;

---------------  dashboard soporte

INSERT INTO `bi4cg_viewlevels`  VALUES
('72','dashboard_support', 'Tablero Ctrl Soporte','2', '[8,19,29,15,25,28,33]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('72', '15'),('72', '19'),('72', '8'),
('72', '29'),('72', '25'),('72', '28'),('72', '33');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 72, id FROM ilg_enterprise;


-----------------  48 suppla

SELECT hc.* FROM ilg_hour_concept hc
inner join ilg_hour_report hr on hc.hour_report_id = hr.id
WHERE   hr.start_time > '2015-03-01'  and hc.start_time > '2015-03-01' 
and hr.enterprise_id IN ( 85 ) AND hr.person_id = 14170
and hc.enterprise_id IN ( 85 ) AND hc.person_id = 14170	
and (					
 ( hr.end_time  				 	    
 BETWEEN  '2015-08-29 20:00:00'  				       
 AND  '2015-09-05 19:59:00' )  			)	
 order by hc.start_time asc
 
 
 SELECT hc.* 
 FROM ilg_hour_concept hc
left join ilg_hour_report hr on hc.hour_report_id = hr.id
WHERE  ( hr.start_time > '2015-03-01'  and hc.start_time > '2015-03-01' 
and hr.enterprise_id IN ( 85 ) 
AND hr.person_id = 14170
and hc.enterprise_id IN ( 85 ) 
AND hc.person_id = 14170	
and (					
 ( hr.end_time  				 	    
 BETWEEN  '2015-09-19 20:00:00'  				       
 AND  '2015-09-26 19:59:00' )  			) ) or ( hc.start_time > '2015-03-01' 
and hc.enterprise_id IN ( 85 ) 
AND hc.person_id = 14170	
AND hc.type = 1
and (					
 ( hc.start_time  				 	    
 BETWEEN  '2015-09-19 20:00:00'  				       
 AND  '2015-09-26 19:59:00' )  			) )
	
 order by hc.start_time asc
 
 SELECT hc
FROM HourConcept hc
LEFT JOIN FETCH hc.hourReport AS hr
WHERE (hr.startTime > '2015-03-01'
       AND hc.startTime > '2015-03-01'
       AND hr.enterprise_id IN (:enterprise_id)
       AND hr.person.id = :person_id
       AND hc.enterprise_id IN (:enterprise_id)
       AND hc.person.id = :person_id
       AND ((hr.endTime BETWEEN :startDate AND :endDate)))
  OR (hc.startTime > '2015-03-01'
      AND hc.enterprise_id IN (:enterprise_id)
      AND hc.person.id = :person_id
      AND hc.type = 1
      AND ((hc.startTime BETWEEN :startDate AND :endDate)))
ORDER BY hc.startTime DESC
 
 
---------------   telegram interpreter

DROP TABLE IF EXISTS `telegram_interpreter`;
CREATE TABLE `telegram_interpreter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(200) NOT NULL,
  `action` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `telegram_interpreter` (`id`, `message`, `action`, `type`, `priority`) VALUES
(31, 'MARCACION,MARCACIONES,MARCACIÓN ', 'marcaciones', 'report', 1),
(32, 'MARCACION,MARCACIONES,MARCACIÓN,TARDE', 'marcaciones_tarde', 'report', 1),
(33, 'MARCACION,MARCACIONES,MARCACIÓN,TEMPRANO', 'marcaciones_temprano', 'report', 1),
(34, 'MARCACION,MARCACIONES,MARCACIÓN,A TIEMPO', 'marcaciones_atiempo', 'report', 1),
(35, 'MES', 'mes', 'date', 1),
(36, 'MES,PASADO,ANTERIOR,ULTIMO,ÚLTIMO', 'mes_pasado', 'date', 1),
(37, 'SEMANA,PASADA,ANTERIOR,ULTIMA,ÚLTIMA', 'semana_pasada', 'date', 1),
(38, 'HOY', 'hoy', 'date', 1),
(39, 'AYER,DÍA,DIA,ANTERIOR,ULTIMO,ÚLTIMO', 'ayer', 'date', 1),
(40, 'SEMANA', 'semana', 'date', 1);




DROP TABLE IF EXISTS `tgram_auth`;
CREATE TABLE `tgram_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` bigint(20) DEFAULT NULL,
  `number` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `code` varchar(4) COLLATE utf8_spanish_ci DEFAULT NULL,
  `validated` smallint(4) NOT NULL DEFAULT '0',
  `product_id` int(11) DEFAULT NULL,
  `notifications` smallint(4) NOT NULL DEFAULT '0',
  `enterprise_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status_id` bigint(20) DEFAULT '1',
  `initial_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `tgram_auth_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ilg_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

INSERT INTO `tgram_auth` (`id`, `chat_id`, `number`, `code`, `validated`, `product_id`, `notifications`, `enterprise_id`, `user_id`, `status_id`, `initial_date`, `end_date`) VALUES
(1, NULL, '3045709465', NULL, 0, NULL, 0, NULL, 1393, 1, '2015-12-10', '2015-12-11');



DROP TABLE IF EXISTS `telegram_user_msg`;
CREATE TABLE `telegram_user_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `chat_id` varchar(20) NOT NULL,
  `message` varchar(200) NOT NULL,
  `status` varchar(50) NOT NULL,
  `action` varchar(150) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `repeat` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

---------------  importar de aurora
CREATE USER 'master'@'%';
grant all on *.* to 'master'@'%' identified by '1234' with grant
 option;


------------------  language

UPDATE bi4cg_menu
SET path = REPLACE(path, '-2', '-en'), alias = REPLACE(alias, '-2', '-en'), title = REPLACE(title, '(2)', '')
 WHERE `language` = 'en-GB' ;

 UPDATE bi4cg_menu
SET path = REPLACE(path, '-4', '-fr'), alias = REPLACE(alias, '-4', '-fr'), title = REPLACE(title, '(4)', '')
 WHERE `language` = 'fr-FR' ;
 
  UPDATE bi4cg_menu
SET path = REPLACE(path, '-5', '-mx'), alias = REPLACE(alias, '-5', '-mx'), title = REPLACE(title, '(5)', '')
 WHERE `language` = 'es-mx' ;
 
   UPDATE bi4cg_menu
SET path = REPLACE(path, '-3', '-es'), alias = REPLACE(alias, '-3', '-es'), title = REPLACE(title, '(3)', '')
 WHERE `language` = 'es-ES' ;
 

UPDATE bi4cg_menu
SET title="Payroll Report" where	alias ="payrollreports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Support" where	alias ="soporte" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Resources" where	alias ="publicresources-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Contact" where	alias ="contacto-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Compatibility" where	alias ="compatibility" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Resources" where	alias ="recursos-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Trial period" where	alias ="periodo-de-prueba" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Prices" where	alias ="precios" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="View Demo" where	alias ="ver-demo" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Steps Home" where	alias ="pasos-de-inicio" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="How to Start" where	alias ="como-empezar-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="BIOPRW F20920" where	alias ="bioprw-f20920" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="G 400" where	alias ="g-400" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Notebooks" where	alias ="portatiles" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="BIOPRW F 20870" where	alias ="bioprw-f-20870" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Facials" where	alias ="faciales" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="G150id" where	alias ="g150id" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="BIOPRW F 20320" where	alias ="bioprw-f-20320" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Biometric" where	alias ="biometricos" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Devices"  where	alias ="dispositivos-de-control-cloudtime-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Configurations" where	alias ="configuracion" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Rules" where	alias ="reglas" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Change Password" where	alias ="changepasswd" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Users" where	alias ="users" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Roles" where	alias ="roles" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Enterprises" where	alias ="enterprise" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Users" where	alias ="accesscontrol-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Employees" where	alias ="employeereport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Incomplete hours worked"  where	alias ="hrincompletehr" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Hours worked" where	alias ="hrreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Hours worked by State"  where	alias ="hrreportstatus" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Worked Intervals"  where	alias ="m-hourreports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Attendance Summary"  where	alias ="attendancesummaryreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Attendance Report"  where	alias ="attedancereport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Employee Reporting No Attendance"   where	alias ="empnotattdayreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="First Last Attendance"  where	alias ="attfirstlastreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Device Attendances" where	alias ="attedancereportdev" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Departure Report" where	alias ="departurereports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Report Arrivals"  where	alias ="arrivalreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Attendance" where	alias ="m-attendancereports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Management Report"  where	alias ="adminreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Administration" where	alias ="administrareports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll by Date"  where	alias ="payemplreportdate" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Hours Concept Report"  where	alias ="hourconceptreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="News Summary"  where	alias ="prnoticesummary" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="News report"  where	alias ="prnoticereport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Contract Work Hours and Device"   where	alias ="hrcontractdevicereport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll Agreement" where	alias ="payemplcontractreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Card Presence"  where	alias ="payemplreportleftdays" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll report" where	alias ="payemplreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll" where	alias ="m-payrollreports" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Absences summary"  where	alias ="absencesummary" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Report Absences"  where	alias ="absencereport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Audit Report"  where	alias ="audit" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Contracts Report"  where	alias ="contractreport" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Reports" where	alias ="reportes-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Subconcepts" where	alias ="subconceptitem" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Concepts" where	alias ="conceptos" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Automatic configuration Periods"   where	alias ="confperiodauto" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll periods" where	alias ="payrollperio" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll configuration"  where	alias ="payrollconfig" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Areas" where	alias ="area" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Branches" where	alias ="branchoffice" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Types of Contract" where	alias ="contracttype" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Cost center" where	alias ="costcenter" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Charges" where	alias ="position" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Tags" where	alias ="tags" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Employees" where	alias ="empleados" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Contract details"  where	alias ="contractdetail" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Human Resources" where	alias ="personadmin" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Holidays" where	alias ="holidays" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Intervals" where	alias ="intervalos" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Shifts" where	alias ="schedule" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Employee shifts" where	alias ="empleados-turnos" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Schedule Shifts"  where	alias ="turnosadmin" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Reprocessing" where	alias ="reprocess" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Tasks" where	alias ="tasks" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Notifications" where	alias ="notifications" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Payroll Notices" where	alias ="novedades" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Biometric Devices"  where	alias ="dispositivos" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Authorization Hours"  where	alias ="authorization" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Import Data" where	alias ="import" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Administration " where	alias ="administracion-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Journal of Absences"  where	alias ="dashboardabsence" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Journal Bearings" where	alias ="diario-marcaciones" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Areas Journal" where	alias ="diario-areas" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Monthly" where	alias ="mensual" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Control Panel" where	alias ="tablero-de-control-en" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Frequent questions" where	alias ="preguntas-frecuentes" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Guarantees" where	alias ="garantias" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Features" where	alias ="caracteristicas" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="What is Falcon Cloud" where	alias ="que-es-falcon-web" and `language` = 'en-GB';
UPDATE bi4cg_menu
SET title="Start " where	alias ="inicio-en" and `language` = 'en-GB';




UPDATE bi4cg_menu
SET title="Rapport de Pré - Paie" where	alias ="payrollreports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Support" where	alias ="soporte" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Ressources" where	alias ="publicresources-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Contact" where	alias ="contacto-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Compatibilité" where	alias ="compatibility" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Ressources" where	alias ="recursos-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Des Périodes d'essai" where	alias ="periodo-de-prueba" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Des Prix" where	alias ="precios" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Voir la Démo" where	alias ="ver-demo" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Commencez étapes" where	alias ="pasos-de-inicio" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Mise en route" where	alias ="como-empezar-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="F20920 BIOPRW" where	alias ="bioprw-f20920" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="G 400" where	alias ="g-fr00" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Portables portables" where	alias ="portatiles" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="BIOPRW F 20870" where	alias ="bioprw-f-20870" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Faciales" where	alias ="faciales" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="G150id" where	alias ="g150id" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="BIOPRW F 20320" where	alias ="bioprw-f-20320" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Biométriques" where	alias ="biometricos" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Dispositifs de contrôle" where	alias ="dispositivos-de-control-cloudtime-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Paramètres" where	alias ="configuracion" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Règles" where	alias ="reglas" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Changer le mot de passe" where	alias ="changepasswd" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Utilisateurs" where	alias ="users" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rôles" where	alias ="roles" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Entreprise" where	alias ="enterprise" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Utilisateurs" where	alias ="accesscontrol-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Personnel" where	alias ="employeereport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Heures travaillées incomplets" where	alias ="hrincompletehr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Heures travaillées" where	alias ="hrreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Heures travaillées par l'Etat" where	alias ="hrreportstatus" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Intervalles travaillées" where	alias ="m-hourreports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Résumé de numérotations" where	alias ="attendancesummaryreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport de numérotations" where	alias ="attedancereport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport des émployés sans numérotations" where	alias ="empnotattdayreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Prèmiere dernière numérotation" where	alias ="attfirstlastreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Numérotations du dispositif" where	alias ="attedancereportdev" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport Sorties" where	alias ="departurereports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport Arrivées" where	alias ="arrivalreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Numérotations" where	alias ="m-attendancereports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport d'administration" where	alias ="adminreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Administration" where	alias ="administrareports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Pré - Paie par date" where	alias ="payemplreportdate" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport de concept d'heures" where	alias ="hourconceptreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Résumé des motivations" where	alias ="prnoticesummary" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport des motivations" where	alias ="prnoticereport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Heures travaillées par contrat et Dispositif" where	alias ="hrcontractdevicereport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Pré-Paie Contrat" where	alias ="payemplcontractreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Carte de présence" where	alias ="payemplreportleftdays" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport Pré-Paie" where	alias ="payemplreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Pré - Paie" where	alias ="m-payrollreports" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Résumé d'absences" where	alias ="absencesummary" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport d'absences" where	alias ="absencereport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport d'audit" where	alias ="audit" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapport des Contrats" where	alias ="contractreport" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Rapports" where	alias ="reportes-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="SubConcepts" where	alias ="subconceptitem" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Concepts" where	alias ="conceptos" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Configuration de périodes automatiques" where	alias ="confperiodauto" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Périodes de paie" where	alias ="payrollperio" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Configuration de Pré - Paie" where	alias ="payrollconfig" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Zones" where	alias ="area" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Branches" where	alias ="branchoffice" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Type de contrat" where	alias ="contracttype" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Centre de coûts" where	alias ="costcenter" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Postes" where	alias ="position" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Étiquettes" where	alias ="tags" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Personnel" where	alias ="empleados" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Détails du contrat" where	alias ="contractdetail" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Ressources humaines" where	alias ="personadmin" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Fériés" where	alias ="holidays" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Intervalles" where	alias ="intervalos" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Turns" where	alias ="schedule" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Turns de l'émployé" where	alias ="empleados-turnos" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Programmation des turns" where	alias ="turnosadmin" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Retraitement" where	alias ="reprocess" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Tâches" where	alias ="tasks" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Notifications" where	alias ="notifications" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Motivations" where	alias ="novedades" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Unités biométriques" where	alias ="dispositivos" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Autorisation d'heures" where	alias ="authorization" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Importer des données" where	alias ="import" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Administration" where	alias ="administracion-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Journal des absences" where	alias ="dashboardabsence" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Journal des numèrotations" where	alias ="diario-marcaciones" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Journal zones" where	alias ="diario-areas" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Mensuel" where	alias ="mensual" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Tableau de bord" where	alias ="tablero-de-control-fr" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Questions fréquentes" where	alias ="preguntas-frecuentes" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Garanties" where	alias ="garantias" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Caractéristiques" where	alias ="caracteristicas" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Quel est Falcon Web" where	alias ="que-es-falcon-web" and `language` = 'fr-FR';
UPDATE bi4cg_menu
SET title="Initiation" where	alias ="inicio-fr" and `language` = 'fr-FR';



---------------------  problemas areas suppla
select count(*) from ilg_person p
where  p.branch_office_id IS NULL ;

select p.id, p.enterprise_id, ( select bo.id from ilg_branch_office bo where bo.enterprise_id = p.enterprise_id and bo.lft = 0 limit 1  ) as newbra from ilg_person p
where  p.branch_office_id IS NULL ;

update ilg_person p
set branch_office_id = ( select bo.id from ilg_branch_office bo where bo.enterprise_id = p.enterprise_id and bo.lft = 0 limit 1  )
where  p.branch_office_id IS NULL ;

--enterprise_id IN (85) AND 

select count(*) from ilg_person p
inner join ilg_area a on p.area_id = a.id
where  a.branch_office_id IS NULL ;

select p.id, p.area_id, p.branch_office_id, ( select id from ilg_area where branch_office_id = p.branch_office_id and area_category_id = 1 limit 1 ) as newa 
from ilg_person p
inner join ilg_area a on p.area_id = a.id
where  a.branch_office_id IS NULL 
limit 0, 10;

update ilg_person p
inner join ilg_area a on p.area_id = a.id
set p.area_id = ( select id from ilg_area where branch_office_id = p.branch_office_id and area_category_id = 1 limit 1 )
where  a.branch_office_id IS NULL ;


select count(*) from ilg_hour_report hr
inner join ilg_area a on hr.area_id = a.id
where  a.branch_office_id IS NULL ;

select hr.id, hr.area_id, (select area_id from ilg_person where hr.person_id = id limit 1 ) as neware 
from ilg_hour_report hr
inner join ilg_area a on hr.area_id = a.id
where  a.branch_office_id IS NULL 
limit 0, 10;

update ilg_hour_report hr
inner join ilg_area a on hr.area_id = a.id
set hr.area_id = (select area_id from ilg_person where hr.person_id = id limit 1 ) 
where  a.branch_office_id IS NULL ;


select count(*) from ilg_area a 
WHERE  (  branch_office_id IS NULL  )  and area_category_id=1 AND  status_id = 1 and rgt=1
and not exists( select id from ilg_hour_report where area_id = a.id );

delete a from ilg_area a WHERE   (  branch_office_id IS NULL  )  and area_category_id=1 AND  status_id = 1 and rgt=1
and not exists( select id from ilg_hour_report where area_id = a.id );

delete a from ilg_area a WHERE  (  branch_office_id IS NULL  )  and area_category_id=1 
and not exists( select id from ilg_hour_report where area_id = a.id );

select count(*) from ilg_area a 
WHERE  (  branch_office_id IS NULL  )
and not exists( select id from ilg_hour_report where area_id = a.id );

delete a from ilg_area a
WHERE  (  branch_office_id IS NULL  )
and not exists( select id from ilg_hour_report where area_id = a.id );



------------------   reporte cng

INSERT INTO `bi4cg_viewlevels`  VALUES
('73','cng_report', 'Reporte CNG','2', '[8,19,29,15,25,28,33]');

INSERT INTO `bi4cg_usergroup_vl` (`vl_id`, `id`) VALUES
('73', '15'),('73', '19'),('73', '8'),
('73', '29'),('73', '25'),('73', '28'),('73', '33');

INSERT INTO ilg_viewlevels_enterprise ( viewlevels_id, enterprise_id ) 
SELECT 73, id FROM ilg_enterprise;


---------------  turno en HourReport

ALTER TABLE `ilg_hour_report`
ADD `schedule_id` bigint NULL COMMENT 'Turno' AFTER `calendar_id`;


------------------  tareas reprocesamiento

INSERT INTO `ilg_task_category` (`id`, `name`, `description`)
VALUES ('2', 'PROCESS', 'Procesamiento');

----------------------    notes att

ALTER TABLE `ilg_attendance`
ADD `notes` text NULL;

----------------------    mexico

ALTER TABLE `ilg_hour_concept`
ADD `created_by` tinyint(4) NULL  DEFAULT 0 COMMENT '0=creado manualmente 1=creado por el proceso de clasificacion de horas  2=Creado por el procesamiento de marcaciones.' AFTER `range_type`,
ADD `concern_to` tinyint(4) NULL  DEFAULT 0 COMMENT '0= Afecta la Entrada 1= Afecta la salida  2=afecta todo el dia' AFTER `created_by`;


ALTER TABLE `ilg_concept`
ADD `concern_to` tinyint(4) NULL  DEFAULT 0 COMMENT '0= Afecta la Entrada 1= Afecta la salida  2=afecta todo el dia' AFTER `type`;

ALTER TABLE `ilg_branch_office`
ADD `max_prn_per_period` tinyint(4) NULL AFTER `code`;

UPDATE `ilg_hour_concept` SET
`created_by` = '1'
WHERE `type` = '0';

UPDATE ilg_hour_report SET start_attendance_id=(@temp:=start_attendance_id), start_attendance_id = end_attendance_id, end_attendance_id = @temp;


UPDATE ilg_attendance at
SET at.payroll_period_id = (
	SELECT prp.id
	FROM ilg_payroll_period prp 
	WHERE prp.initial_date <= DATE(at.time) AND prp.end_date >= DATE(at.time) 
		AND prp.enterprise_id = at.enterprise_id
		AND ( branch_office_id =  at.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC			
	LIMIT 1);
	
UPDATE ilg_hour_report hr
SET hr.payroll_period_id = (
	SELECT prp.id
	FROM ilg_payroll_period prp 
		where
		(
			(
			  DATE(hr.end_time) >= prp.initial_date 
			  AND DATE(hr.end_time) <= prp.end_date
			) 
			OR (
			  hr.end_time IS NULL 
			  AND DATE(hr.start_time) >= prp.initial_date 
			  AND DATE(hr.start_time) <= prp.end_date
			)
		)		
		AND prp.enterprise_id = hr.enterprise_id
		AND ( branch_office_id =  hr.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC			
	LIMIT 1);

UPDATE ilg_hour_concept hc
inner join ilg_hour_report hr on hc.hour_report_id = hr.id
SET hc.payroll_period_id = hr.payroll_period_id;
		
UPDATE ilg_hour_concept hc
SET hc.payroll_period_id = (
	SELECT prp.id
	FROM ilg_payroll_period prp 
		where 
		(
			(
			  DATE(hc.end_time) >= prp.initial_date 
			  AND DATE(hc.end_time) <= prp.end_date
			) 
			OR (
			  hc.end_time IS NULL 
			  AND DATE(hc.start_time) >= prp.initial_date 
			  AND DATE(hc.start_time) <= prp.end_date
			)
		)		
		AND prp.enterprise_id = hc.enterprise_id
		AND ( branch_office_id =  hc.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC			
	LIMIT 1)
WHERE hc.hour_report_id IS NULL	;	


DELIMITER $$
CREATE TRIGGER `att_before_insert` BEFORE INSERT ON `ilg_attendance` FOR EACH ROW
att_before_insert:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.payroll_period_id IS NULL then 
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) 
			AND enterprise_id =  NEW.enterprise_id
			AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
			ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;		
END
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `att_before_update` BEFORE UPDATE ON `ilg_attendance` FOR EACH ROW
att_before_update:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.time !=  OLD.time OR NEW.payroll_period_id IS NULL then 
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where prp.initial_date <= DATE(NEW.time) AND prp.end_date >= DATE(NEW.time) 
			AND enterprise_id =  NEW.enterprise_id
			AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
			ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;		
END
$$
DELIMITER ;



DELIMITER $$
CREATE TRIGGER `hr_before_insert` BEFORE INSERT ON `ilg_hour_report` FOR EACH ROW
hr_before_insert:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.payroll_period_id IS NULL then 
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where
		(
			(
			  DATE(NEW.end_time) >= prp.initial_date 
			  AND DATE(NEW.end_time) <= prp.end_date
			) 
			OR (
			  NEW.end_time IS NULL 
			  AND DATE(NEW.start_time) >= prp.initial_date 
			  AND DATE(NEW.start_time) <= prp.end_date
			)
		)
		AND enterprise_id = NEW.enterprise_id
		AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;	
END
$$
DELIMITER ;	

DELIMITER $$
CREATE TRIGGER `hr_before_update` BEFORE UPDATE ON `ilg_hour_report` FOR EACH ROW
hr_before_update:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.start_time != OLD.start_time OR NEW.end_time != OLD.end_time OR NEW.payroll_period_id IS NULL then 
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where
		(
			(
			  DATE(NEW.end_time) >= prp.initial_date 
			  AND DATE(NEW.end_time) <= prp.end_date
			) 
			OR (
			  NEW.end_time IS NULL 
			  AND DATE(NEW.start_time) >= prp.initial_date 
			  AND DATE(NEW.start_time) <= prp.end_date
			)
		)
		AND enterprise_id = NEW.enterprise_id
		AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;	
END
$$
DELIMITER ;	




DELIMITER $$
CREATE TRIGGER `hc_before_insert` BEFORE INSERT ON `ilg_hour_concept` FOR EACH ROW
hc_before_insert:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.payroll_period_id IS NULL and NEW.hour_report_id IS NOT NULL then 
		select hr.payroll_period_id into payrollPeriodId
		from ilg_hour_report hr
		where
		(
			hr.id = NEW.hour_report_id
		)
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;	
	if NEW.payroll_period_id IS NULL and NEW.hour_report_id IS NULL then 
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where
		(
			(
			  DATE(NEW.end_time) >= prp.initial_date 
			  AND DATE(NEW.end_time) <= prp.end_date
			) 
			OR (
			  NEW.end_time IS NULL 
			  AND DATE(NEW.start_time) >= prp.initial_date 
			  AND DATE(NEW.start_time) <= prp.end_date
			)
		)
		AND enterprise_id = NEW.enterprise_id
		AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;	
	end if;	
END
$$
DELIMITER ;	


DELIMITER $$
CREATE TRIGGER `hc_before_update` BEFORE UPDATE ON `ilg_hour_concept` FOR EACH ROW
hc_before_update:
BEGIN
	DECLARE payrollPeriodId bigint(20);
	if NEW.hour_report_id IS NOT NULL AND NEW.payroll_period_id IS NULL then 
		select hr.payroll_period_id into payrollPeriodId
		from ilg_hour_report hr
		where
		(
			hr.id = NEW.hour_report_id
		)
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;
	end if;	
	if NEW.hour_report_id IS NULL AND ( NEW.end_time !=  OLD.end_time OR  NEW.start_time !=  OLD.start_time ) then 	
		select prp.id into payrollPeriodId
		from ilg_payroll_period prp 
		where
		(
			(
			  DATE(NEW.end_time) >= prp.initial_date 
			  AND DATE(NEW.end_time) <= prp.end_date
			) 
			OR (
			  NEW.end_time IS NULL 
			  AND DATE(NEW.start_time) >= prp.initial_date 
			  AND DATE(NEW.start_time) <= prp.end_date
			)
		)
		AND enterprise_id = NEW.enterprise_id
		AND ( branch_office_id =  NEW.branch_office_id or branch_office_id is null )
		ORDER BY branch_office_id DESC		
		limit 1;
		SET NEW.payroll_period_id = payrollPeriodId;	
	end if;		
END
$$
DELIMITER ;	


