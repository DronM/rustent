/** Copyright (c) 2020
 *	Andrey Mikhalevich, Katren ltd.
 */
function ColorNameEdit(id,options){
	options = options || {};

	if (options.labelCaption==undefined){
		options.labelCaption = "Цвет:";
	}
	options.maxLength = 150;
	
	options.cmdAutoComplete	= true;	
	options.acMinLengthForQuery = 1;
	options.acController = new Color_Controller();
	options.acModel = new Color_Model();
	options.acPublicMethod = options.acController.getPublicMethod("complete")
	options.acPatternFieldId = "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("name")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
		
	ColorNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(ColorNameEdit,EditString);

