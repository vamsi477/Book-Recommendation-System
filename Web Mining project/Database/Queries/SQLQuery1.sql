select count(distinct ISBN) from BooksT
select count(*) from BooksT

select * from BooksT where isbn is null

delete from bookst where isbn is null

create table Booksbk
(
ISBN bigint,
Title nvarchar(255),
Author nvarchar(255),
Year int,
Publisher nvarchar(255),
constraint pk_isbnbk primary key(ISBN))

insert into books
select * from BooksT order by ISBN

select count(*) from RatingsT
select count(*) from RatingsT where ISBN in (select isbn from books)
select count(*) from RatingsT where id in (select id from UsersT)
select count(*) from RatingsT where ISBN in (select isbn from books) and id in (select id from UsersT)

select * from ratingst where ISBN is null
select * from ratingst where rating=0
select count(*) from ratingst where rating=0

delete from RatingsT where ISBN not in (select isbn from books)
delete from RatingsT where ID not in (select id from UsersT)
delete from ratingsT where ISBN is null

create table Ratingsbk
(
ID bigint,
ISBN bigint,
Rating int,
constraint pk_isbnidbk primary key(ID,ISBN),
constraint fk_idbk foreign key(ID) references Usersbk,
constraint fk_isbnbk foreign key(ISBN) references Booksbk)

select * from books where isbn is null

insert into Ratings
select * from Ratingst order by ID,ISBN

with temp(a,b,c) as
select id,isbn,count(*) as cou from RatingsT group by id,isbn,rating

select count(*) from RatingsT

select * from ratingst order by id desc

select * from Ratingst where id=273718 and isbn=140440151
delete from Ratingst where id=273718 and isbn=140440151 and rating=0

Create table Usersbk
(
ID bigint,
Location nvarchar(255),
Age nvarchar(255),
constraint pk_idb primary key(ID))

insert into Usersbk
select * from users

insert into booksbk
select * from books

insert into ratingsbk
select * from ratings

select count(*) from ratings
select count(*) from ratings where rating=0
delete from ratings where rating=0