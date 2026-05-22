create or replace procedure dim.usp_update_vendor(
p_vendor_name VARCHAR(50), 
p_contact_name VARCHAR(50), 
p_email VARCHAR(100), 
p_phone_number_calling VARCHAR(20), 
p_phone_number_whatsapp VARCHAR(20),
p_updated_by VARCHAR(100),
p_country VARCHAR(100),
p_state VARCHAR(100),
p_city VARCHAR(100),
p_postal_code VARCHAR(20),
p_street VARCHAR(255),
p_vendor_id BIGINT
)
language PLPGSQL
as
$$
begin
	

	IF p_country IS NULL AND p_state IS NULL AND p_city IS NULL AND p_postal_code IS NULL AND p_street IS NULL THEN
		UPDATE dim.vendors
		set 
		vendor_name=p_vendor_name,
		contact_name=p_contact_name,
		email=p_email,
		phone_number_calling=p_phone_number_calling,
		phone_number_whatsapp=p_phone_number_whatsapp,
		updated_by=p_updated_by,
		updated_at=now()
		where vendor_id=p_vendor_id;		
	ELSE
		UPDATE dim.vendors
		set 
		vendor_name=p_vendor_name,
		contact_name=p_contact_name,
		email=p_email,
		phone_number_calling=p_phone_number_calling,
		phone_number_whatsapp=p_phone_number_whatsapp,
		updated_by=p_updated_by,
		updated_at=now(),
		country=p_country,
		state=p_state,
		city=p_city,
		zip_code=p_postal_code,
		address=p_street
		where vendor_id=p_vendor_id;
	END IF;
end;
$$;