
	-- ********** constant value table  allowed_extesions *************
	CREATE TABLE IF NOT EXISTS const_allowed_extesions
	(name text, descr text, val text,
		val_type text,ctrl_class text,ctrl_options json, view_class text,view_options json);
	ALTER TABLE const_allowed_extesions OWNER TO rustent;
	INSERT INTO const_allowed_extesions (name,descr,val,val_type,ctrl_class,ctrl_options,view_class,view_options) VALUES (
		'Разрешенные расширения файлдов для загрузки'
		,'Список расширений через запятую, разрешенных для загрузки'
		,
			'jpg,png,jpeg,pdf,doc,docx,xls,xlsx'
		,'Text'
		,NULL
		,NULL
		,NULL
		,NULL
	);
		--constant get value
	CREATE OR REPLACE FUNCTION const_allowed_extesions_val()
	RETURNS text AS
	$BODY$
		SELECT val::text AS val FROM const_allowed_extesions LIMIT 1;
	$BODY$
	LANGUAGE sql STABLE COST 100;
	ALTER FUNCTION const_allowed_extesions_val() OWNER TO rustent;
	--constant set value
	CREATE OR REPLACE FUNCTION const_allowed_extesions_set_val(Text)
	RETURNS void AS
	$BODY$
		UPDATE const_allowed_extesions SET val=$1;
	$BODY$
	LANGUAGE sql VOLATILE COST 100;
	ALTER FUNCTION const_allowed_extesions_set_val(Text) OWNER TO rustent;
	--edit view: all keys and descr
	CREATE OR REPLACE VIEW const_allowed_extesions_view AS
	SELECT
		'allowed_extesions'::text AS id
		,t.name
		,t.descr
	,
	t.val::text AS val
	,t.val_type::text AS val_type
	,t.ctrl_class::text
	,t.ctrl_options::json
	,t.view_class::text
	,t.view_options::json
	FROM const_allowed_extesions AS t
	;
	ALTER VIEW const_allowed_extesions_view OWNER TO rustent;
	CREATE OR REPLACE VIEW constants_list_view AS
	SELECT *
	FROM const_doc_per_page_count_view
	UNION ALL
	SELECT *
	FROM const_grid_refresh_interval_view
	UNION ALL
	SELECT *
	FROM const_session_live_time_view
	UNION ALL
	SELECT *
	FROM const_allowed_extesions_view;
	ALTER VIEW constants_list_view OWNER TO rustent;
	
