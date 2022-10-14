use LibraryDB

go	--update UserBooks CreatedDate

create or alter trigger UpdateUserBooks
	on UserBooks
	after insert, update
	as update UserBooks
		set CreatedDate = GETDATE()
		where Id in (select Id from inserted);

go	--update Users ExpiredDate

create or alter trigger UpdateUsers
	on Users
	after insert, update
	as 
	begin
		update Users
			set ExpiredDate = DATEADD(year, 1, GETDATE())
			where Id in (select Id from inserted);
		update Users
			set Age = DATEDIFF(year, BirthDate, GETDATE())
			where Id in (select Id from inserted);
		end
