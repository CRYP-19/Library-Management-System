# Library-Management-System
A MySQL database for managing library books, members, and loans.
Library Management Database

Overview
This project defines a relational database for a library system. It manages books, authors, categories, members, and borrowing activity. The schema supports tracking inventory, monitoring user activity, and generating insights from borrowing patterns.

Database
books_db

Structure

Authors
Stores information about book authors.

Fields:
author_id, unique identifier
author_name, required
country
birth_year
Categories
Stores book genres or classifications.

Fields:
category_id, unique identifier
category_name, unique and required
Books
Stores all books available in the library.

Fields:
book_id, unique identifier
title, required
author_id, foreign key
category_id, foreign key
isbn, unique
publication_year
copies_available, default is 1
Members
Stores registered library users.

Fields:
member_id, unique identifier
full_name, required
email, unique
phone
membership_date, default is current date
status, Active or Inactive
Book Loans
Tracks borrowing and returning of books.

Fields:
loan_id, unique identifier
book_id, foreign key
member_id, foreign key
borrow_date
due_date
return_date
status, Borrowed, Returned, or Overdue

Key Features

Data Integrity

Foreign key constraints maintain relationships
Unique constraints prevent duplicate records

Inventory Tracking

Track available copies per book
Identify books never borrowed

Member Activity

Monitor borrowing behavior
Identify most active members
Detect members with unreturned books

Analytics Queries

Database Summary

Total books
Total members
Total loans

Usage Insights

Most borrowed books
Most active members
Popular authors
Books borrowed per category

Operational Insights

Overdue books
Average borrowing duration
Monthly borrowing trends

Setup Instructions

Create the database
Run: CREATE DATABASE books_db
Create tables
Execute all CREATE TABLE statements
Insert data
Run all INSERT statements
Run analysis queries
Use provided SELECT queries for insights
