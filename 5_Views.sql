use LibraryDB

go 

create or alter view UsersInfo as 
	select 
	Users.Id as UserId, 
	concat(Users.FirstName, ' ', Users.LastName) as UserFullName,
	Users.Age as UserAge,
	concat(Authors.FirstName, ' ', Authors.LastName) as AuthorFullName,
	Books.Name as BookName,
	Books.Year as BookYear
	from 
	UserBooks 
		right join Users on Users.Id = UserBooks.UserId
		left join Books on Books.Id = UserBooks.BookId
		left join Authors on Authors.Id = Books.AuthorId;