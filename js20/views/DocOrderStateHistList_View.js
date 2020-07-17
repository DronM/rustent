/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017

 * @extends ViewAjxList
 * @requires core/extend.js  

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {Object} options
 * @param {string} options.className
 */
function DocOrderStateHistList_View(id,options){
	options = options || {};	
	
	DocOrderStateHistList_View.superclass.constructor.call(this,id,options);
	
	var model = (options.models && options.models.DocOrderStateHistList_Model)? options.models.DocOrderStateHistList_Model : new DocOrderStateHistList_Model();
	var contr = new DocOrderStateHist_Controller();
		
	var popup_menu = new PopUpMenu();
	
	var period_ctrl = new EditPeriodDate(id+":filter-ctrl-period",{
		"field":new FieldDate("date_time")
	});
	
	var role_id = window.getApp().getServVar("role_id");
	
	var filters = {
		"period":{
			"binding":new CommandBinding({
				"control":period_ctrl,
				"field":period_ctrl.getField()
			}),
			"bindings":[
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlFrom(),
					"field":period_ctrl.getField()
					}),
				"sign":"ge"
				},
				{"binding":new CommandBinding({
					"control":period_ctrl.getControlTo(),
					"field":period_ctrl.getField()
					}),
				"sign":"le"
				}
			]
		}		
	}
	
	var grid_columns;
	
	var pagination;
	
	if (!options.detail){
		var constants = {"doc_per_page_count":null};
		window.getApp().getConstantManager().get(constants);
		var pagClass = window.getApp().getPaginationClass();
		pagination = new pagClass(id+"_page",{"countPerPage":constants.doc_per_page_count.getValue()});	
		
		filters.client = {
			"binding":new CommandBinding({
				"control":new ClientEditRef(id+":filter-ctrl-client",{"labelCaption":"Клиент:"}),
				"field":new FieldInt("client_id")
			}),
			"sign":"e"
		};
		
		filters.doc_order = {
			"binding":new CommandBinding({
				"control":new DocOrderEditRef(id+":filter-ctrl-contract",{"labelCaption":"Заказ:"}),
				"field":new FieldInt("doc_order_id")
			}),
			"sign":"e"
		};
		
		grid_columns = [
			new GridCellHead(id+":grid:head:clients_ref",{
				"value":"Клиент",
				"columns":[
					new GridColumnRef({
						"field":model.getField("clients_ref"),
						"ctrlClass":ClientEditRef,
						"searchOptions":{
							"field":model.getField("client_id"),
							"searchType":"on_match",
							"typeChange":false
						},
						"ctrlOptions":{
							"labelCaption":"",
							"cmdClear":false,
							"cmdOpen":false
						}
					})
				],
				"sortable":true
			})
			,new GridCellHead(id+":grid:head:doc_orders_ref",{
				"value":"Заказ",
				"columns":[
					new GridColumnRef({
						"field":model.getField("doc_orders_ref"),
						"ctrlClass":DocOrderEditRef,
						"searchOptions":{
							"field":model.getField("doc_order_id"),
							"searchType":"on_match",
							"typeChange":false
						},
						"ctrlOptions":{
							"labelCaption":"",
							"cmdClear":false,
							"cmdOpen":false
						}
					})					
				],
				"sortable":true
			})
		];
				
	}
	else{
		grid_columns = [];
	}
	
	grid_columns.push(
		new GridCellHead(id+":grid:head:pay_date",{
				"value":"Дата",
				"columns":[
					new GridColumnDateTime({
						"field":model.getField("date_time"),
						"ctrlClass":EditDateTime,
						"ctrlOptions":{
							"cmdClear":false
							,"value":DateHelper.time()
							,"enable":(role_id=="admin")
						},
						"searchOptions":{
							"field":new FieldDate("date_time"),
							"searchType":"on_beg"
						}						
					})
				],
				"sortable":true,
				"sort":"desc"
			})	
	);
	grid_columns.push(
		new GridCellHead(id+":grid:head:users_ref",{
			"value":"Пользователь",
			"columns":[
				new GridColumnRef({
					"field":model.getField("users_ref")
					,"ctrlOptions":{
						"enable":(role_id=="admin")
					}
				})
			]
		})					
	);
	grid_columns.push(
		new GridCellHead(id+":grid:head:state",{
			"value":"Статус",
			"columns":[
				new EnumGridColumn_doc_order_states({
					"field":model.getField("state")
				})
			]
		})					
	);
	
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"keyIds":["id"],
		"controller":contr,
		"editInline":true,
		"editWinClass":null,
		"popUpMenu":popup_menu,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"filters":filters,
			"variantStorage":options.variantStorage
		}),
		"head":new GridHead(id+":grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":grid_columns
				})
			]
		}),
		"pagination":pagination,				
		"autoRefresh":false,
		"refreshInterval":0,
		"rowSelect":false,
		"focus":true
	}));		
}
extend(DocOrderStateHistList_View,ViewAjxList);

/* Constants */


/* private members */

/* protected*/


/* public methods */

