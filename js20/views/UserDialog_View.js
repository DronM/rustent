/** Copyright (c) 2016,2019
 *	Andrey Mikhalevich, Katren ltd.
 */
function UserDialog_View(id,options){	

	options = options || {};
	options.controller = new User_Controller();
	options.model = options.models.UserDialog_Model;
	
	
	var self = this;
	var role = window.getApp().getServVar("role_id");
	var adm = (role=="admin"||role=="owner");
	options.templateOptions = options.templateOptions || {};
	options.templateOptions.adm = adm;
	
	options.addElement = function(){
	
		this.addElement(new UserNameEdit(id+":name"));

		this.addElement(new Enum_role_types(id+":role",{
			"labelCaption":"Роль:",
			"required":true
		}));	
	
		this.addElement(new EditEmail(id+":email",{
			"labelCaption":"Эл.почта:"
		}));	

		this.addElement(new EditPhone(id+":phone_cel",{
			"labelCaption":"Моб.телефон:"
		}));

		this.addElement(new EditInt(id+":tel_ext",{
			"labelCaption":"Внутр.номер:",
			"maxLength":5
		}));

		this.addElement(new EditCheckBox(id+":banned",{
			"labelCaption":"Доступ запрещен:",
		}));

		if (adm){
			this.addElement(new ButtonCmd(id+":cmdResetPwd",{
				"onClick":function(){
					self.resetPwd();
				}
			}));		
		}		
	}
	
	//****************************************************	
	UserDialog_View.superclass.constructor.call(this,id,options);
	
	//read
	var r_bd = [
		new DataBinding({"control":this.getElement("name")})
		,new DataBinding({"control":this.getElement("role"),"field":this.m_model.getField("role_id")})
		,new DataBinding({"control":this.getElement("email")})
		,new DataBinding({"control":this.getElement("tel_ext")})
		,new DataBinding({"control":this.getElement("phone_cel")})
		,new DataBinding({"control":this.getElement("banned")})
	];
	this.setDataBindings(r_bd);
	
	//write
	this.setWriteBindings([
		new CommandBinding({"control":this.getElement("name")})
		,new CommandBinding({"control":this.getElement("role"),"fieldId":"role_id"})
		,new CommandBinding({"control":this.getElement("email")})
		,new CommandBinding({"control":this.getElement("phone_cel")})
		,new CommandBinding({"control":this.getElement("tel_ext")})
		,new CommandBinding({"control":this.getElement("banned")})
	]);
	
}
extend(UserDialog_View,ViewObjectAjx);

UserDialog_View.prototype.hideUser = function(){
	var pm = this.getController().getPublicMethod("hide");
	pm.setFieldValue("id",this.getElement("id").getValue());
	var self = this;
	pm.run({
		"ok":function(resp){
			self.close({"updated":true});
		}
	});
}

UserDialog_View.prototype.resetPwd = function(){
	var pm = this.getController().getPublicMethod("reset_pwd");
	pm.setFieldValue("user_id",this.getElement("id").getValue());
	var self = this;
	pm.run({
		"ok":function(resp){
			window.showNote("Пароль сброшен!");
			self.close({"updated":true});
		}
	});
}

