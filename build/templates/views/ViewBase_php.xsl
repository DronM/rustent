<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" indent="yes"
			doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
			doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
<xsl:template match="/"><![CDATA[<?php]]>
require_once(FRAME_WORK_PATH.'basic_classes/ViewHTMLXSLT.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelStyleSheet.php');
require_once(FRAME_WORK_PATH.'basic_classes/ModelJavaScript.php');

require_once(FRAME_WORK_PATH.'basic_classes/ModelTemplate.php');
require_once(USER_CONTROLLERS_PATH.'Constant_Controller.php');

<xsl:apply-templates select="metadata/enums/enum[@id='role_types']"/>
class ViewBase extends ViewHTMLXSLT {	

	private $dbLink;

	protected static function getMenuClass(){
		//USER_MODELS_PATH
		$menu_class = NULL;
		$fl = NULL;
		if (file_exists($fl = OUTPUT_PATH.'MainMenu_Model_'.$_SESSION['user_id'].'.php')){
			$menu_class = 'MainMenu_Model_'.$_SESSION['user_id'];
		}
		else if (file_exists($fl = OUTPUT_PATH.'MainMenu_Model_'.$_SESSION['role_id'].'_'.$_SESSION['user_id'].'.php')){
			$menu_class = 'MainMenu_Model_'.$_SESSION['role_id'].'_'.$_SESSION['user_id'];
		}
		else if (file_exists($fl = OUTPUT_PATH.'MainMenu_Model_'.$_SESSION['role_id'].'.php')){
			$menu_class = 'MainMenu_Model_'.$_SESSION['role_id'];
		}
		if (!is_null($menu_class) &amp;&amp; !is_null($fl)){
			require_once($fl);
		}
		return $menu_class;
	}

	protected function addMenu(&amp;$models){
		if (isset($_SESSION['role_id'])){
			//USER_MODELS_PATH
			$menu_class = self::getMenuClass();
			if (is_null($menu_class)){
				//no menu exists yet
				$this->initDbLink();
				$contr = new MainMenuConstructor_Controller($this->dbLink);
				$contr->genMenuForUser($_SESSION['user_id'], $_SESSION['role_id']);
				$menu_class = self::getMenuClass();
				if (is_null($menu_class)){
					throw new Exception('No menu found!');
				}				
			}
			$models['mainMenu'] = new $menu_class();
		}	
	}
	
	protected function addConstants(&amp;$models){
		if (isset($_SESSION['role_id'])){
			$this->initDbLink();
		
			if ($this->dbLink){
				$contr = new Constant_Controller($this->dbLink);
				$list = array(<xsl:apply-templates select="/metadata/constants/constant[@autoload='TRUE']"/>);
				$models['ConstantValueList_Model'] = $contr->getConstantValueModel($list);						
			}
		}	
	}

	protected function initDbLink(){
		if (!$this->dbLink){
			$this->dbLink = new DB_Sql();
			$this->dbLink->persistent=true;
			$this->dbLink->appname = APP_NAME;
			$this->dbLink->technicalemail = TECH_EMAIL;
			$this->dbLink->reporterror = DEBUG;
			$this->dbLink->database= DB_NAME;
			try{			
				$this->dbLink->connect(DB_SERVER,DB_USER,DB_PASSWORD,(defined('DB_PORT'))? DB_PORT:NULL);
			}
			catch (Exception $e){
				//do nothing
			}
		}	
	}

