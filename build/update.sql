
-- SUPERUSER CODE
/*
CREATE USER rustent WITH PASSWORD '159753';
CREATE DATABASE rustent OWNER rustent;
GRANT ALL PRIVILEGES ON DATABASE rustent TO rustent;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO rustent;
*/

-- Table: logins

-- DROP TABLE logins;

CREATE TABLE public.logins
(
  id serial NOT NULL,
  date_time_in timestamp with time zone NOT NULL,
  date_time_out timestamp with time zone,
  ip character varying(15) NOT NULL,
  session_id character(128) NOT NULL,
  user_id integer,
  pub_key character(15),
  set_date_time timestamp without time zone DEFAULT now(),
  CONSTRAINT logins_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.logins
  OWNER TO rustent;

-- Index: logins_session_id_idx

-- DROP INDEX logins_session_id_idx;

CREATE INDEX public.logins_session_id_idx
  ON public.logins
  USING btree
  (session_id COLLATE pg_catalog."default");

-- Index: users_pub_key_idx

-- DROP INDEX users_pub_key_idx;

CREATE INDEX public.users_pub_key_idx
  ON public.logins
  USING btree
  (pub_key COLLATE pg_catalog."default");

CREATE INDEX public.logins_users_index
  ON public.logins
  USING btree
  (user_id,date_time_in,date_time_out);

-- Function: logins_process()

-- DROP FUNCTION logins_process();

--Trigger function
CREATE OR REPLACE FUNCTION public.logins_process()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN
		IF NEW.date_time_out IS NOT NULL THEN
			--DELETE FROM doc___t_tmp__ WHERE login_id=NEW.id;
		END IF;
		
		RETURN NEW;
	ELSE 
		RETURN NEW;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.logins_process()
  OWNER TO rustent;


-- Trigger: logins_trigger on logins

-- DROP TRIGGER logins_trigger ON logins;

CREATE TRIGGER public.logins_trigger
  AFTER UPDATE OR DELETE
  ON public.logins
  FOR EACH ROW
  EXECUTE PROCEDURE public.logins_process();



-- Table: sessions

-- DROP TABLE sessions;

CREATE TABLE public.sessions
(
  id character(128) NOT NULL,
  data text,
  data_enc bytea,
  pub_key character varying(15),
  set_time timestamp without time zone NOT NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.sessions
  OWNER TO rustent;

-- Index: sessions_pub_key_idx

-- DROP INDEX sessions_pub_key_idx;

CREATE INDEX public.sessions_pub_key_idx
  ON public.sessions
  USING btree
  (pub_key COLLATE pg_catalog."default");

-- Index: sessions_set_time_idx

-- DROP INDEX public.sessions_set_time_idx;

CREATE INDEX public.sessions_set_time_idx
  ON public.sessions
  USING btree
  (set_time);

-- Function: sess_gc(interval)

-- DROP FUNCTION sess_gc(interval);

CREATE OR REPLACE FUNCTION public.sess_gc(in_lifetime interval)
  RETURNS void AS
$BODY$	
	UPDATE public.logins
	SET date_time_out = now()
	WHERE session_id IN (SELECT id FROM public.sessions WHERE set_time<(now()-in_lifetime));
	
	DELETE FROM public.sessions WHERE set_time < (now()-in_lifetime);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.sess_gc(interval)
  OWNER TO rustent;

-- Function: sess_write(character varying, text, character varying)

-- DROP FUNCTION sess_write(character varying, text, character varying);

CREATE OR REPLACE FUNCTION public.sess_write(
    in_id character varying,
    in_data text,
    in_remote_ip character varying)
  RETURNS void AS
$BODY$
BEGIN
	UPDATE public.sessions
	SET
		set_time = now(),
		data = in_data
	WHERE id = in_id;
	
	IF FOUND THEN
		RETURN;
	END IF;
	
	BEGIN
		INSERT INTO public.sessions (id, data, set_time)
		VALUES(in_id, in_data, now());
		
		INSERT INTO public.logins(date_time_in,ip,session_id)
		VALUES(now(),in_remote_ip,in_id);
		
	EXCEPTION WHEN OTHERS THEN
		UPDATE public.sessions
		SET
			set_time = now(),
			data = in_data
		WHERE id = in_id;
	END;
	
	RETURN;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sess_write(character varying, text, character varying)
  OWNER TO rustent;


-- ******************* update 14/06/2020 07:58:07 ******************
-- Function: sess_enc_read(character varying, text)

-- DROP FUNCTION sess_enc_read(character varying, text);

CREATE OR REPLACE FUNCTION sess_enc_read(in_id character varying,in_key text)
  RETURNS text AS
$BODY$
	SELECT PGP_SYM_DECRYPT(data_enc,in_key) FROM sessions WHERE id = in_id LIMIT 1;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION sess_enc_read(character varying, text)
  OWNER TO rustent;



-- ******************* update 14/06/2020 07:58:26 ******************
-- Function: sess_enc_write(character varying, text, character varying)

-- DROP FUNCTION sess_enc_write(character varying, text,text, character varying);

CREATE OR REPLACE FUNCTION sess_enc_write(
    in_id character varying,
    in_data_enc text,
    in_key text,
    in_remote_ip character varying)
  RETURNS void AS
$BODY$
BEGIN
	UPDATE sessions
	SET
		set_time = now(),
		data_enc = PGP_SYM_ENCRYPT(in_data_enc,in_key)
	WHERE id = in_id;
	
	IF FOUND THEN
		RETURN;
	END IF;
	
	BEGIN
		INSERT INTO sessions (id, data_enc, set_time,session_key)
		VALUES(in_id, PGP_SYM_ENCRYPT(in_data_enc,in_key), now(),in_id);
		
		INSERT INTO logins(date_time_in,ip,session_id)
		VALUES(now(),in_remote_ip,in_id);
		
	EXCEPTION WHEN unique_violation THEN
		UPDATE sessions
		SET
			set_time = now(),
			data_enc = PGP_SYM_ENCRYPT(in_data_enc,in_key)
		WHERE id = in_id;
	END;
	
	RETURN;

END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION sess_enc_write(character varying, text, text, character varying)
  OWNER TO rustent;



-- ******************* update 14/06/2020 07:58:36 ******************
-- Function: sess_gc(interval)

-- DROP FUNCTION sess_gc(interval);

CREATE OR REPLACE FUNCTION sess_gc(in_lifetime interval)
  RETURNS void AS
$BODY$	
	UPDATE logins
	SET date_time_out = now()
	WHERE session_id IN (SELECT id FROM sessions WHERE set_time<(now()-in_lifetime));
	
	DELETE FROM sessions WHERE set_time < (now()-in_lifetime);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION sess_gc(interval)
  OWNER TO rustent;



-- ******************* update 14/06/2020 09:40:29 ******************
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
ALTER TABLE users_view OWNER TO rustent;



-- ******************* update 14/06/2020 10:26:29 ******************
-- View: users_list

 DROP VIEW users_list;

CREATE OR REPLACE VIEW users_list AS 
	SELECT
	 	u.id
	 	,u.name
	 	,u.role_id
	 	,u.phone_cel
	 	,u.tel_ext
	 	,u.email
	 	,u.banned
	 	
 	FROM users AS u
	ORDER BY u.name;

ALTER TABLE users_list OWNER TO rustent;



-- ******************* update 14/06/2020 10:34:59 ******************
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

ALTER TABLE users_dialog OWNER TO rustent;



-- ******************* update 14/07/2020 11:35:00 ******************
-- View: public.doc_orders_dialog

-- DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT jsonb_array_elements(att.file_inf)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 14/07/2020 11:35:20 ******************
-- View: public.doc_orders_dialog

-- DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT jsonb_array_elements(att.file_inf)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 14/07/2020 11:51:19 ******************
-- View: public.doc_orders_dialog

DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT
			array_agg(att.file_inf)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 14/07/2020 11:56:55 ******************
-- View: public.doc_orders_dialog

DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT
			jsonb_agg(att.file_inf)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 15/07/2020 06:27:01 ******************

		ALTER TABLE doc_order_attachments ADD COLUMN preview_data bytea;



-- ******************* update 15/07/2020 06:53:48 ******************
-- View: public.doc_orders_dialog

DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT
			jsonb_agg(
				att.file_inf || jsonb_build_object('dataBase64',encode(att.preview_data, 'base64'))
			)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 15/07/2020 09:36:58 ******************
-- Function: public.format_date_rus(date, boolean)

-- DROP FUNCTION public.format_date_rus(date, boolean);

CREATE OR REPLACE FUNCTION public.format_date_rus(
    date,
    short_year boolean)
  RETURNS text AS
$BODY$
	SELECT
		date_part('day',$1)
		||' '||CASE
			WHEN date_part('month',$1)=1 THEN 'Января'
			WHEN date_part('month',$1)=2 THEN 'Февраля'
			WHEN date_part('month',$1)=3 THEN 'Марта'
			WHEN date_part('month',$1)=4 THEN 'Апреля'
			WHEN date_part('month',$1)=5 THEN 'Мая'
			WHEN date_part('month',$1)=6 THEN 'Июня'
			WHEN date_part('month',$1)=7 THEN 'Июля'
			WHEN date_part('month',$1)=8 THEN 'Августа'
			WHEN date_part('month',$1)=9 THEN 'Сентября'
			WHEN date_part('month',$1)=10 THEN 'Октября'
			WHEN date_part('month',$1)=11 THEN 'Ноября'
			WHEN date_part('month',$1)=12 THEN 'Декабря'
		END
		||' '|| CASE short_year WHEN TRUE THEN date_part('year',$1)-2000 ELSE date_part('year',$1) END;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.format_date_rus(date, boolean)
  OWNER TO rustent;



-- ******************* update 15/07/2020 09:42:26 ******************
-- Function: public.format_date_rus(date, boolean)

-- DROP FUNCTION public.format_date_rus(date, boolean);

CREATE OR REPLACE FUNCTION public.format_date_rus(
    date,
    short_year boolean)
  RETURNS text AS
$BODY$
	SELECT
		date_part('day',$1)
		||' '||CASE
			WHEN date_part('month',$1)=1 THEN 'Января'
			WHEN date_part('month',$1)=2 THEN 'Февраля'
			WHEN date_part('month',$1)=3 THEN 'Марта'
			WHEN date_part('month',$1)=4 THEN 'Апреля'
			WHEN date_part('month',$1)=5 THEN 'Мая'
			WHEN date_part('month',$1)=6 THEN 'Июня'
			WHEN date_part('month',$1)=7 THEN 'Июля'
			WHEN date_part('month',$1)=8 THEN 'Августа'
			WHEN date_part('month',$1)=9 THEN 'Сентября'
			WHEN date_part('month',$1)=10 THEN 'Октября'
			WHEN date_part('month',$1)=11 THEN 'Ноября'
			WHEN date_part('month',$1)=12 THEN 'Декабря'
		END
		||' '|| CASE short_year WHEN TRUE THEN date_part('year',$1)-2000 ELSE date_part('year',$1) END||'г.';
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.format_date_rus(date, boolean)
  OWNER TO rustent;



-- ******************* update 16/07/2020 07:25:02 ******************

					ALTER TYPE doc_order_states ADD VALUE 'notified';
					ALTER TYPE doc_order_states ADD VALUE 'closed';
	/* function */
	CREATE OR REPLACE FUNCTION enum_doc_order_states_val(doc_order_states,locales)
	RETURNS text AS $$
		SELECT
		CASE
		WHEN $1='accept'::doc_order_states AND $2='ru'::locales THEN 'Прием'
		WHEN $1='production'::doc_order_states AND $2='ru'::locales THEN 'Производство'
		WHEN $1='ready'::doc_order_states AND $2='ru'::locales THEN 'Изготовлен'
		WHEN $1='notified'::doc_order_states AND $2='ru'::locales THEN 'Оповещен'
		WHEN $1='closed'::doc_order_states AND $2='ru'::locales THEN 'Закрыт'
		ELSE ''
		END;		
	$$ LANGUAGE sql;	
	ALTER FUNCTION enum_doc_order_states_val(doc_order_states,locales) OWNER TO rustent;		
		

-- ******************* update 16/07/2020 07:52:58 ******************
-- View: public.doc_orders_list

-- DROP VIEW public.doc_orders_list;

CREATE OR REPLACE VIEW public.doc_orders_list AS 
	SELECT	
		t.id
		,t.date_time
		,t.user_id
		,users_ref(u) AS users_ref
		,t.client_id
		,clients_ref(cl) AS clients_ref
		,cl.tel AS client_tel
		,t.order_name
		,t.total
		,t.material_id
		,materials_ref(mat) AS materials_ref
		,t.notes
		,t.color_id
		,colors_ref(col) AS colors_ref
		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_list OWNER TO rustent;


-- ******************* update 16/07/2020 07:54:10 ******************
-- View: public.doc_orders_list

-- DROP VIEW public.doc_orders_list;

CREATE OR REPLACE VIEW public.doc_orders_list AS 
	SELECT	
		t.id
		,t.date_time
		,t.user_id
		,users_ref(u) AS users_ref
		,t.client_id
		,clients_ref(cl) AS clients_ref
		,cl.tel AS client_tel
		,t.order_name
		,t.total
		,t.material_id
		,materials_ref(mat) AS materials_ref
		,t.notes
		,t.color_id
		,colors_ref(col) AS colors_ref
		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt
		,users_ref(last_st_u) AS last_state_users_ref

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	LEFT JOIN users last_st_u ON last_st_u.id = last_st_data.user_id
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_list OWNER TO rustent;


-- ******************* update 16/07/2020 08:07:16 ******************
-- Function: doc_orders_process()

-- DROP FUNCTION doc_orders_process();

CREATE OR REPLACE FUNCTION doc_orders_process()
  RETURNS trigger AS
$BODY$
BEGIN

	IF (TG_WHEN='AFTER' AND TG_OP='INSERT') THEN		
	
		INSERT INTO doc_order_state_hist
		(doc_order_id,state,user_id)
		VALUES
		(NEW.id,'accept',NEW.user_id);
	
		RETURN NEW;

	ELSIF (TG_WHEN='AFTER' AND TG_OP='UPDATE') THEN		
	
		IF NEW.date_time<>OLD.date_time THEN
			UPDATE doc_order_state_hist
			SET date_time = NEW.date_time
			WHERE doc_order_id = NEW.id AND date_time=OLD.date_time AND state='accept';
		END IF;
			
		RETURN NEW;
		
	ELSIF (TG_WHEN='BEFORE' AND TG_OP='DELETE') THEN			
		
		DELETE FROM doc_order_state_hist WHERE doc_order_id = OLD.id;
	
		RETURN OLD;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION doc_orders_process() OWNER TO rustent;



-- ******************* update 16/07/2020 08:08:40 ******************
-- Trigger: doc_orders_after_trigger on doc_orders

-- DROP TRIGGER doc_orders_after_trigger ON doc_orders;

 CREATE TRIGGER doc_orders_after_trigger
  AFTER INSERT OR UPDATE
  ON doc_orders
  FOR EACH ROW
  EXECUTE PROCEDURE doc_orders_process();


-- ******************* update 16/07/2020 08:09:16 ******************
-- Trigger: doc_orders_after_trigger on doc_orders

-- DROP TRIGGER doc_orders_after_trigger ON doc_orders;

/*
 CREATE TRIGGER doc_orders_after_trigger
  AFTER INSERT OR UPDATE
  ON doc_orders
  FOR EACH ROW
  EXECUTE PROCEDURE doc_orders_process();
*/

-- Trigger: doc_orders_before_trigger on doc_orders

-- DROP TRIGGER doc_orders_before_trigger ON doc_orders;


 CREATE TRIGGER doc_orders_before_trigger
  BEFORE DELETE
  ON doc_orders
  FOR EACH ROW
  EXECUTE PROCEDURE doc_orders_process();


-- ******************* update 16/07/2020 09:05:44 ******************
-- View: public.doc_orders_dialog

DROP VIEW public.doc_orders_dialog;

CREATE OR REPLACE VIEW public.doc_orders_dialog AS 
	SELECT	
		t.id
		,t.date_time
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='accept'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_accept
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='production'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_production
		,(
			SELECT date_time
			FROM doc_order_state_hist h
			WHERE h.doc_order_id=t.id AND state='ready'
			ORDER BY h.date_time DESC
			LIMIT 1
		) AS date_time_ready
		,users_ref(u) AS users_ref
		,cl.name AS client_name
		,cl.tel AS client_tel
		,t.order_name
		,t.order_description
		,mat.name AS material_name
		,t.notes
		,col.name AS color_name
		,t.total
		,t.advance_pay
		,t.valubles
		
		,(SELECT
			jsonb_agg(
				att.file_inf || jsonb_build_object('dataBase64',encode(att.preview_data, 'base64'))
			)
		FROM doc_order_attachments att
		WHERE att.doc_order_id = t.id
		) AS attachments

		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt
		,users_ref(last_st_u) AS last_state_users_ref

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	LEFT JOIN users last_st_u ON last_st_u.id = last_st_data.user_id
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_dialog OWNER TO rustent;


-- ******************* update 16/07/2020 09:29:50 ******************
-- View: public.doc_order_state_hist_list

-- DROP VIEW public.doc_order_state_hist_list;

CREATE OR REPLACE VIEW public.doc_order_state_hist_list AS 
	SELECT	
		t.id
		,doc_orders_ref(d) AS doc_orders_ref
		,t.date_time
		,t.state
		,t.user_id
		,users_ref(u) AS users_ref
		,d.client_id
		,clients_ref(cl) AS clients_ref

	FROM doc_order_state_hist t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN doc_orders d ON d.id = t.doc_order_id
	LEFT JOIN clients cl ON cl.id = d.client_id
	ORDER BY t.doc_order_id DESC, t.date_time DESC;

ALTER TABLE public.doc_order_state_hist_list OWNER TO rustent;


-- ******************* update 16/07/2020 10:14:13 ******************
-- View: public.doc_order_state_hist_list

 DROP VIEW public.doc_order_state_hist_list;

CREATE OR REPLACE VIEW public.doc_order_state_hist_list AS 
	SELECT	
		t.id
		,t.doc_order_id
		,doc_orders_ref(d) AS doc_orders_ref
		,t.date_time
		,t.state
		,t.user_id
		,users_ref(u) AS users_ref
		,d.client_id
		,clients_ref(cl) AS clients_ref

	FROM doc_order_state_hist t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN doc_orders d ON d.id = t.doc_order_id
	LEFT JOIN clients cl ON cl.id = d.client_id
	ORDER BY t.doc_order_id DESC, t.date_time DESC;

ALTER TABLE public.doc_order_state_hist_list OWNER TO rustent;


-- ******************* update 16/07/2020 10:51:11 ******************
-- View: public.doc_orders_list

-- DROP VIEW public.doc_orders_list;

CREATE OR REPLACE VIEW public.doc_orders_list AS 
	SELECT	
		t.id
		,t.date_time
		,t.user_id
		,users_ref(u) AS users_ref
		,t.client_id
		,clients_ref(cl) AS clients_ref
		,cl.tel AS client_tel
		,t.order_name
		,t.total
		,t.material_id
		,materials_ref(mat) AS materials_ref
		,t.notes
		,t.color_id
		,colors_ref(col) AS colors_ref
		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt
		,users_ref(last_st_u) AS last_state_users_ref

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.id,
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.id,h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	--LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.id=last_st.id
	LEFT JOIN users last_st_u ON last_st_u.id = last_st_data.user_id
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_list OWNER TO rustent;


-- ******************* update 16/07/2020 10:59:17 ******************
-- View: public.doc_orders_list

-- DROP VIEW public.doc_orders_list;

CREATE OR REPLACE VIEW public.doc_orders_list AS 
	SELECT	
		t.id
		,t.date_time
		,t.user_id
		,users_ref(u) AS users_ref
		,t.client_id
		,clients_ref(cl) AS clients_ref
		,cl.tel AS client_tel
		,t.order_name
		,t.total
		,t.material_id
		,materials_ref(mat) AS materials_ref
		,t.notes
		,t.color_id
		,colors_ref(col) AS colors_ref
		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt
		,users_ref(last_st_u) AS last_state_users_ref

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.id,
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.id,h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	LEFT JOIN users last_st_u ON last_st_u.id = last_st_data.user_id
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_list OWNER TO rustent;


-- ******************* update 16/07/2020 10:59:32 ******************
-- View: public.doc_orders_list

-- DROP VIEW public.doc_orders_list;

CREATE OR REPLACE VIEW public.doc_orders_list AS 
	SELECT	
		t.id
		,t.date_time
		,t.user_id
		,users_ref(u) AS users_ref
		,t.client_id
		,clients_ref(cl) AS clients_ref
		,cl.tel AS client_tel
		,t.order_name
		,t.total
		,t.material_id
		,materials_ref(mat) AS materials_ref
		,t.notes
		,t.color_id
		,colors_ref(col) AS colors_ref
		,last_st_data.state AS last_state
		,last_st_data.date_time AS last_state_dt
		,users_ref(last_st_u) AS last_state_users_ref

	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	
	LEFT JOIN (
		SELECT
			h.doc_order_id,
			max(h.date_time) AS date_time
		FROM doc_order_state_hist h
		GROUP BY h.doc_order_id
	) AS last_st ON last_st.doc_order_id = t.id
	LEFT JOIN doc_order_state_hist AS last_st_data ON last_st_data.doc_order_id=last_st.doc_order_id AND last_st_data.date_time=last_st.date_time
	LEFT JOIN users last_st_u ON last_st_u.id = last_st_data.user_id
	
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_list OWNER TO rustent;


-- ******************* update 17/07/2020 07:28:29 ******************
-- View: public.main_menus_dialog

-- DROP VIEW public.main_menus_dialog;

CREATE OR REPLACE VIEW public.main_menus_dialog AS 
 SELECT m.id,
    m.role_id,
    m.user_id,
    u.name AS user_descr,
    m.content
   FROM main_menus m
     LEFT JOIN users u ON u.id = m.user_id
  ORDER BY m.role_id, u.name;

ALTER TABLE public.main_menus_dialog
  OWNER TO rustent;


