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
