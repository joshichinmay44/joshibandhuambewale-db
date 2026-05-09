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
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200)
)
language plpgsql
AS
$$
begin
	return query select * from dim.customer c ;
end;
$$;