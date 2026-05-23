create or replace function dim.usp_get_vendors()
RETURNS table
(
	vendor_id BIGINT,
    vendor_name VARCHAR(50),
    contact_name VARCHAR(50),
    email VARCHAR(100),
    phone_number_calling VARCHAR(20),
    phone_number_whatsapp VARCHAR(20),
    country VARCHAR(100),
    state VARCHAR(200),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    street VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
)
language plpgsql
AS
$$
begin
	return query select c.vendor_id, c.vendor_name, c.contact_name, c.email, c.phone_number_calling, c.phone_number_whatsapp,
	c.country, c.state, c.city,
	 c.zip_code, c.address as street, c.created_at, c.updated_at, c.created_by, c.updated_by  
	from dim.vendors c 
 ;
end;
$$;