<?php

class AttendaceReportDevView extends BaseView {

    function __construct() {
        $this->assignType("id", "id", BaseView::HIDDEN);
    
		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
		$this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"));
            
        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter)); 
		
		$this->assignType("ATDAY", JText::_("COM_CTC_SUBCT_DAY"), BaseView::DATE_TIME , array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));
		$this->assignType("HOUR", "Marcación", BaseView::STRING );
		$this->assignType("HOUR1", "Marcación", BaseView::STRING );
		$this->assignType("HOUR2", "Marcación", BaseView::STRING );
		$this->assignType("HOUR3", "Marcación", BaseView::STRING );
		$this->assignType("HOUR4", "Marcación", BaseView::STRING );
		$this->assignType("HOUR5", "Marcación", BaseView::STRING );
		
        $func = function($obj) {
			//JLog::add($obj ,JLog::DEBUG, "cloudtime" );
			if( intval( $obj->COUNT ) > 6 ) {
				return "<a href=\"javascript:" . "goMoreAttendance" . "('" . $obj->person_id . "','".$obj->ATDAY."');\"> . Continua... </a>";
			}
        };
        
        $this->assignType("MORE", "Más", BaseView::FUNC, $func);

		//form
		$this->assignType("time", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name", "last_name","identification"),
            BaseView::ENT_FILTER => $filter));
 
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
		
		$this->assignType("dateti", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
		$this->assignType("mintime", JText::_("COM_CTC_REP_FIRST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_FIRST_DESC") ));
		$this->assignType("maxtime", JText::_("COM_CTC_REP_LAST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_LAST_DESC") ));
		
        $this->addView("form", array("time","person_id_ALIAS_2","person_id_ALIAS_1","contract_type_id",
			"cost_center_id","branch_office_id","area_id"));
        $this->addAction("form", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
		
    
		$this->addView("table", array("person_id","person_id_ALIAS_1", "branch_office_id",
			"ATDAY","HOUR","HOUR1","HOUR2","HOUR3",
			"HOUR4","HOUR5","MORE")); 
		
		$this->addView("tablefl", array("person_id","person_id_ALIAS_1",
			"dateti","mintime","maxtime"));  
		
		
    }
}
