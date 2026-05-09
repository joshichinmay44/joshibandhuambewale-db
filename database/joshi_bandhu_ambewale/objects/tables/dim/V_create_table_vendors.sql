--DROP TABLE IF EXISTS dim.vendors;

CREATE TABLE IF NOT EXISTS dim.vendors (
    vendor_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    vendor_name VARCHAR(100),
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone_number_calling VARCHAR(20),
    phone_number_whatsapp VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    country VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
);