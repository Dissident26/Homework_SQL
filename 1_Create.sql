create database LibraryDB;

go

use LibraryDB

go

create table Authors (
	Id int identity primary key not null,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Country nvarchar(50) not null,
	BirthDate date not null
)

go

create table Books (
	Id int identity primary key not null,
	Name nvarchar(50) not null,
	AuthorId int references Authors(id),
	Year int not null,
)

go

create table Users (
	Id int identity primary key not null,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Email nvarchar(50) unique not null,
	BirthDate date not null,
	Age int null,
	Address nvarchar(100) not null,
	ExpiredDate date null,
)

go

create table UserBooks (
	Id int identity primary key not null,
	UserId int references Users(id) on delete cascade,
	BookId int references Books(id) on delete cascade,
	CreatedDate date null,
);