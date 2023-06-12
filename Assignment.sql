#-------------------------------------------------------#
#Target DBMS:      MySQL                                #
#Project Name      CarDealershipDtabase                 #
#-------------------------------------------------------#
USE sys;
DROP DATABASE IF EXISTS car_dealership;

CREATE DATABASE car_dealership;
-- switch to car_dealership after creating
-- so that tables are created in the correct database

USE car_dealership;

-- Table 1: dealerships
CREATE TABLE dealerships (
  dealership_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  address VARCHAR(50),
  phone VARCHAR(12)
);

-- Table 2: vehicles
CREATE TABLE vehicles (
  VIN VARCHAR(17) PRIMARY KEY,
  make VARCHAR(50),
  model VARCHAR(50),
  year INT,
  price DECIMAL(10,2),
  SOLD BOOLEAN DEFAULT FALSE
);

-- Table 3: inventory
CREATE TABLE inventory (
  dealership_id INT,
  VIN VARCHAR(17),
  FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id),
  FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

-- Table 4: sales_contracts
CREATE TABLE sales_contracts (
  contract_id INT AUTO_INCREMENT PRIMARY KEY,
  VIN VARCHAR(17),
  customer_name VARCHAR(50),
  contract_date DATE,
  FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

-- Table 5: lease_contracts (OPTIONAL)
CREATE TABLE lease_contracts (
  contract_id INT AUTO_INCREMENT PRIMARY KEY,
  VIN VARCHAR(17),
  customer_name VARCHAR(50),
  contract_date DATE,
  FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);

-- Inserting sample data
INSERT INTO dealerships (name, address, phone)
VALUES ('KIA Motors', '123 Main St', '743-866-9750'),
       ('TOYOTA Autos', '456 Elm St', '097-654-3540');

INSERT INTO vehicles (VIN, make, model, year, price, SOLD)
VALUES ('1HGCM82633A123456', 'Honda', 'Accord', 2022, 25000.00, FALSE),
       ('5XYZ123456A789012', 'Toyota', 'Camry', 2021, 27000.00, FALSE),
       ('9ABC987654B321098', 'Ford', 'Mustang', 2023, 35000.00, TRUE);

INSERT INTO inventory (dealership_id, VIN)
VALUES (1, '1HGCM82633A123456'),
       (1, '5XYZ123456A789012'),
       (2, '9ABC987654B321098');

-- Get all dealerships
SELECT * 
FROM dealerships;

-- Find all vehicles for a specific dealership
SELECT v.*
FROM dealerships d
JOIN inventory i ON d.dealership_id = i.dealership_id
JOIN vehicles v ON i.VIN = v.VIN
WHERE d.name = 'KIA Motors';

-- find car by VIN
SELECT * 
FROM vehicles 
WHERE VIN = '5XYZ123456A789012';
	
-- find the dealership where a certain car is located, by VIN
SELECT d.*
FROM dealerships d
JOIN inventory i ON d.dealership_id = i.dealership_id
JOIN vehicles v ON i.VIN = v.VIN
WHERE v.VIN = '5XYZ123456A789012';

-- find all dealerships that have a certain car type
SELECT d.*
FROM dealerships d
JOIN inventory i ON d.dealership_id = i.dealership_id
JOIN vehicles v ON i.VIN = v.VIN
WHERE v.make = 'HONDA' AND v.model = 'ACCORD';

-- get all sales information for a specific dealer for a specific date range
SELECT sc.*
FROM dealerships d
JOIN sales_contracts sc ON d.dealership_id = sc.dealership_id
WHERE d.name = 'KIA Motors'
  AND sc.contract_date >= 'START_DATE'
  AND sc.contract_date <= 'END_DATE';

