<?php
/**
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model_php.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 */

require_once(FRAME_WORK_PATH.'basic_classes/ModelSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTimeTZ.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLJSON.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLJSONB.php');
 
class DocOrderDialog_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_orders_dialog");
			
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
		
		$f_opts['alias']='Дата приема заказа';
		$f_opts['id']="date_time";
						
		$f_date_time=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
		
		//*** Field date_time_accept ***
		$f_opts = array();
		
		$f_opts['alias']='Дата приема';
		$f_opts['id']="date_time_accept";
						
		$f_date_time_accept=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time_accept",$f_opts);
		$this->addField($f_date_time_accept);
		//********************
		
		//*** Field date_time_production ***
		$f_opts = array();
		
		$f_opts['alias']='Дата передачи в производство';
		$f_opts['id']="date_time_production";
						
		$f_date_time_production=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time_production",$f_opts);
		$this->addField($f_date_time_production);
		//********************
		
		//*** Field date_time_ready ***
		$f_opts = array();
		
		$f_opts['alias']='Дата изготовления';
		$f_opts['id']="date_time_ready";
						
		$f_date_time_ready=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time_ready",$f_opts);
		$this->addField($f_date_time_ready);
		//********************
		
		//*** Field users_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Пользователь';
		$f_opts['id']="users_ref";
						
		$f_users_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"users_ref",$f_opts);
		$this->addField($f_users_ref);
		//********************
		
		//*** Field client_name ***
		$f_opts = array();
		
		$f_opts['alias']='Контрагент';
		$f_opts['id']="client_name";
						
		$f_client_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_name",$f_opts);
		$this->addField($f_client_name);
		//********************
		
		//*** Field client_tel ***
		$f_opts = array();
		$f_opts['id']="client_tel";
						
		$f_client_tel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_tel",$f_opts);
		$this->addField($f_client_tel);
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
		
		//*** Field material_name ***
		$f_opts = array();
		
		$f_opts['alias']='Материал';
		$f_opts['id']="material_name";
						
		$f_material_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_name",$f_opts);
		$this->addField($f_material_name);
		//********************
		
		//*** Field notes ***
		$f_opts = array();
		$f_opts['id']="notes";
						
		$f_notes=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"notes",$f_opts);
		$this->addField($f_notes);
		//********************
		
		//*** Field color_name ***
		$f_opts = array();
		
		$f_opts['alias']='Цвет';
		$f_opts['id']="color_name";
						
		$f_color_name=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"color_name",$f_opts);
		$this->addField($f_color_name);
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
		
		//*** Field valubles ***
		$f_opts = array();
		$f_opts['id']="valubles";
						
		$f_valubles=new FieldSQLJSONB($this->getDbLink(),$this->getDbName(),$this->getTableName(),"valubles",$f_opts);
		$this->addField($f_valubles);
		//********************
		
		//*** Field attachments ***
		$f_opts = array();
		$f_opts['id']="attachments";
		$f_opts['noValueOnCopy'] = TRUE;
						
		$f_attachments=new FieldSQLJSONB($this->getDbLink(),$this->getDbName(),$this->getTableName(),"attachments",$f_opts);
		$this->addField($f_attachments);
		//********************
		
		//*** Field last_state ***
		$f_opts = array();
		
		$f_opts['alias']='Текущий статус';
		$f_opts['id']="last_state";
		$f_opts['noValueOnCopy'] = TRUE;
						
		$f_last_state=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state",$f_opts);
		$this->addField($f_last_state);
		//********************
		
		//*** Field last_state_dt ***
		$f_opts = array();
		
		$f_opts['alias']='Дата текущего статуса';
		$f_opts['id']="last_state_dt";
		$f_opts['noValueOnCopy'] = TRUE;
						
		$f_last_state_dt=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state_dt",$f_opts);
		$this->addField($f_last_state_dt);
		//********************
		
		//*** Field last_state_users_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Пользователь, установивший текущий статус';
		$f_opts['id']="last_state_users_ref";
		$f_opts['noValueOnCopy'] = TRUE;
						
		$f_last_state_users_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state_users_ref",$f_opts);
		$this->addField($f_last_state_users_ref);
		//********************
	$this->setLimitConstant('doc_per_page_count');
	}

}
?>
