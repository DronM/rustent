/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2020

 * @extends ButtonCmd
 * @requires core/extend.js
 * @requires controls/ButtonCmd.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function DocOrderPrintOrderBtn(id,options){
	options = options || {};	

	options.caption = " Печать заказа";
	options.title = "Печать заказа";
	options.glyph = "glyphicon-print";

	this.m_newState = options.newState;
	this.m_getDocOrderId = options.getDocOrderId;	
	this.m_beforePrint = options.beforePrint;
	
	this.m_grid = options.grid;
	
	var self = this;

	options.onClick = function(){
		self.print();
	}
	
	DocOrderPrintOrderBtn.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(DocOrderPrintOrderBtn,ButtonCmd);

/* Constants */


/* private members */

/* protected*/

/* public methods */

DocOrderPrintOrderBtn.prototype.printCont = function(){
	var contr = new DocOrder_Controller();
	var pm = contr.getPublicMethod("get_files_list");
	pm.setFieldValue("doc_order_id",this.m_getDocOrderId());
	var self = this;
	pm.run({
		"ok":function(resp){		
			var top = 50;
			var offset = 200;
			var h = $( window ).width()/3*2;
			var left = 100;//$( window ).width()/2;
			var w = $( window ).width()/2 - 20;
			
			var pm = contr.getPublicMethod("get_file");
			pm.setFieldValue("doc_order_id",self.m_getDocOrderId());
			pm.setFieldValue("inline",1);
			
			var m = resp.getModel("FileList_Model");
			var str;
			while(m.getNextRow()){
				str = CommonHelper.unserialize(m.getFieldValue("file_inf"));
				if(str&&str.id&&str.mime){
					if(str.mime!='image/jpeg' && str.mime!='image/png' && str.mime!='image/jpg'){
						//standalone!
						pm.setFieldValue("file_id",str.id);
						contr.openHref("get_file","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+top+",left="+left+",width="+w+",height="+h);						
						//top+= offset;
						left+= offset;
					}
				}
			}
			
			//object print Печатаем при любом раскладе, даже если нет вложений!!!
			var pm = contr.getPublicMethod("get_print");
			pm.setFieldValue("doc_order_id",self.m_getDocOrderId());
			pm.setFieldValue("templ", "DocOrderPrint");
			pm.setFieldValue("inline","1");
			contr.openHref("get_print","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+top+",left="+left+",width="+w+",height="+h);
		}
	});
}

DocOrderPrintOrderBtn.prototype.print = function(){
	if(this.m_beforePrint){
		var self = this;
		this.m_beforePrint(function(){
			self.printCont();
		});
	}
	else{
		this.printCont();
	}
}
