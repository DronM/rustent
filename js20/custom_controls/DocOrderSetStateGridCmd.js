/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>,2020

 * @class
 * @classdesc
 
 * @requires core/extend.js  
 * @requires controls/GridCmd.js

 * @param {string} id Object identifier
 * @param {namespace} options
*/
function DocOrderSetStateGridCmd(id,options){
	options = options || {};	

	options.showCmdControl = true;
	options.glyph = "glyphicon-print";
	options.controls = [
		new DocOrderSetStateBtn(id+":btnSetState",{
			"caption":" Статус"
			,"title":"Сменить на произвольный статус"
			,"glyph":"glyphicon-refresh"
			,"getDocOrderId":options.getDocOrderId
			,"getDocOrderState":options.getDocOrderState
			,"newState":"select"
			,"grid":options.grid
		})
	];

	DocOrderSetStateGridCmd.superclass.constructor.call(this,id,options);
		
}
extend(DocOrderSetStateGridCmd,GridCmd);

/* Constants */


/* private members */

/* protected*/


/* public methods */
