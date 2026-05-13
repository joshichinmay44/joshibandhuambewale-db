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
declare 
p_address_id BIGINT;
previous_address_id BIGINT;
sql_query TEXT;

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
	join dim.address a on ca.address_id = a.address_id
	where COALESCE(ca.customer_id,0)=COALESCE(p_cust_id,0) and md5(concat(a.street, a.city, a.state, a.postal_code, a.country)) != md5(concat(p_street, p_city, p_state, p_postal_code, p_country))) THEN
	SELECT ad.address_id into previous_address_id
	from dim.customer_address ca
	join dim.address ad on ca.address_id = ad.address_id
	where ca.customer_id=p_cust_id and ca.is_active=TRUE;
	INSERT INTO dim.address
	(street, city, state, postal_code, country, created_by, updated_by)
	VALUES(p_street, p_city,p_state, p_postal_code, p_country, p_updated_by, p_updated_by)
	RETURNING address_id into p_address_id;
	UPDATE dim.customer_address SET is_active=FALSE, updated_by=p_updated_by, updated_at=now() where customer_id=p_cust_id and address_id=previous_address_id;
	INSERT INTO dim.customer_address (customer_id, address_id, created_by, updated_by)	VALUES (p_cust_id, p_address_id, p_updated_by, p_updated_by);
	ELSIF EXISTS (SELECT 1 FROM dim.address a WHERE a.street = p_street AND a.city=p_city AND a.state=p_state AND a.postal_code=p_postal_code AND a.country=p_country) THEN
		SELECT address_id INTO p_address_id FROM dim.address a WHERE a.street = p_street AND a.city=p_city AND a.state=p_state AND a.postal_code=p_postal_code AND a.country=p_country;	
		IF NOT EXISTS (SELECT 1 FROM dim.customer_address where customer_id=p_cust_id and address_id=p_address_id and is_active=TRUE) THEN
			INSERT INTO dim.customer_address (customer_id, address_id, created_by, updated_by)	VALUES (p_cust_id, p_address_id, p_updated_by, p_updated_by);
		END IF;
	ELSE
	INSERT INTO dim.address
	(street, city, state, postal_code, country, created_by, updated_by)
	VALUES(p_street, p_city,p_state, p_postal_code, p_country, p_updated_by, p_updated_by)
	RETURNING address_id into p_address_id;
	
	INSERT INTO dim.customer_address(address_id, customer_id, created_by, updated_by)
	VALUES (p_address_id, p_cust_id, p_updated_by, p_updated_by);
	END IF;
end;
$$;