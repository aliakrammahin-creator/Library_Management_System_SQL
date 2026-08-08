use library_project_db;


-- Project Task:

-- Task 1.Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
insert into books (isbn, book_title, category, rental_price, status, author, publisher)
values
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2.Update an Existing Member's Address
set sql_safe_updates = 0;
update members
set member_address = '125 Main St'
where member_id = 'C101';

-- Task 3.Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
select * from issued_status;
delete from issued_status
where issued_id = 'IS121';

-- Task 4.Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'. 
select issued_book_name, issued_book_isbn
from 
issued_status
where issued_emp_id = 'E101';

-- Task 5.Retrieve All Books in a Specific Category:
select * from books
where category = 'Classic';

-- Task 6.List Members Who Registered in the Last 180 Days
SELECT *
FROM members
WHERE reg_date >= CURDATE() - INTERVAL 180 DAY;

-- Task 7.List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select
    issued_member_id,
    COUNT(issued_id) AS total_books_issued
from issued_status
group by issued_member_id
having COUNT(issued_id) > 1;

-- Task 8. Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
create table book_cnts
as
select 
      b.isbn,
      book_title,
      count(issued_id) as no_issued
from books as b
join issued_status as ist
on b.isbn = ist.issued_book_isbn
group by 1, 2;

select * 
from book_cnts;

-- Task 9.Find Total Rental Income by Category:
select 
     b.category,
     sum(b.rental_price) as total_income,
     count(ist.issued_id) as book_issued
from books as b
join issued_status as ist
on b.isbn = ist.issued_book_isbn
group by b.category 
order by total_income asc;

-- Task 10.List Employees with Their Branch Manager's Name and their branch details
select 
     e1.*,
     e2.emp_name as Manager,
     e2.emp_id as Manager_id,
     b.branch_id
from employees as e1
join 
branch as b
on e1.branch_id = b.branch_id
join 
employees as e2
on e2.emp_id = b.manager_id; 

-- Task 11.Retrieve the List of Books Not Yet Returned
select 
     distinct issued_book_name,
     issued_book_isbn
from issued_status as i1
left join 
return_status as r1
on i1.issued_id = r1.issued_id
where return_id is null;

/* Task 12.Identify Members with Overdue Books, 
Write a query to identify members who have overdue books.(assume a 850-day return period)
Display the member's_id, member's name, book title, issue date, and days overdue. 
*/
select 
     ist.issued_member_id,
     m.member_name,
     bk.book_title,
     ist.issued_date,
     rs.return_date,
     DATEDIFF(CURDATE(), issued_date) as days_issued
from issued_status as ist
join 
members as m
on ist.issued_member_id = m.member_id
join
books as bk
on ist.issued_book_isbn = bk.isbn
left join 
return_status as rs
on ist.issued_id = rs.issued_id
where return_date is null
and DATEDIFF(CURDATE(), issued_date) > 850
order by ist.issued_member_id;

-- Task 13.Create a Table of Books with Rental Price Above a Certain Threshold $7.
create table expensive_books
select * from books
where rental_price > 7;

select * from expensive_books;

/* Task 14.Create a query that generates a performance report for each branch, 
showing the number of books issued, the number of books returned, 
and the total revenue generated from book rentals.
*/
create table branch_report
as
select 
     br.branch_id,
     br.manager_id,
     count(ist.issued_id) as no_book_issued,
     count(rs.return_id) as no_book_returned,
     sum(bk.rental_price) as total_revenue
from issued_status as ist
join 
employees as em 
on ist.issued_emp_id = em.emp_id 
join 
branch as br
on br.branch_id = em.branch_id
left join 
return_status as rs
on rs.issued_id = ist.issued_id
join
books as bk
on ist.issued_book_isbn = bk.isbn
group by 1,2;

select * from branch_report;

/* Task 15.Use the CREATE TABLE AS (CTAS) statement to create a new table active_members 
containing members who have issued at least one book in the last 28 months.
*/
create table active_members
select distinct
     member_id,
     member_name,
     member_address
from
issued_status as ist
join 
members as m1
on ist.issued_member_id = m1.member_id
where issued_date >= current_date - interval 28 month;

select * from active_members;

/* Task 16.Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 850 days. 
The table should include: The number of overdue books. The total fines, member ID with each day's fine calculated at $0.50.
*/

create table member_fines AS
select
    ist.issued_member_id AS member_id,
    count(*) AS overdue_books,
    sum(datediff(curdate(), issued_date) - 850) * 0.50 AS total_fines
from issued_status as ist
left join return_status as rs
    on ist.issued_id = rs.issued_id
where rs.return_date is null
and datediff(curdate(), issued_date) > 850
group by 1;

select * from member_fines;

/* Task 17.Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/
select 
      em.emp_name,
      br.branch_id,
      br.branch_address,
      count(ist.issued_id) as no_of_books_processed
from issued_status as ist
join
employees as em
on em.emp_id = ist.issued_emp_id
join 
branch as br
on em.branch_id = br.branch_id
group by 1, 2, 3
order by count(ist.issued_id) desc
limit 3;
