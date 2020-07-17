/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2017
 * @class
 * @classdesc Enumerator class. Created from template build/templates/js/Enum_js.xsl. !!!DO NOT MODIFY!!!
 
 * @extends EditSelect
 
 * @requires core/extend.js
 * @requires controls/EditSelect.js
 
 * @param string id 
 * @param {object} options
 */

function Enum_doc_order_states(id,options){
	options = options || {};
	options.addNotSelected = (options.addNotSelected!=undefined)? options.addNotSelected:true;
	options.options = [{"value":"accept",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"accept"],
checked:(options.defaultValue&&options.defaultValue=="accept")}
,{"value":"production",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"production"],
checked:(options.defaultValue&&options.defaultValue=="production")}
,{"value":"ready",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"ready"],
checked:(options.defaultValue&&options.defaultValue=="ready")}
,{"value":"notified",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"notified"],
checked:(options.defaultValue&&options.defaultValue=="notified")}
,{"value":"closed",
"descr":this.multyLangValues[window.getApp().getLocale()+"_"+"closed"],
checked:(options.defaultValue&&options.defaultValue=="closed")}
];
	
	Enum_doc_order_states.superclass.constructor.call(this,id,options);
	
}
extend(Enum_doc_order_states,EditSelect);

Enum_doc_order_states.prototype.multyLangValues = {"ru_accept":"Прием"
,"ru_production":"Производство"
,"ru_ready":"Изготовлен"
,"ru_notified":"Оповещен"
,"ru_closed":"Закрыт"
};


