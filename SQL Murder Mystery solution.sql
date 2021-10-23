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

# Level 1: Exploring the datasets */
--crime_scene_report
SELECT *
FROM crime_scene_report

--person
SELECT *
FROM person

--drivers_license
SELECT *
FROM drivers_license

--facebook_event_checkin
SELECT *
FROM facebook_event_checkin

--interview
SELECT *
FROM interview

--get_fit_now_member
SELECT *
FROM get_fit_now_member

--get_fit_now_check_in
SELECT *
FROM get_fit_now_check_in

--income
SELECT *
FROM income

--solution (no data)

/* Level 2: Deeper Exploratory Data Analysis
Select all important fields and Join all necessary tables based on the Schema Diagram */
SELECT person.id, person.name, person.address_number, person.address_street_name, person.ssn, facebook_event_checkin.date, crime_scene_report.type, crime_scene_report.description, crime_scene_report.city, interview.transcript, drivers_license.age, drivers_license.height, drivers_license.eye_color, drivers_license.hair_color, drivers_license.gender, drivers_license.plate_number, drivers_license.car_make, drivers_license.car_model 
FROM person
INNER JOIN facebook_event_checkin
ON facebook_event_checkin.person_id = person.id
INNER JOIN crime_scene_report
ON facebook_event_checkin.date = crime_scene_report.date
INNER JOIN get_fit_now_member
ON get_fit_now_member.person_id = person.id
INNER JOIN get_fit_now_check_in
ON get_fit_now_check_in.membership_id = get_fit_now_member.id
INNER JOIN interview
ON interview.person_id = person.id
INNER JOIN drivers_license
ON drivers_license.id = person.license_id
GROUP BY person.name

/* Let's see all crime types: */
SELECT crime_scene_report.type
FROM crime_scene_report
GROUP BY crime_scene_report.type

/* As the question is to find the murderer, I can look for this person according to the 'murder' type on Jan 15th, 2018. */
SELECT person.id, person.name, person.address_number, person.address_street_name, person.ssn, facebook_event_checkin.date, crime_scene_report.type, crime_scene_report.description, crime_scene_report.city, interview.transcript, drivers_license.age, drivers_license.height, drivers_license.eye_color, drivers_license.hair_color, drivers_license.gender, drivers_license.plate_number, drivers_license.car_make, drivers_license.car_model 
FROM person
INNER JOIN facebook_event_checkin
ON facebook_event_checkin.person_id = person.id
INNER JOIN crime_scene_report
ON facebook_event_checkin.date = crime_scene_report.date
INNER JOIN get_fit_now_member
ON get_fit_now_member.person_id = person.id
INNER JOIN get_fit_now_check_in
ON get_fit_now_check_in.membership_id = get_fit_now_member.id
INNER JOIN interview
ON interview.person_id = person.id
INNER JOIN drivers_license
ON drivers_license.id = person.license_id
WHERE type = "murder" 
	AND crime_scene_report.date = 20180115

/* Level 3: Final queries
Now I will add some key verbs of a murder in the description such as "kill", "stab", "shot" and group the results by person's name: */
SELECT person.id, person.name, person.address_number, person.address_street_name, person.ssn, facebook_event_checkin.date, crime_scene_report.type, crime_scene_report.description, crime_scene_report.city, interview.transcript, drivers_license.age, drivers_license.height, drivers_license.eye_color, drivers_license.hair_color, drivers_license.gender, drivers_license.plate_number, drivers_license.car_make, drivers_license.car_model 
FROM person
INNER JOIN facebook_event_checkin
ON facebook_event_checkin.person_id = person.id
INNER JOIN crime_scene_report
ON facebook_event_checkin.date = crime_scene_report.date
INNER JOIN get_fit_now_member
ON get_fit_now_member.person_id = person.id
INNER JOIN get_fit_now_check_in
ON get_fit_now_check_in.membership_id = get_fit_now_member.id
INNER JOIN interview
ON interview.person_id = person.id
INNER JOIN drivers_license
ON drivers_license.id = person.license_id
WHERE type = "murder" 
	AND crime_scene_report.date = 20180115
	AND crime_scene_report.description LIKE '%kill%'
   OR crime_scene_report.description LIKE '%shot%'
   OR crime_scene_report.description LIKE '%stab%'
GROUP BY person.name

/* It can be seen easily that there are only 2 suspects left. Then I will read their description and transcript to understand what they had said. After reading them, 
I can identify the murderer as Jeremy Bowers due to:

- The decscriptions of both Jeremy Bowers and Annabel Miller: "Mama, I killed a man, put a gun against his head..."
- Annabel Miller's transcript can be distinguished as an observer, not a murderer: "I saw the murder happen, and I recognized the killer from my gym when I was working out 
last week on January the 9th."
- Jeremy Bowers's transcript can be determined as the exact killer: "I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017." */

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        SELECT value FROM solution;