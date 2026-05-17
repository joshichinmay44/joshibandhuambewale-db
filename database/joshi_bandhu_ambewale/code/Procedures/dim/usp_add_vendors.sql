create or replace procedure dim.usp_add_vendors (p_vendor_name VARCHAR(100), p_contact_name VARCHAR(100), p_email VARCHAR(100), p_phone_number_calling VARCHAR(20), p_phone_number_whatsapp VARCHAR(20),  p_address VARCHAR(255), p_city VARCHAR(50), p_state VARCHAR(50), p_zip_code VARCHAR(10), p_country VARCHAR(50), p_created_by VARCHAR(200))
language PLPGSQL
as
$$
begin
	INSERT INTO dim.vendors
(vendor_id, vendor_name, contact_name, email, phone_number_calling, phone_number_whatsapp, address, city, state, zip_code, country, created_by, updated_by)
	VALUES (p_vendor_id,p_vendor_name,p_contact_name,p_email,p_phone_number_calling,p_phone_number_whatsapp,p_address,p_city,p_state,p_zip_code,p_country,p_created_by,p_created_by);
end;
$$;