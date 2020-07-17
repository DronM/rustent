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
