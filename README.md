# SQL-Murder-Mystery-Northwestern-University-knight-lab

### Category: 

- Crime

- Police

- Safety

- Security

### Overview:

"There's been a Murder in SQL City! The SQL Murder Mystery is designed to be both a self-directed lesson to learn SQL concepts and commands and a fun game for experienced SQL users to solve an intriguing crime."

### Experienced SQL sleuths start here:

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

### Exploring the Database Structure:

Experienced SQL users can often use database queries to infer the structure of a database. But each database system has different ways of managing this information. The SQL Murder Mystery is built using SQLite. Use this SQL command to find the tables in the Murder Mystery database.

### Target:

Finding out the extract murder and killing planner with the shortest-possible SQL queries.

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

## SQL Queries: (2 approaches)

### 1st approach: Naive approach

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

### 2nd approach: More efficient, advanced approach

Going back to the original SQL sleuths, I will find out the witnesses.
`
"A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database."
`

Here I will use WITH sub-queries to seperate witness 1 and 2 into the witness group. 

#### Witnesses

```
SELECT description FROM crime_scene_report
WHERE date = '20180115' AND type = 'murder' AND city = 'SQL City'
```

The result shows 2 witnesses: One is Annabel living on Franklin Ave, another one is someone living on Northwestern Dr.
```
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
```

#### 1st Witness 
`
I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
`

#### 2nd Witness 
`
I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
`

#### Suspect(s)
```
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
```

Here's the same result as the 1st approach:

| person_id | name | plate_number | gender |
|-|-|-|-|
| 67318 | Jeremy Bowers | 0H42W2 | male |

#### Murder Planner

I will see how the killer talked about in the script:
```
SELECT transcript FROM interview WHERE person_id = 67318
```

`I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.`

A HAVING clause is like a WHERE clause, but applies only to groups as a whole (that is, to the rows in the result set representing groups), whereas the WHERE clause applies to individual rows. A query can contain both a WHERE clause and a HAVING clause. In that case:

The WHERE clause is applied first to the individual rows in the tables or table-valued objects in the Diagram pane. Only the rows that meet the conditions in the WHERE clause are grouped.

The HAVING clause is then applied to the rows in the result set. Only the groups that meet the HAVING conditions appear in the query output. You can apply a HAVING clause only to columns that also appear in the GROUP BY clause or in an aggregate function.

So in this case, WHERE shuld be applied to filter the conditions of gender, hair color, car make, car model, height first. Secondly, other conditions will be fitered out such as event name & the specific date. Lastly, after all those filterations are conducted and grouped by person_id, I will use HAVING to eliminate all cases not having 3 times of checkin.

```
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
```

| name | annual_income | 
|-|-|
| Miranda Priestly | 310000 | 

```
INSERT INTO solution VALUES (1, "Miranda Priestly");

SELECT value FROM solution;
```

#### Final Result
`
Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
`
