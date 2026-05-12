CREATE TABLE IF NOT EXISTS dim.customer_address (
    address_id BIGINT,
    customer_id BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES dim.customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES dim.address(address_id)
);