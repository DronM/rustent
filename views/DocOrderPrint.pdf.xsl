<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet version="1.0"  xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"><xsl:output method="xml"/> <!--https://www.webucator.com/tutorial/learn-xsl-fo--><xsl:template name="format_money">	<xsl:param name="val"/>	<xsl:choose>		<xsl:when test="$val='0' or string(number($val))='NaN'">			<xsl:text>&#160;</xsl:text>		</xsl:when>		<xsl:otherwise>			<xsl:value-of select="format-number($val,'##0.00')"/>		</xsl:otherwise>			</xsl:choose></xsl:template><!-- Main template --><xsl:template match="/">	<fo:root>		<fo:layout-master-set>			<fo:simple-page-master master-name="Report"				page-height="21cm" page-width="14.7cm" margin-top="0.5cm"				margin-left="1cm" margin-right="0.5cm" margin-bottom="0.5cm">				<fo:region-body margin-bottom="0.5cm"/>				<fo:region-before/>				<fo:region-after extent=".3cm" background-color="silver"/>			</fo:simple-page-master>		</fo:layout-master-set>		<fo:page-sequence master-reference="Report">	  			<fo:static-content flow-name="xsl-region-after">				<fo:block font-family="Arial" font-size="6pt" text-align="right">					Страница <fo:page-number/> из <fo:page-number-citation ref-id="last-page"/>				</fo:block>			</fo:static-content>								<fo:flow flow-name="xsl-region-body">										<xsl:apply-templates select="document/model"/>						<!--				<fo:block id="last-page" page-break-before="always">					<fo:external-graphic					height="20cm" width="13.2cm"					content-height="scale-down-to-fit" content-width="scale-down-to-fit"     					src="url({document/model[@id='DocOrderPrint_Model']/row/project_path}output/ord_7_a206da2d-3b75-4905-abd5-5b1e862f1e7b)" />								</fo:block>							-->			</fo:flow>							</fo:page-sequence>	</fo:root></xsl:template><xsl:template match="model[@id='FileList_Model']/row">	<xsl:variable name="file_url" select="concat(//document/model[@id='DocOrderPrint_Model']/row/project_path,'output/ord_',//document/model[@id='DocOrderPrint_Model']/row/id,'_',file_id/.)"/>	<xsl:variable name="page_id">		<xsl:choose>		<xsl:when test="position() = last()">last-page</xsl:when>		<xsl:otherwise>fl_{position()}</xsl:otherwise>		</xsl:choose>	</xsl:variable>		<fo:block id="{$page_id}" page-break-before="always">		<fo:external-graphic		height="20cm" width="13.2cm"		content-height="scale-down-to-fit" content-width="scale-down-to-fit"     		src="url({$file_url})" />					</fo:block>			</xsl:template><xsl:template match="model[@id='DocOrderPrint_Model']">		<fo:block>		<fo:external-graphic		height="3cm" width="13.2cm"		content-height="scale-down-to-fit" content-width="scale-down-to-fit"     		src="url({row/project_path}img/OrderPrintLogo.jpg)" />	</fo:block>				<!--<fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>-->			<fo:block font-family="Arial" font-style="normal"		margin-top="7px" margin-bottom="15px" font-size="14px"		font-weight="bold" text-align="center"		border-top-width="2pt" 		border-top-style="solid" 		border-top-color="black"					>					Заказ № <xsl:value-of select="row/id"/> от <xsl:value-of select="row/date_descr"/>	</fo:block>		<fo:block-container font-family="Arial" font-style="normal" margin-top="15px">		<fo:table table-layout="fixed" width="100%">			<fo:table-column column-width="25%"/>			<fo:table-column column-width="25%"/>			<fo:table-column column-width="25%"/>			<fo:table-column column-width="25%"/>					<fo:table-body font-size="8pt">				<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block>						</fo:block>					</fo:table-cell>																																	<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							Дата приема заказа						</fo:block>					</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							Дата размещения в производство						</fo:block>					</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							Дата изготовления						</fo:block>					</fo:table-cell>								</fo:table-row>						<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block>						</fo:block>					</fo:table-cell>																																	<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							<xsl:value-of select="row/date_time_formatted"/>						</fo:block>					</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							<xsl:value-of select="row/date_time_production_formatted"/>						</fo:block>					</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							<xsl:value-of select="row/date_time_ready_formatted"/>						</fo:block>					</fo:table-cell>								</fo:table-row>			</fo:table-body>			</fo:table>	</fo:block-container>		<fo:block-container font-family="Arial" font-style="normal" margin-top="15px">		<fo:table table-layout="fixed" width="100%">			<fo:table-column column-width="5%"/>			<fo:table-column column-width="30%"/>			<fo:table-column column-width="65%"/>					<fo:table-body font-size="8pt">				<fo:table-row height="0.4cm">					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							1						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Номер заказа						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							№ <xsl:value-of select="row/id"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- ФИО -->				<fo:table-row>						<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							2						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							ФИО заказчика						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/client_name"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Телефон -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							3						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Контактный телефон						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/client_tel"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Наименование заказа -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							4						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Наименование заказа						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/order_name"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Описание заказа -->				<fo:table-row>									<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							5						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Описание заказа						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/order_description"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Материал исполнения -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							6						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Материал исполнения						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/material_name"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Цвет -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							7						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Цвет						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/color_name"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Примечания -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							8						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Примечания						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							<xsl:value-of select="row/notes"/>						</fo:block>					</fo:table-cell>				</fo:table-row>							<!-- Стоимость -->								<fo:table-row>					<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							9						</fo:block>					</fo:table-cell>								<fo:table-cell border="solid 0.1mm black">						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Стоимость						</fo:block>					</fo:table-cell>					<fo:table-cell border="solid 0.1mm black">						<fo:table table-layout="fixed" width="100%">							<fo:table-column column-width="20%"/>							<fo:table-column column-width="20%"/>							<fo:table-column column-width="20%"/>							<fo:table-column column-width="20%"/>							<fo:table-column column-width="20%"/>									<fo:table-body font-size="8pt">								<fo:table-row height="0.4cm">									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											стоимость										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											аванс										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											к доплате										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											100% предоплата										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											заказ оплачен										</fo:block>									</fo:table-cell>															</fo:table-row>															<fo:table-row height="0.4cm">									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											<xsl:call-template name="format_money">												<xsl:with-param name="val" select="row/total" />											</xsl:call-template>										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											<xsl:call-template name="format_money">												<xsl:with-param name="val" select="row/advance_pay" />											</xsl:call-template>										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											<xsl:call-template name="format_money">												<xsl:with-param name="val" select="row/total - row/advance_pay" />											</xsl:call-template>										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											<xsl:choose>											<xsl:when test="(row/total - row/advance_pay)=0">V											</xsl:when>											<xsl:otherwise>											</xsl:otherwise>											</xsl:choose>										</fo:block>									</fo:table-cell>									<fo:table-cell border="solid 0.1mm black">										<fo:block font-family="Arial" font-style="normal"											font-weight="normal" text-align="center">											заказ оплачен										</fo:block>									</fo:table-cell>															</fo:table-row>														</fo:table-body>							</fo:table>					</fo:table-cell>								</fo:table-row>				</fo:table-body>			</fo:table>	</fo:block-container>						<fo:block font-family="Arial" font-style="normal"		margin-top="15px" margin-bottom="5px" font-size="14px"		font-weight="bold" text-align="center"		border-top-width="2pt" 		border-top-style="solid" 		border-top-color="black"					>					Акт о приеме-передаче материальных ценностей	</fo:block>		<fo:table table-layout="fixed" width="100%">		<fo:table-column column-width="5%"/>		<fo:table-column column-width="80%"/>		<fo:table-column column-width="15%"/>		<fo:table-body font-size="8pt">			<fo:table-row height="0.4cm">				<fo:table-cell border="solid 0.1mm black">					<fo:block font-family="Arial" font-style="normal"						font-weight="normal" text-align="center">						№					</fo:block>				</fo:table-cell>				<fo:table-cell border="solid 0.1mm black">					<fo:block font-family="Arial" font-style="normal"						font-weight="normal" text-align="center">						Наименование					</fo:block>				</fo:table-cell>				<fo:table-cell border="solid 0.1mm black">					<fo:block font-family="Arial" font-style="normal"						font-weight="normal" text-align="center">						Количество					</fo:block>				</fo:table-cell>						</fo:table-row>						<xsl:apply-templates select="row/valubles"/>						</fo:table-body>	</fo:table>		<fo:block font-family="Arial" font-style="normal"		margin-top="15px" font-size="8px"		font-weight="normal" text-align="left"		>					Передача материальных ценностей только на период производства работ по данному заказу. При выдаче заказа материальные ценности в полном объеме возвращаются заказчику.	</fo:block>		<fo:block-container font-family="Arial" font-style="normal" margin-top="15px">		<fo:table table-layout="fixed" width="100%">			<fo:table-column column-width="50%"/>			<fo:table-column column-width="50%"/>			<fo:table-body font-size="8pt">				<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Исполнитель:						</fo:block>					</fo:table-cell>					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							Заказчик:						</fo:block>					</fo:table-cell>				</fo:table-row>				<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							__________________ (подпись)						</fo:block>					</fo:table-cell>					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							__________________ (подпись)						</fo:block>					</fo:table-cell>				</fo:table-row>				<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							__________________ (расшифровка подписи)						</fo:block>					</fo:table-cell>					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="left">							__________________ (расшифровка подписи)						</fo:block>					</fo:table-cell>				</fo:table-row>				<fo:table-row height="0.4cm">					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							М.П.						</fo:block>					</fo:table-cell>					<fo:table-cell>						<fo:block font-family="Arial" font-style="normal"							font-weight="normal" text-align="center">							М.П.						</fo:block>					</fo:table-cell>				</fo:table-row>						</fo:table-body>		</fo:table>	</fo:block-container></xsl:template><xsl:template match="valuble">	<xsl:variable name="color">		<xsl:choose>		<xsl:when test="not((position()+1) mod 2 = 0)">Gainsboro</xsl:when>		<xsl:otherwise>white</xsl:otherwise>		</xsl:choose>	</xsl:variable>	<fo:table-row height="0.4cm" background-color="{$color}">		<fo:table-cell border="solid 0.1mm black">			<fo:block font-family="Arial" font-style="normal"				font-weight="normal" text-align="center">				<xsl:value-of select="position()"/>			</fo:block>		</fo:table-cell>																															<fo:table-cell border="solid 0.1mm black">			<fo:block font-family="Arial" font-style="normal"				font-weight="normal" text-align="left">				<xsl:value-of select="name"/>			</fo:block>		</fo:table-cell>																														<fo:table-cell border="solid 0.1mm black">			<fo:block font-family="Arial" font-style="normal"				font-weight="normal" text-align="right">				<xsl:value-of select="quant"/>			</fo:block>		</fo:table-cell>	</fo:table-row></xsl:template></xsl:stylesheet>