<?php

class FaultReportView extends BaseView {

    function __construct() {
   
		$filter = new Filter();
		$filter->eq_("status_id", 1 );

		$funcNamePS = function( $obj ) {
			$bo = new BranchOffice();
			if( $bo->loadWithFields($obj->branch_office_id,array("id")) ){
				return $bo->name . " $obj->initial_date - $obj->end_date";
			}
			return "$obj->initial_date - $obj->end_date";
		};	
		$this->assignType("start_time", "Hora Inicio", BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		$this->assignType("payroll_period_id", JText::_("COM_CTC_REP_PR_PERIOD"), BaseView::ENTITY, array(
            BaseView::ENT_FIELD_SORT => "initial_date",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => $funcNamePS,
            BaseView::ENT_CLASS => "PayrollPeriod",
            BaseView::ENT_FILTER => null ));
		
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => array("name", "last_name","identification")));
		
		$this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		$this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "BranchOffice",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		$this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Area",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter,
			BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));	
		$this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "ContractType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));		
		
		$this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
			));
		
		$this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_IDENFIFICATION"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
			));
            
		$this->assignType("schedule_id", JText::_("COM_CTC_SCHEDULE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Schedule",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => null));
		
		$this->assignType("keydate", JText::_("COM_CTC_KEYDATE"), BaseView::STRING );
				
		$this->addView("tableReport", array("start_time",
			"person_id_ALIAS_1","person_id","keydate"));
		$exporterConf = array(20, 20, 40, 25,  40, 14,14, 14,14, 14,14, 14,14, 14,14, 14,14, 14,14, 14,);
		$exporterConf['height'] = 20;
		$this->addExporterConf("tableReport", $exporterConf);
		
		
        $this->addView("formReport", array("payroll_period_id",
			"person_id_ALIAS_2","person_id_ALIAS_1",
			"cost_center_id","branch_office_id","area_id","contract_type_id",
			"schedule_id"));            
        $this->addAction("formReport", "filter", JText::_("COM_CTC_UPDATE"), "save.png");
		$this->addAction("formReport", "clearf", JText::_("COM_CTC_CLEAR"), "remove.png");

    }
}