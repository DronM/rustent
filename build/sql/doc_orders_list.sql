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

		,t.ready_date
		,coalesce(last_st_data.state='closed',FALSE) AS closed

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
