/** Copyright (c) 2020
 *	Andrey Mikhalevich, Katren ltd.
 */
function MaterialNameEdit(id,options){
	options = options || {};

	if (options.labelCaption==undefined){
		options.labelCaption = "Материал:";
	}
	options.maxLength = 150;
	
	options.cmdAutoComplete	= true;	
	options.acMinLengthForQuery = 1;
	options.acController = new Material_Controller();
	options.acModel = new Material_Model();
	options.acPublicMethod = options.acController.getPublicMethod("complete")
	options.acPatternFieldId = "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("name")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
		
	MaterialNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(MaterialNameEdit,EditString);

