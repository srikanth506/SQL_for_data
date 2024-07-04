CREATE DATABASE BD;
USE BD;

CREATE TABLE bd_stores(
    store_id INT,
    city VARCHAR(40),
    store_mgr_id INT 
);

CREATE TABLE bd_departments(
    department_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE bd_employees(
    employee_id INT NOT NULL,
    first_name VARCHAR (30) NOT NULL,
    last_name VARCHAR (30) NOT NULL,
    birt_date DATE NOT NULL,
    soc_ins_no DECIMAL (9,0) NOT NULL,
    sex VARCHAR (1) NOT NULL,
    pension_contr INT NOT NULL DEFAULT 0,
    hire_date DATE NOT NULL DEFAULT CURRENT_DATE,
    job_class VARCHAR (1) NOT NULL DEFAULT 'T',
    job_level DECIMAL (1,0) NOT NULL,
    salary DECIMAL (9,2) NOT NULL,
    bonus DECIMAL (9,2),
    commission DECIMAL (9,2),
    coach_id INT,
    store_id INT NOT NULL,
    department_id INT NOT NULL DEFAULT 300
);

CREATE TABLE bd_store_departments (
    store_id INT NOT NULL,
    department_id INT NOT NULL,
    dept_mgr_id INT NOT NULL
);

ALTER TABLE bd_stores MODIFY store_id INT NOT NULL;
ALTER TABLE bd_stores MODIFY city VARCHAR (40) NOT NULL;

ALTER TABLE bd_stores ADD CONSTRAINT bd_stores_pk PRIMARY KEY (store_id);
ALTER TABLE bd_stores ADD CONSTRAINT bd_stores_city_uk UNIQUE (city);
ALTER TABLE bd_stores ADD CONSTRAINT bd_stores_store_mgr_id_fk FOREIGN KEY (store_mgr_id) REFERENCES bd_employees (employee_id);

ALTER TABLE bd_departments ADD CONSTRAINT bd_departments_pk PRIMARY KEY (department_id);
ALTER TABLE bd_departments ADD CONSTRAINT bd_departments_department_name_uk UNIQUE (department_name);

ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_pk PRIMARY KEY (employee_id);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_soc_ins_no_uk UNIQUE (soc_ins_no);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_coach_id_fk FOREIGN KEY (coach_id) REFERENCES bd_employees(employee_id);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_store_id_fk FOREIGN KEY (store_id) REFERENCES bd_stores(store_id);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_department_id_fk FOREIGN KEY (department_id) REFERENCES bd_departments(department_id);

ALTER TABLE bd_store_departments ADD CONSTRAINT bd_store_departments_pk PRIMARY KEY (store_id,department_id);
ALTER TABLE bd_store_departments ADD CONSTRAINT bd_store_departments_store_id_fk FOREIGN KEY (store_id) REFERENCES bd_stores (store_id);
ALTER TABLE bd_store_departments ADD CONSTRAINT bd_store_departments_department_id_fk FOREIGN KEY (department_id) REFERENCES bd_departments (department_id);
ALTER TABLE bd_store_departments ADD CONSTRAINT bd_store_departments_dept_mgr_id_fk FOREIGN KEY (dept_mgr_id) REFERENCES bd_employees (employee_id);

ALTER TABLE bd_stores ADD CONSTRAINT bd_stores_store_id_range_ck CHECK (store_id BETWEEN 11 AND 99);
ALTER TABLE bd_departments ADD CONSTRAINT bd_departments_department_id_range_ck CHECK (department_id BETWEEN 300 AND 399);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_birth_date_ck CHECK (birt_date >= '1980-01-01');
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_soc_ins_no_range_ck CHECK (soc_ins_no BETWEEN 1 AND 999999999);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_gender_ck CHECK (sex IN ('M','F'));
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_pension_contr_ck CHECK (pension_contr IN (0,1));
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_hire_date_birth_ck CHECK (hire_date > birt_date);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_job_class_ck CHECK (job_class IN ('T','J','C','M'));
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_job_level_range_ck CHECK (job_level BETWEEN 1 AND 9);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_salary_ck CHECK (salary <= 125000.00);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_salary_commission_ck CHECK (salary>commission AND commission <salary*0.085);
ALTER TABLE bd_employees ADD CONSTRAINT bd_employees_bonus_commission_ck CHECK ((bonus IS NOT NULL AND commission IS NULL AND bonus <> 0) OR (bonus IS NULL AND commission IS NOT NULL AND commission <> 0));