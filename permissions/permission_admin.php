<?php
/**
	DO NOT MODIFY THIS FILE!	
	Its content is generated automaticaly from template placed at build/permissions/permission_php.tmpl.	
 */
function method_allowed($contrId,$methId){
$permissions = array();

					$permissions['Constant_Controller_set_value']=TRUE;
				
					$permissions['Constant_Controller_get_list']=TRUE;
				
					$permissions['Constant_Controller_get_object']=TRUE;
				
					$permissions['Constant_Controller_get_values']=TRUE;
				
					$permissions['Enum_Controller_get_enum_list']=TRUE;
				
					$permissions['MainMenuConstructor_Controller_insert']=TRUE;
				
					$permissions['MainMenuConstructor_Controller_update']=TRUE;
				
					$permissions['MainMenuConstructor_Controller_delete']=TRUE;
				
					$permissions['MainMenuConstructor_Controller_get_list']=TRUE;
				
					$permissions['MainMenuConstructor_Controller_get_object']=TRUE;
				
					$permissions['MainMenuContent_Controller_insert']=TRUE;
				
					$permissions['MainMenuContent_Controller_update']=TRUE;
				
					$permissions['MainMenuContent_Controller_delete']=TRUE;
				
					$permissions['MainMenuContent_Controller_get_list']=TRUE;
				
					$permissions['MainMenuContent_Controller_get_object']=TRUE;
				
					$permissions['View_Controller_get_list']=TRUE;
				
					$permissions['View_Controller_complete']=TRUE;
				
					$permissions['View_Controller_get_section_list']=TRUE;
				
					$permissions['VariantStorage_Controller_insert']=TRUE;
				
					$permissions['VariantStorage_Controller_upsert_filter_data']=TRUE;
				
					$permissions['VariantStorage_Controller_upsert_col_visib_data']=TRUE;
				
					$permissions['VariantStorage_Controller_upsert_col_order_data']=TRUE;
				
					$permissions['VariantStorage_Controller_update']=TRUE;
				
					$permissions['VariantStorage_Controller_delete']=TRUE;
				
					$permissions['VariantStorage_Controller_get_list']=TRUE;
				
					$permissions['VariantStorage_Controller_get_object']=TRUE;
				
					$permissions['VariantStorage_Controller_get_filter_data']=TRUE;
				
					$permissions['VariantStorage_Controller_get_col_visib_data']=TRUE;
				
					$permissions['VariantStorage_Controller_get_col_order_data']=TRUE;
				
					$permissions['About_Controller_get_object']=TRUE;
				
					$permissions['User_Controller_insert']=TRUE;
				
					$permissions['User_Controller_update']=TRUE;
				
					$permissions['User_Controller_delete']=TRUE;
				
					$permissions['User_Controller_get_list']=TRUE;
				
					$permissions['User_Controller_get_object']=TRUE;
				
					$permissions['User_Controller_complete']=TRUE;
				
					$permissions['User_Controller_get_profile']=TRUE;
				
					$permissions['User_Controller_reset_pwd']=TRUE;
				
					$permissions['User_Controller_login']=TRUE;
				
					$permissions['User_Controller_login_refresh']=TRUE;
				
					$permissions['User_Controller_logout']=TRUE;
				
					$permissions['User_Controller_logout_html']=TRUE;
				
					$permissions['Login_Controller_get_list']=TRUE;
				
					$permissions['Login_Controller_get_object']=TRUE;
				
					$permissions['Color_Controller_insert']=TRUE;
				
					$permissions['Color_Controller_update']=TRUE;
				
					$permissions['Color_Controller_delete']=TRUE;
				
					$permissions['Color_Controller_get_list']=TRUE;
				
					$permissions['Color_Controller_get_object']=TRUE;
				
					$permissions['Color_Controller_complete']=TRUE;
				
					$permissions['Material_Controller_insert']=TRUE;
				
					$permissions['Material_Controller_update']=TRUE;
				
					$permissions['Material_Controller_delete']=TRUE;
				
					$permissions['Material_Controller_get_list']=TRUE;
				
					$permissions['Material_Controller_get_object']=TRUE;
				
					$permissions['Material_Controller_complete']=TRUE;
				
					$permissions['Client_Controller_insert']=TRUE;
				
					$permissions['Client_Controller_update']=TRUE;
				
					$permissions['Client_Controller_delete']=TRUE;
				
					$permissions['Client_Controller_get_list']=TRUE;
				
					$permissions['Client_Controller_get_object']=TRUE;
				
					$permissions['Client_Controller_complete']=TRUE;
				
					$permissions['DocOrder_Controller_insert']=TRUE;
				
					$permissions['DocOrder_Controller_add_file']=TRUE;
				
					$permissions['DocOrder_Controller_delete_file']=TRUE;
				
					$permissions['DocOrder_Controller_get_file']=TRUE;
				
					$permissions['DocOrder_Controller_update']=TRUE;
				
					$permissions['DocOrder_Controller_delete']=TRUE;
				
					$permissions['DocOrder_Controller_get_list']=TRUE;
				
					$permissions['DocOrder_Controller_get_object']=TRUE;
				
					$permissions['DocOrder_Controller_complete']=TRUE;
				
					$permissions['DocOrder_Controller_get_print']=TRUE;
				
					$permissions['DocOrderStateHist_Controller_insert']=TRUE;
				
					$permissions['DocOrderStateHist_Controller_update']=TRUE;
				
					$permissions['DocOrderStateHist_Controller_delete']=TRUE;
				
					$permissions['DocOrderStateHist_Controller_get_list']=TRUE;
				
					$permissions['DocOrderStateHist_Controller_get_object']=TRUE;
				
					$permissions['DocOrderValuble_Controller_insert']=TRUE;
				
					$permissions['DocOrderValuble_Controller_update']=TRUE;
				
					$permissions['DocOrderValuble_Controller_delete']=TRUE;
				
					$permissions['DocOrderValuble_Controller_get_list']=TRUE;
				
					$permissions['DocOrderValuble_Controller_get_object']=TRUE;
				
return array_key_exists($contrId.'_'.$methId,$permissions);
}
?>