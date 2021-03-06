/****** Script for SelectTopNRows command from SSMS  

SELECT TOP (1000) [PaperID]
      ,[SemesterID]
      ,[PersonID]
  FROM [yourDatabaseName].[dbo].[Enrolment]
  
  Week 3 labs are due on Friday 21 August

 13.1 Develop a stored procedure [EnrolmentCount] that accepts a paperID
		and a semesterID and calculates the number of enrolments in the 
		relevant paper instance. It returns the enrolment count as an
		output parameter.

create or alter proc EnrolmentCount(@paperid nvarchar(10), @semesterid char(6))
as 
select count(personid) from enrolment e 
where paperid like @paperid and semesterid like @semesterid
group by paperid

exec EnrolmentCount 'IN510', '2019S1'

		
13.2	Re-develop stored procedure [EnrolmentCount] so that semesterID
		is optional and defaults to the current semester. If there is no
		current semester, it chooses the most recent semester. 

create or alter proc EnrolmentCount(@paperid nvarchar(10), @semesterid char(6) = null, @CastOutput int OUTPUT)
as
	begin
		if @semesterid is null
		set @semesterid = (
		select semesterid from semester
		where getdate() between startdate and enddate)
	end
	set @CastOutput = (
	select count(personid) from enrolment e 
	where paperid like @paperid and semesterid like @semesterid)
go

exec EnrolmentCount 'IN510', null, @CastOutput output

13.3  Write the script you will need to test 13.2 hint: you may have to cast your output.
	
go 
declare @CastOutput int

exec EnrolmentCount 'IN238', '2020S2', @CastOutput output
exec EnrolmentCount 'IN238', null, @CastOutput output

print ''
print 'This paper has' + CAST(@CastOutput as int) + 'enrolments'

		*/