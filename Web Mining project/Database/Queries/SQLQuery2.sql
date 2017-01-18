select id,rating from ratings where isbn=373250215

select avg(rating) from ratings where id=25409

select isbn, count(ID) from ratings group by isbn

373250215

select avg(rating)

select count(distinct isbn) from ratings where rating is not null

with a(b,c) as (select top 1000 isbn, count(rating) as rings from ratings group by isbn order by rings desc)
delete from books where isbn not in (select distinct isbn from ratings)

select distinct isbn from ratings

select count(*) from booksim

select * from booksim where sim not in (0,-1) and sim>0 order by sim 

select count(isbn) from books

select count(*) from ratings

delete from ratings where isbn not in (select isbn from ratings group by isbn having count(rating)>9)

select count(*) from books

delete from books where isbn not in (select isbn from ratings group by isbn having count(rating)>9)

select distinct id from ratings

delete from users where id not in (select distinct id from ratings)

select count(*) from users

select id, count(isbn) as cnt from ratings group by id order by cnt desc

create table simij
(
ISBN1 bigint,
ISBN2 bigint,
Score float,
constraint pk_ISBN12 primary key(ISBN1,ISBN2),
constraint fk_isbn1 foreign key(ISBN1) references Books,
constraint fk_isbn2 foreign key(ISBN2) references Books)

insert into simij
select * from booksim2 order by bk1,bk2

delete from simij where score=0