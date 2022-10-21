use LibraryDB

go 

create or alter procedure ChargeUser 
	@UserEmail nvarchar(50),
	@BookId int
as
begin
	declare @UserId int;
	declare @CreatedDate date;

	set @UserId = (select Id from Users where Email = @UserEmail);
	set @CreatedDate = (select CreatedDate from UserBooks where @BookId = BookId);

	if(@UserId is null)
		begin
			print 'User not exist!'
			return;
		end;

	update UserBooks 
		set ToCharge = dbo.GetCharge(@CreatedDate, null)
		where BookId = @BookId;
end;

go

create or alter procedure ReturnBook
	@UserEmail nvarchar(50),
	@AuthorFirstName nvarchar(50),
	@AuthorLastName nvarchar(50),
	@BookName nvarchar(50)
as
begin
	declare @AuthorId int;
	declare @BookId int;
	declare @UserId int;
	declare @ChargeValue money;

	set @AuthorId = (select Id from Authors where 
		FirstName = @AuthorFirstName
		and
		LastName = @AuthorLastName);

	set @BookId = (select Id from Books where
		AuthorId = @AuthorId
		and
		Name = @BookName); 
		
	set @UserId = (select Id from Users where
		Email = @UserEmail);

		exec ChargeUser @UserEmail, @BookId;
		
	set @ChargeValue = (select ToCharge from UserBooks where 
		UserId = @UserId 
		and 
		BookId = @BookId);

		print CONCAT('User charge is', ' ', @ChargeValue);

		delete from UserBooks where UserId = @UserId and BookId = @BookId;
end;