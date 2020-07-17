/** Copyright (c) 2020
 *	Andrey Mikhalevich, Katren ltd.
 */
function DocOrderDialog_View(id,options){	

	options = options || {};
	options.controller = new DocOrder_Controller();
	options.model = options.models.DocOrderDialog_Model;
	
	var role_id = window.getApp().getServVar("role_id");
	
	options.templateOptions = options.templateOptions || {};
	options.templateOptions.stateHist = (role_id=="admin" || role_id=="manager");
	options.templateOptions.noStateHist = !options.templateOptions.stateHist; 
		
	var self = this;
	
	options.addElement = function(){
	
		this.addElement(new EditNum(id+":id",{
			"inline":true
			,"attrs":{"style":"width:100px;"}
			//,"labelCaption":"Номер:"
			,"cmdClear":false
			,"enable":false
		}));	
	
		this.addElement(new EditDate(id+":date_time",{
			"inline":true
			,"attrs":{"style":"width:250px;"}
			,"editMask":"99/99/9999 99:99"
			,"dateFormat":"d/m/Y H:i"
			//,"labelCaption":"Дата:"
			,"cmdClear":false
			,"value":DateHelper.time()
		}));	

		this.addElement(new ClientNameEdit(id+":client_name",{
			"required":true
			,"focus":true
			,"labelCaption":"ФИО заказчика:"
			,"onSelect":function(f){
				if(f && !f["name"].isNull()){
					self.getElement("client_tel").setValue(f["tel"].getValue());
					self.getElement("order_name").getNode().focus();
					//self.getElement("client_email").setValue(f["email"].getValue());
				}
			}
		}));	

		this.addElement(new EditPhone(id+":client_tel",{
			"required":true
			,"labelCaption":"Контактный телефон:"
		}));	

		this.addElement(new ColorNameEdit(id+":color_name",{
			"labelCaption":"Цвет:"
		}));

		this.addElement(new MaterialNameEdit(id+":material_name",{
			"labelCaption":"Материал исполнения:"
		}));	

		this.addElement(new EditString(id+":order_name",{
			"required":true
			,"maxLength":"500"
			,"labelCaption":"Наименование заказа:"
		}));	

		this.addElement(new EditText(id+":order_description",{
			"rows":"4"
			,"labelCaption":"Описание заказа:"
		}));	

		this.addElement(new EditString(id+":notes",{
			"maxLength":"1000"
			,"labelCaption":"Примечание:"
		}));	

		this.addElement(new EditMoney(id+":total",{
			"labelCaption":"Стоимость:"
		}));	

		this.addElement(new EditMoney(id+":advance_pay",{
			"labelCaption":"Аванс:"
		}));	

		this.addElement(new DocOrderValubleGrid(id+":valubles",{
		}));	

		this.addElement(new EditFile(id+":file_list",{
			"multipleFiles":true
			//,"labelCaption":"Схемы к заказу:"
			,"showHref":true
			,"showPic":true
			,"onDeleteFile":function(fileId,callBack){
				self.deleteAttachment(fileId,callBack);
			}
			,"onFileAdded":function(fileId){
				self.addAttachment(fileId);
			}
			,"onDownload":function(fileId){
				self.downloadAttachment(fileId);
			}
			,"allowedFileExtList":["jpg","pdf","png","jpeg","doc","docx","xls","xlsx"]
			//,"allowedFileTypeList":["application/pdf","image/png"]			
		}));	
	
		this.addElement(new ButtonCmd(id+":cmdPrint",{
			"caption":" Печать"
			,"title":"Печать заказа"
			,"glyph":"glyphicon-print"
			,"onClick":function(){
				self.printOrder();
			}
		}));	
	
		if(options.templateOptions.stateHist){
			//таблица статусов
			this.addElement(new DocOrderStateHistList_View(id+":state_hist_list",{
				"detail":true
			}));			
		}	
	}
	
	//****************************************************	
	DocOrderDialog_View.superclass.constructor.call(this,id,options);
	
	//read
	var r_bd = [
		new DataBinding({"control":this.getElement("id")})
		,new DataBinding({"control":this.getElement("date_time")})
		,new DataBinding({"control":this.getElement("client_name")})
		,new DataBinding({"control":this.getElement("client_tel")})
		,new DataBinding({"control":this.getElement("color_name")})
		,new DataBinding({"control":this.getElement("material_name")})
		,new DataBinding({"control":this.getElement("order_name")})
		,new DataBinding({"control":this.getElement("order_description")})
		,new DataBinding({"control":this.getElement("notes")})
		,new DataBinding({"control":this.getElement("total")})
		,new DataBinding({"control":this.getElement("advance_pay")})
		,new DataBinding({"control":this.getElement("valubles")})
		,new DataBinding({"control":this.getElement("file_list"),"fieldId":"attachments"})
	];
	this.setDataBindings(r_bd);
	
	//write
	this.setWriteBindings([
		new CommandBinding({"control":this.getElement("date_time")})
		,new CommandBinding({"control":this.getElement("client_name")})
		,new CommandBinding({"control":this.getElement("client_tel")})
		,new CommandBinding({"control":this.getElement("color_name")})
		,new CommandBinding({"control":this.getElement("material_name")})
		,new CommandBinding({"control":this.getElement("order_name")})
		,new CommandBinding({"control":this.getElement("order_description")})
		,new CommandBinding({"control":this.getElement("notes")})
		,new CommandBinding({"control":this.getElement("total")})
		,new CommandBinding({"control":this.getElement("advance_pay")})
		,new CommandBinding({"control":this.getElement("valubles"),"fieldId":"valubles"})
	]);
	
	if (options.templateOptions.stateHist){
		this.addDetailDataSet({
			"control":this.getElement("state_hist_list").getElement("grid")
			,"controlFieldId":"doc_order_id"
			,"value":options.model.getFieldValue("id")
		});
	}	
}
extend(DocOrderDialog_View,ViewObjectAjx);

