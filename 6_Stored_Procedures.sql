use LibraryDB

go 

create or alter procedure DeleteUsersByExpiredDate 
as
begin
	declare @ExpiredUsersWithBooks table(UserId int, UserFullName nvarchar(50), BookName nvarchar(50))
	
	insert into @ExpiredUsersWithBooks
	select
		UsersInfo.UserId,
		UsersInfo.UserFullName,
		UsersInfo.BookName
		from UsersInfo
			join 
			(select * from Users where ExpiredDate < GETDATE()) as ExpiredUsers
			on UsersInfo.UserId = ExpiredUsers.Id;
	
	declare @CurrentUserId int;
	declare @UserFullName nvarchar(50);
	declare @BookName nvarchar(50);

	while exists (select * from @ExpiredUsersWithBooks)
	begin
		select top(1) 
			@CurrentUserId = UserId, 
			@UserFullName = UserFullName, 
			@BookName = BookName 
		from @ExpiredUsersWithBooks;

		if(@BookName is not null) print concat(@UserFullName, ' ', 'still has', ' ', @BookName);
		else delete from Users where Id = @CurrentUserId;

		delete @ExpiredUsersWithBooks where UserId = @CurrentUserId;
	end;
end;


go 

create or alter procedure GiveBookToUser 
	@UserEmail nvarchar(50),
	@AuthorsFirstName nvarchar(50),
	@AuthorsLastName  nvarchar(50),
	@BookName nvarchar(50) 
as
	begin
		declare @UserId int;
		declare @AuthorId int;
		declare @BookId int;

		set @UserId = (select Id from Users where Email = @UserEmail);
		if(@UserId is null) 
			print 'User not found!';
		
		set @AuthorId = (select Id from Authors 
			where FirstName = @AuthorsFirstName and LastName = @AuthorsLastName);
		if(@AuthorId is null) 
			begin
				print 'Author not found!'
				return;
			end;

		set @BookId = (select Id from Books where Name = @BookName and AuthorId = @AuthorId);
		if(@BookId is null) 
			print 'Book not found!';

		if(@BookId = any(select BookId from UserBooks where UserId = @UserId))
			begin
				print 'User already has this book!'
				return;
			end;

		if(exists (select * from UserBooks where @BookId = BookId))
			print 'This book already given to another user!';

		if((@UserId is null) or (@BookId is null)) return;

		insert into UserBooks(UserId, BookId) values (@UserId, @BookId);
	end;
