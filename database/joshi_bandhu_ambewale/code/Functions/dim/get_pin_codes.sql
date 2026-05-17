create or replace function dim.get_pin_codes(p_city_name VARCHAR(100))
returns table(pincode int)
language PLPGSQL
as
$$
begin
	return query(SELECT distinct d.pincode FROM dim.india_pin_codes d
	where (lower(d.region_name) = lower(concat(p_city_name,' region'))) or (lower(d.division_name) = lower(concat(p_city_name,' division'))));
end;
$$;