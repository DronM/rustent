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
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTimeTZ.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLJSON.php');
 
class DocOrderStateHistList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_order_state_hist_list");
			
		//*** Field id ***
		$f_opts = array();
		$f_opts['primaryKey'] = TRUE;
		$f_opts['autoInc']=TRUE;
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="id";
						
		$f_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"id",$f_opts);
		$this->addField($f_id);
		//********************
		
		//*** Field doc_order_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="doc_order_id";
						
		$f_doc_order_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_order_id",$f_opts);
		$this->addField($f_doc_order_id);
		//********************
		
		//*** Field doc_orders_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Заказ';
		$f_opts['id']="doc_orders_ref";
						
		$f_doc_orders_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"doc_orders_ref",$f_opts);
		$this->addField($f_doc_orders_ref);
		//********************
		
		//*** Field date_time ***
		$f_opts = array();
		
		$f_opts['alias']='Дата';
		$f_opts['id']="date_time";
						
		$f_date_time=new FieldSQLDateTimeTZ($this->getDbLink(),$this->getDbName(),$this->getTableName(),"date_time",$f_opts);
		$this->addField($f_date_time);
		//********************
		
		//*** Field state ***
		$f_opts = array();
		
		$f_opts['alias']='Статус';
		$f_opts['id']="state";
						
		$f_state=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"state",$f_opts);
		$this->addField($f_state);
		//********************
		
		//*** Field user_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="user_id";
						
		$f_user_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"user_id",$f_opts);
		$this->addField($f_user_id);
		//********************
		
		//*** Field users_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Пользователь';
		$f_opts['id']="users_ref";
						
		$f_users_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"users_ref",$f_opts);
		$this->addField($f_users_ref);
		//********************
		
		//*** Field client_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="client_id";
						
		$f_client_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_id",$f_opts);
		$this->addField($f_client_id);
		//********************
		
		//*** Field clients_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Клиент';
		$f_opts['id']="clients_ref";
						
		$f_clients_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"clients_ref",$f_opts);
		$this->addField($f_clients_ref);
		//********************
	$this->setLimitConstant('doc_per_page_count');
	}

}
?>
