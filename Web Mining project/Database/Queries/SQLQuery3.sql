select count(*) from ratings

select isbn, count(rating) as rints from ratings group by isbn order by rints desc

select id from ratings where isbn=28604199
intersect
select id from ratings where isbn=60175400

select rating from ratings where isbn=28604199 and id=150979
select rating from ratings where isbn=60175400 and id=150979

select id from ratings where isbn=28604199
intersect
select id from ratings where isbn=60096195

select rating from ratings where isbn=28604199 and id=7346
select rating from ratings where isbn=60096195 and id=7346

select rating from ratings where id=7346

create table items
(
isbn int
)
insert into items values(1)
insert into items values(2)
insert into items values(3)
insert into items values(4)
select * from items

create table ir
(
id int,
isbn int,
rating int
)

select * from ir

select distinct id from ir where isbn=2 intersect select distinct

insert into ir values(1,1,1)
insert into ir values(1,2,5)
insert into ir values(1,3,4)
insert into ir values(1,4,5)
insert into ir values(2,1,2)
insert into ir values(2,2,5)
insert into ir values(2,3,4)
insert into ir values(2,4,4)
insert into ir values(3,1,5)
insert into ir values(3,2,2)
insert into ir values(3,3,1)
insert into ir values(3,4,1)

delete ir
delete items

create table simit
(
i1 int,
i2 int,
sim float
)

drop table itemsim
select * from itemsim

select count(*) from sim where sim >0.80 and sim<1

select id,count(isbn) as cnt from ratings group by id order by cnt desc
select * from ratings where id=104636

select isbn1,isbn2, score from sim where isbn1 in (select isbn from ratings where id=60244) and isbn2 not in (select isbn from ratings where id=60244) and score between 0.8 and 0.99

select * from books where isbn=60502258
select isbn2, title, author, score from sim s
left join books b on s.isbn2=b.isbn
where isbn1=60502258 and isbn2 not in (select isbn from ratings where id=60244) and score between 0.85 and 1 order by score desc

select isbn2 from sim where isbn1=60502258 and isbn2 not in (select isbn from ratings where id=60244) and score>0.85

select ISBN2 from sim where isbn1 in (select isbn2 from sim where isbn1=60502258 and isbn2 not in (select isbn from ratings where id=60244) and score>0.85)
intersect select isbn from ratings where id=60244



select title,Author,year, Publisher from books where isbn=60502258
select title, author, year, Publisher, Score as "Similarity Score" from simij s
left join books b on s.ISBN2=b.ISBN
where ISBN1=60502258 order by score desc
select title,Author,Year,Publisher,R as "Predicted Rating" from books b
right join Pred p on b.ISBN=p.bk
order by R desc



select count(*) from Ratingsbk

select isbn2,title, author, year, Publisher,Score from sim s
left join books b on s.ISBN2=b.ISBN
where ISBN1=141000198 order by score desc

select r.isbn, title, author, Rating from ratings r
left join books b on r.ISBN=b.ISBN
where id=60244

select * from booksim2 order by sim

drop table pred

select title,Author,year, Publisher from books where isbn=60502258
select title, author, year, publisher, R as "Predicted Rating", score as "Similarity Score" from pred p
left join simij s on p.bk=s.ISBN2
				and p.isbn=s.ISBN1
left join books b on p.bk=b.ISBN
order by R desc
