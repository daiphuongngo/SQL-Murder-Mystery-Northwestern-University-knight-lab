# SQL-Murder-Mystery-Northwestern-University-knight-lab

### Overview:

"There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime."

### Experienced SQL sleuths start here:

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

### Exploring the Database Structure:

Experienced SQL users can often use database queries to infer the structure of a database. But each database system has different ways of managing this information. The SQL Murder Mystery is built using SQLite. Use this SQL command to find the tables in the Murder Mystery database.

### Language: SQL

### Tables:

- crime_scene_report: 

| date | type	| description	| city |
|-|-|-|-|

- person: 

| id | name	| license_id	| address_number	| address_street_name	| ssn |
|-|-|-|-|-|-|

- drivers_license: 

| id	| age	| height | eye_color | hair_color | gender | plate_number | car_make | car_model |
|-|-|-|-|-|-|-|-|-|

- facebook_event_checkin: 

| person_id	| event_id | event_name |	date |
|-|-|-|-|

- interview: 

| person_id | transcript |
|-|-|

- get_fit_now_member: 

| id | person_id | name	| membership_start_date	| membership_status | 
|-|-|-|-|-|

- get_fit_now_check_in: 

| membership_id	| check_in_date |	check_in_time |	check_out_time | 
|-|-|-|-|

- income:

| ssn	| annual_income | 
|-|-|

- solution: (no data)

| user | value |
|-|-|

### Schema Diagram:

