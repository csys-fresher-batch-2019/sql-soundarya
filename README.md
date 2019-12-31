# Simple Social Media

http://socialmedia.in

## Features:
*  User should able to view all the pepole who are using the social media

### Feature 1:List of people using the social media
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
* Query
```sql
insert into user_list(user_id,user_name,email,age,gender,dob,created_date,status) values 
(1,'soundarya','sound@gmail.com',21,'female',to_date('28-12-1998','dd-MM-yyyy'),current_timestamp,'i_am_sound');

insert into user_list(user_id,user_name,email,age,gender,dob,created_date,status) values  
(2,'aishu','aishu@gmail.com',20,'female',to_date('31-12-1998','dd-MM-yyyy'),current_timestamp,'i_am_ice');

insert into user_list(user_id,user_name,email,age,gender,dob,created_date,status) values  
(3,'mala','mala@gmail.com',19,'female',to_date('27-03-1998','dd-MM-yyyy'),current_timestamp,'i_am_mala');

select * from user_list;
```
### table1

* user_list

| user_id | user_name | email           | age | gender | dob       | created_date                 | status     |
|---------|-----------|-----------------|-----|--------|-----------|------------------------------|------------|
| 1       | soundarya | sound@gmail.com | 21  | female | 28-DEC-98 | 30-DEC-19 11.24.17.955164 PM | i_am_sound |
| 2       | aishu     | aishu@gmail.com | 20  | female | 31-DEC-98 | 30-DEC-19 11.24.17.959820 PM | i_am_ice   |
| 3       | mala      | mala@gmail.com  | 19  | female | 27-MAR-98 | 30-DEC-19 11.24.17.963878 PM | i_am_mala  |

### Feature 2: List the User's friends request
```sql
create table friend_request( 
user1_id number not null, 
user2_id number not null, 
current_status varchar2(20) not null, 
action_performed_by number not null, 
constraint user1_id_fk foreign key (user1_id) references user_list(user_id),
constraint user2_id_fk foreign key (user2_id) references user_list(user_id),
constraint current_status_check check(current_status in('accepted','blocked')) 
);
```
* Query
```sql
insert into friend_request (user1_id,user2_id,current_status,action_performed_by) values (1,3,'accepted',3);

insert into friend_request (user1_id,user2_id,current_status,action_performed_by) values (1,2,'blocked',1);

insert into friend_request (user1_id,user2_id,current_status,action_performed_by) values (3,2,'accepted',3);

select * from friend_request where (user1_id = 1 or user2_id = 1) and current_status = 'accepted';
```
### Feature 3:Posts posted by the user
```sql
create table posts(
post_id number primary key,
user_id number not null,
post_type varchar2(20),
caption varchar2(100),
date_created timestamp not null,
date_updated timestamp,
constraint user_id_fk foreign key(user_id) references user_list(user_id),
constraint post_type_check check(post_type in('image','video'))
);
```
* Query
```sql
insert into posts (post_id,User_id,post_type,caption,date_created) values (201,1,'image','have a nice day',current_timestamp);


insert into posts (post_id,User_id,post_type,caption,date_created) values (202,2,'video','happy morning',current_timestamp);

select * from posts;
```
