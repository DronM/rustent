/**	
 * @author Andrey Mikhalevich <katrenplus@mail.ru>, 2018

 * @extends ButtonCmd
 * @requires core/extend.js
 * @requires controls/ButtonCmd.js     

 * @class
 * @classdesc
 
 * @param {string} id - Object identifier
 * @param {object} options
 */
function DocOrderSetStateBtn(id,options){
	options = options || {};	

	this.m_newState = options.newState;
	this.m_getDocOrderId = options.getDocOrderId;
	this.m_getDocOrderState = options.getDocOrderState;
	this.m_grid = options.grid;
	
	var self = this;

	options.onClick = function(){
		self.setState();
	}
	
	DocOrderSetStateBtn.superclass.constructor.call(this,id,options);
}
//ViewObjectAjx,ViewAjxList
extend(DocOrderSetStateBtn,ButtonCmd);

/* Constants */


/* private members */

/* protected*/
DocOrderSetStateBtn.prototype.stateChanged = function(){
	window.showTempNote("Установлен новый статус",null,5000);
}

/* public methods */
DocOrderSetStateBtn.prototype.setStateCont = function(newStatus){
	var pm = (new DocOrderStateHist_Controller()).getPublicMethod("insert");
	pm.setFieldValue("doc_order_id",this.m_getDocOrderId());
	pm.setFieldValue("user_id",0);
	pm.setFieldValue("state",newStatus);
	var self = this;
	pm.run({
		"ok":function(resp){
			if(self.m_grid){
				self.m_grid.onRefresh(function(){
					self.stateChanged();	
				});
			}
			else{
				self.stateChanged();	
			}
		}
	})
}

DocOrderSetStateBtn.prototype.setState = function(){
	var self = this;
	var cur_st = this.m_getDocOrderState();
	console.log(cur_st)
	if(this.m_newState=="select"){
		//status selection with popover
		(new PopUpMenu({
			"caption":"Новый статус"
			,"elements":[
				{"id":"stat_accept"
				,"caption":"Прием"
				,"disabled":(cur_st=="accept")
				,"onClick":function(){
					self.setParticularState("accept");
				}}
				,{"id":"stat_production"
				,"caption":"Производство"
				,"disabled":(cur_st=="production")
				,"onClick":function(){
					self.setStateCont("production");
				}}
				,{"id":"stat_ready"
				,"caption":"Изготовлен"
				,"disabled":(cur_st=="ready")
				,"onClick":function(){
					self.setStateCont("ready");
				}}
				
				,{"id":"stat_notified"
				,"caption":"Оповещен"
				,"disabled":(cur_st=="notified")
				,"onClick":function(){
					self.setStateCont("notified");
				}}
				,{"id":"stat_closed"
				,"caption":"Закрыт"
				,"disabled":(cur_st=="closed")
				,"onClick":function(){
					self.setStateCont("closed");
				}}
				
			]
		})).show(null,this.getNode());
	}
	else{
		//particular preselected status		
		if(cur_st=="accept"){			
			WindowQuestion.show({
				"cancel":false,
				"timeout":5000,
				"text":"Установить статус готово?",
				"callBack":function(res){
					if(res==WindowQuestion.RES_YES){
						self.setStateCont(self.m_newState);
					}
				}
			});
		}
		else{
			window.showTempNote("Неверный статус документа.",null,5000);
		}
	}
}
