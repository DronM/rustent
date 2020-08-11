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



require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldXML.php');

require_once('common/downloader.php');

class DocOrder_Controller extends ControllerSQL{
	public function __construct($dbLinkMaster=NULL,$dbLink=NULL){
		parent::__construct($dbLinkMaster,$dbLink);
			

		/* insert */
		$pm = new PublicMethod('insert');
		$param = new FieldExtDateTimeTZ('date_time'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtInt('user_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('client_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('order_name'
				,array('required'=>TRUE));
		$pm->addParam($param);
		$param = new FieldExtText('order_description'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('material_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtInt('color_id'
				,array());
		$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array());
		$pm->addParam($param);
		$param = new FieldExtFloat('advance_pay'
				,array());
		$pm->addParam($param);
		$param = new FieldExtText('notes'
				,array());
		$pm->addParam($param);
		$param = new FieldExtJSONB('valubles'
				,array());
		$pm->addParam($param);
		
		$pm->addParam(new FieldExtInt('ret_id'));
		
			$f_params = array();
			
				$f_params['required']=TRUE;
			$param = new FieldExtString('client_name'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			
				$f_params['required']=TRUE;
			$param = new FieldExtString('client_tel'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('material_name'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('color_name'
			,$f_params);
		$pm->addParam($param);		
		
		
		$this->addPublicMethod($pm);
		$this->setInsertModelId('DocOrder_Model');

			
		$pm = new PublicMethod('add_file');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_order_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtText('file_data',$opts));
	
				
	$opts=array();
	
		$opts['length']=36;
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('file_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('delete_file');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_order_id',$opts));
	
				
	$opts=array();
	
		$opts['length']=36;
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('file_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_file');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_order_id',$opts));
	
				
	$opts=array();
	
		$opts['length']=36;
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('file_id',$opts));
	
				
	$opts=array();
					
		$pm->addParam(new FieldExtInt('inline',$opts));
	
			
		$this->addPublicMethod($pm);

			
		$pm = new PublicMethod('get_files_list');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_order_id',$opts));
	
			
		$this->addPublicMethod($pm);

			
		/* update */		
		$pm = new PublicMethod('update');
		
		$pm->addParam(new FieldExtInt('old_id',array('required'=>TRUE)));
		
		$pm->addParam(new FieldExtInt('obj_mode'));
		$param = new FieldExtInt('id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtDateTimeTZ('date_time'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('user_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('client_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('order_name'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('order_description'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('material_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtInt('color_id'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('total'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtFloat('advance_pay'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtText('notes'
				,array(
			));
			$pm->addParam($param);
		$param = new FieldExtJSONB('valubles'
				,array(
			));
			$pm->addParam($param);
		
			$param = new FieldExtInt('id',array(
			));
			$pm->addParam($param);
		
			$f_params = array();
			$param = new FieldExtString('client_name'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('client_tel'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('material_name'
			,$f_params);
		$pm->addParam($param);		
		
			$f_params = array();
			$param = new FieldExtString('color_name'
			,$f_params);
		$pm->addParam($param);		
		
		
			$this->addPublicMethod($pm);
			$this->setUpdateModelId('DocOrder_Model');

			
		/* delete */
		$pm = new PublicMethod('delete');
		
		$pm->addParam(new FieldExtInt('id'
		));		
		
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('from'));				
		$this->addPublicMethod($pm);					
		$this->setDeleteModelId('DocOrder_Model');

			
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

		$this->addPublicMethod($pm);
		
		$this->setListModelId('DocOrderList_Model');
		
			
		/* get_object */
		$pm = new PublicMethod('get_object');
		$pm->addParam(new FieldExtString('mode'));
		
		$pm->addParam(new FieldExtInt('id'
		));
		
		
		$this->addPublicMethod($pm);
		$this->setObjectModelId('DocOrderDialog_Model');		

			
		/* complete  */
		$pm = new PublicMethod('complete');
		$pm->addParam(new FieldExtString('pattern'));
		$pm->addParam(new FieldExtInt('count'));
		$pm->addParam(new FieldExtInt('ic'));
		$pm->addParam(new FieldExtInt('mid'));
		$pm->addParam(new FieldExtString('id'));		
		$this->addPublicMethod($pm);					
		$this->setCompleteModelId('DocOrderList_Model');

			
		$pm = new PublicMethod('get_print');
		
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('doc_order_id',$opts));
	
				
	$opts=array();
	
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtInt('inline',$opts));
	
				
	$opts=array();
	
		$opts['length']=100;
		$opts['required']=TRUE;				
		$pm->addParam(new FieldExtString('templ',$opts));
	
			
		$this->addPublicMethod($pm);

		
	}	
	

	private static function get_data_file_path(){
		return OUTPUT_PATH;
	}

	private static function get_data_file_pref($docId){
		return self::get_data_file_path().'ord_'.$docId.'_';
	}
	
	private static function delete_data_file($fl){
		unlink($fl);
	}
	
	private static function delete_data_files($docId){
		$files = glob(self::get_data_file_pref($docId).'*');
		foreach($files as $fl){
			self::delete_data_file($fl);
		}
	}

	private static function get_thumbnail($fl,$mimeType){
		$thbn_pref = OUTPUT_PATH.uniqid();		
		if($mimeType=='application/pdf'){
			$cmd = sprintf("pdftoppm -q -l 1 -scale-to 150 -jpeg '%s' '%s'",$fl,$thbn_pref);
			exec($cmd);
			if(file_exists($thbn_pref.'-1.jpg')){
				$thbn_fl = $thbn_pref.'-1.jpg';
			}
			else if(file_exists($thbn_pref.'-01.jpg')){
				$thbn_fl = $thbn_pref.'-01.jpg';
			}
			
		}
		else if(substr($mimeType,0,5)=='image'){
			$thbn_fl = $thbn_pref.'.gif';
			$cmd = sprintf("convert -define jpeg:size=500x180 '%s' -auto-orient -thumbnail 250x100 -unsharp 0x.5 '%s'",$fl,$thbn_fl);
			exec($cmd);
		}
		
		return (file_exists($thbn_fl)? $thbn_fl:NULL);
	}

	public static function insertParam(&$controller,&$link,&$pm,$tableName,$paramName){
		if($pm->getParamValue($paramName.'_name')){
			$ar = $link->query_first(sprintf(
				"SELECT id FROM %s WHERE lower(name)=lower(%s)",
				$tableName,
				$controller->getExtDbVal($pm,$paramName.'_name')
			));
			
			if(!is_array($ar) || !count($ar) || !isset($ar['id'])){
				$ar = $link->query_first(sprintf(
					"INSERT INTO %s
					(name)
					VALUES (%s)
					RETURNING id",
					$tableName,
					$controller->getExtDbVal($pm,$paramName.'_name')
				));
			}
			
			$pm->setParamValue($paramName.'_id',$ar['id']);	
		}
	}

	public static function updateParam(&$controller,&$link,&$pm,$tableName,$paramName){
		$new_name = $controller->getExtVal($pm,$paramName.'_name');
	
		if($new_name){
			$ar = $link->query_first(sprintf(
				"SELECT id,name FROM %s WHERE id=(SELECT o.%s_id FROM doc_orders o WHERE o.id=%d)",
				$tableName,
				$paramName,
				$controller->getExtDbVal($pm,'old_id')
			));
		
			if(is_array($ar) && count($ar)){
				$fld = '';
				if($new_name&&$new_name!=$ar['name']){
					$fld.= ($fld=='')? '':',';
					$fld.= sprintf('name=%s',$controller->getExtDbVal($pm,$paramName.'_name'));
				}
				$link->query(sprintf(
					"UPDATE %s
					SET %s
					WHERE id=%d",
					$tableName,
					$fld,			
					$ar['id']
				));					
			}
		}	
	}

	public static function updateMaterial(&$controller,&$link,&$pm){
		self::updateParam($controller,$link,$pm,'materials','material');
	}

	public static function updateColor(&$controller,&$link,&$pm){
		self::updateParam($controller,$link,$pm,'colors','color');
	}

	public static function insertMaterial(&$controller,&$link,&$pm){
		self::insertParam($controller,$link,$pm,'materials','material');
	}
	public static function insertColor(&$controller,&$link,&$pm){
		self::insertParam($controller,$link,$pm,'colors','color');
	}


	public static function insertClient(&$controller,&$link,&$pm){
		if($pm->getParamValue('client_name')){
			$ar = $link->query_first(sprintf(
				"SELECT id FROM clients WHERE lower(name)=lower(%s) AND tel=%s",
				$controller->getExtDbVal($pm,'client_name'),
				$controller->getExtDbVal($pm,'client_tel')
			));
			
			if(!is_array($ar) || !count($ar) || !isset($ar['id'])){
				$ar = $link->query_first(sprintf(
					"INSERT INTO clients
					(name,tel)
					VALUES (%s,%s)
					RETURNING id",
					$controller->getExtDbVal($pm,'client_name'),
					$controller->getExtDbVal($pm,'client_tel')
				));
			}
			
			$pm->setParamValue('client_id',$ar['id']);	
		}
	}

	public static function updateClient(&$controller,&$link,&$pm){
		$new_name = $controller->getExtVal($pm,'client_name');
		$new_tel = $controller->getExtVal($pm,'client_tel');
	
		if($new_name||$new_tel){
			$ar = $link->query_first(sprintf(
				"SELECT id,name,tel FROM clients WHERE id=(SELECT o.client_id FROM doc_orders o WHERE o.id=%d)",
				$controller->getExtDbVal($pm,'old_id')
			));
		
			if(is_array($ar) && count($ar)){
				$fld = '';
				if($new_name&&$new_name!=$ar['name']){
					$fld.= ($fld=='')? '':',';
					$fld.= sprintf('name=%s',$controller->getExtDbVal($pm,'client_name'));
				}
				if($new_tel&&$new_tel!=$ar['tel']){
					$fld.= ($fld=='')? '':',';
					$fld.= sprintf('tel=%s',$controller->getExtDbVal($pm,'client_tel'));
				}
				$link->query(sprintf(
					"UPDATE clients
					SET %s
					WHERE id=%d",
					$fld,
					$ar['id']
				));					
			}
		}	
	}

	public function update($pm){
		$pm->setParamValue('user_id',$_SESSION['user_id']);	
		$link = $this->getDbLinkMaster();
		$link->query("BEGIN");
		try{	
			self::updateClient($this,$link,$pm);
			self::updateMaterial($this,$link,$pm);
			self::updateColor($this,$link,$pm);
			
			parent::update($pm);
			
			if(file_exists($fl=OUTPUT_PATH.'order_'.$pm->getParamValue('old_id').'.pdf')){
				unlink($fl);
			}
			
			$link->query("COMMIT");
		}
		catch(Exception $e){
			$link->query("ROLLBACK");
			throw $e;
		}		
	}

	public function insert($pm){	
		$pm->setParamValue('user_id',$_SESSION['user_id']);	
	
		$link = $this->getDbLinkMaster();
		$link->query("BEGIN");
		try{	
			self::insertClient($this,$link,$pm);	
			self::insertMaterial($this,$link,$pm);	
			self::insertColor($this,$link,$pm);	
			
			$inserted_ids = parent::insert($pm);
			
			$link->query("COMMIT");
		}
		catch(Exception $e){
			$link->query("ROLLBACK");
			throw $e;
		}		
	}

	public function delete($pm){
		$link = $this->getDbLinkMaster();
		$link->query("BEGIN");
		try{	
	
			$link->query(sprintf(
				"DELETE FROM doc_order_attachments WHERE doc_order_id=%d"
				,$this->getExtDbVal($pm,"id")
			));
		
			parent::delete($pm);

			if(file_exists($fl=OUTPUT_PATH.'order_'.$this->getExtDbVal($pm,'id').'.pdf')){
				unlink($fl);
			}

			self::delete_data_files($this->getExtDbVal($pm,'id'));

			$link->query("COMMIT");
		}
		catch(Exception $e){
			$link->query("ROLLBACK");
			throw $e;
		}		
	}



	public function add_file($pm){	
		$fl = self::get_data_file_pref($this->getExtVal($pm,"doc_order_id")).$this->getExtVal($pm,"file_id");
		if(file_exists($fl)){
			self::delete_data_file($fl);
		}
		
		if(isset($_FILES) && isset($_FILES['file_data'])){
			
			$allowed = array("jpg","pdf","png","jpeg","doc","docx","xls","xlsx");
			$ext = pathinfo($_FILES['file_data']['name'][0], PATHINFO_EXTENSION);
			if (!in_array(strtolower($ext), $allowed)) {
				throw new Exception('Файлы с данным расширением загружать запрещено!');
			}		
			
			if(!move_uploaded_file($_FILES['file_data']['tmp_name'][0],$fl)){
				throw new Exception('Ошибка загрузки файла!');
			}
			
			$link = $this->getDbLinkMaster();
			try{
				$link->query("BEGIN");
			
				$fl_mime = getMimeTypeOnExt($_FILES['file_data']['name'][0]);//mime_content_type($fl)
				$prev_fl = self::get_thumbnail($fl,$fl_mime);
				if($prev_fl){
					$prev_data = file_get_contents($prev_fl);
				}
				try{
					$link->query(sprintf(
						"DELETE FROM doc_order_attachments WHERE id=%s"
						,$this->getExtDbVal($pm,"file_id")
					));

					$link->query(sprintf(
						"INSERT INTO doc_order_attachments
						(id,doc_order_id,file_inf,file_data,preview_data)
						VALUES
						(%s,
						%d,
						jsonb_build_object(
							'id',%s
							,'name','%s'
							,'size',%s
							,'mime','%s'
						),
						'%s',
						%s
						)"
						,$this->getExtDbVal($pm,"file_id")
						,$this->getExtDbVal($pm,"doc_order_id")
						,$this->getExtDbVal($pm,"file_id")
						,$_FILES['file_data']['name'][0]
						,filesize($fl)
						,$fl_mime
						,pg_escape_bytea(file_get_contents($fl))
						,$prev_fl? "'".pg_escape_bytea($prev_data)."'":'NULL'
					));
			
					$link->query("COMMIT");
				}
				finally{
					if(file_exists($prev_fl)){
						unlink($prev_fl);
					}
				}
					
			}
			catch(Exception $e){
				$link->query("ROLLBACK");
				unlink($fl);
				throw $e;
			}
		}
		
		if($prev_data){
			$this->addModel(new ModelVars(
				array('name'=>'Vars',
					'id'=>'Preview_Model',
					'values'=>array(
							new Field('value',DT_STRING,array('value'=>base64_encode($prev_data) ))
						)
					)
				)
			);		
		}		
	}

	public function delete_file($pm){
		$this->getDbLinkMaster()->query(sprintf(
			"DELETE FROM doc_order_attachments WHERE id=%s AND doc_order_id=%d"
			,$this->getExtDbVal($pm,"file_id")
			,$this->getExtDbVal($pm,"doc_order_id")
		));
		
		$fl = self::get_data_file_pref($this->getExtVal($pm,"doc_order_id")).$this->getExtVal($pm,"file_id");
		if(file_exists($fl)){
			self::delete_data_file($fl);
		}
	}
	
	public function get_file($pm){
		$fl = self::get_data_file_pref($this->getExtVal($pm,"doc_order_id")).$this->getExtVal($pm,"file_id");
		$need_data = !file_exists($fl);

		$ar = $this->getDbLink()->query_first(sprintf(
			"SELECT
				file_inf%s
			FROM doc_order_attachments
			WHERE id=%s AND doc_order_id=%d"
			,$need_data? ",file_data":""
			,$this->getExtDbVal($pm,"file_id")
			,$this->getExtDbVal($pm,"doc_order_id")
		));

		if(!is_array($ar) || !count($ar)){
			throw new Exception('Файл не найден!');
		}

		if($need_data){
			file_put_contents($fl,pg_unescape_bytea($ar['file_data']));
		}

		$fl_n = json_decode($ar['file_inf'])->name;
		$fl_mime = getMimeTypeOnExt($fl_n);
		/*json_decode($ar['file_inf'])->mime;
		if(!$fl_mime){
			$fl_mime = mime_content_type($fl_n);//getMimeTypeOnExt($fl_n);
		}
		*/
		ob_clean();
		downloadFile(
			$fl,
			$fl_mime,
			($this->getExtVal($pm,"inline")==1)? 'inline;':'attachment;',
			$fl_n
		);
		return TRUE;
		
	}


	public function get_files_list($pm){
		$this->addNewModel(sprintf(
			"SELECT
				file_inf
			FROM doc_order_attachments
			WHERE doc_order_id=%d"
			,$this->getExtDbVal($pm,"doc_order_id")
		),
		'FileList_Model'
		);					
	}

	/**
	 * @param {string} content XML content
	 * @param {string} documentType pdf|doc
	 */
	private function print_document($templName,$outFileName,$outFile,&$content,$documentType){
		$xml = '<?xml version="1.0" encoding="UTF-8"?>';
		$xml.= '<document>';
		$xml.= $content;
		$xml.= '</document>';
		$out_file_tmp = OUTPUT_PATH.uniqid().".".$documentType;
		
		if($documentType=='pdf'){
			$xml_file = OUTPUT_PATH.uniqid().".xml";
			file_put_contents($xml_file,$xml);
			try{
				//FOP
				$xslt_file = USER_VIEWS_PATH.$templName.".".$documentType.".xsl";			
				$cmd = sprintf(PDF_CMD_TEMPLATE,$xml_file, $xslt_file, $out_file_tmp);
				exec($cmd);
			}
			finally{
				if (file_exists($xml_file) && (file_exists($out_file_tmp)||!DEBUG ) ){
					unlink($xml_file);
				}			
			}
		}
		else{
			//word
			$xslt_file = USER_VIEWS_PATH.$_REQUEST['templ'].sprintf(".%s.xsl",$documentType);
			if(!file_exists($xslt_file)){
				throw new Exception('Template not found!');
			}
			$xml_file = OUTPUT_PATH.uniqid().".xml";
			file_put_contents($xml_file,$xml);
			try{
				$xml_transformed = OUTPUT_PATH.uniqid().".xml";
			
				/*exec(sprintf("xsltproc '%s' '%s' > '%s'",$xslt_file,$xml_file,$xml_transformed));
				$tidy = new tidy();
				$str = $tidy->repairString($xml_transformed,'/home/andrey/www/htdocs/expert72/views/enum/tidy.md.ini');
				file_put_contents($xml_transformed,$str);
				*/
			
				$doc = new DOMDocument();     
				$xsl = new XSLTProcessor();
				set_error_handler(function($number, $error){
					if (preg_match('/^DOMDocument::loadXML\(\): (.+)$/', $error, $m) === 1) {
						throw new Exception($m[1]);
					}
				});			
				$doc->load($xslt_file);
				restore_error_handler();
			
				libxml_use_internal_errors(true);
				$result = $xsl->importStyleSheet($doc);
				if (!$result) {
					$er_str = '';
					foreach (libxml_get_errors() as $error) {
						 $er_str.= ($er_str==''? '':' ');
						 $er_str.= "Libxml error: {$error->message}\n";
					}
					throw new $er_str;
				}
				libxml_use_internal_errors(false);			
			
				$xmlDoc = new DOMDocument();
				$xmlDoc->loadXML($xml);
				//$xmlDoc->formatOutput=TRUE;
				//$xmlDoc->save(OUTPUT_PATH.'page.xml');			
				$xml = $xsl->transformToXML($xmlDoc);
				file_put_contents($xml_transformed,$xml);
				try{
					self::makeDOCXFile($xml_transformed,$out_file_tmp);
				}
				finally{
					unlink($xml_transformed);
				}
			}
			finally{
				unlink($xml_file);
			}
		}
		
		if (!file_exists($out_file_tmp)){
			$this->setHeaderStatus(400);
			$m = NULL;
			if (DEBUG && $documentType=='pdf'){
				$m = 'Ошибка формирования файла! CMD='.$cmd;
			}
			else{
				$m = 'Ошибка формирования файла!';				
			}
			throw new Exception($m);
		}
		try{
			rename($out_file_tmp, $outFile);
			ob_clean();
			downloadFile(
				$outFile,
				'application/'.$documentType,
				(isset($_REQUEST['inline']) && $_REQUEST['inline']=='1')? 'inline;':'attachment;',
				$outFileName.".".$documentType
			);
		}
		finally{
			if (file_exists($out_file_tmp)){
				rename($out_file_tmp, $outFile);
			}
		}	
		return TRUE;
	}

	public function get_print($pm){
	
		$doc_type = 'pdf';//strtolower($this->getExtVal($pm,'doc_type'));
		if(!($doc_type=='pdf' || $doc_type=='doc' || $doc_type=='docx')){
			$this->setHeaderStatus(400);
			throw new Exception('Unsupported document type!');
		}
	
		$ord_id = $this->getExtDbVal($pm,'doc_order_id');
		$out_file = OUTPUT_PATH.'order_'.$ord_id.'.'.$doc_type;
		
		$templ_name = $pm->getParamValue('templ');
		
		if (
		file_exists($out_file)
		){
			$mime = getMimeTypeOnExt($out_file);
			ob_clean();
			downloadFile(
				$out_file,
				$mime,
				(isset($_REQUEST['inline']) && $_REQUEST['inline']=='1')? 'inline;':'attachment;',
				'Заказ №'||$ord_id.'.'.$doc_type
			);
			return TRUE;			
		}
	
		//********************************
		$ar = $this->getDbLink()->query_first(sprintf(
			"SELECT
				d.*
				,format_date_rus(d.date_time::DATE,FALSE) AS date_descr
				,to_char(d.date_time,'DD.MM.YYYY') AS date_time_formatted
				,to_char(d.date_time_production,'DD.MM.YYYY') AS date_time_production_formatted
				,to_char(d.date_time_ready,'DD.MM.YYYY') AS date_time_ready_formatted
			FROM doc_orders_dialog AS d
			WHERE d.id=%d",
		$ord_id
		));
	
		$ar['attachments'] = NULL;
		
		//valubles
		$valubles_m = json_decode($ar['valubles'],TRUE);
		$ar['valubles'] = '';
		foreach($valubles_m['rows'] as $row){
			$ar['valubles'].=sprintf('<valuble><name>%s</name><quant>%s</quant></valuble>',
				htmlspecialchars($row['fields']['name'])
				,$row['fields']['quant']
			);
		}
		
		//*************************************************
		$m_fields = array();
		foreach($ar as $f_id=>$f_val){
			array_push(
				$m_fields,
				new FieldXML($f_id,DT_STRING,array('value'=>$f_val))
			);
		}
		
		$model = new ModelVars(
			array('name'=>'Vars',
				'id'=>'DocOrderPrint_Model',
				'values'=>$m_fields
		));
		
		if ($_REQUEST['v']=='ViewPDF'){
			$cont = $model->dataToXML(TRUE);
			return $this->print_document($templ_name,$out_file_name,$out_file,$cont,$doc_type);		
		}
		else{
			$this->addModel($model);
		}	
	
	}


}
?>