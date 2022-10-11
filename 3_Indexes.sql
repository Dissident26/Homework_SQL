use LibraryDB

go

create unique nonclustered index IX_UserId_BookId_Unique
on UserBooks(UserId, BookId)

go 

create unique nonclustered index IX_Name_AuthorId_Unique
on Books(Name, AuthorId)

go 

create unique nonclustered index IX_FirstName_LastName_Country_Unique
on Authors(FirstName, LastName, Country)