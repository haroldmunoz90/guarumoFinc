<?php

class HourConceptReportView extends BaseView {

	function __construct() {
		$filter = new Filter();
		$filter->eq_("status_id", 1);
		
		$filterType = new Filter();
		$filterType->omit('BranchOffice');
		$filterType->setIncludeParents(true);		
		
		$this->assignType("id", "id", BaseView::HIDDEN);

		$this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Person",
			BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => array( "name",
					"last_name",
					"identification"),
			BaseView::ENT_FILTER => $filter));
		
		$this->assignType("concept_id", JText::_("COM_CTC_CONCEPT"), BaseView::ENTITIES, array(
			BaseView::ENT_VAR_NAME => "Concept",
			BaseView::ENT_CLASS => "Concept",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => array("name","code"),
			BaseView::ENT_FIELD_ID => "name",
			BaseView::ENT_FILTER => $filterType,
			BaseView::FUNC_JS => "goConcept"));
		
		$this->assignType("authorized", "Incluir Autorizadas",  BaseView::PICKLIST, array(
            "T" => "Si",
            "F" => "No"
		));		
		
		$this->assignType("hours", "Horas", BaseView::STRING );
		$this->assignType("money", "Valor", BaseView::STRING );
		$this->assignType("start_time", "Hora Inicio", BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		$this->assignType("end_time", "Hora Final", BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
		// Campos de formularios de Reporte
		$this->assignType("concept_id_ALIAS_1", JText::_("COM_CTC_CONCEPT"), BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Concept",
			BaseView::ENT_CLASS => "Concept",
			BaseView::ENT_FIELD => array("code"),
			BaseView::ENT_FIELD_ID => "code",
			BaseView::FUNC_JS => "goConcept"));
		
		$this->assignType("code", JText::_("COM_CTC_CODE") , BaseView::STRING );		
		
		$this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "ContractType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));	
		
		$this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_EMPLOYEE"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
			));
		
		$this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Area",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter,
			BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));
		
		$this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		

		$this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "BranchOffice",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		
		$this->assignType("paid", "Remunerada", BaseView::PICKLIST, array(
			'F' => "No",
			'T' => "Si"
		));		
		

		///  Vistas de Reporte
		$this->addView("reportform", 
			array( "person_id", "start_time","contract_type_id","concept_id",
				"area_id","branch_office_id","cost_center_id","paid","authorized"));
		$this->addAction("reportform", "hc_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		$this->addView("tablereport", 
			array("person_id_ALIAS_1",
				"code", "hours", "money"));		
		
		$this->addView("details", array("concept_id", "hours", "start_time", "end_time"));

		$this->addView("aud", array(
			"person_id",
			"concept_id",
			"hours",
			"start_time",
			"end_time"));
	}

}
