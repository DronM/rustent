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

	var self = this;
	
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
			,"getGrid":function(){
				return self.getGrid();
			}
		})
	];

	DocOrderSetStateGridCmd.superclass.constructor.call(this,id,options);
		
}
extend(DocOrderSetStateGridCmd,GridCmd);

/* Constants */


/* private members */

/* protected*/


/* public methods */
