/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>,2020

 * @class
 * @classdesc
 
 * @requires core/extend.js  
 * @requires controls/GridCmd.js

 * @param {string} id Object identifier
 * @param {namespace} options
*/
function DocOrderPrintOrderGridCmd(id,options){
	options = options || {};	

	options.showCmdControl = true;
	options.glyph = "glyphicon-print";
	options.controls = [
		new DocOrderPrintOrderBtn(id+":btnPrintOrder",{
			"caption":" Печать заказа"
			,"title":"Печать заказа"
			,"glyph":"glyphicon-print"
			,"getDocOrderId":options.getDocOrderId
			,"getDocOrderState":options.getDocOrderState
			,"grid":options.grid
		})
	];

	DocOrderPrintOrderGridCmd.superclass.constructor.call(this,id,options);
		
}
extend(DocOrderPrintOrderGridCmd,GridCmd);

/* Constants */


/* private members */

/* protected*/


/* public methods */
