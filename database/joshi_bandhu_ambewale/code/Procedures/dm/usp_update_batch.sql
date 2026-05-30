create or replace procedure dm.usp_update_batch (p_batch_id bigint, 
p_sku_name VARCHAR(200), 
p_total_units int, 
p_unit_cost_price NUMERIC(19,4),
p_total_cost_price numeric (19,4),
p_description TEXT,
p_vendor_name VARCHAR(200),
p_created_by VARCHAR(100)
)
language PLPGSQL
as
$$
declare 
	v_sku_id BIGINT;
	v_vendor_id BIGINT;
	v_current_time TIMESTAMP := NOW();
begin
	v_sku_id := (SELECT sku_id FROM dim.sku where lower(sku_name) = lower(p_sku_name));
	v_vendor_id := (SELECT vendor_id FROM dim.vendors where lower(vendor_name) = lower(p_vendor_name));
	INSERT INTO dm.batch(batch_id, sku_id, total_units, unit_cost_price, total_cost_price, description, vendor_id, created_at, updated_at, created_by, updated_by)
	VALUES (p_batch_id, v_sku_id, p_total_units, p_unit_cost_price, p_total_cost_price, p_description, v_vendor_id, v_current_time, v_current_time, p_created_by, p_created_by);
end;
$$;