DROP TABLE employees IF EXISTS CASCADE;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    school VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, first_name, last_name, school, hire_date, salary) VALUES
(1, 'Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
(2, 'Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
(3, 'Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
(4, 'Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
(5, 'Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
(6, 'Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);
