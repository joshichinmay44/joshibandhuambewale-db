create or replace procedure dim.usp_add_sku(p_sku_name VARCHAR(100), p_description text,p_created_by VARCHAR(200))
language PLPGSQL
as
$$
declare
v_current_time TIMESTAMP := NOW();
begin
	INSERT INTO dim.sku(sku_name, description, created_at, updated_at, created_by, updated_by)
	VALUES( p_sku_name, p_description, v_current_time, v_current_time, p_created_by , p_created_by);
end;
$$;