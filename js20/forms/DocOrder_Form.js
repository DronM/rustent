/** Copyright (c) 2020 
	Andrey Mikhalevich, Katren ltd.
*/
function DocOrder_Form(options){
	options = options || {};	
	
	options.formName = "DocOrderDialog";
	options.controller = "DocOrder_Controller";
	options.method = "get_object";
	
	DocOrder_Form.superclass.constructor.call(this,options);
	
}
extend(DocOrder_Form,WindowFormObject);

/* Constants */


/* private members */

/* protected*/


/* public methods */