DocOrderDialog_View.prototype.deleteAttachmentCont = function(fileId,callBack){
	var pm = this.getController().getPublicMethod("delete_file");
	pm.setFieldValue("doc_order_id",this.getElement("id").getValue());
	pm.setFieldValue("file_id",fileId);
	pm.run({
		"ok":function(){
			if(callBack){
				callBack();
			}
		}
	});
}

DocOrderDialog_View.prototype.deleteAttachment = function(fileId,callBack){
	var self = this;
	WindowQuestion.show({
		"text":"Удалить файл?",
		"cancel":false,
		"callBack":function(res){			
			if (res==WindowQuestion.RES_YES){
				self.deleteAttachmentCont(fileId,callBack);
			}
		}
	});
}

DocOrderDialog_View.prototype.setAttachmentUploaded = function(fl,previewData){
	var n = document.getElementById(fl.file_id+"-pic");
	if(n){
		n.className = "glyphicon glyphicon-ok";
		n.title = "Файл прикреплен к заказу";
	}
	var n = document.getElementById(fl.file_id+"-href");
	if(n){
		n.setAttribute("file_uploaded","true");
	}	
	var n = document.getElementById(fl.file_id+"-del");
	if(n){
		n.setAttribute("file_uploaded","true");
	}	
	
	fl.uploaded = true;
	
	var n = document.getElementById(fl.file_id+"-preview");
	if(n&&previewData){
		n.setAttribute("src","data:image/png;base64, "+previewData);
	}
	//DOMHelper.previewImage(this.getElement("picture_file").getElement("file").getNode(),document.getElementById(fl.file_id+"-preview"));
}

