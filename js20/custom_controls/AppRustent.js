/**
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2016
 
 * @class
 * @classdesc
	
 * @param {object} options
 */	
function AppRustent(options){
	options = options || {};
	options.lang = "ru";
	AppRustent.superclass.constructor.call(this,"rustent",options);
}
extend(AppRustent,App);

/* Constants */


/* private members */

/* protected*/


/* public methods */
AppRustent.prototype.makeItemCurrent = function(elem){
	if (elem){
		var l = DOMHelper.getElementsByAttr("active", document.body, "class", true,"LI");
		for(var i=0;i<l.length;i++){
			DOMHelper.delClass(l[i],"active");
		}
		DOMHelper.addClass((elem.tagName.toUpperCase()=="LI")? elem:elem.parentNode,"active");
		if (elem.nextSibling){
			elem.nextSibling.style="display: block;";
		}
	}
}

AppRustent.prototype.showMenuItem = function(item,c,f,t,extra,title){
	AppRustent.superclass.showMenuItem.call(this,item,c,f,t,extra,title);
	this.makeItemCurrent(item);
}

AppRustent.prototype.formatError = function(erCode,erStr){
	return (erStr +( (erCode)? (", код:"+erCode):"" ) );
}

