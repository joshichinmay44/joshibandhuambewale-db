create or replace procedure dim.usp_insert_new_customer(
p_first_name VARCHAR(50), 
p_last_name VARCHAR(50), 
p_email VARCHAR(100), 
p_phone_number_calling VARCHAR(20), 
p_phone_number_whatsapp VARCHAR(20),
p_customer_type VARCHAR(50),
p_customer_mode VARCHAR(50),
p_created_by VARCHAR(100)
)
language PLPGSQL
AS
$$
BEGIN
	INSERT INTO dim.customer
	( first_name, last_name, email, phone_number_calling, phone_number_whatsapp, customer_type, customer_mode, created_by, updated_by)
	values ( p_first_name, p_last_name, p_email, p_phone_number_calling, p_phone_number_whatsapp, p_customer_type, p_customer_mode , p_created_by, p_created_by);
END;
$$;