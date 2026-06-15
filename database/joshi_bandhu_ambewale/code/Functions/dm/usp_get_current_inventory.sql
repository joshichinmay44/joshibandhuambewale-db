create or replace function dm.usp_get_current_inventory()
returns table (
    "SKU Name" VARCHAR(200),
    "Vendor Name" VARCHAR(200),
    "Total Units Received" BIGINT,
    "Available Stock (in dozens)" numeric(19,4),
    "Available Stock (in units)" numeric(19,4)
)
language plpgsql
AS
$$
begin
    RETURN QUERY (
with agg_data as (       
		SELECT 
        s.sku_name as "SKU Name", 
        v.vendor_name as "Vendor Name",
        SUM(b.total_units) as "Total Units Received", 
		SUM(b.available_stock) AS "Available Stock (in dozens)"
        FROM dm.batch b
        INNER JOIN dim.vendors v on v.vendor_id = b.vendor_id
        INNER JOIN dim.sku s ON s.sku_id = b.sku_id
        WHERE b.is_active = TRUE
        GROUP BY s.sku_name, v.vendor_name
        )
		SELECT 
		a."SKU Name", 
		a."Vendor Name", 
		a."Total Units Received", 
		a."Available Stock (in dozens)",
		a."Available Stock (in dozens)" * 12 as "Available Stock (in units)" 
		FROM agg_data a
)
		;
end;
$$;