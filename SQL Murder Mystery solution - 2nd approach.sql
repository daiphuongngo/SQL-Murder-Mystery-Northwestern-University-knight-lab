/*Overview:
"There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to 
solve an intriguing crime."

Experienced SQL sleuths start here:
A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that 
occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

Exploring the Database Structure:
Experienced SQL users can often use database queries to infer the structure of a database. But each database system has different ways of managing this information. 
The SQL Murder Mystery is built using SQLite. Use this SQL command to find the tables in the Murder Mystery database. */

/* Tables:
- crime_scene_report: | date | type	| description	| city |
- person: | id | name	| license_id	| address_number	| address_street_name	| ssn |
- drivers_license: | id	| age	| height | eye_color | hair_color | gender | plate_number | car_make | car_model |
- facebook_event_checkin: | person_id	| event_id | event_name |	date |
- interview: | person_id | transcript |
- get_fit_now_member: | id | person_id | name	| membership_start_date	| membership_status | 
- get_fit_now_check_in: | membership_id	| check_in_date |	check_in_time |	check_out_time | 
- income: | ssn	| annual_income | 
- solution: | user | value |

2nd approach: More efficient, advanced approach
Going back to the original SQL sleuths, I will find out the witnesses. 
"A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. 
You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. 
Start by retrieving the corresponding crime scene report from the police department’s database." */

-- Witnesses
SELECT description FROM crime_scene_report
WHERE date = '20180115' AND type = 'murder' AND city = 'SQL City'

--The result shows 2 witnesses: One is Annabel living on Franklin Ave, another one is someone living on Northwestern Dr.

WITH 
1st_witness AS (
    SELECT id FROM person
    WHERE INSTR(name, 'Annabel') > 0 AND address_street_name = 'Franklin Ave'
), 
2nd_witness AS (
    SELECT id FROM person
    WHERE address_street_name = 'Northwestern Dr'
    ORDER BY address_number DESC LIMIT 1
), 
witnesses AS (
    SELECT *, 1 AS witness FROM 1st_witness
    UNION
    SELECT *, 2 AS witness FROM 2nd_witness
)
SELECT witness, transcript FROM witnesses
LEFT JOIN interview ON witnesses.id = interview.person_id

/* 
--1st Witness
I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- 2nd Witness
I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. 
The man got into a car with a plate that included "H42W". */

-- Suspect(s)
WITH gym_checkins AS (
    SELECT person_id, name
    FROM get_fit_now_member
    LEFT JOIN get_fit_now_check_in ON get_fit_now_member.id = get_fit_now_check_in.membership_id
    WHERE membership_status = 'gold' -- Only gold members have those bags
      AND id REGEXP '^48Z' -- membership number on the bag started with "48Z"
      AND check_in_date = '20180109' -- Witness 2 recognized him on January the 9th
), suspects AS (
    SELECT gym_checkins.person_id, gym_checkins.name, plate_number, gender
    FROM gym_checkins
    LEFT JOIN person ON gym_checkins.person_id = person.id
    LEFT JOIN drivers_license ON person.license_id = drivers_license.id
)
SELECT * FROM suspects
-- The man got into a car with a plate that included "H42W"
WHERE INSTR(plate_number, 'H42W') > 0 AND gender = 'male'

--Here's the same result as the 1st approach:
/*
|person_id | name | plate_number | gender |
|67318 | Jeremy Bowers | 0H42W2 | male |
*/

-- Murder Planner
-- I will see how the killer talked about in the script:
SELECT transcript FROM interview WHERE person_id = 67318

/* I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017. */

WITH 
red_haired_tesla_drivers AS (
    SELECT id AS license_id
    FROM drivers_license
    WHERE gender = 'female' AND hair_color = 'red' -- She has red hair
      AND car_make = 'Tesla' AND car_model = 'Model S' -- and she drives a Tesla Model S
      AND height >= 64 AND height <= 68 -- she's around 5'5" (65") or 5'7" (67")
), 
rich_suspects AS (
    SELECT person.id AS person_id, name, annual_income
    FROM red_haired_tesla_drivers AS rhtd
    LEFT JOIN person ON rhtd.license_id = person.license_id
    LEFT JOIN income ON person.ssn = income.ssn
), 
symphony_attenders AS (
    SELECT person_id, COUNT(1) AS n_checkins
    FROM facebook_event_checkin
    WHERE event_name = 'SQL Symphony Concert' -- she attended the SQL Symphony Concert
      AND `date` REGEXP '^201712' -- in December 2017
    GROUP BY person_id
    HAVING n_checkins = 3 -- 3 times
)
SELECT name, annual_income
FROM rich_suspects
INNER JOIN symphony_attenders ON rich_suspects.person_id = symphony_attenders.person_id

/*
| name	| annual_income |
| Miranda Priestly | 310000 |
*/

INSERT INTO solution VALUES (1, "Miranda Priestly");

SELECT value FROM solution;

/*
-- Final Result
Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!*/