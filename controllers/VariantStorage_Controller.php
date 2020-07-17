<?php
require_once(FRAME_WORK_PATH.'basic_classes/ControllerSQL.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtInt.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtString.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtFloat.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtEnum.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtText.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDateTime.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtPassword.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtBool.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtDateTimeTZ.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtJSON.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldExtJSONB.php');

/**
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_php.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 */


class VariantStorage_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL,$dbLink=NULL){
		parent::__construct($dbLinkMaster,$dbLink);
			

		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtInt('user_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('storage_name'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtText('variant_name'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtBool('default_variant'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('filter_data'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('col_visib_data'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('col_order_data'
				,array());
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('VariantStorage_Model');

			
		$pm = new PublicMethod('upsert_filter_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
				
	$opts=array();
			
		$pm->addParam(new FieldExtText('filter_data',$opts));
	
				
	$opts=array();
			
		$pm->addParam(new FieldExtBool('default_variant',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('upsert_col_visib_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('col_visib',$opts));
	
				
	$opts=array();
			
		$pm->addParam(new FieldExtBool('default_variant',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('upsert_col_order_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('col_order',$opts));
	
				
	$opts=array();
			
		$pm->addParam(new FieldExtBool('default_variant',$opts));
	
			
		$this->addPublicMethod($pm);

			
		/* update */		
		$pm = new PublicMethod('update');
		
		$pm->addParam(new FieldExtInt('old_id',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('obj_mode'));
		$param = new FieldExtInt('id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('user_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('storage_name'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('variant_name'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtBool('default_variant'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('filter_data'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('col_visib_data'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('col_order_data'
				,array(
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('VariantStorage_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('VariantStorage_Model');

			
		/* get_list */
		$pm = new PublicMethod('get_list');
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));
		$pm->addParam(new FieldExtString('cond_fields'));
		$pm->addParam(new FieldExtString('cond_sgns'));
		$pm->addParam(new FieldExtString('cond_vals'));
		$pm->addParam(new FieldExtString('cond_ic'));
		$pm->addParam(new FieldExtString('ord_fields'));
		$pm->addParam(new FieldExtString('ord_directs'));
		$pm->addParam(new FieldExtString('field_sep'));

			$f_params = array();
			
				$f_params['required']=TRUE;
			$param = new FieldExtString('storage_name'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('variant_name'
			,$f_params);
		$pm->addParam($param);		
		
		$this->addPublicMethod($pm);
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtString('mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('VariantStorage_Model');		

			
		$pm = new PublicMethod('get_filter_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_col_visib_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_col_order_data');
		
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('storage_name',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;		
		$pm->addParam(new FieldExtText('variant_name',$opts));
	
			
		$this->addPublicMethod($pm);

		
	}	
	
}
?>