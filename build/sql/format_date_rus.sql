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
  OWNER TO ;

