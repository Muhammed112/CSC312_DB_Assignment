CREATE DATABASE butcher_shop_db;
USE butcher_shop_db;

#Table 1: Employees
CREATE TABLE employees (
	employee_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    job_role VARCHAR(50),
    hire_date VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO employees (employee_id, first_name, last_name, phone, email, job_role, hire_date, is_active) VALUES
('emp01', 'Muhammed', 'Dawood', '0214289301', 'muhammed.dawood@stepinsidemeat.co.za', 'Manager', '2026-01-12', FALSE),
('emp02', 'Ayesha', 'Jacobs', '0823914057', 'ayesha.jacobs@stepinsidemeat.co.za', 'Buyer', '2026-02-03', TRUE),
('emp03', 'Zaheer', 'Adams', '0217891243', 'zaheer.adams@stepinsidemeat.co.za', 'Stock Controller', '2026-02-18', TRUE),
('emp04', 'Fatima', 'Davids', '0765108294', 'fatima.davids@stepinsidemeat.co.za', 'Cashier', '2026-03-09', TRUE),
('emp05', 'Daniel', 'Petersen', '0215546018', 'daniel.petersen@stepinsidemeat.co.za', 'Delivery Driver', '2026-04-20', FALSE),
('emp06', 'Yusuf', 'Khan', '0839247150', 'yusuf.khan@stepinsidemeat.co.za', 'Butcher', '2026-05-11', TRUE);

#Table 2: Customers
CREATE TABLE customers (
	customer_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    joined_date VARCHAR(100),
    loyalty_points INT DEFAULT 0
);

INSERT INTO customers (customer_id, first_name, last_name, phone, email, address, joined_date, loyalty_points) VALUES
('cus01', 'Imraan', 'Abrahams', '0219138472', 'imraan.abrahams@gmail.com', '12 Market Road, Mitchells Plain, Cape Town', '2026-05-06', 120),
('cus02', 'Sarah', 'Williams', '0614029385', 'sarah.williams@outlook.com', '24 Main Road, Athlone, Cape Town', '2026-05-22', 95),
('cus03', 'Zainab', 'Isaacs', '0216852039', 'zainab.isaacs@gmail.com', '8 Church Street, Bellville, Cape Town', '2026-06-15', 65),
('cus04', 'Thabo', 'Mokoena', '0721984365', 'thabo.mokoena@outlook.com', '17 Station Road, Woodstock, Cape Town', '2026-07-02', 40),
('cus05', 'Nadia', 'Parker', '0218527491', 'nadia.parker@icloud.com', '6 School Road, Grassy Park, Cape Town', '2026-07-19', 55),
('cus06', 'Ashley', 'Brown', '0846391028', 'ashley.brown@gmail.com', '31 Park Avenue, Lansdowne, Cape Town', '2026-08-10', 30),
('cus07', 'Rashied', 'Hendricks', '0213975820', 'rashied.hendricks@outlook.com', '4 Rose Street, Bo Kaap, Cape Town', '2026-09-01', 20),
('cus08', 'Lerato', 'Dlamini', '0792846153', 'lerato.dlamini@proton.me', '15 Victoria Road, Plumstead, Cape Town', '2026-09-23', 10);

#Table 3: Suppliers
CREATE TABLE suppliers (
	supplier_id VARCHAR(50) PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
	phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
	lead_days INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE
);

INSERT INTO suppliers (supplier_id, supplier_name, contact_person, phone, email, address, lead_days, is_active) VALUES
('sup01', 'Cape Meat Suppliers', 'Ahmed Daniels', '0217129046', 'orders@capemeatsuppliers.co.za', '18 Industrial Road, Epping, Cape Town', 3, TRUE),
('sup02', 'Gauteng Poultry Co.', 'Nomsa Nkosi', '0638153972', 'sales@gautengpoultry.co.za', '42 Supply Avenue, Johannesburg', 2, TRUE),
('sup03', 'Karoo Lamb Distributors', 'Pieter Botha', '0214618239', 'dispatch@karoolamb.co.za', '9 Abattoir Road, Beaufort West', 5, TRUE);

#Table 4: Products
CREATE TABLE products (
	product_id VARCHAR(50) PRIMARY KEY,
    supplier_id VARCHAR(50),
    sku VARCHAR(30) UNIQUE NOT NULL,
    product_name VARCHAR(100) NOT NULL,
	category VARCHAR(50),
    unit VARCHAR(20),
    price DECIMAL(10,2),
    minimum_stock_level DECIMAL(10,3),
    target_stock_level DECIMAL(10,3),
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

INSERT INTO products (product_id, supplier_id, sku, product_name, category, unit, price, minimum_stock_level, target_stock_level, is_active) VALUES
('prod01', 'sup01', 'BEEF-001', 'Beef Mince Lean', 'Beef', 'kg', 130.00, 8.000, 48.000, TRUE),
('prod02', 'sup01', 'BEEF-002', 'Beef Sirloin Steak', 'Beef', 'kg', 150.00, 8.000, 45.000, TRUE),
('prod03', 'sup01', 'BEEF-003', 'Beef Ribs', 'Beef', 'kg', 125.00, 6.000, 35.000, TRUE),
('prod04', 'sup01', 'BEEF-004', 'Beef Brisket', 'Beef', 'kg', 140.00, 6.000, 30.000, TRUE),
('prod05', 'sup01', 'BEEF-005', 'Beef Tenderloin', 'Beef', 'kg', 190.00, 5.000, 40.000, TRUE),
('prod06', 'sup02', 'CHKN-001', 'Chicken Breast Fillets', 'Poultry', 'kg', 95.00, 10.000, 40.000, TRUE),
('prod07', 'sup02', 'CHKN-002', 'Chicken Wings', 'Poultry', 'kg', 80.00, 8.000, 35.000, TRUE),
('prod08', 'sup02', 'CHKN-003', 'Chicken Drumsticks', 'Poultry', 'kg', 65.00, 10.000, 45.000, TRUE),
('prod09', 'sup02', 'CHKN-004', 'Whole Chicken', 'Poultry', 'kg', 60.00, 8.000, 30.000, TRUE),
('prod10', 'sup02', 'CHKN-005', 'Chicken Livers', 'Poultry', 'kg', 55.00, 20.000, 35.000, TRUE),
('prod11', 'sup03', 'LAMB-001', 'Lamb Chops', 'Lamb', 'kg', 180.00, 6.000, 30.000, TRUE),
('prod12', 'sup03', 'LAMB-002', 'Lamb Leg', 'Lamb', 'kg', 195.00, 18.000, 30.000, TRUE),
('prod13', 'sup03', 'LAMB-003', 'Lamb Shoulder', 'Lamb', 'kg', 150.00, 5.000, 25.000, TRUE),
('prod14', 'sup03', 'LAMB-004', 'Lamb Stew Cuts', 'Lamb', 'kg', 145.00, 6.000, 30.000, TRUE),
('prod15', 'sup03', 'LAMB-005', 'Lamb Ribs', 'Lamb', 'kg', 160.00, 5.000, 25.000, TRUE);

#Table 5: Equipment
CREATE TABLE equipment (
	equipment_id VARCHAR(50) PRIMARY KEY,
    employee_id VARCHAR(50),
    asset_tag VARCHAR(30) UNIQUE NOT NULL,
    equipment_name VARCHAR(100),
    equipment_type VARCHAR(50),
    serial_number VARCHAR(50),
    location VARCHAR(100),
    purchase_date VARCHAR(100),
    last_service_date VARCHAR(100),
    next_service_date VARCHAR(100),
    equipment_status VARCHAR(30),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO equipment (equipment_id, employee_id, asset_tag, equipment_name, equipment_type, serial_number, location, purchase_date, last_service_date, next_service_date, equipment_status) VALUES
('eqp01', 'emp03', 'EQ-BF-001', 'Beef Storage Freezer', 'Freezer', 'FRZ-BEEF-001', 'Cold Store A', '2026-01-20', '2026-08-17', '2026-11-17', 'Operational'),
('eqp02', 'emp03', 'EQ-PF-002', 'Poultry Storage Freezer', 'Freezer', 'FRZ-POUL-002', 'Cold Store B', '2026-02-12', '2026-08-24', '2026-11-24', 'Operational'),
('eqp03', 'emp03', 'EQ-LF-003', 'Lamb Storage Freezer', 'Freezer', 'FRZ-LAMB-003', 'Cold Store C', '2026-03-03', '2026-09-02', '2026-12-02', 'Operational'),
('eqp04', 'emp06', 'EQ-CH-004', 'Fresh Meat Display Chiller', 'Refrigerator', 'CHILL-004', 'Retail Display', '2026-04-15', '2026-09-14', '2026-12-14', 'Operational'),
('eqp05', 'emp03', 'EQ-SC-005', 'Digital Stock Weighing Scale', 'Scale', 'SCALE-005', 'Receiving Counter', '2026-05-07', '2026-09-21', '2026-12-21', 'Operational');

#Table 6: Orders
CREATE TABLE orders (
	order_id VARCHAR(50) PRIMARY KEY,
    supplier_id VARCHAR(50),
    employee_id VARCHAR(50),
    order_date DATETIME,
    expected_delivery_date DATE,
    order_status VARCHAR(30),
    notes TEXT,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO orders (order_id, supplier_id, employee_id, order_date, expected_delivery_date, order_status, notes) VALUES
('ord01', 'sup01', 'emp02', '2026-09-25 08:15:00', '2026-09-28', 'Received', 'Received in full; batch records capture receipt.'),
('ord02', 'sup02', 'emp02', '2026-09-26 09:15:00', '2026-09-28', 'Received', 'Received in full; batch records capture receipt.'),
('ord03', 'sup03', 'emp02', '2026-09-27 10:15:00', '2026-10-02', 'Received', 'Received in full; batch records capture receipt.'),
('ord04', 'sup01', 'emp02', '2026-09-28 11:15:00', '2026-10-01', 'Received', 'Received in full; batch records capture receipt.'),
('ord05', 'sup02', 'emp02', '2026-09-29 08:15:00', '2026-10-01', 'Received', 'Received in full; batch records capture receipt.'),
('ord06', 'sup01', 'emp02', '2026-09-30 09:15:00', '2026-10-03', 'Received', 'Received in full; batch records capture receipt.'),
('ord07', 'sup02', 'emp02', '2026-10-01 10:15:00', '2026-10-03', 'Received', 'Received in full; batch records capture receipt.'),
('ord08', 'sup03', 'emp02', '2026-10-07 11:15:00', '2026-10-12', 'Pending', 'Restock low lamb inventory; delivery expected 12 October.');

#Table 7: Order Details
CREATE TABLE order_details (
	order_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity DECIMAL(10,3),
    unit_cost DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_details (order_id, product_id, quantity, unit_cost) VALUES
('ord01', 'prod01', 48.000, 90.00),
('ord01', 'prod02', 43.000, 110.00);

#Table 8: Inventory Batches
CREATE TABLE inventory_batches (
	batch_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    employee_id VARCHAR(50),
    equipment_id VARCHAR(50),
    batch_code VARCHAR(50) UNIQUE NOT NULL,
    received_at VARCHAR(100),
    manufacture_date DATE,
    expiry_date DATE,
    quantity_received DECIMAL(10,3),
    quantity_on_hand DECIMAL(10,3),
    batch_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

INSERT INTO inventory_batches (batch_id, order_id, product_id, employee_id, equipment_id, batch_code, received_at, manufacture_date, expiry_date, quantity_received, quantity_on_hand, batch_status) VALUES
('bat01', 'ord01', 'prod01', 'emp03', 'eqp01', 'B001-20260928', '2026-09-28 09:00:00', '2026-09-27', '2026-12-26', 48.000, 42.750, 'Available'),
('bat02', 'ord01', 'prod02', 'emp03', 'eqp01', 'B002-20260928', '2026-09-28 10:30:00', '2026-09-27', '2026-12-26', 43.000, 39.250, 'Available'),
('bat03', 'ord02', 'prod06', 'emp01', 'eqp02', 'B006-20260928', '2026-09-28 11:00:00', '2026-09-27', '2026-12-26', 35.000, 30.500, 'Available'),
('bat04', 'ord02', 'prod07', 'emp01', 'eqp02', 'B007-20260928', '2026-09-28 09:30:00', '2026-09-27', '2026-12-26', 30.000, 26.750, 'Available'),
('bat05', 'ord03', 'prod11', 'emp06', 'eqp03', 'B011-20261002', '2026-10-02 10:00:00', '2026-10-01', '2026-12-30', 24.000, 21.500, 'Available'),
('bat06', 'ord03', 'prod12', 'emp06', 'eqp03', 'B012-20261002', '2026-10-02 11:30:00', '2026-10-01', '2026-12-30', 20.000, 16.000, 'Available'),
('bat07', 'ord04', 'prod03', 'emp04', 'eqp01', 'B003-20261001', '2026-10-01 09:00:00', '2026-09-30', '2026-12-29', 32.000, 25.500, 'Available'),
('bat08', 'ord04', 'prod04', 'emp04', 'eqp01', 'B004-20261001', '2026-10-01 10:30:00', '2026-09-30', '2026-12-29', 28.000, 23.750, 'Available'),
('bat09', 'ord05', 'prod08', 'emp02', 'eqp02', 'B008-20261001', '2026-10-01 11:00:00', '2026-09-30', '2026-12-29', 40.000, 35.000, 'Available'),
('bat10', 'ord05', 'prod09', 'emp02', 'eqp02', 'B009-20261001', '2026-10-01 09:30:00', '2026-09-30', '2026-12-29', 25.000, 22.250, 'Available'),
('bat11', 'ord06', 'prod05', 'emp05', 'eqp04', 'B005-20261003', '2026-10-03 10:00:00', '2026-10-02', '2026-10-11', 36.000, 31.500, 'Available'),
('bat12', 'ord07', 'prod10', 'emp05', 'eqp04', 'B010-20261003', '2026-10-03 11:30:00', '2026-10-02', '2026-10-11', 22.000, 18.750, 'Available');

#Table 9: Sales
CREATE TABLE sales (
	sale_id VARCHAR(50) PRIMARY KEY,
    employee_id VARCHAR(50),
    customer_id VARCHAR(50) NULL,
    sale_date VARCHAR(100),
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    sale_status VARCHAR(30),
    notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO sales (sale_id, employee_id, customer_id, sale_date, payment_method, payment_status, sale_status, notes) VALUES
('sal01', 'emp04', 'cus01', '2026-10-04 09:15:00', 'Card', 'Paid', 'Completed', 'Sale 1; customer delivery.'),
('sal02', 'emp06', 'cus02', '2026-10-04 11:30:00', 'Cash', 'Paid', 'Completed', 'Sale 2; counter collection.'),
('sal03', 'emp04', 'cus03', '2026-10-05 10:00:00', 'EFT', 'Paid', 'Completed', 'Sale 3; customer delivery.'),
('sal04', 'emp06', 'cus04', '2026-10-05 14:20:00', 'Card', 'Paid', 'Completed', 'Sale 4; counter collection.'),
('sal05', 'emp04', 'cus05', '2026-10-06 09:40:00', 'Cash', 'Paid', 'Completed', 'Sale 5; customer delivery.'),
('sal06', 'emp06', 'cus01', '2026-10-06 12:10:00', 'EFT', 'Paid', 'Completed', 'Sale 6; customer delivery.'),
('sal07', 'emp04', 'cus02', '2026-10-07 10:45:00', 'Card', 'Paid', 'Completed', 'Sale 7; customer delivery.'),
('sal08', 'emp06', NULL, '2026-10-08 10:30:00', 'Cash', 'Paid', 'Completed', 'Walk-in customer collected at counter.');

#Table 10: Sale Items
CREATE TABLE sale_items (
	sale_id VARCHAR(50),
    batch_id VARCHAR(50),
    quantity_sold DECIMAL(10,3),
    unit_selling_price DECIMAL(10,2),
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    PRIMARY KEY (sale_id, batch_id),
    FOREIGN KEY (sale_id) REFERENCES sales(sale_id),
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id)
);

INSERT INTO sale_items (sale_id, batch_id, quantity_sold, unit_selling_price, discount_amount) VALUES
('sal01', 'bat01', 5.250, 130.00, 0.00),
('sal02', 'bat02', 3.750, 150.00, 10.00),
('sal01', 'bat03', 4.500, 95.00, 0.00),
('sal02', 'bat04', 3.000, 80.00, 0.00),
('sal03', 'bat05', 2.500, 180.00, 15.00),
('sal03', 'bat06', 4.000, 195.00, 0.00),
('sal04', 'bat07', 6.000, 125.00, 0.00),
('sal05', 'bat08', 4.250, 140.00, 5.00),
('sal06', 'bat09', 5.000, 65.00, 0.00),
('sal07', 'bat10', 2.750, 60.00, 0.00),
('sal08', 'bat11', 4.500, 190.00, 0.00),
('sal08', 'bat12', 3.250, 55.00, 0.00);

#Table 11: Stock Checks
CREATE TABLE stock_checks (
	stock_check_id VARCHAR(50) PRIMARY KEY,
    employee_id VARCHAR(50),
    equipment_id VARCHAR(50),
    checked_at DATETIME,
    check_status VARCHAR(30),
    notes TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

INSERT INTO stock_checks (stock_check_id, employee_id, equipment_id, checked_at, check_status, notes) VALUES
('sto01', 'emp03', 'eqp05', '2026-10-06 17:00:00', 'Completed', 'Beef and poultry freezer count.'),
('sto02', 'emp05', 'eqp05', '2026-10-07 17:00:00', 'Completed', 'Poultry and lamb count; torn pack discarded.');

#Table 12: Stock Check Details
CREATE TABLE stock_check_details (
	stock_check_id VARCHAR(50),
    batch_id VARCHAR(50),
    expected_quantity DECIMAL(10,3),
    counted_quantity DECIMAL(10,3),
    condition_status VARCHAR(30),
    discrepancy_reason TEXT,
    PRIMARY KEY (stock_check_id, batch_id),
    FOREIGN KEY (stock_check_id) REFERENCES stock_checks(stock_check_id),
    FOREIGN KEY (batch_id) REFERENCES inventory_batches(batch_id)
);

INSERT INTO stock_check_details (stock_check_id, batch_id, expected_quantity, counted_quantity, condition_status, discrepancy_reason) VALUES
('sto01', 'bat01', 42.750, 42.750, 'Good', NULL),
('sto02', 'bat04', 27.000, 26.750, 'Damaged', '0.250 kg discarded after packaging damage; stock corrected.');

#Table 13: Audit Logs
CREATE TABLE audit_logs (
	log_id VARCHAR(50) PRIMARY KEY,
    table_name VARCHAR(50),
    action_type VARCHAR(20),
    employee_id VARCHAR(50),
    changed_at VARCHAR(100),
    description TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO audit_logs (log_id, table_name, action_type, employee_id, changed_at, description) VALUES
('aud01', 'inventory_batches', 'UPDATE', 'emp03', '2026-10-07 17:05:00', 'Adjusted stock level for batch 4 due to damaged packaging.');