/*
Exercises for section 4

delete from PaperInstance where PaperID = 'IN610' -- I populated this table using a cross join so all of the data will match otherwise.
insert into Enrolment values ('IN511', '2019S2', 102);

4.1	List the starting date and ending date of each occasion 
	IN511 Programming 2 has run.

select p.papername, s.startdate, s.enddate from semester as s
join PaperInstance [pi] on s.semesterid = [pi].semesterid
join Paper p on p.PaperID = [pi].paperid
where p.paperid like ('IN511')

4.2	List all the full names of the people who have ever enrolled in
	IN511 Programming 2 .
	If a person has enrolled more than once, do not repeat their name.

select distinct p.fullname from person as p
join enrolment e on e.personid = p.personid
where e.paperid like ('IN511')

4.3	List all the full names of all the people who have never enrolled in a paper
	(according to the data on the database).

select p.fullname from person as p
left join enrolment e on e.personid = p.personid
where e.paperid is null


4.4	List all the papers that have never been run (according to the data).There are currently none so insert one in order to test the query.
Insert into Paper values ('IN728', 'Programming5') 

select p.papername from paper as p
left join paperinstance [pi] on [pi].paperid = p.paperid
where [pi].semesterid is null

4.5	List all the semesters, showing semester start date and length in days, in which IN511 has run.

select p.papername, s.startdate, DATEDIFF(day, StartDate, EndDate) from semester as s
join PaperInstance [pi] on s.semesterid = [pi].semesterid
join Paper p on p.PaperID = [pi].paperid
where p.paperid like ('IN511')

4.6	Develop a statement that returns all people that enrolled in IN511 
	in a semester that started on or between 12-Apr-2018 and 13-Aug-2019.
	Display the full name of each person and the year in which they enrolled. 
	Ensure the people are listed alphabetically according to their family name then given name.

select distinct p.givenname, p.familyname, year(s.startdate) from person as p
join enrolment e on p.personid = e.personid
join semester s on e.semesterid = s.semesterid
where s.startdate between '2018-04-12' and '2019-08-13'
order by p.familyname, p.givenname

*/
/*
Exercises for section 5

5.1	List all the papers that have a paper instance. 
	Display the PaperID and number of instances of the paper.

select p.paperid, count([pi].paperid) from paper p
join paperinstance [pi] on p.paperid = [pi].paperid
group by p.paperid

5.2	How many people, in total over all semesters, have enrolled in each of the papers
	that have been delivered? Display the paper ID, paper name and enrolment count.

select p.paperid, p.papername, count(e.personid) from paper p
join enrolment e on e.paperid = p.paperid
group by p.paperid, p.papername

5.3	How many people, in total over all semesters, have enrolled in each of the papers
	listed on the Paper table? Display the paper ID, paper name and enrolment count.

select p.paperid, p.papername, count(e.personid) from paper p
left join enrolment e on e.paperid = p.paperid
group by p.paperid, p.papername

5.4	List the paper instance with the highest enrolment. 
	Display the paper instance's start date, end date, paper name and enrolment count.

select top 1 s.startdate, s.enddate, p.papername, count(e.personid) from semester s
join enrolment e on s.semesterid = e.semesterid
join paper p on p.paperid = e.paperid
group by s.startdate, s.enddate, p.papername

5.5	List all the people who have 3, 4 or 5 enrolments.

select p.fullname from person p
join enrolment e on e.personid = p.personid
group by p.fullname
having count(e.personid) >=3

*/