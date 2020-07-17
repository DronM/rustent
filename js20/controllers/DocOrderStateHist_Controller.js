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

function DocOrderStateHist_Controller(options){
	options = options || {};
	options.listModelClass = DocOrderStateHistList_Model;
	options.objModelClass = DocOrderStateHistList_Model;
	DocOrderStateHist_Controller.superclass.constructor.call(this,options);	
	
	//methods
	this.addInsert();
	this.addUpdate();
	this.addDelete();
	this.addGetList();
	this.addGetObject();
		
}
extend(DocOrderStateHist_Controller,ControllerObjServer);

			DocOrderStateHist_Controller.prototype.addInsert = function(){
	DocOrderStateHist_Controller.superclass.addInsert.call(this);
	
	var pm = this.getInsert();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;
	var field = new FieldInt("doc_order_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
	options.required = true;	
	options.enumValues = 'accept,production,ready,notified,closed';
	var field = new FieldEnum("state",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	pm.addField(new FieldInt("ret_id",{}));
	
	
}

			DocOrderStateHist_Controller.prototype.addUpdate = function(){
	DocOrderStateHist_Controller.superclass.addUpdate.call(this);
	var pm = this.getUpdate();
	
	var options = {};
	options.primaryKey = true;options.autoInc = true;
	var field = new FieldInt("id",options);
	
	pm.addField(field);
	
	field = new FieldInt("old_id",{});
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("doc_order_id",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldDateTimeTZ("date_time",options);
	
	pm.addField(field);
	
	var options = {};
		
	options.enumValues = 'accept,production,ready,notified,closed';
	options.enumValues+= (options.enumValues=='')? '':',';
	options.enumValues+= 'null';
	
	var field = new FieldEnum("state",options);
	
	pm.addField(field);
	
	var options = {};
	
	var field = new FieldInt("user_id",options);
	
	pm.addField(field);
	
	
}

			DocOrderStateHist_Controller.prototype.addDelete = function(){
	DocOrderStateHist_Controller.superclass.addDelete.call(this);
	var pm = this.getDelete();
	var options = {"required":true};
		
	pm.addField(new FieldInt("id",options));
}

			DocOrderStateHist_Controller.prototype.addGetList = function(){
	DocOrderStateHist_Controller.superclass.addGetList.call(this);
	
	
	
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
	
	pm.addField(new FieldInt("doc_order_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Заказ";
	pm.addField(new FieldJSON("doc_orders_ref",f_opts));
	var f_opts = {};
	f_opts.alias = "Дата";
	pm.addField(new FieldDateTimeTZ("date_time",f_opts));
	var f_opts = {};
	f_opts.alias = "Статус";
	pm.addField(new FieldString("state",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("user_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Пользователь";
	pm.addField(new FieldJSON("users_ref",f_opts));
	var f_opts = {};
	
	pm.addField(new FieldInt("client_id",f_opts));
	var f_opts = {};
	f_opts.alias = "Клиент";
	pm.addField(new FieldJSON("clients_ref",f_opts));
}

			DocOrderStateHist_Controller.prototype.addGetObject = function(){
	DocOrderStateHist_Controller.superclass.addGetObject.call(this);
	
	var pm = this.getGetObject();
	var f_opts = {};
		
	pm.addField(new FieldInt("id",f_opts));
	
	pm.addField(new FieldString("mode"));
}

		