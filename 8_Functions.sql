use LibraryDB

go

create or alter function GetCharge(@CreateDate date, @Term int = 60)
returns money
as
begin
	declare @FinePerDay money;
	declare @DateDifferenceInDaysAboveTerm int;

	set @FinePerDay =  2.7;
	set @DateDifferenceInDaysAboveTerm = DATEDIFF(day, @CreateDate, GETDATE()) - @Term;

	return iif(@DateDifferenceInDaysAboveTerm > 0, @DateDifferenceInDaysAboveTerm * @FinePerDay, 0);
end;