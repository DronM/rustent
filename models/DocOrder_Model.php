<?php
/**
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model_php.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 */

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDate.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTimeTZ.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLJSONB.php');
 
class DocOrder_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_orders");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['id']="id";
						
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
		
		//*** Field date_time ***
		$f_opts = array();
		$f_opts['defaultValue']='CURRENT_TIMESTAMP';
		$f_opts['id']="date_time";
						
		$f_date_time=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
		
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['id']="user_id";
						
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
		
		//*** Field client_id ***
		$f_opts = array();
		$f_opts['id']="client_id";
						
		$f_client_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_id",$f_opts);
		$this->addField($f_client_id);
		//********************
		
		//*** Field order_name ***
		$f_opts = array();
		$f_opts['id']="order_name";
						
		$f_order_name=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"order_name",$f_opts);
		$this->addField($f_order_name);
		//********************
		
		//*** Field order_description ***
		$f_opts = array();
		$f_opts['id']="order_description";
						
		$f_order_description=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"order_description",$f_opts);
		$this->addField($f_order_description);
		//********************
		
		//*** Field material_id ***
		$f_opts = array();
		$f_opts['id']="material_id";
						
		$f_material_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_id",$f_opts);
		$this->addField($f_material_id);
		//********************
		
		//*** Field color_id ***
		$f_opts = array();
		$f_opts['id']="color_id";
						
		$f_color_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"color_id",$f_opts);
		$this->addField($f_color_id);
		//********************
		
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
						
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
		
		//*** Field advance_pay ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="advance_pay";
						
		$f_advance_pay=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"advance_pay",$f_opts);
		$this->addField($f_advance_pay);
		//********************
		
		//*** Field notes ***
		$f_opts = array();
		$f_opts['id']="notes";
						
		$f_notes=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"notes",$f_opts);
		$this->addField($f_notes);
		//********************
		
		//*** Field valubles ***
		$f_opts = array();
		$f_opts['id']="valubles";
						
		$f_valubles=new FieldSQLJSONB($this->getDbLink(),$this->getDbName(),$this->getTableName(),"valubles",$f_opts);
		$this->addField($f_valubles);
		//********************
		
		//*** Field ready_date ***
		$f_opts = array();
		
		$f_opts['alias']='Срок исполнения';
		$f_opts['id']="ready_date";
						
		$f_ready_date=new FieldSQLDate($this->getDbLink(),$this->getDbName(),$this->getTableName(),"ready_date",$f_opts);
		$this->addField($f_ready_date);
		//********************
	$this->setLimitConstant('doc_per_page_count');
	}

}
?>
