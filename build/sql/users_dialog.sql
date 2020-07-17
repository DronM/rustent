-- View: users_dialog

-- DROP VIEW users_dialog;

CREATE OR REPLACE VIEW users_dialog AS 
	SELECT
	 	u.id
	 	,u.name
	 	,u.role_id
	 	,u.phone_cel
	 	,u.tel_ext
	 	,u.email
	 	,u.banned
	 	
 	FROM users AS u
	;

ALTER TABLE users_dialog OWNER TO ;

