#Simple Social Media

http://socialmedia.in

##Features:
* User should able to view all the pepole who are using the social media

###Feature 1:List of people using the social media
```sql
create table user_list (
user_id number not null,
user_name varchar2(40) not null,
email varchar2(40) not null,
age number not null,
gender varchar2(10) not null,
dob date ,
created_date timestamp not null, 
status varchar2(10),
constraint user_id_pk primary key (user_id),
constraint age_check check (age>=18)
);
```
*Query
```sql
insert into user_list(user_id,user_name,email,age,gender,dob,created_date,status) values 
(1,'soundarya','sound@gmail.com',21,'female',to_date('28-12-1998','dd-MM-yyyy'),current_timestamp,'i_am_sound');

select * from user_list;
```