	public function __construct($name){
		parent::__construct($name);
		<xsl:apply-templates select="metadata/cssScripts"/>
		if (!DEBUG){
			<xsl:apply-templates select="metadata/jsScripts/jsScript[@standalone='TRUE']"/>
			$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'lib.js'));
			$script_id = VERSION;
		}
		else{		
			<xsl:apply-templates select="metadata/jsScripts"/>			
			if (isset($_SESSION['scriptId'])){
				$script_id = $_SESSION['scriptId'];
			}
			else{
				$script_id = VERSION;
			}			
		}
		<!-- custom vars definitions-->
		$this->getVarModel()->addField(new Field('role_id',DT_STRING));
		$this->getVarModel()->addField(new Field('user_name',DT_STRING));
		
		
		<!-- obligatory vars values -->
		$this->getVarModel()->insert();
		$this->setVarValue('scriptId',$script_id);
		
		$currentPath = $_SERVER['PHP_SELF'];
		$pathInfo = pathinfo($currentPath);
		$hostName = $_SERVER['HTTP_HOST'];
		$protocol = isset($_SERVER['HTTPS'])? 'https://':'http://';
		$dir = $protocol.$hostName.$pathInfo['dirname'];
		if (substr($dir,strlen($dir)-1,1)!='/'){
			$dir.='/';
		}
		$this->setVarValue('basePath', $dir);
		
		$this->setVarValue('version',VERSION);		
		$this->setVarValue('debug',DEBUG);
		if (isset($_SESSION['locale_id'])){
			$this->setVarValue('locale_id',$_SESSION['locale_id']);
		}
		else if (!isset($_SESSION['locale_id']) &amp;&amp; defined('DEF_LOCALE')){
			$this->setVarValue('locale_id', DEF_LOCALE);
		}		
		
		if (isset($_SESSION['role_id'])){
			$this->setVarValue('role_id',$_SESSION['role_id']);
			$this->setVarValue('user_name',$_SESSION['user_name']);
			$this->setVarValue('curDate',round(microtime(true) * 1000));
			//$this->setVarValue('token',$_SESSION['token']);
			//$this->setVarValue('tokenr',$_SESSION['tokenr']);
		}
		<!-- custom vars values
		if (isset($_SESSION['constrain_to_store'])){
			$this->setVarValue('constrain_to_store',$_SESSION['constrain_to_store']);
		}
		-->
		
		//Global Filters
		<!--
		<xsl:for-each select="/metadata/globalFilters/field">
		if (isset($_SESSION['global_<xsl:value-of select="@id"/>'])){
			$val = $_SESSION['global_<xsl:value-of select="@id"/>'];
			$this->setVarValue('<xsl:value-of select="@id"/>',$val);
		}
		</xsl:for-each>		
		-->
	}
	public function write(ArrayObject &amp;$models){
		$this->addMenu($models);
		
		<!-- constant autoload -->
		<xsl:if test="count(/metadata/constants/constant[@autoload='TRUE'])">
		$this->addConstants($models);
		</xsl:if>
		
		//template
		if (isset($_REQUEST['t'])){
			$tmpl = $_REQUEST['t']; 
			if (file_exists($file = USER_VIEWS_PATH. $tmpl. '.html') ){
				$text = $this->convToUtf8(file_get_contents($file));
				$models[$tmpl] = new ModelTemplate($tmpl,$text);
			}
		}		
		parent::write($models);
	}	
}	
<![CDATA[?>]]>
</xsl:template>
			
<xsl:template match="constants/constant[@autoload='TRUE']">
<xsl:if test="position() &gt; 1">,</xsl:if>'<xsl:value-of select="@id"/>'</xsl:template>
			
<xsl:template match="enum/value">
if (file_exists('models/MainMenu_Model_<xsl:value-of select="@id"/>.php')){
require_once('models/MainMenu_Model_<xsl:value-of select="@id"/>.php');
}</xsl:template>

<xsl:template match="jsScripts/jsScript">
<xsl:choose>
<xsl:when test="@resource">
	if (
	(isset($_SESSION['locale_id']) &amp;&amp; $_SESSION['locale_id']=='<xsl:value-of select="@resource"/>')
	||
	(!isset($_SESSION['locale_id']) &amp;&amp; DEF_LOCALE=='<xsl:value-of select="@resource"/>')
	){
		$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'<xsl:value-of select="@file"/>'));
	}
</xsl:when>
<xsl:otherwise>$this->addJsModel(new ModelJavaScript(USER_JS_PATH.'<xsl:value-of select="@file"/>'));</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="cssScripts/cssScript">$this->addCssModel(new ModelStyleSheet(USER_JS_PATH.'<xsl:value-of select="@file"/>'));</xsl:template>

</xsl:stylesheet>
