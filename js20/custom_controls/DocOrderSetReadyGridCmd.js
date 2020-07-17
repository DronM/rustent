/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>,2016

 * @class
 * @classdesc
 
 * @requires core/extend.js  
 * @requires controls/GridCmd.js

 * @param {string} id Object identifier
 * @param {namespace} options
*/
function DocOrderSetReadyGridCmd(id,options){
	options = options || {};	

	options.showCmdControl = true;
	options.glyph = "glyphicon-print";
	options.controls = [
		new DocOrderSetStateBtn(id+":btn",{
			"caption":" Готово"
			,"title":"Сменить статус на готово"
			,"glyph":"glyphicon-check"
			,"getDocOrderId":options.getDocOrderId
			,"getDocOrderState":options.getDocOrderState
			,"newState":"ready"
			,"grid":options.grid
		})
	];

	DocOrderSetReadyGridCmd.superclass.constructor.call(this,id,options);
		
}
extend(DocOrderSetReadyGridCmd,GridCmd);

/* Constants */


/* private members */

/* protected*/


/* public methods */
