<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="Controller_php.xsl"/>

<!-- -->
<xsl:variable name="CONTROLLER_ID" select="'DocOrder'"/>
<!-- -->

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
			
<xsl:template match="/">
	<xsl:apply-templates select="metadata/controllers/controller[@id=$CONTROLLER_ID]"/>
</xsl:template>

<xsl:template match="controller"><![CDATA[<?php]]>

<xsl:call-template name="add_requirements"/>

require_once(FRAME_WORK_PATH.'basic_classes/ModelVars.php');
require_once(FRAME_WORK_PATH.'basic_classes/FieldXML.php');

require_once('common/downloader.php');

class <xsl:value-of select="@id"/>_Controller extends <xsl:value-of select="@parentId"/>{
	public function __construct($dbLinkMaster=NULL,$dbLink=NULL){
		parent::__construct($dbLinkMaster,$dbLink);<xsl:apply-templates/>
	}	
	<xsl:call-template name="extra_methods"/>
}
<![CDATA[?>]]>
</xsl:template>

<xsl:template name="extra_methods">

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

	public static function insertParam(&amp;$controller,&amp;$link,&amp;$pm,$tableName,$paramName){
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

	public static function updateParam(&amp;$controller,&amp;$link,&amp;$pm,$tableName,$paramName){
		$new_name = $controller->getExtVal($pm,$paramName.'_name');
	
		if($new_name){
			$ar = $link->query_first(sprintf(
				"SELECT id,name FROM %s WHERE id=(SELECT o.%s_id FROM doc_orders o WHERE o.id=%d)",
				$tableName,
				$paramName,
				$controller->getExtDbVal($pm,'old_id')
			));
		
			if(is_array($ar) &amp;&amp; count($ar)){
				$fld = '';
				if($new_name&amp;&amp;$new_name!=$ar['name']){
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

	public static function updateMaterial(&amp;$controller,&amp;$link,&amp;$pm){
		self::updateParam($controller,$link,$pm,'materials','material');
	}

	public static function updateColor(&amp;$controller,&amp;$link,&amp;$pm){
		self::updateParam($controller,$link,$pm,'colors','color');
	}

	public static function insertMaterial(&amp;$controller,&amp;$link,&amp;$pm){
		self::insertParam($controller,$link,$pm,'materials','material');
	}
	public static function insertColor(&amp;$controller,&amp;$link,&amp;$pm){
		self::insertParam($controller,$link,$pm,'colors','color');
	}


	public static function insertClient(&amp;$controller,&amp;$link,&amp;$pm){
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

	public static function updateClient(&amp;$controller,&amp;$link,&amp;$pm){
		$new_name = $controller->getExtVal($pm,'client_name');
		$new_tel = $controller->getExtVal($pm,'client_tel');
	
		if($new_name||$new_tel){
			$ar = $link->query_first(sprintf(
				"SELECT id,name,tel FROM clients WHERE id=(SELECT o.client_id FROM doc_orders o WHERE o.id=%d)",
				$controller->getExtDbVal($pm,'old_id')
			));
		
			if(is_array($ar) &amp;&amp; count($ar)){
				$fld = '';
				if($new_name&amp;&amp;$new_name!=$ar['name']){
					$fld.= ($fld=='')? '':',';
					$fld.= sprintf('name=%s',$controller->getExtDbVal($pm,'client_name'));
				}
				if($new_tel&amp;&amp;$new_tel!=$ar['tel']){
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
			
			$link->query("COMMIT");
			
			self::clear_print_cache($pm->getParamValue('old_id'));
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
		
		if(isset($_FILES) &amp;&amp; isset($_FILES['file_data'])){
			if(!isset($_SESSION['allowed_extesions'])){
				$ar = $this->getDbLink()->query_first(("SELECT const_allowed_extesions_val() AS v"));
				$_SESSION['allowed_extesions'] = explode(',',$ar['v']);
			}
			$ext = pathinfo($_FILES['file_data']['name'][0], PATHINFO_EXTENSION);
			if (!in_array(strtolower($ext), $_SESSION['allowed_extesions'])) {
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
					
					self::clear_print_cache($this->getExtDbVal($pm,"doc_order_id"));
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
		
		self::clear_print_cache($this->getExtDbVal($pm,"doc_order_id"));
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


	private static function get_files_list_query($orderId){
		return sprintf(
			"SELECT
				file_inf
			FROM doc_order_attachments
			WHERE doc_order_id=%d"
			,$orderId
		);
	}

	public function get_files_list($pm){
		$this->addNewModel(
			self::get_files_list_query($this->getExtDbVal($pm,"doc_order_id"))
			,'FileList_Model'
		);					
	}

	/**
	 * @param {string} content XML content
	 * @param {string} documentType pdf|doc
	 */
	private function print_document($templName,$outFileName,$outFile,&amp;$content,$documentType){
		$xml = '&lt;?xml version="1.0" encoding="UTF-8"?&gt;';
		$xml.= '&lt;document&gt;';
		$xml.= $content;
		$xml.= '&lt;/document&gt;';
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
				if (file_exists($xml_file) &amp;&amp; (file_exists($out_file_tmp)||!DEBUG ) ){
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
			if (DEBUG &amp;&amp; $documentType=='pdf'){
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
				(isset($_REQUEST['inline']) &amp;&amp; $_REQUEST['inline']=='1')? 'inline;':'attachment;',
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

	private static function clear_print_cache($orderId){
		if(file_exists($fl = OUTPUT_PATH.'order_'.$orderId.'.pdf')){
			unlink($fl);
		}
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
				(isset($_REQUEST['inline']) &amp;&amp; $_REQUEST['inline']=='1')? 'inline;':'attachment;',
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
			$ar['valubles'].=sprintf('&lt;valuble&gt;&lt;name&gt;%s&lt;/name&gt;&lt;quant&gt;%s&lt;/quant&gt;&lt;/valuble&gt;',
				htmlspecialchars($row['fields']['name'])
				,$row['fields']['quant']
			);
		}
		
		//project path for images
		$ar['project_path'] = ABSOLUTE_PATH;
		
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
		
		$file_q = sprintf(
			"SELECT
				id AS file_id								
			FROM doc_order_attachments
			WHERE doc_order_id=%d AND (file_inf->>'mime'='image/jpeg' OR file_inf->>'mime'='image/png' OR file_inf->>'mime'='image/jpg')"
			,$ord_id
		);
		
		$file_model = new ModelSQL($this->getDbLink(),array('id'=>'FileList_Model'));
		$file_model->addField(new FieldSQLString($file_model->getDbLink(),'',"file_id",['id'=>'file_id']));
		$file_model->query($file_q, FALSE);
		
		//attachments
		$ids_need_data = '';		
		$file_model->setRowBOF();		
		while ($file_model->getNextRow()){				
			$file_id = $file_model->getFieldById('file_id')->getValue();
			
			$fl = self::get_data_file_pref($ord_id).$file_id;
			if(!file_exists($fl)){
				$ids_need_data.= ($ids_need_data=='')? '':',';
				$ids_need_data.= sprintf("'%s'",$file_id);
			}
		}
		if(strlen($ids_need_data)){
			$file_d_id = $this->getDbLink()->query(sprintf(
				"SELECT
					file_inf->>'id' AS file_id,
					file_data
				FROM doc_order_attachments
				WHERE id IN (%s)"
				,$ids_need_data
			));
			while($file_d_ar = $this->getDbLink()->fetch_array($file_d_id)){
				$fl = self::get_data_file_pref($ord_id).$file_d_ar['file_id'];
				file_put_contents($fl,pg_unescape_bytea($file_d_ar['file_data']));			
			}
		}

		if ($_REQUEST['v']=='ViewPDF'){
			$cont = $model->dataToXML(TRUE) . $file_model->dataToXML();
			return $this->print_document($templ_name,$out_file_name,$out_file,$cont,$doc_type);		
		}
		else{
			$this->addModel($model);
			$this->addModel($file_model);
		}	
	
	
		//all attachments
	}

</xsl:template>

</xsl:stylesheet>
