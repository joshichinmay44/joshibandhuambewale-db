create or replace procedure dim.usp_update_customer(
p_first_name VARCHAR(50), 
p_last_name VARCHAR(50), 
p_email VARCHAR(100), 
p_phone_number_calling VARCHAR(20), 
p_phone_number_whatsapp VARCHAR(20),
p_customer_type VARCHAR(50),
p_customer_mode VARCHAR(50),
p_updated_by VARCHAR(100),
p_country VARCHAR(100),
p_state VARCHAR(100),
p_city VARCHAR(100),
p_postal_code VARCHAR(20),
p_street VARCHAR(255),
p_cust_id BIGINT
)
language PLPGSQL
as
$$
declare p_address_id BIGINT;
begin
	UPDATE dim.customer
	set 
	first_name=p_first_name,
	last_name=p_last_name,
	email=p_email,
	phone_number_calling=p_phone_number_calling,
	phone_number_whatsapp=p_phone_number_whatsapp,
	customer_type=p_customer_type,
	customer_mode=p_customer_mode,
	updated_by=p_updated_by,
	updated_at=now()
	where customer_id=p_cust_id;

	IF p_country IS NULL AND p_state IS NULL AND p_city IS NULL AND p_postal_code IS NULL AND p_street IS NULL THEN
		RETURN;
	END IF;

	IF EXISTS  (SELECT 1
	from dim.customer_address ca
	join dim.address ad on COALESCE(ca.address_id, 0) = COALESCE(ad.address_id, 0)
	where ca.customer_id=p_cust_id) THEN
		MERGE INTO dim.address a
		USING (SELECT ad.address_id
	from dim.customer_address ca
	join dim.address ad on COALESCE(ca.address_id, 0) = COALESCE(ad.address_id, 0)
	where ca.customer_id=p_cust_id) as source
	on a.address_id = source.address_id
	when matched then update
		SET
			street = p_street,
			city = p_city,
			state = p_state,
			postal_code = p_postal_code,
			country = p_country;

	ELSE
	INSERT INTO dim.address (street, city, state, postal_code, country, created_by, updated_by)
		VALUES (p_street, p_city, p_state, p_postal_code, p_country, p_updated_by, p_updated_by)
		RETURNING address_id INTO p_address_id;
		INSERT INTO dim.customer_address (customer_id, address_id, created_by, updated_by)	VALUES (p_cust_id, p_address_id, p_updated_by, p_updated_by);
	END IF;
end;
$$;