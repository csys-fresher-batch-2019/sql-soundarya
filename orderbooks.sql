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


select * from books;

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


update orders set delivered_date=current_timestamp, status='delivered' where o_id=287;

select count(delivered_date) as sales_count from orders where status='delivered';

select * from orders;
                           
create table order_items (
item_id number not null,or_id number not null,b_id number not null,quantity number  default 1,status varchar2(20) not null,
constraint quantity_cq check (quantity>=1),
constraint bk_id_fk foreign key(b_id) references books(b_id),
constraint or_id_fkey foreign key(or_id) references orders(o_id),
constraint item_id_pk primary key (item_id)
);

drop table order_items;

insert into order_items (item_id,or_id,b_id,quantity,status) values (1,287,028,3,'ordered');

insert into order_items (item_id,or_id,b_id,quantity,status) values (2,73,007,5,'ordered');

select * from order_items;

create table books_stock (
stock_id number not null,bo_id number not null,qnty number,
constraint bo_id_fk foreign key(bo_id) references books(b_id),
constraint stock_id_pk primary key (stock_id)
);

insert into books_stock (stock_id,bo_id,qnty) values (1,028,10);

insert into books_stock (stock_id,bo_id,qnty) values (2,007,5);

select * from books_stock;

select b_name,(select qnty from books_stock where bo_id=b.b_id) as book_count from books b;

select b_name,(select sum(quantity) from order_items where b_id =b.b_id) as no_of_qnty_ordered from books b;

select b_name,(
(select sum(qnty) from books_stock where bo_id=b.b_id)-
(select sum(quantity) from order_items where b_id =b.b_id)
)as available_stocks 
from books b;

