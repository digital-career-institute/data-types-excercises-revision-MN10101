CREATE TYPE invoice_status AS ENUM('NEW', 'PAID', 'WAITING FOR PAYMENT');

CREATE TABLE Invoices (
    id SERIAL PRIMARY KEY,
    buyer VARCHAR(255),
    seller VARCHAR(255),
    value DECIMAL(10, 2),
    account_number VARCHAR(20),
    status invoice_status
);

INSERT INTO Invoices (buyer, seller, value, account_number, status)
VALUES
    ('ABC Electronics', 'XYZ Suppliers', 500.00, '1234567890', 'NEW'),
    ('FreshGroceries Inc.', 'Farm Fresh Co.', 300.25, '0987654321', 'PAID'),
    ('Tech Solutions Ltd.', 'Gadget Innovations', 750.50, '1122334455', 'WAITING FOR PAYMENT');
	
SELECT * FROM Invoices WHERE status = 'NEW';

SELECT * FROM pg_extension WHERE extname = 'uuid-ossp';

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER TABLE Invoices ADD COLUMN internal_id UUID DEFAULT uuid_generate_v4();

UPDATE Invoices SET internal_id = '9152a5a1-cdb8-482e-b1ab-aeee5159f18e' WHERE id = 1;
UPDATE Invoices SET internal_id = '865a11d3-b372-4486-bb90-0b67a1c70c64' WHERE id = 2;
UPDATE Invoices SET internal_id = '18f89295-16fb-4159-896e-4c51f039ae60' WHERE id = 3;

ALTER TABLE Invoices ADD COLUMN json_data JSON;

ALTER TABLE Invoices ADD COLUMN jsonb_data JSONB;

UPDATE Invoices SET json_data = '{"buyer": "ABC Electronics", "seller": "XYZ Suppliers", "value": 500.00, "account_number": "1234567890", "status": "NEW"}' WHERE id = 1;
UPDATE Invoices SET json_data = '{"buyer": "FreshGroceries Inc.", "seller": "Farm Fresh Co.", "value": 300.25, "account_number": "0987654321", "status": "PAID"}' WHERE id = 2;
UPDATE Invoices SET json_data = '{"buyer": "Tech Solutions Ltd.", "seller": "Gadget Innovations", "value": 750.50, "account_number": "1122334455", "status": "WAITING FOR PAYMENT"}' WHERE id = 3;

ALTER TABLE Invoices ADD COLUMN phone_numbers VARCHAR(20) ARRAY[3];

UPDATE Invoices SET phone_numbers = ARRAY['123211233', '125433221', '127643454'] WHERE id = 3;
UPDATE Invoices SET phone_numbers = ARRAY['432323112', '123344311'] WHERE id = 2;

SELECT buyer, phone_numbers[3] AS last_phone_number FROM Invoices WHERE id = 3;

SELECT * FROM Invoices WHERE '432323112' = ANY(phone_numbers);

ALTER TABLE Invoices ADD COLUMN file_data BYTEA;

UPDATE Invoices SET file_data = pg_read_binary_file('C:/Users/mn/Desktop/invoice_file.txt') WHERE id = 1;

ALTER TABLE Invoices
ADD COLUMN payment_deadline DATE,
ADD COLUMN transaction_time TIMESTAMP,
ADD COLUMN transaction_hour TIME,
ADD COLUMN cyclic_payment INTERVAL;

UPDATE Invoices SET
    payment_deadline = '2024-02-01',
    transaction_time = '2024-01-30 12:00:00',
    transaction_hour = '12:00:00',
    cyclic_payment = '1 day';
	
UPDATE Invoices SET
    transaction_time = transaction_time + interval '10 hours';
	
SELECT * FROM Invoices;