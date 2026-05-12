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

	MERGE INTO dim.address a
	USING (SELECT p_street as street, p_city as city, p_state as state, p_postal_code as postal_code, p_country as country, p_cust_id as customer_id 
	from dim.customer_address ca
	join dim.address ad on ca.address_id=ad.address_id
	where COALESCE(ca.customer_id,'')=COALESCE(p_cust_id,'') and COALESCE(ad.street,'')=COALESCE(p_street,'') and COALESCE(ad.city,'')=COALESCE(p_city,'') and COALESCE(ad.state,'')=COALESCE(p_state,'') and COALESCE(ad.postal_code,'')=COALESCE(p_postal_code,'') and COALESCE(ad.country,'')=COALESCE(p_country,'')
	) AS vals
	ON a.customer_id = vals.customer_id 
	WHEN MATCHED THEN
		UPDATE SET
			street = vals.street,
			city = vals.city,
			state = vals.state,
			postal_code = vals.postal_code,
			country = vals.country;
end;
$$;