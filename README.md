#  Social Media Application

http://socialmedia.in

## Features:

### List of people using the social media
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
status varchar2(40),
user_password varchar2(20) not null,
constraint email_pk primary key (email),
constraint age_check check (age>=18)
);
create sequence us_id_s increment by 1;

alter table user_list add (
active_status varchar(20) default 'active',
constraint active_status_cq check (active_status in('active','inactive')) );

alter table user_list add (profile_pic varchar2(30));
```

* Query
```sql

select * from user_list;


```
### user_list

| user_id   | user_name       | email | age    | gender   | dob     | city  | country                        | created_date    | status  | user_password | active_status | profile_pic |
|-----------|-----------------|-------|--------|----------|---------|-------|--------------------------------|-----------------|---------|---------------|---------------|-------------|
| soundarya | sound@gmail.com | 21    | female | 28-12-98 | madurai | India | 29-01-20 10:26:00.243000000 AM | i_am_sound      | sound   | active        | simage.jpg    | (null)      |
| ajiee     | ajiee@gmail.com | 21    | male   | 07-07-98 | madurai | india | 29-01-20 11:56:36.257000000 AM | Thalapathy Mass | aji07   | active        | 7.jpg         | (null)      |
| aishu     | aishu@gmail.com | 21    | female | 31-12-98 | delhi   | India | 29-01-20 12:06:44.132000000 PM | i_am_ice        | pass123 | active        | (null)        | (null)      | 


### Feature 2: List the User's friends request
```sql
create table friend_request( 
requestor varchar2(40) not null, 
acceptor varchar2(40) not null, 
current_status varchar2(20) default 'pending' not null,
constraint requestor_fk foreign key (requestor) references user_list(email),
constraint acceptor_fk foreign key (acceptor) references user_list(email),
constraint current_status_check check(current_status in('pending','accepted','rejected')) 
);
```
* Query
```sql
select * from friend_request;
```
### friend_request



| requestor               | acceptor              | current_status |
|-------------------------|-----------------------|----------------|
| sound@gmail.com         | ajiee@gmail.com       | accepted       |
| sound@gmail.com         | mala@gmail.com        | accepted       | 

### Feature 3:Posts posted by the user
```sql
create table posts(
post_id number primary key,
email varchar(40),
post_type varchar2(20),
caption varchar2(100),
viewability varchar2(20),
date_posted timestamp not null,
constraint email_fk foreign key(email) references user_list(email),
constraint viewability_check check(viewability in('public','friends'))
);
create sequence pos_id_se increment by 1;
```
* Query
```sql
select * from posts;
```
### posts


| post_id | email           | post_type | caption         | viewability | date_posted                    |
|---------|-----------------|-----------|-----------------|-------------|--------------------------------|
| 1       | sound@gmail.com | rose.jpg  | have a nice day | public      | 02-01-20 03:22:20.221000000 PM |
| 2       | aishu@gmail.com | movie.mp4 | happy morning   | friends     | 02-01-20 03:22:20.229000000 PM |


### Feature 4:posting reply comments to the posts

```sql
create table comments (
cmt_post_id number,
cmt_email varchar2(40),
cmts varchar2(100),
cmt_date timestamp not null,
constraint cmt_post_id_fk foreign key (cmt_post_id) references posts (post_id),
constraint cmt_email_fk foreign key (cmt_email) references user_list(email)
);
```
* Query
```sql

select * from comments;
```
### comments


| cmt_post_id | cmt_email       | cmts         | cmt_date                       |
|-------------|-----------------|--------------|--------------------------------|
| 1           | aishu@gmail.com | hai          | 10-02-20 10:59:11.632000000 AM |
| 2           | sound@gmail.com | good morning | 10-02-20 10:59:11.681000000 AM |


### Feature 5:Adding likes to the posts

```sql
create table likes (
like_post_id number not null,
like_email varchar2(40) not null,
like_date timestamp not null,
constraint like_post_id_fk foreign key (like_post_id) references posts (post_id),
constraint like_email_fk foreign key (like_email) references user_list(email)
);
```
* Query
```sql

select * from likes;
```
### likes


| like_post_id | like_email      | like_date                      |
|--------------|-----------------|--------------------------------|
| 7            | sound@gmail.com | 18-02-20 05:45:21.288000000 PM |
| 13           | sound@gmail.com | 20-02-20 12:39:11.116000000 PM |

