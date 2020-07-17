/**	
 *
 * THIS FILE IS GENERATED FROM TEMPLATE build/templates/models/Model_js.xsl
 * ALL DIRECT MODIFICATIONS WILL BE LOST WITH THE NEXT BUILD PROCESS!!!
 *
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 * @class
 * @classdesc Model class. Created from template build/templates/models/Model_js.xsl. !!!DO NOT MODEFY!!!
 
 * @extends ModelXML
 
 * @requires core/extend.js
 * @requires core/ModelXML.js
 
 * @param {string} id 
 * @param {Object} options
 */

function DocOrderList_Model(options){
	var id = 'DocOrderList_Model';
	options = options || {};
	
	options.fields = {};
	
			
				
			
			
				
			
				
	
	var filed_options = {};
	filed_options.primaryKey = true;	
	
	filed_options.autoInc = true;	
	
	options.fields.id = new FieldInt("id",filed_options);
	options.fields.id.getValidator().setRequired(true);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата приема заказа';
	filed_options.autoInc = false;	
	
	options.fields.date_time = new FieldDateTimeTZ("date_time",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.user_id = new FieldInt("user_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Пользователь';
	filed_options.autoInc = false;	
	
	options.fields.users_ref = new FieldJSON("users_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.client_id = new FieldInt("client_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Контрагент';
	filed_options.autoInc = false;	
	
	options.fields.clients_ref = new FieldJSON("clients_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.client_tel = new FieldString("client_tel",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.material_id = new FieldInt("material_id",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Материал';
	filed_options.autoInc = false;	
	
	options.fields.materials_ref = new FieldJSON("materials_ref",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.order_name = new FieldText("order_name",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	
	filed_options.autoInc = false;	
	
	options.fields.total = new FieldFloat("total",filed_options);
	options.fields.total.getValidator().setMaxLength('15');
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Текущий статус';
	filed_options.autoInc = false;	
	
	options.fields.last_state = new FieldString("last_state",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Дата текущего статуса';
	filed_options.autoInc = false;	
	
	options.fields.last_state_dt = new FieldDateTime("last_state_dt",filed_options);
	
				
	
	var filed_options = {};
	filed_options.primaryKey = false;	
	filed_options.alias = 'Пользователь, установивший текущий статус';
	filed_options.autoInc = false;	
	
	options.fields.last_state_users_ref = new FieldJSON("last_state_users_ref",filed_options);
	
		DocOrderList_Model.superclass.constructor.call(this,id,options);
}
extend(DocOrderList_Model,ModelXML);

