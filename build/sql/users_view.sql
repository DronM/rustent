-- View: users_view

-- DROP VIEW users_view;

CREATE OR REPLACE VIEW users_view AS 
	SELECT
	 	u.id,
	 	u.name,
	 	u.role_id,
	 	u.locale_id,
	 	u.banned,
	 	u.email,
	 	u.pwd,
	 	time_zone_locales_ref(loc) AS time_zone_locales_ref
	 	
 	FROM users AS u
 	LEFT JOIN time_zone_locales AS loc ON loc.id=u.time_zone_locale_id
	;
ALTER TABLE users_view OWNER TO ;

