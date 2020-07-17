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

ALTER TABLE public.doc_order_state_hist_list OWNER TO ;
