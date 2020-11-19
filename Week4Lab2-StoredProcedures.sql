/*
Using Transact-SQL : Exercises
------------------------------------------------------------

Exercises for section 12 : STORED PROCEDURE

*In all exercises, write the answer statement and then execute it.



e12.1		Create a SP that returns the people with a family name that 
			starts with a vowel [A,E,I,O,U]. List the PersonID and the FullName.

select * from person

create proc getVowelFamilyName
as
select personid, fullname from
person
where familyname like '[AEIOU]%'

exec getVowelFamilyName

		
			

e12.2		Create a SP that accepts a semesterID parameter and returns the papers that
			have enrolments in that semester. List the PaperID and PaperName.

create proc semesterEnrolments(@semesterid nvarchar(10))
as
select p.paperid, papername from paper p
join paperinstance i on p.paperid = i.paperid
join semester s on s.semesterid = i.semesterid
where s.semesterid = @semesterid
go

exec semesterEnrolments '2019S1'

			
e12.3		Modify the SP of 12.2 so that the parameter is optional.
			If the user	does not supply a parameter value default to the current semester.
			If there is no current semester default to the most recent semester.

alter proc semesterEnrolmentsOptional(@semesterid nvarchar(10) = NULL)
as
if @semesterid is null
begin
set @semesterid = '2019S2'
end
select p.paperid, papername from paper p
join paperinstance i on p.paperid = i.paperid
join semester s on s.semesterid = i.semesterid
where s.semesterid = @semesterid
go

exec semesterEnrolmentsOptional

			

e12.4		Create a SP that creates a new semester record. the user must supply all
			appropriate input parameters.

select * from semester

create or alter proc semesterRecord
(	@semesterid nvarchar(10),
	@startdate datetime,
	@enddate datetime)
as
insert semester (semesterid, startdate, enddate) values (@semesterid, @startdate, @enddate)
go

exec semesterRecord '2050S1', '2050-02-02', '2050-07-07' 