create table books (
b_id number,b_name varchar2(30) not null,a_name varchar2(30) not null,price number not null,
publisher varchar2(30) not null,version number,category varchar2(30) not null,active number default 1,
constraint b_id_pk primary key(b_id),
constraint price_ck check(price>=0),
constraint uq unique (b_name,a_name,version),
constraint active_cq check(active in (1,0))
);

insert into books (b_id,b_name,a_name,price,publisher,version,category,active) values (028,'Life','xxx',1000,'yyy',3,'magazine',1);

insert into books (b_id,b_name,a_name,price,publisher,version,category) values (007,'java','xxx',700,'yyy',7,'theory');

drop table books;
drop table orders;


create table orders(
o_id number,
u_name varchar2(30) not null,
b_id number not null,
ordered_date timestamp  not null,
delivered_date timestamp,
total_amt number not null,
qty number default 1,
status varchar(20) default 'ordered',
comments varchar(100),
constraint o_id_pk primary key (o_id),
constraint b_id_fk foreign key(b_id) references books(b_id),
constraint total_amt_cq check (total_amt >=0),
constraint qty_cq check (qty >=1),
constraint unq unique (u_name,b_id,ordered_date)
);

insert into orders (o_id,u_name,b_id,ordered_date,total_amt,qty,status,comments) values 
(287,'sound',028,current_timestamp,2700,2,'ordered','xxxxyyyy');


insert into orders (o_id,u_name,b_id,ordered_date,total_amt,comments) values 
(73,'mala',007,current_timestamp,700,'xxxxyyyy');

insert into orders (o_id,u_name,b_id,ordered_date,total_amt,qty,status,comments) values 
(222,'soundarya',020,current_timestamp,200,1,'ordered','xxxyyyy');

delete * from orders where b_id=7;

select * from books b inner join orders o on b.b_id=o.b_id;

select b.b_name,o.ordered_date from books b inner join orders o on b.b_id=o.b_id;

select b.b_name,b.price,o.ordered_date from books b left outer join orders o on b.b_id=o.b_id;

select b.b_name,b.price,o.ordered_date from books b right outer join orders o on b.b_id=o.b_id;

select b.b_name,b.price,o.ordered_date from books b full outer join orders o on b.b_id=o.b_id;

select * from books,orders;

select b1.b_name,b2.version from books b1 join books b2 on b.b_id=o.b_id;




