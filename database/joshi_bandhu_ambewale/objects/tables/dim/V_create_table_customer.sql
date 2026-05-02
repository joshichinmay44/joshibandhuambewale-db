-- DROP TABLE IF EXISTS dim.customer;

CREATE TABLE IF NOT EXISTS dim.customer (
    customer_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number_calling VARCHAR(20),
    phone_number_whatsapp VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    country VARCHAR(50),
    customer_type VARCHAR(50) CHECK (customer_type IN ('Retail', 'Wholesale')),
    customer_mode VARCHAR(50) CHECK (customer_mode IN ('Online', 'Offline')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
);