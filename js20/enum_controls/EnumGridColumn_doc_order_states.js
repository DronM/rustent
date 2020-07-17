/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 * @class
 * @classdesc Grid column Enumerator class. Created from template build/templates/js/EnumGridColumn_js.xsl. !!!DO NOT MODIFY!!!
 
 * @extends GridColumnEnum
 
 * @requires core/extend.js
 * @requires controls/GridColumnEnum.js
 
 * @param {object} options
 */

function EnumGridColumn_doc_order_states(options){
	options = options || {};
	
	options.multyLangValues = {};
	
	options.multyLangValues["ru"] = {};

	options.multyLangValues["ru"]["accept"] = "Прием";

	options.multyLangValues["ru"]["production"] = "Производство";

	options.multyLangValues["ru"]["ready"] = "Изготовлен";

	options.multyLangValues["ru"]["notified"] = "Оповещен";

	options.multyLangValues["ru"]["closed"] = "Закрыт";

	
	options.ctrlClass = options.ctrlClass || Enum_doc_order_states;
	options.searchOptions = options.searchOptions || {};
	options.searchOptions.searchType = options.searchOptions.searchType || "on_match";
	options.searchOptions.typeChange = (options.searchOptions.typeChange!=undefined)? options.searchOptions.typeChange:false;
	
	EnumGridColumn_doc_order_states.superclass.constructor.call(this,options);		
}
extend(EnumGridColumn_doc_order_states,GridColumnEnum);

