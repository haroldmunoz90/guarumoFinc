<?php

class AttendaceReportView extends BaseView {

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
		
		$this->assignType("time", "Hora Evento", BaseView::DATE_TIME , array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));

							
		$this->assignType("attendance_status_id", JText::_("COM_CTC_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Type", 
            BaseView::ENT_CLASS => "AttendanceStatus",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
		
		$this->assignType("attendance_type_id", JText::_("COM_CTC_ATT_CLASSIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Type", 
            BaseView::ENT_CLASS => "AttendanceType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
		
		$this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
			1 => "Dispositivo",
            2 => "Manual",
            3 => "Automática"
            ));
    
////////////  form
		$this->assignType("start_time", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name", "last_name","identification"),
            BaseView::ENT_FILTER => $filter));
		
		$this->assignType("attendance_status_id", JText::_("COM_CTC_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Type", 
            BaseView::ENT_CLASS => "AttendanceStatus",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
		       
		$this->assignType("attendance_type_id", JText::_("COM_CTC_ATT_CLASSIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Type", 
            BaseView::ENT_CLASS => "AttendanceType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
		
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
		$this->assignType("adate", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
		$this->assignType("GC_NOVEDADES", "Novedades", BaseView::STRING);		
		
		$this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
			1 => "Dispositivo",
            2 => "Manual",
            3 => "Automática"
            ));
		$this->assignType("device_id", JText::_("COM_CTC_DEVICE"), BaseView::ENTITY, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Device",
            BaseView::ENT_FILTER => null ));
		$this->assignType("devices", JText::_("COM_CTC_DEVICES_ALLOW"), BaseView::ENTITIES, array(
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_CLASS => "Device",
			BaseView::ENT_FILTER => $filter,
            BaseView::TOOLTIP => JText::_("COM_CTC_DEVICES_ALLOW_DESC")));	

        $this->addView("form", array("start_time","person_id_ALIAS_2",
			"person_id_ALIAS_1",
			"attendance_status_id","attendance_type_id","cost_center_id","branch_office_id",
			"area_id","contract_type_id","origin_type_id","devices"));            
        $this->addAction("form", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		
		$this->addView("table", array("person_id","person_id_ALIAS_1",
			"time","attendance_status_id","attendance_type_id","device_id",

			"origin_type_id", "branch_office_id"));
		
        $this->addView("formdatenotatt", array("start_time","person_id_ALIAS_2",
			"person_id_ALIAS_1","cost_center_id","branch_office_id",
			"area_id","contract_type_id"));            
        $this->addAction("formdatenotatt", "report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		
		$this->addView("tabledatenotatt", array("person_id","person_id_ALIAS_1",
			"adate","GC_NOVEDADES"));  		
    }
}