INSERT INTO authors (author_name, country, birth_year) VALUES
('J.K. Rowling',          'United Kingdom', 1965),
('George R.R. Martin',    'United States',  1948),
('Agatha Christie',       'United Kingdom', 1991),
('Haruki Murakami',       'Japan',          1949),
('Chinua Achebe',         'Nigeria',        1930),
('Jane Austen',           'United Kingdom', 1901),
('Mark Twain',            'United States',  1901),
('Gabriel García Márquez','Colombia',       1927),
('Toni Morrison',         'United States',  1931),
('Chimamanda Ngozi Adichie', 'Nigeria',     1977);

select * from authors;

-- Insert Categories
INSERT INTO categories (category_name) VALUES
('Fiction'),
('Fantasy'),
('Mystery'),
('Science Fiction'),
('Romance'),
('Classic Literature'),
('Non-Fiction'),
('Biography'),
('History'),
('Self-Help');

-- 3. Insert into books table
INSERT INTO books (title, author_id, category_id, isbn, publication_year, copies_available) VALUES
('Harry Potter and the Philosopher\'s Stone', 1, 2, '9780747532699', 1997, 5),
('A Game of Thrones',                        2, 2, '9780553103540', 1996, 3),
('Murder on the Orient Express',             3, 3, '9780007119318', 1934, 4),
('Norwegian Wood',                           4, 1, '9780099448822', 1987, 2),
('Things Fall Apart',                        5, 1, '9780385474542', 1958, 6),
('Pride and Prejudice',                      6, 5, '9780141439518', 1913, 3),
('The Adventures of Tom Sawyer',             7, 6, '9780486400778', 1976, 4),
('One Hundred Years of Solitude',            8, 1, '9780060883287', 1967, 2),
('Beloved',                                  9, 1, '9781400033416', 1987, 3),
('Americanah',                              10, 1, '9780307455925', 2013, 5),
('The Great Gatsby',                        7, 6, '9780743273565', 1925, 4);

SELECT * FROM books;

-- 4. Insert into members table
INSERT INTO members (full_name, email, phone, membership_date) VALUES
('John Smith', 'john.smith@email.com', '08012345678', '2024-01-15'),
('Aisha Bello', 'aisha.bello@email.com', '09087654321', '2024-02-01'),
('Michael Chen', 'michael.chen@email.com', '07098765432', '2024-01-20'),
('Fatima Yusuf', 'fatima.yusuf@email.com', '08123456789', '2024-03-10'),
('David Okon', 'david.okon@email.com', '08055555555', '2023-12-05'),
('Sarah Johnson', 'sarah.j@email.com', '09011112222', '2024-02-15'),
('Emmanuel Adebayo', 'emmanuel.a@email.com', '07033334444', '2024-01-08'),
('Priya Sharma', 'priya.sharma@email.com', '08177778888', '2024-03-05'),
('Ahmed Khan', 'ahmed.khan@email.com', '08099998888', '2024-02-20'),
('Sophia Lee', 'sophia.lee@email.com', '09022223333', '2024-01-25');

SELECT * FROM members;

-- 5. Insert into book_loans table (Borrowing Records)
INSERT INTO book_loans (book_id, member_id, borrow_date, due_date, return_date, status) VALUES
(31, 1, '2025-03-01', '2025-03-15', '2025-03-12', 'Returned'),
(33, 2, '2025-03-05', '2025-03-20', NULL, 'Borrowed'),
(35, 3, '2025-03-10', '2025-03-25', '2025-03-22', 'Returned'),
(32, 4, '2025-03-12', '2025-03-27', NULL, 'Borrowed'),
(38, 1, '2025-03-15', '2025-03-30', '2025-03-28', 'Returned'),
(40, 5, '2025-03-18', '2025-04-02', NULL, 'Borrowed'),
(34, 6, '2025-03-20', '2025-04-04', '2025-04-01', 'Returned'),
(37, 7, '2025-03-22', '2025-04-06', NULL, 'Borrowed'),
(39, 8, '2025-03-25', '2025-04-09', '2025-04-05', 'Returned'),
(36, 2, '2025-03-28', '2025-04-12', NULL, 'Borrowed'),
(41, 9, '2025-04-01', '2025-04-15', '2025-04-10', 'Returned');

SELECT * FROM book_loans;

SELECT 
    (SELECT COUNT(*) FROM books) AS total_books,
    (SELECT COUNT(*) FROM members) AS total_members,
    (SELECT COUNT(*) FROM book_loans) AS total_loans;

-- Most Borrowed Books (Top 5)
SELECT 
    b.title,
    a.author_name,
    COUNT(*) AS times_borrowed
FROM book_loans bl
JOIN books b ON bl.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
GROUP BY b.book_id, b.title, a.author_name
ORDER BY times_borrowed DESC
LIMIT 5;

-- Most active member

SELECT 
    m.full_name,
    COUNT(*) AS books_borrowed
FROM book_loans bl
JOIN members m ON bl.member_id = m.member_id
GROUP BY m.member_id, m.full_name
ORDER BY books_borrowed DESC
LIMIT 5;

-- Overdue books
SELECT 
    m.full_name,
    b.title,
    bl.borrow_date,
    bl.due_date
FROM book_loans bl
JOIN members m ON bl.member_id = m.member_id
JOIN books b ON bl.book_id = b.book_id
WHERE bl.return_date IS NULL 
  AND bl.due_date < CURDATE();
  
-- Average borrowing duration
SELECT 
    ROUND(AVG(DATEDIFF(return_date, borrow_date)), 1) AS avg_borrowing_days
FROM book_loans
WHERE return_date IS NOT NULL;

-- Books borrowed per category
SELECT 
    c.category_name,
    COUNT(*) AS books_borrowed
FROM book_loans bl
JOIN books b ON bl.book_id = b.book_id
JOIN categories c ON b.category_id = c.category_id
GROUP BY c.category_name
ORDER BY books_borrowed DESC;

-- popular authors(most borrowed)
SELECT 
    a.author_name,
    COUNT(*) AS times_borrowed
FROM book_loans bl
JOIN books b ON bl.book_id = b.book_id
JOIN authors a ON b.author_id = a.author_id
GROUP BY a.author_name
ORDER BY times_borrowed DESC
LIMIT 3;

-- Members that never returned a book
SELECT 
    m.full_name,
    COUNT(*) AS unreturned_books
FROM book_loans bl
JOIN members m ON bl.member_id = m.member_id
WHERE bl.return_date IS NULL
GROUP BY m.member_id, m.full_name
ORDER BY unreturned_books DESC;

-- Monthly borring trends
SELECT 
    MONTHNAME(borrow_date) AS month,
    COUNT(*) AS total_borrowings
FROM book_loans
GROUP BY 
    MONTH(borrow_date),
    MONTHNAME(borrow_date)
ORDER BY 
    MONTH(borrow_date);
    
-- Books that have never been borrowed
SELECT 
    b.title,
    a.author_name
FROM books b
LEFT JOIN book_loans bl ON b.book_id = bl.book_id
JOIN authors a ON b.author_id = a.author_id
WHERE bl.book_id IS NULL
ORDER BY b.title;
