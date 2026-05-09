create or replace procedure dim.usp_update_customer(
p_first_name VARCHAR(50), 
p_last_name VARCHAR(50), 
p_email VARCHAR(100), 
p_phone_number_calling VARCHAR(20), 
p_phone_number_whatsapp VARCHAR(20),
p_customer_type VARCHAR(50),
p_customer_mode VARCHAR(50),
p_updated_by VARCHAR(100),
p_cust_id BIGINT
)
language PLPGSQL
as
$$
begin
	UPDATE dim.customer
	set phone_number_calling=p_phone_number_calling,
	phone_number_whatsapp=p_phone_number_whatsapp,
	customer_type=p_customer_type,
	customer_mode=p_customer_mode,
	updated_by=p_updated_by,
	updated_at=now()
	where customer_id=p_cust_id;
end;
$$;