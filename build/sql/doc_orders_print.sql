-- View: public.doc_orders_print

--DROP VIEW public.doc_orders_print;

CREATE OR REPLACE VIEW public.doc_orders_print AS 
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
		
	FROM doc_orders t
	LEFT JOIN users u ON u.id = t.user_id
	LEFT JOIN colors col ON col.id = t.color_id
	LEFT JOIN materials mat ON mat.id = t.material_id
	LEFT JOIN clients cl ON cl.id = t.client_id
	ORDER BY t.date_time DESC;

ALTER TABLE public.doc_orders_print OWNER TO rustent;