![SQL Murder Mystery](https://user-images.githubusercontent.com/70437668/138572561-4c78a23b-7ab6-470e-ba2f-75b1dcca59f5.jpeg)

### SQL Queries:

#### Level 1: Exploring the datasets

##### Run this query to find the names of the tables in this database

![Run this query to find the names of the tables in this database](https://user-images.githubusercontent.com/70437668/138573000-1f1a03c8-4e78-40a4-b310-0dfd0cc025b3.jpg)

##### Run this query to find the structure of the `crime_scene_report` table

![Run this query to find the structure of the `crime_scene_report` table](https://user-images.githubusercontent.com/70437668/138573029-a984ea06-ce40-4262-941a-d2855ed84331.jpg)

```
--crime_scene_report
SELECT *
FROM crime_scene_report
```

![crime_scene_report   ](https://user-images.githubusercontent.com/70437668/138573058-e1ca05b5-5323-4bb2-b06a-94e05f5589ee.jpg)

```
--person
SELECT *
FROM person
```

![person](https://user-images.githubusercontent.com/70437668/138573104-3f30298b-52ae-465e-aa4b-e38f134e92b0.jpg)

```
--drivers_license
SELECT *
FROM drivers_license
```

![drivers_license ](https://user-images.githubusercontent.com/70437668/138573145-a6584934-3292-43bb-9012-7afcf39b0a18.jpg)

```
--facebook_event_checkin
SELECT *
FROM facebook_event_checkin
```

![facebook_event_checkin](https://user-images.githubusercontent.com/70437668/138573181-1674ddb1-8e68-4ae2-8c2c-c0b15ec38dfe.jpg)

```
--interview
SELECT *
FROM interview
```

![interview](https://user-images.githubusercontent.com/70437668/138573198-f852aa77-95dd-4d39-90ea-9dbc7d92921e.jpg)

```
--get_fit_now_member
SELECT *
FROM get_fit_now_member
```

![get_fit_now_member](https://user-images.githubusercontent.com/70437668/138573253-64cc4949-80a6-47fc-8a47-b09439d4ead7.jpg)

```
--get_fit_now_check_in
SELECT *
FROM get_fit_now_check_in
```

![get_fit_now_check_in](https://user-images.githubusercontent.com/70437668/138573275-c1837c29-04d7-428b-a9a6-d7de35a3fc6c.jpg)

```
--income
SELECT *
FROM income
```

![income](https://user-images.githubusercontent.com/70437668/138573299-a4cf4d68-a5b0-4dbc-bf84-427c6a96064f.jpg)

```
--solution (no data)
```
##### Level 2: Deeper Exploratory Data Analysis

Select all important fields and Join all necessary tables based on the Schema Diagram

![Select all important fields and Join all necessary tables based on the Schema Diagram](https://user-images.githubusercontent.com/70437668/138573395-e2a93b51-2086-49ab-bcaa-fb019903a90b.jpg)

Let's see all crime types:

![Let's see all crime types](https://user-images.githubusercontent.com/70437668/138573446-66e67950-c78a-4274-831f-a9afd93b851c.jpg)

As the question is to find the murderer, I can look for this person according to the 'murder' type on Jan 15th, 2018.

![20180115](https://user-images.githubusercontent.com/70437668/138573581-0abb793c-7d22-4313-8b14-fbd9a050d803.jpg)

##### Level 3: Identify the murderer

Now I will add some key verbs of a murder in the description such as "kill", "stab", "shot" and group the results by person's name:

```
SELECT person.id, person.name, person.address_number, person.address_street_name, 
person.ssn, facebook_event_checkin.date, crime_scene_report.type, crime_scene_report.description, 
crime_scene_report.city, interview.transcript, drivers_license.age, drivers_license.height, 
drivers_license.eye_color, drivers_license.hair_color, drivers_license.gender, 
drivers_license.plate_number, drivers_license.car_make, drivers_license.car_model 
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
```
![Final queries p1](https://user-images.githubusercontent.com/70437668/138573656-83fea926-6eb7-4959-92cd-f6752ae3ed7b.jpg)

![Final queries p2](https://user-images.githubusercontent.com/70437668/138573658-a68b5933-40df-4efb-adc2-f402394f9a7f.jpg)

It can be seen easily that there are only 2 suspects left. Then I will read their description and transcript to understand what they had said. After reading them, I can identify the murderer as Jeremy Bowers due to:

- The decscriptions of both Jeremy Bowers and Annabel Miller: "Mama, I killed a man, put a gun against his head..."
- Annabel Miller's transcript can be distinguished as an observer, not a murderer: "I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th."
- Jeremy Bowers's transcript can be determined as the exact killer: "I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017."

| id | name | gender | car_make | car_model | hair_color | height | ssn | 
|-|-|-|-|-|-|-|-|
| 67318 | Jeremy Bowers | male | Chevrolet | Spark LS | brown | 70 | 871539279 |

##### Check the result:

![Final queries p3](https://user-images.githubusercontent.com/70437668/138573772-68e193d5-e676-4d8d-ad90-e913118a2760.jpg)

##### Level 4: Find the killing planner

After applying the details from Jeremy Bowers's transcript to the WHERE conditions, there was no results appearing on the screen. The reason for this could be INNER JOIN that caused an amount of data lost. So, I will use LEFT JOIN instead with 'person' table as the parent table.

```
SELECT person.id, person.name, income.annual_income, facebook_event_checkin.event_name, 
person.address_number, person.address_street_name, person.ssn, facebook_event_checkin.date, 
crime_scene_report.type, crime_scene_report.description, crime_scene_report.city, 
interview.transcript, drivers_license.age, drivers_license.height, drivers_license.eye_color, 
drivers_license.hair_color, drivers_license.gender, drivers_license.plate_number, 
drivers_license.car_make, drivers_license.car_model 
FROM person
LEFT JOIN facebook_event_checkin
ON facebook_event_checkin.person_id = person.id
LEFT JOIN crime_scene_report
ON facebook_event_checkin.date = crime_scene_report.date
LEFT JOIN get_fit_now_member
ON get_fit_now_member.person_id = person.id
LEFT JOIN get_fit_now_check_in
ON get_fit_now_check_in.membership_id = get_fit_now_member.id
LEFT JOIN interview
ON interview.person_id = person.id
LEFT JOIN drivers_license
ON drivers_license.id = person.license_id
LEFT JOIN income
ON person.ssn = income.ssn
WHERE drivers_license.gender LIKE "Female"
	AND drivers_license.car_make LIKE "Tesla"
	AND drivers_license.car_model LIKE "Model S"
	AND drivers_license.hair_color LIKE "red"
	AND (drivers_license.height >= 60 AND drivers_license.height <= 70)
	AND facebook_event_checkin.event_name = "SQL Symphony Concert" 
	AND facebook_event_checkin.date LIKE "201712%"
```
![Lv 4 p1](https://user-images.githubusercontent.com/70437668/138577494-7d82ff70-45bc-46ce-91f8-f490b83522eb.jpg)

![Lv 4 p2](https://user-images.githubusercontent.com/70437668/138577495-3683f182-4dcf-460e-badb-c77b8a0bca02.jpg)

Then, I can determine that the real villain behind this murder is "Miranda Priestly".

| id | name | gender | car_make | car_model | hair_color | height | ssn | event_name |  
|-|-|-|-|-|-|-|-|-|  
| 99716 | Miranda Priestly | Female | Tesla | Model S | red | 66 | 987756388 | SQL Symphony Concert | 
