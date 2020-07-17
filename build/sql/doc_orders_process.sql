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
ALTER FUNCTION doc_orders_process() OWNER TO ;

