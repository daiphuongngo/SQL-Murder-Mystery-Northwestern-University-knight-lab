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
