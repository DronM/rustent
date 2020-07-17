/** Copyright (c) 2019
 *	Andrey Mikhalevich, Katren ltd.
 */
function ClientNameEdit(id,options){
	options = options || {};

	if (options.labelCaption==undefined){
		options.labelCaption = "ФИО:";
	}
	options.maxLength = 150;
	
	options.cmdAutoComplete	= true;	
	options.acMinLengthForQuery = 1;
	options.acController = new Client_Controller();
	options.acModel = new Client_Model();
	options.acPublicMethod = options.acController.getPublicMethod("complete")
	options.acPatternFieldId = "name";
	options.acKeyFields = options.acKeyFields || [options.acModel.getField("name")];
	options.acDescrFields = options.acDescrFields || [options.acModel.getField("name")];
	var self = this;
	options.acDescrFunction = function(f){
		var res = f["name"].getValue();
		var tel = f["tel"].getValue();
		if(tel&&tel.length){
			if(!self.input){
				self.input = new Control(self.getId()+":mask","input",{"attrs":{"value":tel},"visible":false});
			}
			else{
				self.input.setValue(tel);
			}
			$(self.input.getNode()).mask(window.getApp().getPhoneEditMask());
			res+=" "+self.input.m_node.value;
		}
		return res;
	};
	
	this.m_origOnSelect = options.onSelect;
	options.onSelect = function(f){
		if(f && !f["name"].isNull() && f["name"].isSet()){
			this.setValue(f["name"].getValue());
			if(this.m_origOnSelect){
				this.m_origOnSelect.call(self,f);
			}
		}
	}
	options.acICase = options.acICase || "1";
	options.acMid = options.acMid || "1";
		
	ClientNameEdit.superclass.constructor.call(this,id,options);
	
}
extend(ClientNameEdit,EditString);

