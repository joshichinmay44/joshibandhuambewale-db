CREATE TABLE IF NOT EXISTS dim.india_pin_codes (
	id int4 NULL,
	circle_name varchar(50) NULL,
	region_name varchar(50) NULL,
	division_name varchar(50) NULL,
	office_name varchar(50) NULL,
	pincode int4 NULL,
	office_type varchar(50) NULL,
	delivery varchar(50) NULL,
	district varchar(50) NULL,
	statename varchar(50) NULL
);