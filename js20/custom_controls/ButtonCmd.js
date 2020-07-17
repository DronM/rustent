/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>,2020

 * @class
 * @classdesc Basic command ButtonTabMenu

 * @extends ButtonTabMenu

 * @requires core/extend.js  
 * @requires controls/Button.js

 * @param {string} id Object identifier
 * @param {namespace} options
 * @param {string} [options.caption=this.DEF_CAPTION]
 * @param {string} [options.title=this.DEF_HINT]
*/
function ButtonCmd(id,options){
	options = options || {};
	
	ButtonCmd.superclass.constructor.call(this,id,options);
}
extend(ButtonCmd,ButtonTabMenu);

ButtonCmd.prototype.DEF_CAPTION = "";
