<?php

class AbsenceReportView extends BaseView {

    function __construct() {
        $this->assignType("id", "id", BaseView::HIDDEN);
    
		$filter = new Filter();
		$filter->eq_("status_id", 1 );

		$this->assignType("start_time", JText::_("COM_CTC_START_DATE"), BaseView::DATE, array(
            BaseView::NO_OPER => true) );
		
		$this->assignType("end_time", "Fecha Final", BaseView::DATE, array(
            BaseView::NO_OPER => true) );
		
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => array("name", "last_name","identification")));
		
		$this->assignType("calendar_time_id", "Intervalo de Turno", BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "CalendarTime",
			BaseView::ENT_CLASS => "CalendarTime",
			BaseView::ENT_FIELD => array( "name"),
			BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goListAbsenceByCT"));	
		
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
		
		$this->assignType("countDay", "Días Ausente",  BaseView::NUMBER );
		
		$sqlquery = 
			"and not exists(".
			"select id ".
			"from ilg_hour_concept pn ".
			"where pn.person_id = p.id ".
			"and date( a.Date ) between date( pn.start_time ) and  date( pn.end_time ) ".
			")";
		
		$this->assignType("hourconcept", "Excluir Días con Novedad",  BaseView::PICKLIST, array(
            "$sqlquery" => JText::_("COM_CTC_YES"),
            "" => JText::_("COM_CTC_NOT"),
			BaseView::NO_OPER => true
            ));
		
//--------------------------
		
		
		
		$this->assignType("daytime", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
		
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
				
		$this->assignType("calendar_time_id", "Intervalo de Turno", BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "CalendarTime",
			BaseView::ENT_CLASS => "CalendarTime",
			BaseView::ENT_FIELD => array( "name"),
			BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goListAbsenceByCT"));			
	
		$this->assignType("shiftTime", "Inicio de Intervalo",BaseView::STRING);		
				
		$this->addView("table", array("daytime","person_id",
			"person_id_ALIAS_1","schedule_id",
			"calendar_time_id","shiftTime"));  
		
		
        $this->addView("form", array("start_time","end_time",
			"person_id_ALIAS_2","person_id_ALIAS_1","calendar_time_id",
			"cost_center_id","branch_office_id","area_id","contract_type_id",
			"hourconcept"));            
        $this->addAction("form", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");

		$this->addViewEx("formSummary", array ("start_time","end_time",
			"person_id_ALIAS_2","person_id_ALIAS_1","calendar_time_id",
			"cost_center_id","branch_office_id","area_id","contract_type_id",
			"countDay","hourconcept")); 
		
        $this->addAction("formSummary", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
    }

}

?>
