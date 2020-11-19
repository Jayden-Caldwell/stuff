/*
Using Transact-SQL : Exercises
------------------------------------------------------------

/*
Exercises for section 8 : INSERT

*In all exercises, write the answer statement and then execute it.

select * from semester

e8.1	Write a statement to create 2 new papers: IN338 and IN238 Extraspecial Topic 

	select * from paper

	insert into paper(paperid, papername)
	values ('IN338', 'Extraspecial Topic'), ('IN238', 'Extraspecial Topic')

e8.2	Create a new user (yourself)
		Write statements that will add three enrolments for you
		in papers you have completed (Add extra papers if required).

	select * from person
	insert into person(personid, givenname, familyname, fullname)
	values (420, 'Jayden', 'Caldwell', 'Jayden Caldwell')

	select * from enrolment
	insert into enrolment(paperid, semesterid, personid)
	values ('IN628', '2019S2', 420), ('IN612', '2019S2', 420), ('IN605', '2019S1', 420)

e8.3	Imagine that every paper on the database will run in 2021.
		Write the statements that will create all the necessary paper instances. You will need to add the Semester
		This can be done using a subselect or a left outer join.

	select * from semester
	select * from paperinstance
	insert into semester(semesterid, startdate, enddate)
	values ('2021S1', '2021-02-02', '2021-06-06'), ('2021S2', '2021-07-04', '2021-11-20')

	insert paperinstance(paperid, semesterid)
	select paperid, '2021S1'
	from paper
	where paperid not in (select paperid from paperinstance where semesterid = '2021S1')

e8.4	Imagine a strange path-of-study requirement: in semester 2020S2
		Find all people who are currently enrolled in IN605 and not enrolled in IN612 and enrol them in IN238.
		Write a statement to create the correct paper instance for IN238.
		Write a statement that will find all people enrolled in IN605 (semester 2019S2)
		but	not enrolled in IN612 (semester 2019S2) and 
		will create IN238 (semester 2020S1) enrolments for them. Build it up one step at a time.
		
		1. create paper, semester and paper instance data
	
	select * from semester
	insert into semester(semesterid, startdate, enddate)
	values ('2020S2', '2020-07-04', '2020-11-20')
	
	select * from paperinstance
	insert into paperinstance(paperid, semesterid)
	values ('IN238', '2020S2')

		2. Find IN605/2019S2 enrolments that are not in IN612

	select * from enrolment
	select personid from enrolment
	where paperid like 'IN605' and paperid not like 'IN612' and semesterid like '2019S2'

		3. insert new enrolments

	insert into enrolment(paperid, semesterid, personid)
	select 'IN238', '2020S2', personid from enrolment
	where paperid like 'IN605' and paperid not like 'IN612' and semesterid like '2019S2' 