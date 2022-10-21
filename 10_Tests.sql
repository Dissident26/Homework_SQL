use LibraryDB

go 

exec GiveBookToUser 'vasyan3@gmail.com', '�����', '�����', '�������';
exec GiveBookToUser 'pupa_lupa_azaza@gmail.com', '������', '�������', '������� ������';

drop trigger UpdateUserBooks;
drop trigger UpdateUsers;

update Users 
	set ExpiredDate = '2020-10-21'
	where Id = 2;

update Users 
	set ExpiredDate = '2020-10-21'
	where Id = 4;

update UserBooks 
	set CreatedDate = '2022-05-21'
	where BookId = 4;

exec ReturnBook 'vasyan3@gmail.com', '�����', '�����', '�������';

exec ReturnBook 'pupa_lupa_azaza@gmail.com', '������', '�������', '������� ������';

exec DeleteUsersByExpiredDate;