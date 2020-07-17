/* Copyright (c) 2020
 *	Andrey Mikhalevich, Katren ltd.
 */
function ClientEditRef(id,options){
	options = options || {};	
	if (options.labelCaption!=""){
		options.labelCaption = options.labelCaption || "Контрагент:";
	}
	options.cmdInsert = (options.cmdInsert!=undefined)? options.cmdInsert:false;
	
	options.keyIds = options.keyIds || ["id"];
	
	//форма выбора из списка
	options.selectWinClass = null;
	options.selectDescrIds = options.selectDescrIds || ["name"];
	
	//форма редактирования элемента
	options.editWinClass = null;
	
	options.acMinLengthForQuery = 1;
	options.acController = new Client_Controller(options.app);
	options.acModel = new Client_Model();
	options.acPatternFieldId = options.acPatternFieldId || "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("id")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
	
	ClientEditRef.superclass.constructor.call(this,id,options);
}
extend(ClientEditRef,EditRef);

/* Constants */


/* private members */

/* protected*/


/* public methods */

