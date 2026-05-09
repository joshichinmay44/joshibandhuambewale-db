--DROP TABLE IF EXISTS log.user_activity;

CREATE TABLE IF NOT EXISTS log.user_activity (
    activity_id BIGINT GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) PRIMARY KEY,
    user_id BIGINT,
    activity_type VARCHAR(100),
    activity_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT,
    status VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(200),
    updated_by VARCHAR(200),
    FOREIGN KEY (user_id) REFERENCES usr.user(user_id)
);