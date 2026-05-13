create or replace function dim.usp_get_customers()
RETURNS table
(
	customer_id BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number_calling VARCHAR(20),
    phone_number_whatsapp VARCHAR(20),
    customer_type VARCHAR(50),
    customer_mode VARCHAR(50),
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
	return query select c.customer_id, c.first_name, c.last_name, c.email, c.phone_number_calling, c.phone_number_whatsapp,
	c.customer_type, c.customer_mode, a.country, a.state, a.city,
	 a.postal_code, a.street, c.created_at, c.updated_at, c.created_by, c.updated_by  
	from dim.customer c 
	left join dim.customer_address ca on c.customer_id=ca.customer_id
	left join dim.address a on ca.address_id=a.address_id and c.customer_id=ca.customer_id
    where COALESCE(ca.is_active,TRUE)=TRUE
 ;
end;
$$;