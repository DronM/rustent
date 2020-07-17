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
require_once(FRAME_WORK_PATH.'basic_classes/ModelOrderSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLDateTimeTZ.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldSQLJSON.php');
 
class DocOrderList_Model extends ModelSQL{
	
	public function __construct($dbLink){
		parent::__construct($dbLink);
		
		$this->setDbName("public");
		
		$this->setTableName("doc_orders_list");
			
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
		
		$f_opts['alias']='Контрагент';
		$f_opts['id']="clients_ref";
						
		$f_clients_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"clients_ref",$f_opts);
		$this->addField($f_clients_ref);
		//********************
		
		//*** Field client_tel ***
		$f_opts = array();
		$f_opts['id']="client_tel";
						
		$f_client_tel=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"client_tel",$f_opts);
		$this->addField($f_client_tel);
		//********************
		
		//*** Field material_id ***
		$f_opts = array();
		$f_opts['sysCol']=TRUE;
		$f_opts['id']="material_id";
						
		$f_material_id=new FieldSQLInt($this->getDbLink(),$this->getDbName(),$this->getTableName(),"material_id",$f_opts);
		$this->addField($f_material_id);
		//********************
		
		//*** Field materials_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Материал';
		$f_opts['id']="materials_ref";
						
		$f_materials_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"materials_ref",$f_opts);
		$this->addField($f_materials_ref);
		//********************
		
		//*** Field order_name ***
		$f_opts = array();
		$f_opts['id']="order_name";
						
		$f_order_name=new FieldSQLText($this->getDbLink(),$this->getDbName(),$this->getTableName(),"order_name",$f_opts);
		$this->addField($f_order_name);
		//********************
		
		//*** Field total ***
		$f_opts = array();
		$f_opts['length']=15;
		$f_opts['id']="total";
						
		$f_total=new FieldSQLFloat($this->getDbLink(),$this->getDbName(),$this->getTableName(),"total",$f_opts);
		$this->addField($f_total);
		//********************
		
		//*** Field last_state ***
		$f_opts = array();
		
		$f_opts['alias']='Текущий статус';
		$f_opts['id']="last_state";
						
		$f_last_state=new FieldSQLString($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state",$f_opts);
		$this->addField($f_last_state);
		//********************
		
		//*** Field last_state_dt ***
		$f_opts = array();
		
		$f_opts['alias']='Дата текущего статуса';
		$f_opts['id']="last_state_dt";
						
		$f_last_state_dt=new FieldSQLDateTime($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state_dt",$f_opts);
		$this->addField($f_last_state_dt);
		//********************
		
		//*** Field last_state_users_ref ***
		$f_opts = array();
		
		$f_opts['alias']='Пользователь, установивший текущий статус';
		$f_opts['id']="last_state_users_ref";
						
		$f_last_state_users_ref=new FieldSQLJSON($this->getDbLink(),$this->getDbName(),$this->getTableName(),"last_state_users_ref",$f_opts);
		$this->addField($f_last_state_users_ref);
		//********************
	
		$order = new ModelOrderSQL();		
		$this->setDefaultModelOrder($order);		
		$direct = 'DESC';
		$order->addField($f_date_time,$direct);
$this->setLimitConstant('doc_per_page_count');
	$this->setAggFunctions(
		array(array('alias'=>'total_total','expr'=>'sum(total)')
)
	);	

	}

}
?>
