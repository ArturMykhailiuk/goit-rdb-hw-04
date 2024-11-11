--1--
-- Створення бази даних
CREATE DATABASE LibraryManagement;
-- Використання бази даних
USE LibraryManagement;
-- Створення таблиці "authors"
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);
-- Створення таблиці "genres"
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);
-- Створення таблиці "books"
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors (author_id),
    FOREIGN KEY (genre_id) REFERENCES genres (genre_id)
);
-- Створення таблиці "users"
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);
-- Створення таблиці "borrowed_books"
CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books (book_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

--2--
USE LibraryManagement;
-- Заповнення таблиці "authors"
INSERT INTO
    authors (author_name)
VALUES ('J.K. Rowling'), ('George R.R. Martin'), ('J.R.R. Tolkien');
-- Заповнення таблиці "genres"
INSERT INTO
    genres (genre_name)
VALUES ('Fantasy'), ('Science Fiction'), ('Mystery');
-- Заповнення таблиці "books"
INSERT INTO
    books (title, publication_year, author_id, genre_id)
VALUES ('Harry Potter and the Philosopher\'s Stone', 1997, 1, 1),
       ('A Game of Thrones', 1996, 2, 1),
       ('The Hobbit', 1937, 3, 1);
-- Заповнення таблиці "users"
INSERT INTO
    users (username, email)
VALUES ('john_doe', 'john_doe@example.com'),
    ('jane_smith', 'jane_smith@example.com'),
    ('alice_jones', 'alice_jones@example.com');
-- Заповнення таблиці "borrowed_books"
INSERT INTO
    borrowed_books ( book_id, user_id, borrow_date, return_date)
VALUES (1, 1, '2023-01-01', '2023-01-15'),
       (2, 2, '2023-02-01', '2023-02-15'),
       (3, 3, '2023-03-01', '2023-03-15');

--3--
USE mydb_03;

SELECT
    orders.id as order_id,
    orders.date as order_date,
    customers.id as customer_id,
    customers.name as customer_name,
    employees.employee_id,
    employees.first_name AS employee_first_name,
    employees.last_name AS employee_last_name,
    shippers.id as shipper_id,
    shippers.name as shipper_name,
    suppliers.id as supplier_id,
    suppliers.name as supplier_name,
    categories.id as category_id,
    categories.name as category_name,
    products.id as product_id,
    products.name as product_name,
    order_details.quantity
FROM
    order_details
    INNER JOIN orders ON order_details.order_id = orders.id
    INNER JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    INNER JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    INNER JOIN categories ON products.category_id = categories.id
    INNER JOIN suppliers ON products.supplier_id = suppliers.id;

--4.1--
USE mydb_03;

SELECT COUNT(*)
FROM
    order_details
    INNER JOIN orders ON order_details.order_id = orders.id
    INNER JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    INNER JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    INNER JOIN categories ON products.category_id = categories.id
    INNER JOIN suppliers ON products.supplier_id = suppliers.id;

--4.2--
USE mydb_03;

SELECT *
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id;

--4.3--
USE mydb_03;

SELECT *
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id
WHERE
    employees.employee_id > 3 AND employees.employee_id <= 10

    --4.4--
SELECT categories.name, COUNT(*) AS row_count, AVG(order_details.quantity) AS average_quantity
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name;

--4.5--
SELECT categories.name, COUNT(*) AS row_count, AVG(order_details.quantity) AS average_quantity
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING AVG(order_details.quantity) > 21;

--4.6--
SELECT categories.name, COUNT(*) AS row_count, AVG(order_details.quantity) AS average_quantity
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING AVG(order_details.quantity) > 21
ORDER BY row_count DESC;

--4.7--
SELECT categories.name, COUNT(*) AS row_count, AVG(order_details.quantity) AS average_quantity
FROM
    orders
    RIGHT JOIN order_details ON order_details.order_id = orders.id
    RIGHT JOIN customers ON orders.customer_id = customers.id
    INNER JOIN employees ON orders.employee_id = employees.employee_id
    RIGHT JOIN shippers ON orders.shipper_id = shippers.id
    INNER JOIN products ON order_details.product_id = products.id
    LEFT JOIN categories ON products.category_id = categories.id
    LEFT JOIN suppliers ON products.supplier_id = suppliers.id
WHERE employees.employee_id > 3 AND employees.employee_id <= 10
GROUP BY categories.name
HAVING AVG(order_details.quantity) > 21
ORDER BY row_count DESC
LIMIT 4 OFFSET 1;