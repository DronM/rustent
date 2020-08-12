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

	this.m_newState = options.newState;
	this.m_getDocOrderId = options.getDocOrderId;
	this.m_getDocOrderState = options.getDocOrderState;
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

DocOrderPrintOrderBtn.prototype.print = function(){
	var contr = new DocOrder_Controller();
	var pm = contr.getPublicMethod("get_files_list");
	pm.setFieldValue("doc_order_id",this.m_getDocOrderId());
	var self = this;
	pm.run({
		"ok":function(resp){
			var offset = 0;
			var h = $( window ).width()/3*2;
			var left = $( window ).width()/2;
			var w = left - 20;
			/*
			var pm = contr.getPublicMethod("get_file");
			pm.setFieldValue("doc_order_id",self.m_getDocOrderId());
			pm.setFieldValue("inline",1);
			
			var m = resp.getModel("FileList_Model");
			var str;
			while(m.getNextRow()){
				str = CommonHelper.unserialize(m.getFieldValue("file_inf"));
				if(str&&str.id){
					console.log(offset)
					pm.setFieldValue("file_id",str.id);
					contr.openHref("get_file","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+(50+offset)+",left="+(left+offset)+",width="+w+",height="+h);
					offset = offset + 100;
				}
			}
			console.log(offset)
			*/
			//object print
			var pm = contr.getPublicMethod("get_print");
			pm.setFieldValue("doc_order_id",self.m_getDocOrderId());
			pm.setFieldValue("templ", "DocOrderPrint");
			pm.setFieldValue("inline","1");
			
			contr.openHref("get_print","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+(50+offset)+",left="+(left+offset)+",width="+w+",height="+h);
		}
	});

	/*
	var docType = "pdf";
	var templ = "DocOrderPrint";
	var offset = 0;
	
	var contr = new DocOrder_Controller();
	var pm = contr.getPublicMethod("get_print");
	pm.setFieldValue("doc_order_id",this.m_getDocOrderId());
	pm.setFieldValue("templ",templ);
	pm.setFieldValue("inline",(docType=="pdf")? "1":"0");
	
	if(docType=="pdf"){
		var h = $( window ).width()/3*2;
		var left = $( window ).width()/2;
		var w = left - 20;
		contr.openHref("get_print","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+(50+offset)+",left="+(left+offset)+",width="+w+",height="+h);
	}
	*/
}
