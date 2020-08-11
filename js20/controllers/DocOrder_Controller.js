/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/controllers/Controller_js20.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 
 * @class
 * @classdesc controller
 
 * @extends ControllerObjServer
  
 * @requires core/extend.js
 * @requires core/ControllerObjServer.js
  
 * @param {Object} options
 * @param {Model} options.listModelClass
 * @param {Model} options.objModelClass
 */ 

function DocOrder_Controller(options){
	options = options || {};
	options.listModelClass = DocOrderList_Model;
	options.objModelClass = DocOrderDialog_Model;
	DocOrder_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.add_add_file();
	this.add_delete_file();
	this.add_get_file();
	this.add_get_files_list();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
	this.addComplete();
	this.add_get_print();
		
}
extend(DocOrder_Controller,ControllerObjServer);

			DocOrder_Controller.prototype.addInsert = function(){
	DocOrder_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldText("order_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("order_description",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("color_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("advance_pay",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("notes",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldJSONB("valubles",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("client_name",options));
	
		var options = {};
		options.required = true;		
		pm.addField(new FieldString("client_tel",options));
	
		var options = {};
				
		pm.addField(new FieldString("material_name",options));
	
		var options = {};
				
		pm.addField(new FieldString("color_name",options));
	
	
}

			DocOrder_Controller.prototype.add_add_file = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('add_file',opts);
	
	pm.setRequestType('post');
	
	pm.setEncType(ServConnector.prototype.ENCTYPES.MULTIPART);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_order_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldText("file_data",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "36";
	
		pm.addField(new FieldString("file_id",options));
	
			
	this.addPublicMethod(pm);
}

			DocOrder_Controller.prototype.add_delete_file = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('delete_file',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_order_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "36";
	
		pm.addField(new FieldString("file_id",options));
	
			
	this.addPublicMethod(pm);
}

			DocOrder_Controller.prototype.add_get_file = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_file',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_order_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "36";
	
		pm.addField(new FieldString("file_id",options));
	
				
	
	var options = {};
	
		pm.addField(new FieldInt("inline",options));
	
			
	this.addPublicMethod(pm);
}

			DocOrder_Controller.prototype.add_get_files_list = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_files_list',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_order_id",options));
	
			
	this.addPublicMethod(pm);
}

			DocOrder_Controller.prototype.addUpdate = function(){
	DocOrder_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("client_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("order_name",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("order_description",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("material_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("color_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("total",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldFloat("advance_pay",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldText("notes",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldJSONB("valubles",options);
	
	pm.addField(field);
	
		var options = {};
				
		pm.addField(new FieldString("client_name",options));
	
		var options = {};
				
		pm.addField(new FieldString("client_tel",options));
	
		var options = {};
				
		pm.addField(new FieldString("material_name",options));
	
		var options = {};
				
		pm.addField(new FieldString("color_name",options));
	
	
}

			DocOrder_Controller.prototype.addDelete = function(){
	DocOrder_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DocOrder_Controller.prototype.addGetList = function(){
	DocOrder_Controller.superclass.addGetList.call(this);
	
	
	
	var pm = this.getGetList();
	
	pm.addField(new FieldInt(this.PARAM_COUNT));
	pm.addField(new FieldInt(this.PARAM_FROM));
	pm.addField(new FieldString(this.PARAM_COND_FIELDS));
	pm.addField(new FieldString(this.PARAM_COND_SGNS));
	pm.addField(new FieldString(this.PARAM_COND_VALS));
	pm.addField(new FieldString(this.PARAM_COND_ICASE));
	pm.addField(new FieldString(this.PARAM_ORD_FIELDS));
	pm.addField(new FieldString(this.PARAM_ORD_DIRECTS));
	pm.addField(new FieldString(this.PARAM_FIELD_SEP));

	var f_opts = {};
	
	pm.addField(new FieldInt("id",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата приема заказа";
	pm.addField(new FieldDateTimeTZ("date_time",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("user_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Пользователь";
	pm.addField(new FieldJSON("users_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("client_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Контрагент";
	pm.addField(new FieldJSON("clients_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldString("client_tel",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("material_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Материал";
	pm.addField(new FieldJSON("materials_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldText("order_name",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldFloat("total",f_opts));
	var f_opts = {};
	f_opts.alias = "Текущий статус";
	pm.addField(new FieldString("last_state",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата текущего статуса";
	pm.addField(new FieldDateTime("last_state_dt",f_opts));
	var f_opts = {};
	f_opts.alias = "Пользователь, установивший текущий статус";
	pm.addField(new FieldJSON("last_state_users_ref",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("date_time");
	
}

			DocOrder_Controller.prototype.addGetObject = function(){
	DocOrder_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
}

			DocOrder_Controller.prototype.addComplete = function(){
	DocOrder_Controller.superclass.addComplete.call(this);
	
	var f_opts = {};
	
	var pm = this.getComplete();
	pm.addField(new FieldInt("id",f_opts));
	pm.getField(this.PARAM_ORD_FIELDS).setValue("id");	
}

			DocOrder_Controller.prototype.add_get_print = function(){
	var opts = {"controller":this};	
	var pm = new PublicMethodServer('get_print',opts);
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("doc_order_id",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		pm.addField(new FieldInt("inline",options));
	
				
	
	var options = {};
	
		options.required = true;
	
		options.maxlength = "100";
	
		pm.addField(new FieldString("templ",options));
	
			
	this.addPublicMethod(pm);
}

		