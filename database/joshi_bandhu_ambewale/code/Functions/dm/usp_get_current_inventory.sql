create or replace function dm.usp_get_current_inventory()
returns table (
    batch_id BIGINT,
    sku_name VARCHAR(200),
    total_units INT,
    "Available Stock (in dozens)" numeric(19,4),
    unit_cost_price NUMERIC(19,4),
    total_cost_price NUMERIC(19,4),
    description TEXT,
    vendor_name VARCHAR(200)
)
language plpgsql
AS
$$
begin
    RETURN QUERY (
        SELECT 
        b.batch_id, 
        s.sku_name, 
        b.total_units, 
		b.available_stock,
        b.unit_cost_price, 
        b.total_cost_price,
        b.description,
        v.vendor_name
        FROM dm.batch b
        INNER JOIN dim.vendors v on v.vendor_id = b.vendor_id
        INNER JOIN dim.sku s ON s.sku_id = b.sku_id
        WHERE b.is_active = TRUE
        );
end;
$$;