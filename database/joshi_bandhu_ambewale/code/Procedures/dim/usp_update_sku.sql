create or replace procedure dim.usp_update_sku (p_sku_id BIGINT, p_sku_name VARCHAR(100), p_description TEXT, p_updated_by VARCHAR(200))
language plpgsql
as
$$
declare
v_current_time TIMESTAMP := NOW();
begin
	UPDATE dim.sku SET sku_name = p_sku_name, description = p_description, updated_at = v_current_time, updated_by = p_updated_by
	WHERE sku_id = p_sku_id;
end;
$$;