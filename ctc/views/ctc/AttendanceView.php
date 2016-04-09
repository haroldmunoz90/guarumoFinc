<?php

class AttendanceView extends BaseView {

	function __construct() {
		$this->assignType("id", "ID", BaseView::HIDDEN);

		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
		$this->assignType("id_person", "id_person", BaseView::HIDDEN);
		
		$this->assignType("person_id", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Person",
			BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD => array("name", "last_name"),
			BaseView::ENT_FILTER => $filter,
			BaseView::FUNC_JS => "goPerson"));

		$this->assignType("person_id_ALIAS_1", "Identification", BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Person",
			BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD => array("identification"),
			BaseView::ENT_FILTER => $filter));


		$this->assignType("attendance_type_id", JText::_("COM_CTC_ATT_CLASSIFICATION"), BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Type",
			BaseView::ENT_CLASS => "AttendanceType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => null));
		
		$this->assignType("attendance_status_id", "Tipo Estado", BaseView::ENTITY, array(
			BaseView::ENT_VAR_NAME => "Type",
			BaseView::ENT_CLASS => "AttendanceType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => null));	
		
		$this->assignType("elapsedHours", "Horas Diferencia", BaseView::TIME);
		
/////////////////////  form
       $this->assignType("time", JText::_("COM_SORCORE_DATE"), BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name", 
				"last_name",
				"identification"),
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
		$this->assignType("workcode", JText::_("COM_CTC_PRN_TYPE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Concept",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FIELD_ID => "workcode",
			BaseView::ENT_FIELD_ID_ISNOTID => true,
			BaseView::ENT_FILTER => null));
		$this->assignType("showallnovedad", "Mostrar Con Novedad",  BaseView::PICKLIST, array(
            "1" => "Marcaciones Con Novedad",
			BaseView::CUSTOM_OPER => "Mostrar",
			BaseView::TOOLTIP => "Al seleccionar éste filtro se mostraran todas las marcaciones con Novedad."
            ));
				
        
        $this->addView("form", array("time","person_id_ALIAS_2","person_id_ALIAS_1",
			"attendance_type_id","cost_center_id","branch_office_id","workcode",
			"area_id","contract_type_id"));            
        $this->addAction("form", "arrival_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		
		$this->addView("filter", array("time","id_person"));
        $this->addAction("filter", "update_map_rep", JText::_("COM_CTC_UPDATE"), "refresh.png", null,null, "Actualizar el mapa con el filtro especificado");
		$this->addAction("filter", "center_next", "Centrar", "arrow-right.png", null,null, "Centrar el mapa en la próxima marcación");

		$this->addView("table", array("time","person_id",
			"person_id_ALIAS_1","attendance_type_id","workcode","elapsedHours", "branch_office_id"));

		$this->addView("aud", array(
			"person_id_ALIAS_1",
			"time",
			"attendance_type_id"));
	}

}
