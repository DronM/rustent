/* Copyright (c) 2020
 *	Andrey Mikhalevich, Katren ltd.
 */
function ColorEditRef(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Цвет:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = null;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Color_Controller(options.app);
	options.acModel = new ColorList_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ColorEditRef.superclass.constructor.call(this,id,options);
}
extend(ColorEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

