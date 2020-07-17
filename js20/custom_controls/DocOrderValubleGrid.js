/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2020

 * @extends GridAjx
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 * @param {string} options.className
 */
function DocOrderValubleGrid(id,options){
	var model = new DocOrderValuble_Model({
		"sequences":{"id":0}
	});

	var cells = [
		new GridCellHead(id+":head:name",{
			"value":"Наименование",
			"columns":[
				new GridColumn({
					"field":model.getField("name")
					,"ctrlClass":EditString
					,"ctrlOptions":{
						"maxLength":"500"
					}					
				})
			]
		})
		,new GridCellHead(id+":head:quant",{
			"value":"Количество",
			"columns":[
				new GridColumnFloat({
					"field":model.getField("quant")
					,"precision":"4"
					,"ctrlClass":EditFloat
					,"ctrlOptions":{
						"maxLength":"500"
						,"precision":"4"
					}					
				})
			]
		})
	];

	options = {
		"model":model,
		"keyIds":["id"],
		"controller":new DocOrderValuble_Controller({"clientModel":model}),
		"editInline":true,
		"editWinClass":null,
		"popUpMenu":new PopUpMenu(),
		"commands":new GridCmdContainerAjx(id+":cmd",{
			"cmdSearch":false,
			"cmdExport":false
		}),
		"head":new GridHead(id+":head",{
			"elements":[
				new GridRow(id+":head:row0",{
					"elements":cells
				})
			]
		}),
		"pagination":null,				
		"autoRefresh":false,
		"refreshInterval":0,
		"rowSelect":true
	};	
	DocOrderValubleGrid.superclass.constructor.call(this,id,options);
}
extend(DocOrderValubleGrid,GridAjx);

/* Constants */


/* private members */

/* protected*/


/* public methods */
