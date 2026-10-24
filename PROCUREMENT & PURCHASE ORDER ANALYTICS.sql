
-- =========================================
-- PROCUREMENT & PURCHASE ORDER ANALYTICS
-- =========================================

CREATE DATABASE IF NOT EXISTS procurement_analytics;

USE procurement_analytics;


-- 1. SUPPLIERS TABLE

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(150),
    country VARCHAR(50),
    supplier_status VARCHAR(20) NOT NULL DEFAULT 'Active'
) ENGINE = InnoDB;


-- 2. DEPARTMENTS TABLE

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    department_manager VARCHAR(100)
) ENGINE = InnoDB;


-- 3. PURCHASE ORDERS TABLE

CREATE TABLE purchase_orders (
    po_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT NOT NULL,
    department_id INT NOT NULL,
    po_date DATE NOT NULL,
    expected_delivery_date DATE,
    po_status VARCHAR(30) NOT NULL DEFAULT 'Open',
    po_amount DECIMAL(12, 2) NOT NULL,

    CONSTRAINT fk_po_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT fk_po_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_po_amount
        CHECK (po_amount >= 0)
) ENGINE = InnoDB;


-- 4. GOODS RECEIPTS TABLE

CREATE TABLE goods_receipts (
    receipt_id INT AUTO_INCREMENT PRIMARY KEY,
    po_id INT NOT NULL,
    receipt_date DATE NOT NULL,
    quantity_received INT NOT NULL,
    receipt_status VARCHAR(30) NOT NULL DEFAULT 'Received',

    CONSTRAINT fk_receipt_po
        FOREIGN KEY (po_id)
        REFERENCES purchase_orders(po_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_quantity_received
        CHECK (quantity_received > 0)
) ENGINE = InnoDB;


-- 5. INVOICES TABLE

CREATE TABLE invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    po_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    invoice_amount DECIMAL(12, 2) NOT NULL,
    invoice_status VARCHAR(30) NOT NULL DEFAULT 'Pending',

    CONSTRAINT fk_invoice_po
        FOREIGN KEY (po_id)
        REFERENCES purchase_orders(po_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT chk_invoice_amount
        CHECK (invoice_amount >= 0)
) ENGINE = InnoDB;

show tables;





USE procurement_analytics;

-- =========================================
-- TABLE 1: SUPPLIERS
-- =========================================

INSERT INTO suppliers
    (supplier_id, supplier_name, contact_email, country, supplier_status)
VALUES
    (1,  'Alpha Office Supplies',   'orders@alpha.example',   'India',        'Active'),
    (2,  'BrightTech Solutions',    'sales@brighttech.example','India',        'Active'),
    (3,  'Global Facilities Ltd',   'contact@globalfac.example','UK',          'Active'),
    (4,  'Prime Logistics',         'ops@prime.example',       'India',        'Active'),
    (5,  'Northstar Consulting',    'info@northstar.example',  'UK',           'Active'),
    (6,  'Vertex IT Services',      'sales@vertex.example',    'India',        'Active'),
    (7,  'GreenLeaf Packaging',     'orders@greenleaf.example','India',        'Active'),
    (8,  'Metro Office Furniture',  'sales@metro.example',     'Germany',      'Active'),
    (9,  'Apex Marketing Services', 'hello@apex.example',      'India',        'Active'),
    (10, 'BlueWave Telecom',        'support@bluewave.example','Singapore',    'Active'),
    (11, 'Legacy Print Solutions',  'orders@legacy.example',   'India',        'Inactive'),
    (12, 'Summit Engineering',      'contact@summit.example',  'UK',           'Active');


-- =========================================
-- TABLE 2: DEPARTMENTS
-- =========================================

INSERT INTO departments
    (department_id, department_name, department_manager)
VALUES
    (1, 'Marketing',       'Ananya Sharma'),
    (2, 'Information Technology', 'Rahul Mehta'),
    (3, 'Human Resources', 'Priya Kapoor'),
    (4, 'Facilities',      'Vikram Singh'),
    (5, 'Operations',      'Neha Verma');

-- =========================================
-- TABLE 3: PURCHASE ORDERS
-- =========================================

INSERT INTO purchase_orders
    (po_id, supplier_id, department_id, po_date,
     expected_delivery_date, po_status, po_amount)
VALUES
    (101, 1,  1, '2025-11-03', '2025-11-10', 'Completed',         12500.00),
    (102, 2,  2, '2025-11-12', '2025-11-25', 'Completed',         85000.00),
    (103, 3,  4, '2025-12-01', '2025-12-15', 'Completed',         42000.00),
    (104, 4,  5, '2025-12-10', '2025-12-20', 'Completed',         18500.00),
    (105, 5,  3, '2025-12-18', '2026-01-05', 'Closed',            65000.00),
    (106, 6,  2, '2026-01-05', '2026-01-20', 'Completed',        145000.00),
    (107, 7,  1, '2026-01-12', '2026-01-22', 'Completed',         22000.00),
    (108, 8,  4, '2026-01-20', '2026-02-05', 'Completed',        110000.00),
    (109, 9,  1, '2026-02-02', '2026-02-12', 'Completed',         95000.00),
    (110, 10, 2, '2026-02-15', '2026-03-01', 'Completed',         36000.00),

    (111, 1,  3, '2026-03-02', '2026-03-12', 'Completed',          9800.00),
    (112, 2,  2, '2026-03-10', '2026-03-25', 'Partially Received', 72000.00),
    (113, 3,  4, '2026-03-18', '2026-04-01', 'Completed',         56000.00),
    (114, 4,  5, '2026-04-01', '2026-04-12', 'Open',              27500.00),
    (115, 5,  3, '2026-04-10', '2026-04-25', 'Completed',         48000.00),
    (116, 6,  2, '2026-04-20', '2026-05-05', 'Partially Received', 96000.00),
    (117, 7,  1, '2026-05-01', '2026-05-12', 'Completed',         31500.00),
    (118, 8,  4, '2026-05-08', '2026-05-25', 'Cancelled',         78000.00),
    (119, 9,  1, '2026-05-15', '2026-05-28', 'Completed',         125000.00),
    (120, 10, 2, '2026-05-25', '2026-06-10', 'Open',              44000.00),

    (121, 11, 1, '2026-06-02', '2026-06-15', 'Completed',         18500.00),
    (122, 12, 4, '2026-06-10', '2026-06-25', 'Completed',         89000.00),
    (123, 1,  5, '2026-06-20', '2026-07-02', 'Open',              16500.00),
    (124, 2,  2, '2026-07-01', '2026-07-15', 'Partially Received', 135000.00),
    (125, 3,  4, '2026-07-10', '2026-07-25', 'Completed',         67000.00),
    (126, 4,  5, '2026-07-20', '2026-08-05', 'Completed',         29500.00),
    (127, 6,  2, '2026-08-01', '2026-08-18', 'Open',             180000.00),
    (128, 9,  1, '2026-08-10', '2026-08-25', 'Completed',         54000.00),
    (129, 10, 2, '2026-09-05', '2026-09-20', 'Open',              62500.00),
    (130, 12, 4, '2026-09-15', '2026-10-01', 'Open',             102000.00);
    
    
-- =========================================
-- TABLE 4: GOODS RECEIPTS
-- =========================================

INSERT INTO goods_receipts
    (receipt_id, po_id, receipt_date, quantity_received, receipt_status)
VALUES
    (201, 101, '2025-11-09', 100, 'Received'),
    (202, 102, '2025-11-24',  50, 'Received'),
    (203, 103, '2025-12-18',  80, 'Received'),
    (204, 104, '2025-12-19',  40, 'Received'),
    (205, 105, '2026-01-06',  60, 'Received'),
    (206, 106, '2026-01-18',  90, 'Received'),
    (207, 107, '2026-01-22', 120, 'Received'),
    (208, 108, '2026-02-03',  25, 'Received'),
    (209, 108, '2026-02-10',  25, 'Received'),
    (210, 109, '2026-02-11',  75, 'Received'),
    (211, 110, '2026-03-04',  30, 'Received'),

    (212, 111, '2026-03-11',  45, 'Received'),
    (213, 112, '2026-03-24',  20, 'Received'),
    (214, 112, '2026-04-05',  10, 'Received'),
    (215, 113, '2026-04-04',  55, 'Received'),
    (216, 115, '2026-04-23',  35, 'Received'),
    (217, 116, '2026-05-04',  25, 'Received'),
    (218, 116, '2026-05-20',  15, 'Received'),
    (219, 117, '2026-05-11',  90, 'Received'),
    (220, 119, '2026-05-27',  60, 'Received'),

    (221, 121, '2026-06-14',  45, 'Received'),
    (222, 122, '2026-06-28',  20, 'Received'),
    (223, 123, '2026-07-01',  30, 'Received'),
    (224, 124, '2026-07-14',  15, 'Received'),
    (225, 124, '2026-07-29',  10, 'Received'),
    (226, 125, '2026-07-24',  55, 'Received'),
    (227, 126, '2026-08-04',  40, 'Received'),
    (228, 127, '2026-08-17',  12, 'Received'),
    (229, 128, '2026-08-24',  70, 'Received'),
    (230, 129, '2026-09-19',  35, 'Received'),

    (231, 130, '2026-10-05',  18, 'Received'),
    (232, 114, '2026-10-10',   8, 'Received'),
    (233, 120, '2026-10-15',   5, 'Received'),
    (234, 127, '2026-09-01',   8, 'Received'),
    (235, 103, '2025-12-20',   5, 'Received');
    
    
    

-- =========================================
-- TABLE 5: INVOICES
-- =========================================

INSERT INTO invoices
    (invoice_id, invoice_number, po_id, invoice_date,
     invoice_amount, invoice_status)
VALUES
    (301, 'INV-2025-001', 101, '2025-11-09', 12500.00, 'Paid'),
    (302, 'INV-2025-002', 102, '2025-11-26', 85000.00, 'Paid'),
    (303, 'INV-2025-003', 103, '2025-12-20', 42000.00, 'Paid'),
    (304, 'INV-2025-004', 104, '2025-12-21', 18500.00, 'Paid'),
    (305, 'INV-2025-005', 105, '2026-01-07', 65000.00, 'Paid'),
    (306, 'INV-2026-006', 106, '2026-01-19', 145000.00, 'Paid'),
    (307, 'INV-2026-007', 107, '2026-01-23', 22000.00, 'Paid'),
    (308, 'INV-2026-008A',108, '2026-02-04', 60000.00, 'Paid'),
    (309, 'INV-2026-008B',108, '2026-02-12', 50000.00, 'Paid'),
    (310, 'INV-2026-009', 109, '2026-02-13', 95000.00, 'Paid'),

    (311, 'INV-2026-010', 110, '2026-03-05', 36000.00, 'Paid'),
    (312, 'INV-2026-011', 111, '2026-03-12',  9800.00, 'Paid'),
    (313, 'INV-2026-012A',112, '2026-03-25', 40000.00, 'Paid'),
    (314, 'INV-2026-012B',112, '2026-04-06', 32000.00, 'Pending'),
    (315, 'INV-2026-013', 113, '2026-04-05', 56000.00, 'Paid'),
    (316, 'INV-2026-014', 114, '2026-04-10', 27500.00, 'Pending'),
    (317, 'INV-2026-015', 115, '2026-04-24', 48000.00, 'Paid'),
    (318, 'INV-2026-016A',116, '2026-05-05', 60000.00, 'Paid'),
    (319, 'INV-2026-016B',116, '2026-05-21', 36000.00, 'Disputed'),
    (320, 'INV-2026-017', 117, '2026-05-12', 31500.00, 'Paid'),

    (321, 'INV-2026-019', 119, '2026-05-29', 125000.00, 'Paid'),
    (322, 'INV-2026-020', 120, '2026-06-11', 44000.00, 'Pending'),
    (323, 'INV-2026-021', 121, '2026-06-15', 18500.00, 'Paid'),
    (324, 'INV-2026-022', 122, '2026-06-29', 89000.00, 'Approved'),
    (325, 'INV-2026-023', 123, '2026-07-03', 16500.00, 'Pending'),
    (326, 'INV-2026-024A',124, '2026-07-16', 80000.00, 'Paid'),
    (327, 'INV-2026-024B',124, '2026-07-30', 55000.00, 'Pending'),
    (328, 'INV-2026-025', 125, '2026-07-26', 67000.00, 'Paid'),
    (329, 'INV-2026-026', 126, '2026-08-06', 29500.00, 'Approved'),
    (330, 'INV-2026-027', 127, '2026-08-19', 180000.00, 'Pending'),
    (331, 'INV-2026-028', 128, '2026-08-26', 54000.00, 'Paid'),
    (332, 'INV-2026-029', 129, '2026-09-21', 62500.00, 'Pending');


-- Check row counts
SELECT 'suppliers' AS table_name, COUNT(*) AS total_rows
FROM suppliers

UNION ALL

SELECT 'departments', COUNT(*)
FROM departments

UNION ALL

SELECT 'purchase_orders', COUNT(*)
FROM purchase_orders

UNION ALL

SELECT 'goods_receipts', COUNT(*)
FROM goods_receipts

UNION ALL

SELECT 'invoices', COUNT(*)
FROM invoices;

select * from purchase_orders where po_status = "open";

-- Find open orders past their expected delivery dates and calculate how many days late they are.

SELECT 
    purchase_orders.po_id,
    expected_delivery_date,
    receipt_date,
    po_status,
    (receipt_date - expected_delivery_date) AS Delayed_by_days
FROM
    purchase_orders
        LEFT JOIN
    goods_receipts ON purchase_orders.po_id = goods_receipts.po_id
WHERE
    po_status = 'open'
        AND expected_delivery_date < receipt_date;


-- Compare supplier spending, delivery delays, and the number of orders associated with each supplier.

SELECT 
    suppliers.supplier_id, avg((expected_delivery_date - po_date)),
    supplier_name,
    SUM(po_amount) AS supplier_spending
FROM
    suppliers
        LEFT JOIN
    purchase_orders ON suppliers.supplier_id = purchase_orders.supplier_id
GROUP BY suppliers.supplier_id, supplier_name order by supplier_spending;



-- Determine which departments raise the most POs and account for the largest procurement amounts.
SELECT 
    departments.department_id,
    departments.department_name,
    COUNT(*) AS PO_Counts,
    SUM(po_amount) AS PO_Total_Values
FROM
    departments
        LEFT JOIN
    purchase_orders ON departments.department_id = purchase_orders.department_id
GROUP BY departments.department_id , departments.department_name
ORDER BY PO_Total_Values DESC;


-- Identify purchase orders where the total invoiced amount differs from the PO amount, and find pending or disputed invoices.

SELECT 
    purchase_orders.po_id, po_amount, invoice_amount, (po_amount - invoice_amount) as Amount_Difference, po_status, invoice_status
FROM
    purchase_orders
        LEFT JOIN
    invoices ON purchase_orders.po_id = invoices.po_id where po_amount != invoice_amount and invoice_status in ("Pending","Disputed");
    
-- Find open orders assigned to inactive suppliers.    
SELECT 
    po_id, po_status, purchase_orders.supplier_id, supplier_status
FROM
    purchase_orders
        LEFT JOIN
    suppliers ON purchase_orders.supplier_id = suppliers.supplier_id where po_status = "open" and supplier_status = "Inactive";

-- There are no open POs assigned to any inactive suppliers



-- 1. Procurement risk and overdue commitments
-- Identify overdue POs, quantify their value, and prioritize the biggest risks.

SELECT 
    purchase_orders.po_id,
    expected_delivery_date,
    receipt_date,
    datediff(receipt_date,expected_delivery_date) as Delayed_by,
    po_amount
FROM
    purchase_orders
        LEFT JOIN
    goods_receipts ON purchase_orders.po_id = goods_receipts.po_id
WHERE
    receipt_date > expected_delivery_date
ORDER BY po_amount DESC;




