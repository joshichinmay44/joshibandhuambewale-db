-- DROP TABLE IF EXISTS dim.sku;

CREATE TABLE IF NOT EXISTS dim.sku (
    sku_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    sku_name VARCHAR(100),
    sku_units DECIMAL(19,4) GENERATED ALWAYS AS (CASE 
        WHEN lower(sku_name) LIKE '%2.5%' THEN 2.5
        when lower(sku_name) like '%2' then 2
        WHEN lower(sku_name) LIKE '%3%' THEN 3
        WHEN lower(sku_name) LIKE '%1.25%' THEN 1.25
        WHEN lower(sku_name) LIKE '%1.5%' THEN 1.5
        WHEN lower(sku_name) LIKE '%l%' THEN 1
        ELSE NULL
    END) stored,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
);