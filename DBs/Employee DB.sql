CREATE DATABASE Employee;
USE Employee;
GO

-- create schemas
CREATE SCHEMA hr;
go

CREATE SCHEMA projects;
go



CREATE TABLE hr.departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(255) NULL
);


CREATE TABLE hr.employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(255) NULL,
    last_name VARCHAR(255) NULL,
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES hr.departments(department_id) ON DELETE SET NULL,
    FOREIGN KEY (manager_id) REFERENCES hr.employees(employee_id) ON DELETE NO ACTION, -- Change to NO ACTION
    -- FOREIGN KEY (manager_id) REFERENCES hr.employees(employee_id) ON DELETE SET NULL -- Or change to SET NULL if appropriate
);



CREATE TABLE projects.projects (
    project_id INT IDENTITY(1,1) PRIMARY KEY,
    project_name VARCHAR(255) NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES hr.departments(department_id) ON DELETE SET NULL
);


CREATE TABLE projects.employee_projects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES hr.employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects.projects(project_id) ON DELETE CASCADE
);


CREATE TABLE hr.salaries (
    employee_id INT,
    salary DECIMAL(10, 2) NULL,
    effective_date DATE NULL,
    PRIMARY KEY (employee_id, effective_date),
    FOREIGN KEY (employee_id) REFERENCES hr.employees(employee_id) ON DELETE CASCADE
);


CREATE TABLE hr.performance_reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    review_date DATE NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES hr.employees(employee_id) ON DELETE CASCADE
);


--Insert Sample Data

--Insert Departments
INSERT INTO hr.departments (department_name)
VALUES ('Civil Engineering'), ('Software Engineering'), ('Legal Marketing'), ('HR'), ('Finance');


--Insert Employees
INSERT INTO hr.employees (first_name, last_name, department_id, manager_id)
VALUES 
('Khaled', 'Abdel Nasser', 1, NULL),
('Mohamed', 'Abdel Nasser', 2, 1),
('Ahmed', 'Abdel Nasser', 2, 1),
('Hassan', 'Abdel Nasser', 3, 1),
('Sara', 'El-Sayed', 4, 2),
('Fatma', 'Ali', 5, 2);



--Insert Projects
INSERT INTO projects.projects (project_name, department_id)
VALUES 
('New House', 1),
('New Website', 2),
('Product Launch', 3),
('System Upgrade', 2),
('Recruitment Drive', 4),
('Annual Budget', 5);


--Insert Employee Projects
INSERT INTO projects.employee_projects (employee_id, project_id)
VALUES 
(1, 1),
(2, 2),
(2, 4),
(3, 2),
(4, 3),
(5, 5),
(6, 6);



--Insert Salaries
INSERT INTO hr.salaries (employee_id, salary, effective_date)
VALUES 
(1, 5000.00, '2023-01-01'),
(2, 6000.00, '2023-01-01'),
(3, 6000.00, '2023-01-01'),
(4, 5500.00, '2023-01-01'),
(5, 4500.00, '2023-01-01'),
(6, 7000.00, '2023-01-01');



--Insert Performance Reviews
INSERT INTO hr.performance_reviews (employee_id, review_date, rating, comments)
VALUES 
(1, '2023-06-01', 4, 'Excellent performance'),
(2, '2023-06-01', 5, 'Outstanding performance'),
(3, '2023-06-01', 4, 'Very good performance'),
(4, '2023-06-01', 3, 'Good performance'),
(5, '2023-06-01', 4, 'Very good performance'),
(6, '2023-06-01', 5, 'Outstanding performance');