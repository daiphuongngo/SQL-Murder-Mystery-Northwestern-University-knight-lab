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

--crime_scene_report
SELECT *
FROM crime_scene_report

![crime_scene_report   ](https://user-images.githubusercontent.com/70437668/138573058-e1ca05b5-5323-4bb2-b06a-94e05f5589ee.jpg)

--person
SELECT *
FROM person

![person](https://user-images.githubusercontent.com/70437668/138573104-3f30298b-52ae-465e-aa4b-e38f134e92b0.jpg)

--drivers_license
SELECT *
FROM drivers_license

![drivers_license ](https://user-images.githubusercontent.com/70437668/138573145-a6584934-3292-43bb-9012-7afcf39b0a18.jpg)

--facebook_event_checkin
SELECT *
FROM facebook_event_checkin

![facebook_event_checkin](https://user-images.githubusercontent.com/70437668/138573181-1674ddb1-8e68-4ae2-8c2c-c0b15ec38dfe.jpg)

--interview
SELECT *
FROM interview

![interview](https://user-images.githubusercontent.com/70437668/138573198-f852aa77-95dd-4d39-90ea-9dbc7d92921e.jpg)

--get_fit_now_member
SELECT *
FROM get_fit_now_member

![get_fit_now_member](https://user-images.githubusercontent.com/70437668/138573253-64cc4949-80a6-47fc-8a47-b09439d4ead7.jpg)

--get_fit_now_check_in
SELECT *
FROM get_fit_now_check_in

![get_fit_now_check_in](https://user-images.githubusercontent.com/70437668/138573275-c1837c29-04d7-428b-a9a6-d7de35a3fc6c.jpg)

--income
SELECT *
FROM income

![income](https://user-images.githubusercontent.com/70437668/138573299-a4cf4d68-a5b0-4dbc-bf84-427c6a96064f.jpg)

--solution (no data)

