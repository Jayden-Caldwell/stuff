/*
WORKSHEET - JOINS AND SUBQUERIES
------------------------------------------------------------


Exercises for Joins and Subqueries : WORKSHEET

1.	List the titles and prices of all books that have the cheapest price.

select title, price from titles
where price = (SELECT MIN(price) FROM titles)

2.	List all titles that have sold more than 40 copies at a single store.

select t.title from titles as t
left join sales s on s.title_id = t.title_id
where s.qty > 40

3.	List all authors who have not published any books.

select au_id, au_lname, au_fname from authors
where contract = 0

select a.au_id, a.au_lname, a.au_fname from authors as a
left join titleauthor ta on ta.au_id = a.au_id
where title_id IS NULL

4.	List all the publishers who have published any business books.

select distinct p.pub_name from publishers as p
join titles t on t.pub_id = p.pub_id
where type like ('business')

5.	List all authors who have published a “popular computing” book (these books have type = 'popular_comp' in the titles table).

select a.au_lname, a.au_fname from authors as a
join titleauthor ta on a.au_id = ta.au_id
join titles t on ta.title_id = t.title_id
where type like ('popular_comp')

6.	List all the cities where both an author (or authors) and a publisher (or publishers) are located.

select distinct city from authors 
where city in (select city from publishers)

7.	List all cities where an author, but no publisher, is located.

select distinct city from authors 
where city not in(select city from publishers)

8.	List all titles that have sold no copies.
select * from sales

select title from titles
where ytd_sales IS NULL 

select t.title from titles as t
left join sales s on s.title_id = t.title_id
where qty IS NULL

9.	List the title and total sales of each book whose total sales is less than the average totals sales across all books.

select t.title, sum(s.qty) from titles t
join sales s on t.title_id = s.title_id
group by t.title
having sum(qty) < (select AVG(sumTable.sumqty)
from
(select sum(qty) as sumqty
from sales group by title_id) sumTable)

10.	List the publishers, and the number of books each has published, who are not located in California.

select p.pub_name, count(t.pub_id) from publishers as p
join titles t on p.pub_id = t.pub_id
where p.state not like ('CA')
group by p.pub_name

11.	For each book, list the number of stores where it has been sold.

select title, count(s.stor_id) from titles t
join sales s on s.title_id = t.title_id
join stores st on st.stor_id = s.stor_id
group by title


12.	For each book, list its title, the largest quantity of it sold at any one store, and the name of that store.

select title, stor_name, max(qty) from titles t
join sales s on s.title_id = t.title_id
join stores st on st.stor_id = s.stor_id
group by title, stor_name
order by title

13.	Increase by two points the royalty rate for all books that have sold more than 30 copies total.

update roysched
set royalty = royalty + 2
where title_id in (
select t.title_id from sales s
join titles t on t.title_id = s.title_id
group by t.title_id
having sum(qty) > 30)

14.	List all types of books published by more than one publisher.

select t.type from titles t
join publishers p on t.pub_id = p.pub_id
group by t.type
having count(distinct p.pub_id) > 1
