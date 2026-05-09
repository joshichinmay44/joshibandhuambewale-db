--drop function usr.authenticate_script(varchar,varchar);
CREATE or REPLACE FUNCTION usr.authenticate_script (user_name VARCHAR(500),jwt_token VARCHAR(500))
RETURNS BOOLEAN
language PLPGSQL
AS
$$
BEGIN
    INSERT INTO log.user_activity (user_id, activity_type, description, created_by, status)
    SELECT user_id, 'AUTHENTICATION_ATTEMPT', 'User attempted log in', user_name ,
    CASE WHEN jwt_token IS NOT NULL AND jwt_token != password_hash THEN 'AUTHENTICATION_SUCCESS' ELSE 'AUTHENTICATION_FAILURE' END
    FROM usr.user
    WHERE username = user_name AND is_active = TRUE;
    RETURN EXISTS (SELECT 1 FROM usr.user WHERE  password_hash=jwt_token AND username = user_name AND is_active = TRUE); -- Return true if the token is valid, false otherwise.
END;
$$;