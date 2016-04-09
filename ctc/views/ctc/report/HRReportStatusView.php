<?php

class HRReportStatusView extends BaseView {

    function __construct() {
        $this->assignType("id", "id", BaseView::HIDDEN);
    
		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
		$this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
			));
            
        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter)); 

		
        $this->assignType("start_time", JText::_("COM_CTC_ARRIVE"), BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
        $this->assignType("end_time", JText::_("COM_CTC_DEPART"), BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
        $this->assignType("duration", JText::_("COM_CTC_SUBCT_DURATION"), BaseView::STRING);		
		$this->assignType("area", JText::_("COM_CTC_AREA"), BaseView::STRING);
		
		$this->assignType("calendar_time_id", JText::_("COM_CTC_INIT_INTERVAL"),BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "CalendarTime", 
            BaseView::ENT_CLASS => "CalendarTime",
            BaseView::ENT_FIELD => array("name"),
            BaseView::FUNC_JS => "goCalendarTime"));			

		$this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
			1 => "Dispositivo",
            2 => "Manual",
            3 => "Automática"
            ));	
		
		$this->assignType("status_id", "Estado Empleado", BaseView::PICKLIST, array(
            1 => "Activo",
            2 => "Suspendido"
            ));
		
/// form
		$this->assignType("start_time_form", JText::_("COM_SORCORE_DATE"), BaseView::DATE);

        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name", "last_name","identification"),
            BaseView::ENT_FILTER => $filter ));
	
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
		
        $this->addViewEx("form", array());            
        $this->addAction("form", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		
		$this->addView("table", array("person_id","person_id_ALIAS_1",
			"start_time","end_time","duration","area","calendar_time_id",
			"origin_type_id","status_id"));  
    }

}

?>
