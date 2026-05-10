create or replace function usr.validate_username_availability(p_username VARCHAR(100))
returns boolean
language plpgsql
as
$$
begin
	return not exists ( SELECT 1 from usr.user where username=p_username and is_active=True);
end;
$$;
end;