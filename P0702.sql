----------1.a----------
CREATE DATABASE RoyalProducts;
USE RoyalProducts;


---------1.b, 1.c------------
CREATE TABLE rp_reps (
    rep_id INT PRIMARY KEY,
    last_name VARCHAR(50),
    first_name VARCHAR(50),
    street VARCHAR(50),
    rep_city VARCHAR(50),
    rep_state CHAR(2),
    zip VARCHAR(10),
    commission DECIMAL(10, 2),
    rate DECIMAL(5, 2)
);

CREATE TABLE rp_customers (
    customer_id     INT PRIMARY KEY,
    customer_name   VARCHAR (255),
    street          VARCHAR (50),
    cust_city       varchar (50),
    cust_state      CHAR (2),
    zip             VARCHAR (10),
    balance         DECIMAL (10,2),
    credit_limit    NUMERIC (10,2),
    rep_id          INT
    FOREIGN KEY (rep_id) REFERENCES rp_reps(rep_id)
);

CREATE TABLE rp_orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES rp_customers(customer_id)
);

CREATE TABLE rp_products (
    product_code CHAR(5) PRIMARY KEY,
    description VARCHAR(255),
    category CHAR(2),
    suggested_price DECIMAL(10, 2)
);

CREATE TABLE rp_order_lines (
    order_id INT,
    product_code CHAR(5),
    qty_ordered INT,
    price_paid DECIMAL(10, 2),
    PRIMARY KEY (order_id, product_code),
    FOREIGN KEY (order_id) REFERENCES rp_orders(order_id),
    FOREIGN KEY (product_code) REFERENCES rp_products(product_code)
);

CREATE TABLE rp_warehouses (
    warehouse_id INT PRIMARY KEY,
    whse_city VARCHAR(50)
);

CREATE TABLE rp_inventory (
    warehouse_id INT,
    product_code CHAR(5),
    qoh INT,
    PRIMARY KEY (warehouse_id, product_code),
    FOREIGN KEY (warehouse_id) REFERENCES rp_warehouses(warehouse_id),
    FOREIGN KEY (product_code) REFERENCES rp_products(product_code)
);

------------1.e-------------
INSERT INTO rp_reps (rep_id, last_name, first_name, street, rep_city, rep_state, zip, commission, rate) 
VALUES (20, 'Culp', 'Betty', '1275 Main St', 'Detroit', 'MI', '48288', 20542.50, 0.05);

INSERT INTO rp_reps (rep_id, last_name, first_name, street, rep_city, rep_state, zip, commission, rate) 
VALUES (35, 'Manis', 'Richard', '532 Jackson', 'Toronto', 'ON', 'M5V2K1', 39216.00, 0.07);

INSERT INTO rp_reps (rep_id, last_name, first_name, street, rep_city, rep_state, zip, commission, rate) 
VALUES (65, 'Large', 'Tom', '1626 Taylor', 'Chicago', 'IL', '60099', 23487.00, 0.05);


-------------1.f-----------
INSERT INTO rp_warehouses VALUES (100, 'Chicago');
INSERT INTO rp_warehouses VALUES (200, 'Detroit');
INSERT INTO rp_warehouses VALUES (300, 'Toronto');


-----------1.d--------------
INSERT INTO rp_customers VALUES
(148,'Al''s Appliance and Sport','2837 Greenway','Detroit','MI','48244',6550.00,7500.00,20),
(282,'Brookings Direct','3827 Devon','Toronto','ON','M5V7F5',431.50,10000.00,35),
(356,'Ferguson''s','382 Wildwood','Northfield','MI','33146',5785.00,7500.00,20),
(408,'The Everything Shop','1828 Raven','Crystal','IL','60082',5285.25,5000.00,65),
(462,'Bargains Galore','3829 Central','Toronto','ON','M5V9G4',3412.00,10000.00,35),
(524,'Kline''s','838 Ridgeland','Lakeside','IL','60091',12762.00,15000.00,65),
(608,'Johnson''s Department Store','372 Oxford','Toronto','ON','M5V9S4',2106.00,10000.00,35),
(687,'Lee''s Sport and Appliance','282 Evergreen','Troy','MI','48283',2851.00,5000.00,20),
(725,'Deerfield''s Four Seasons','282 Columbia','Toronto','ON','M5V9J5',248.00,7500.00,35),
(842,'All Season','28 Lakeview','Grove City','IL','60081',8221.00,7500.00,65);

INSERT INTO rp_products VALUES
('AT94','Iron','HW',24.95),
('BV06','Home Gym','SG',794.95),
('CD52','Microwave Oven','AP',165.00),
('DL71','Cordless Drill','HW',129.95),
('DR93','Gas Range','AP',495.00),
('DW11','Washer','AP',399.99),
('FD21','Stand Mixer','HW',159.95),
('KL62','Dryer','AP',349.95),
('KT03','Dishwasher','AP',595.00),
('KV29','Treadmill','SG',1390.00);

INSERT INTO rp_orders VALUES
(21608,'2021-01-20',148),
(21610,'2021-02-20',356),
(21613,'2021-02-21',408),
(21614,'2021-03-21',282),
(21617,'2021-03-22',608),
(21619,'2021-04-23',148),
(21623,'2021-04-23',608);

INSERT INTO rp_order_lines VALUES
(21608,'AT94',11,21.95),
(21610,'DR93',1,495.00),
(21610,'DW11',1,399.99),
(21613,'KL62',4,329.95),
(21614,'KT03',2,595.00),
(21617,'BV06',2,794.95),
(21617,'CD52',4,150.00),
(21619,'DR93',1,495.00),
(21623,'KV29',2,1290.00);

INSERT INTO rp_inventory VALUES
(100, 'AT94', 43),
(100, 'BV06', 24),
(100, 'CD52', 21),
(100, 'DL71', 11),
(100, 'DR93', 31),
(100, 'DW11', 12),
(100, 'FD21', 12),
(100, 'KL62', 34),
(100, 'KT03', 23),
(100, 'KV29', 25),
(200, 'AT94', 43),
(200, 'BV06', 34),
(200, 'CD52', 11),
(200, 'DL71', 41),
(200, 'DR93', 21),
(300, 'DW11', 42),
(300, 'FD21', 52),
(300, 'KL62', 14),
(300, 'KT03', 53),
(300, 'KV29', 35);


-----------------1.g---------------
UPDATE rp_customers SET balance = 4285.25 WHERE customer_id = 408;
UPDATE rp_customers SET balance = 6221.00 WHERE customer_id = 842;
UPDATE rp_products SET suggested_price = suggested_price * 1.085 WHERE category = 'AP';
DELETE FROM rp_products WHERE description = 'Cordless Drill';
UPDATE rp_customers SET credit_limit = 14500.00 WHERE customer_name = 'Brookings Direct';
