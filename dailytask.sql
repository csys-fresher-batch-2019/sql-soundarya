create table daily_task (
status number not null,task varchar2(50) not null,done_by varchar2(30) not null,deadline date not null,completed_on date,priority number 
not null)
constraint number_cq check (number in(1,0)),
constraint completed_on_cq check (completed_on <= deadline)
);

insert into daily_task (status,task,done_by,deadline,compleated_on,priority) values (0,dailyTask1,soundarya,
to_date('28-12-2019','dd-MM-yyyy'),to_date('27-12-2019','dd-MM-yyyy'),1);

insert into daily_task (status,task,done_by,deadline,priority) values (0,dailyTask2,nandhu,
to_date('28-12-2019','dd-MM-yyyy'),3);

update daily_task set status=1 where compleated_on != NULL;

select * from daily_task where status = 1;
