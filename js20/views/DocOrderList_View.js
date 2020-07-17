/** Copyright (c) 2020
	Andrey Mikhalevich, Katren ltd.
*/
function DocOrderList_View(id,options){	

	options.templateOptions = options.templateOptions || {};
	options.templateOptions.HEAD_TITLE = "Реестр заказов";

	DocOrderList_View.superclass.constructor.call(this,id,options);
	
	var model = options.models.DocOrderList_Model;
	var contr = new DocOrder_Controller();
	
	var constants = {"doc_per_page_count":null,"grid_refresh_interval":null};
	window.getApp().getConstantManager().get(constants);
	
	var period_ctrl = new EditPeriodDateTime(id+":filter-ctrl-period",{
		"field":new FieldDateTime("date_time")
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
		,"client":{
			"binding":new CommandBinding({
				"control":new ClientEditRef(id+":filter-ctrl-client",{
					"contClassName":"form-group-filter",
					"labelCaption":"Контрагент:"
				}),
				"field":new FieldInt("client_id")}),
			"sign":"e"		
		}
		,"material":{
			"binding":new CommandBinding({
				"control":new MaterialEditRef(id+":filter-ctrl-material",{
					"contClassName":"form-group-filter",
					"labelCaption":"Материал:"
				}),
				"field":new FieldInt("material_id")}),
			"sign":"e"		
		}
		,"user":{
			"binding":new CommandBinding({
				"control":new UserEditRef(id+":filter-ctrl-user",{
					"contClassName":"form-group-filter",
					"labelCaption":"Автор:"
				}),
				"field":new FieldInt("user_id")}),
			"sign":"e"		
		}
		,"doc_order_state":{
			"binding":new CommandBinding({
				"control":new Enum_doc_order_states(id+":filter-ctrl-doc_order",{
					"contClassName":"form-group-filter",
					"labelCaption":"Статус:"
				}),
				"field":new FieldString("last_state")}),
			"sign":"e"		
		},
		
	};

	var self = this;
	var popup_menu = new PopUpMenu();
	var pagClass = window.getApp().getPaginationClass();
	this.addElement(new GridAjx(id+":grid",{
		"model":model,
		"controller":contr,
		"editInline":false,
		"editWinClass":DocOrder_Form,
		"commands":new GridCmdContainerAjx(id+":grid:cmd",{
			"cmdFilter":true,
			"cmdDelete":(role_id=="admin"),
			"filters":filters,
			"variantStorage":options.variantStorage			
			,"addCustomCommands":(role_id!="production")? null:function(commands){
				commands.push(
					new DocOrderSetReadyGridCmd(id+":grid:cmdSetReady",{
						"grid":self.getElement("grid")
						,"getDocOrderId":function(){
							return self.getElement("grid").getModelRow().id.getValue();
						}
						,"getDocOrderState":function(){
							return self.getElement("grid").getModelRow().last_state.getValue();
						}
						
					})
				);
			}
			
		}),		
		"popUpMenu":popup_menu,
		"head":new GridHead(id+"-grid:head",{
			"elements":[
				new GridRow(id+":grid:head:row0",{
					"elements":[
						new GridCellHead(id+":grid:head:id",{
							"value":"Номер",
							"columns":[
								new GridColumn({
									"field":model.getField("id")
								})
							],
							"sortable":true
						})					
						,new GridCellHead(id+":grid:head:date_time",{
							"value":"Дата приема",
							"columns":[
								new GridColumnDateTime({
									"field":model.getField("date_time")
									,"ctrlClass":EditDate
									,"searchOptions":{
										"field":new FieldDate("date_time")
										,"searchType":"on_beg"
									}

								})
							],
							"sortable":true,
							"sort":"desc"							
						})
						,new GridCellHead(id+":grid:head:clients_ref",{
							"value":"Контрагент",
							"columns":[
								new GridColumnRef({
									"field":model.getField("clients_ref")
									,"ctrlBindFieldId":"client_id"
									,"ctrlClass":ClientEditRef
									,"ctrlOptions":{
										"labelCaption":""
									}
								})
							],
							"sortable":true
						})
						,new GridCellHead(id+":grid:head:client_tel",{
							"value":"Телефон",
							"columns":[
								new GridColumnPhone({
									"field":model.getField("client_tel")
								})
							],
							"sortable":true
						})
						
						,new GridCellHead(id+":grid:head:order_name",{
							"value":"Наименование",
							"columns":[
								new GridColumn({
									"field":model.getField("order_name")
								})
							]
						})
						,new GridCellHead(id+":grid:head:last_state",{
							"value":"Статус",
							"columns":[
								new EnumGridColumn_doc_order_states({
									"field":model.getField("last_state")
									,"ctrlClass":Enum_doc_order_states
									,"ctrlOptions":{
										"labelCaption":"Статус:"
									}
									,"searchOptions":{
										"searchType":"on_match",
										"typeChange":false
									}									
									,"formatFunction":function(fields){
										//var st = fields.last_state.getValue()
										var val = fields.last_state.getValue();
										var st = this.getAssocValueList()[val];
										return (
											st+
											" ("+
											fields.last_state_users_ref.getValue().getDescr()+", "+
											DateHelper.format(fields.last_state_dt.getValue(),"d/m/Y H:i")+
											")"
										);
									}
								})
							]
						})
						,new GridCellHead(id+":grid:head:total",{
							"value":"Стоимость",
							"columns":[
								new GridColumnFloat({
									"field":model.getField("total")
									,"precision":"2"
								})
							]
						})

					]
				})
			]
		}),
		"foot":new GridFoot(id+"grid:foot",{
			"autoCalc":true,			
			"elements":[
				new GridRow(id+":grid:foot:row0",{
					"elements":[
						new GridCell(id+":grid:foot:total_sp1",{
							"colSpan":"6"
						})											
						,new GridCellFoot(id+":grid:foot:tot_total",{
							"attrs":{"align":"right"},
							"totalFieldId":"total_total",
							"gridColumn":new GridColumnFloat({"id":"tot_total"})
						})
					]
				})		
			]
		}),
		"pagination":new pagClass(id+"_page",
			{"countPerPage":constants.doc_per_page_count.getValue()}),		
		
		"autoRefresh":false,
		"refreshInterval":constants.grid_refresh_interval.getValue()*1000,
		"rowSelect":false,
		"focus":true
	}));	
	


}
extend(DocOrderList_View,ViewAjxList);
