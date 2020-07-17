-- Function: public.colors_ref(materials)

-- DROP FUNCTION public.colors_ref(colors);

CREATE OR REPLACE FUNCTION public.colors_ref(colors)
  RETURNS json AS
$BODY$
	SELECT json_build_object(
		'keys',json_build_object(
			'id',$1.id    
			),	
		'descr',$1.name,
		'dataType','colors'
	);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION public.colors_ref(colors)
  OWNER TO rustent;

