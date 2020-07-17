-- Function: public.doc_orders_ref(doc_orders)

-- DROP FUNCTION public.doc_orders_ref(doc_orders);

CREATE OR REPLACE FUNCTION public.doc_orders_ref(doc_orders)
  RETURNS json AS
$BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.id::text||' '||to_char($1.date_time,to_char(now(),'DD/MM/YY HH24:MI')),
		'dataType','doc_orders'
	);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.doc_orders_ref(doc_orders)
  OWNER TO rustent;

