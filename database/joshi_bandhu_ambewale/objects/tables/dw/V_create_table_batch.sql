--DROP TABLE IF EXISTS dm.batch;

CREATE TABLE IF NOT EXISTS dm.batch(
    batch_id BIGINT,
    sku_id VARCHAR(100),
    total_units INT,
    unit_cost_price DECIMAL(19,4),
    total_cost_price DECIMAL(19,4),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
);