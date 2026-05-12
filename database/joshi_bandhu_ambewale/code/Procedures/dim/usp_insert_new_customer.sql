create or replace procedure dim.usp_insert_new_customer(
p_first_name VARCHAR(50), 
p_last_name VARCHAR(50), 
p_email VARCHAR(100), 
p_phone_number_calling VARCHAR(20), 
p_phone_number_whatsapp VARCHAR(20),
p_customer_type VARCHAR(50),
p_customer_mode VARCHAR(50),
p_created_by VARCHAR(100),
p_country VARCHAR(100),
p_state VARCHAR(100),
p_city VARCHAR(100),
p_postal_code VARCHAR(20),
p_street VARCHAR(255)
)
language PLPGSQL
AS
$$
DECLARE 
p_customer_id BIGINT;
p_address_id BIGINT;
BEGIN
	INSERT INTO dim.customer
	( first_name, last_name, email, phone_number_calling, phone_number_whatsapp, customer_type, customer_mode, created_by, updated_by)
	VALUES( p_first_name, p_last_name, p_email, p_phone_number_calling, p_phone_number_whatsapp, p_customer_type, p_customer_mode , p_created_by, p_created_by)
	RETURNING customer_id into p_customer_id;

	INSERT INTO dim.address
	(street, city, state, postal_code, country, created_by, updated_by)
	VALUES(p_street, p_city,p_state, p_postal_code, p_country, p_created_by, p_created_by)
	RETURNING address_id into p_address_id;
	
	INSERT INTO dim.customer_address(address_id, customer_id, created_by, updated_by)
	VALUES (p_address_id, p_customer_id, p_created_by, p_created_by);
END;
$$;