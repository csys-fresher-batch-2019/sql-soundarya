# Simple Social Media

http://socialmedia.in

## Features:
*  Table 1

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

| requestor               | acceptor              | current_status |
|-------------------------|-----------------------|----------------|
| sound@gmail.com         | mala@gmail.com        | accepted       |
| sound@gmail.com         | aishu@gmail.com       | rejected       | 

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
constraint post_type_check check(post_type in('image','video')),
constraint viewability_check check(viewability in('public','friends'))
constraint post_id_email_uq unique(post_id,email)
);
create sequence post_id_se increment by 1;
```
* Query
```sql
insert into posts (post_id,email,post_type,caption,viewability,date_posted) values (post_id_se.nextval,'sound@gmail.com','image','have a nice day','public',current_timestamp);

insert into posts (post_id,email,post_type,caption,viewability,date_posted) values (post_id_se.nextval,'aishu@gmail.com','video','happy morning','friends',current_timestamp);

select * from posts;
```
### Table 3
* posts

| post_id | email           | post_type | caption         | viewability | date_posted                    |
|---------|-----------------|-----------|-----------------|-------------|--------------------------------|
| 1       | sound@gmail.com | image     | have a nice day | public      | 02-01-20 03:22:20.221000000 PM |
| 2       | aishu@gmail.com | video     | happy morning   | friends     | 02-01-20 03:22:20.229000000 PM |


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


### Use cases
* add new post to the same user
```sql
insert into posts (post_id,email,post_type,caption,viewability,date_posted) values (post_id_se.nextval,'aishu@gmail.com','image','happy new year','public',current_timestamp);
```
| post_id | email           | post_type | caption        | viewability | date_posted                    |
|---------|-----------------|-----------|----------------|-------------|--------------------------------|
| 1       | sound@gmail.com | image     | hello          | public      | 02-01-20 10:05:44.404000000 PM |
| 2       | aishu@gmail.com | video     | happy morning  | friends     | 02-01-20 03:22:20.229000000 PM |
| 5       | aishu@gmail.com | image     | happy new year | public      | 03-01-20 05:45:58.163000000 AM |

* no 0f posts posted by a single user
```sql
select email , count(*) as no_of_posts from posts where email='aishu@gmail.com';
select email , count(*) as no_of_posts from posts group by email;
```
| email           | no_of_posts |
|-----------------|-------------|
| sound@gmail.com | 1           |
| aishu@gmail.com | 2           |

* edit the post and repost it
```sql
update posts set date_posted = current_timestamp,caption='hello' where email='sound@gmail.com';
```
| post_id | email           | post_type | caption         | viewability | date_updated                   |
|---------|-----------------|-----------|-----------------|-------------|--------------------------------|
| 1       | sound@gmail.com | image     | hello           | public      | 02-01-20 10:05:44.404000000 PM |
| 2       | aishu@gmail.com | video     | happy morning   | friends     | 02-01-20 03:22:20.229000000 PM |

* display the current status for the user's request
```sql
select * from friend_request where (requestor = 'sound@gmail.com') and current_status = 'accepted';
select * from friend_request where requestor = 'sound@gmail.com';
```
| requestor       | acceptor       | current_status |
|-----------------|----------------|----------------|
| sound@gmail.com | mala@gmail.com | accepted       |

* searching for the user
```sql
select * from user_list where user_name like 'a%';
```
| user_id | user_name | email           | age | gender | dob      | city    | country | created_date                   | status     |
|---------|-----------|-----------------|-----|--------|----------|---------|---------|--------------------------------|------------|
| 2       | aishu     | aishu@gmail.com | 21  | female | 31-12-98 | Delhi   | India   | 02-01-20 03:20:25.969000000 PM | i_am_ice   |
| 4       | ajiee     | ajiee@gmail.com | 18  | male   | 13-01-01 | chennai | India   | 02-01-20 03:20:25.979000000 PM | i_am_ajiee |

```sql
select * from user_list where user_name like '%mala%';
```
| user_id | user_name    | email            | age | gender | dob      | city    | country | created_date                   | status    |
|---------|--------------|------------------|-----|--------|----------|---------|---------|--------------------------------|-----------|
| 3       | mala         | mala@gmail.com   | 20  | female | 27-03-99 | chennai | India   | 02-01-20 03:20:25.974000000 PM | i_am_mala |
| 5       | chithra mala | chithu@gmail.com | 20  | female | 17-03-99 | madurai | India   | 02-01-20 03:20:25.984000000 PM | iam_chithu|

* search the user by using their location and user name
```sql
select * from user_list where city='madurai';
```
| user_id | user_name    | email            | age | gender | dob      | city    | country | created_date                   | status    |
|---------|--------------|------------------|-----|--------|----------|---------|---------|--------------------------------|-----------|
| 1       | soundarya    | sound@gmail.com  | 21  | female | 28-12-98 | madurai | India   | 02-01-20 03:20:25.963000000 PM | i_am_sound|
| 5       | chithra mala | chithu@gmail.com | 20  | female | 17-03-99 | madurai | India   | 02-01-20 03:20:25.984000000 PM | iam_chithu|

* displaying the user name and posted status for the particular user
```sql
select u.user_name,p.post_type,p.caption,p.date_posted from user_list u inner join posts p on u.email=p.email;
```
| user_name | post_type | caption       | date_posted                    |
|-----------|-----------|---------------|--------------------------------|
| soundarya | image     | hello         | 02-01-20 10:05:44.404000000 PM |
| aishu     | video     | happy morning | 02-01-20 03:22:20.229000000 PM |

* displaying the comments for the posts posted by the users
```sql
select u.user_name,p.caption,c.cmts,c.cmt_email from user_list u,posts p,comments c where u.email=p.email
and p.post_id=c.cmt_post_id;
```
| user_name | caption       | cmts         | cmt_email       |
|-----------|---------------|--------------|-----------------|
| soundarya | hello         | hai          | aishu@gmail.com |
| aishu     | happy morning | good morning | sound@gmail.com |

* displaying the no of people posted their posts as public and private
```sql
select count(email) as public_posted_count from posts where viewability='public';
select count(email) as privately_posted_count from posts where viewability='friends';
```

| public_posted_count | private_posted_count |
|---------------------|----------------------|
| 1                   | 1                    |

* delete posts 
```sql
delete from posts where post_id=4; 
```


