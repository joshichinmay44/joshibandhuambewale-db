-- DROP TABLE IF EXISTS dm.sales;

CREATE TABLE IF NOT EXISTS dm.sales (
    sale_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    sale_date DATE,
    vendor_id BIGINT,
    sku_id BIGINT,
    delivery_type_id BIGINT,
    salesperson_id BIGINT,
    booking_id BIGINT,
    batch_id BIGINT,
    quantity INT,
    address_id BIGINT,
    delivery_fee DECIMAL(19, 4),
    total_amount DECIMAL(19, 4),
    sales_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200),
    FOREIGN KEY (vendor_id) REFERENCES dim.vendors(vendor_id),
    FOREIGN KEY (sku_id) REFERENCES dim.sku(sku_id),
    FOREIGN KEY (delivery_type_id) REFERENCES dim.delivery_type(delivery_type_id),
    FOREIGN KEY (address_id) REFERENCES dim.address(address_id),
    FOREIGN KEY (salesperson_id) REFERENCES dim.salespeople(salesperson_id)
);