create or replace procedure usr.usp_add_new_user(
p_username VARCHAR(100), 
p_email VARCHAR(200), 
p_password_hash VARCHAR(255), 
p_first_name VARCHAR(100), 
p_last_name VARCHAR(100),
p_date_of_birth date,
p_phone_number VARCHAR(20),
p_address TEXT,
p_createdby VARCHAR(100)
)
language PLPGSQL
AS
$$
BEGIN
	INSERT INTO usr."user"
	( username, email, password_hash, first_name, last_name, date_of_birth, phone_number, address)
	VALUES(p_username, p_email, p_password_hash, p_first_name, p_last_name, p_date_of_birth, p_phone_number, p_address);
	INSERT INTO log.user_activity (user_id, activity_type, description, created_by, status)
    SELECT user_id, 'NEW_USER_REGISTRATION', 'User registered', p_createdby, 'Success'
    FROM usr.user WHERE username = p_createdby AND is_active = TRUE;
END;
$$;