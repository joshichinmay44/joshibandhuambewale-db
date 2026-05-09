--DROP TABLE IF EXISTS dim.delivery_type;

CREATE TABLE IF NOT EXISTS dim.delivery_type (
    delivery_type_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    delivery_type_name VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
);