DocOrderDialog_View.prototype.onGetData = function(resp,cmd){
	DocOrderDialog_View.superclass.onGetData.call(this,resp,cmd);
	
	var m = this.getModel();
	
	if(window.getApp().getServVar("role_id")=="production"){
		//read only
		this.disableAll();
		this.getElement("cmdPrint").setEnabled(true);
		this.getElement("cmdCancel").setEnabled(true);
	}
	
	var n = document.getElementById(this.getId()+":last_state_inf");
	if(n){
		var val = m.getFieldValue("last_state");
		var st = Enum_doc_order_states.prototype.multyLangValues[window.getApp().getLocale()+"_"+val];
		if(st){
			DOMHelper.setText(n,
				"Статус: "+
				st+
				" ("+
				m.getFieldValue("last_state_users_ref").getDescr()+", "+
				DateHelper.format(m.getFieldValue("last_state_dt"),"d/m/Y H:i")+
				")"
			);
		}
	}	
}

DocOrderDialog_View.prototype.setAttachmentUploadError = function(fl){
	var n = document.getElementById(fl.file_id+"-pic");
	if(n){
		n.className = "glyphicon glyphicon-remove";
		n.title = "Ошибка загрузки файла";
	}
}

DocOrderDialog_View.prototype.addAttachmentCont = function(fl){
	//console.log("DocOrderDialog_View.prototype.addAttachmentCont")
	//console.log(fl)
	
	var self = this;
	var pm = this.m_controller.getPublicMethod("add_file");
	pm.setFieldValue("doc_order_id",this.getElement("id").getValue());
	pm.setFieldValue("file_id",fl.file_id);
	pm.setFieldValue("file_data",[fl]);
	pm.run({
		"ok":function(resp){
			console.log(resp)
			var m = resp.getModel("Preview_Model");
			var preview_data;
			if(m && m.getNextRow()){
				preview_data = m.getFieldValue("value");
			}
			self.setAttachmentUploaded(fl,preview_data);
		}
		,"fail":function(resp,errCode,errStr){
			self.setAttachmentUploadError(fl);
			throw new Error("Ошибка загрузки файла: "+errStr);
		}
	});
}

DocOrderDialog_View.prototype.addAttachment = function(fileId){
	var list = this.getElement("file_list").getFiles();
	if(!list || !list.length)return;
	var fl = list[list.length-1];
	
	if (!this.getModified()){
		this.addAttachmentCont(fl);
	}
	else{	
		var self = this;
		this.getControlOK().setEnabled(false);		
		
		this.onSave(
			function(){
				self.addAttachmentCont(fl);
			},
			null,
			function(){
				self.getControlOK().setEnabled(true);		
			}
		);			
	}
}	

DocOrderDialog_View.prototype.downloadAttachment = function(fileId){
	var pm = this.getController().getPublicMethod("get_file");
	pm.setFieldValue("doc_order_id",this.getElement("id").getValue());
	pm.setFieldValue("file_id",fileId);
	pm.download();

}

DocOrderDialog_View.prototype.printOrderCont = function(){
	var docType = "pdf";
	var templ = "DocOrderPrint";
	var offset = 0;
	
	var contr = this.getController();
	var pm = contr.getPublicMethod("get_print");
	pm.setFieldValue("doc_order_id",this.getElement("id").getValue());
	pm.setFieldValue("templ",templ);
	pm.setFieldValue("inline",(docType=="pdf")? "1":"0");
	
	if(docType=="pdf"){
		var h = $( window ).width()/3*2;
		var left = $( window ).width()/2;
		var w = left - 20;
		contr.openHref("get_print","ViewPDF","location=0,menubar=0,status=0,titlebar=0,top="+(50+offset)+",left="+(left+offset)+",width="+w+",height="+h);
	}
	
}	

DocOrderDialog_View.prototype.printOrder = function(){
	if (!this.getModified()){
		this.printOrderCont();
	}
	else{	
		var self = this;
		this.getControlOK().setEnabled(false);		
		
		this.onSave(
			function(){
				self.printOrderCont();
			},
			null,
			function(){
				self.getControlOK().setEnabled(true);		
			}
		);			
	}

}
