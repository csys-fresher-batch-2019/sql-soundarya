# Simple Social Media

http://socialmedia.in

## Features:
*  User should able to view all the pepole who are using the social media

### Feature 1:List of people using the social media
```sql
create table user_list (
user_id number not null,
user_name varchar2(40) not null,
email varchar2(40),
age number not null,
gender varchar2(10) not null,
dob date ,
city varchar2(30),
country varchar2(30) not null,
created_date timestamp not null, 
status varchar2(10),
constraint email_pk primary key (email),
constraint age_check check (age>=18)
);
create sequence user_id_seq increment by 1;
```
* Query
```sql
insert into user_list(user_id,user_name,email,age,gender,dob,city,country,created_date,status) values 
(user_id_seq.nextval,'soundarya','sound@gmail.com',21,'female',to_date('28-12-1998','dd-MM-yyyy'),'Madurai','India',current_timestamp,'i_am_sound');

insert into user_list(user_id,user_name,email,age,gender,dob,city,country,created_date,status) values  
(user_id_seq.nextval,'aishu','aishu@gmail.com',20,'female',to_date('31-12-1998','dd-MM-yyyy'),'Delhi','India',current_timestamp,'i_am_ice');

insert into user_list(user_id,user_name,email,age,gender,dob,city,country,created_date,status) values  
(user_id_seq.nextval,'mala','mala@gmail.com',19,'female',to_date('27-03-1998','dd-MM-yyyy'),'chennai','India',current_timestamp,'i_am_mala');

select * from user_list;

```
### table1

* user_list

| user_id | user_name | email           | age | gender | dob       |city     |country    | created_date                | status     |
|---------|-----------|-----------------|-----|--------|-----------|---------|-----------|-----------------------------|------------|
| 1       | soundarya | sound@gmail.com | 21  | female | 28-DEC-98 |Madurai  |India      |30-DEC-19 11.24.17.955164 PM | i_am_sound |
| 2       | aishu     | aishu@gmail.com | 20  | female | 31-DEC-98 |Delhi    |India      |30-DEC-19 11.24.17.959820 PM | i_am_ice   |
| 3       | mala      | mala@gmail.com  | 19  | female | 27-MAR-98 |chennai  |India      |30-DEC-19 11.24.17.963878 PM | i_am_mala  |

### Feature 2: List the User's friends request
```sql
create table friend_request( 
requestor varchar2(40) not null, 
acceptor varchar2(40) not null, 
current_status varchar2(20) not null,
constraint requestor_fk foreign key (requestor) references user_list(email),
constraint acceptor_fk foreign key (acceptor) references user_list(email),
constraint current_status_check check(current_status in('accepted','rejected')) 
);
```
* Query
```sql
insert into friend_request (requestor,acceptor,current_status) values ('sound@gmail.com','mala@gmail.com','accepted');

insert into friend_request (requestor,acceptor,current_status) values ('sound@gmail.com','mala@gmail.com','rejected');

insert into friend_request (requestor,acceptor,current_status) values ('mala@gmail.com','aishu@gmail.com','accepted');
```
### table 2

* friend_request

| requestor               | acceptor              | current_status | action_performed_by |
|-------------------------|-----------------------|----------------|---------------------|
| sound@gmail.com         | mala@gmail.com        | accepted       | 3                   |
| sound@gmail.com         | aishu@gmail.com       | blocked        | 1                   |

### Feature 3:Posts posted by the user
```sql
create table posts(
post_id number primary key,
email varchar(40),
post_type varchar2(20),
caption varchar2(100),
viewability varchar2(20),
date_created timestamp not null,
date_updated timestamp,
constraint email_fk foreign key(email) references user_list(email),
constraint post_type_check check(post_type in('image','video')),
constraint viewability_check check(viewability in('public','friends'))
);
create sequence post_id_seq increment by 1;
```
* Query
```sql
insert into posts (post_id,email,post_type,caption,viewability,date_created) values
(post_id_seq.nextval,'sound@gmail.com','image','have a nice day','public',current_timestamp);

insert into posts (post_id,email,post_type,caption,viewability,date_created) values (post_id_seq.nextval,'aishu@gmail.com','video','happy morning','friends',current_timestamp);

update posts set date_updated = current_timestamp,caption='hello' where email='sound@gmail.com';

select * from posts;
```
### Table 3
* posts

| post_id|email                | post_type | caption         |viewability | date_created                 | date_updated                |
|--------|---------------------|-----------|-----------------|------------|------------------------------|-----------------------------|
| 1      |sound@gmail.com      | image     | hello           |public      | 31-DEC-19 01.19.55.103225 AM | 31-DEC-19 03.44.10.320435 AM|
| 2      |aishu@gmail.com      | video     | happy morning   |friends     | 31-DEC-19 01.21.03.888304 AM |  -                          |


### Feature 4:posting reply comments to the posts

```sql
create table comments (
cmt_post_id number,
cmt_email varchar2(40),
cmts varchar2(100),
constraint cmt_post_id_fk foreign key (cmt_post_id) references posts (post_id),
constraint cmt_email_fk foreign key (cmt_email) references user_list(email)
);
```
* Query
```sql
insert into comments (cmt_post_id,cmt_email,cmts) values (1,'aishu@gmail.com','hai');

insert into comments (cmt_post_id,cmt_email,cmts) values (2,'sound@gmail.com','good morning');

select * from comments;
```
### Table 4
* comments

| cmt_post_id | cmt_email       | cmts         |
|-------------|-----------------|--------------|
| 1           | aishu@gmail.com | hai          |
| 2           | sound@gmail.com | good morning |
