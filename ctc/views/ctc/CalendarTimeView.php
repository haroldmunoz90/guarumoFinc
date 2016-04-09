<?php

/**
 * Configuracion de vistas para la clase "IlgCalendarTime".
 *
 */
class CalendarTimeView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
		parent::addCheckBox("table");
		
		$filter = new Filter();
		$filter->eq_("status_id", 1);
		
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
		$this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);
        //$this->assignType("date_type_id", JText::_("COM_CTC_TYPE"), BaseView::HIDDEN);
		
		$this->assignType("mode","Modo del Intervalo", BaseView::PICKLIST, array(
			CalendarTime::MODE_REGULAR => "Regular",
			CalendarTime::MODE_FLEXIBLE => "Flexible",
			BaseView::TOOLTIP => "Regular indica que el intervalo tiene hora de inicio y fin. "
				. "Flexible se utiliza cuando los empleados no tienen un horario fijo y solo se requiere controlar el tiempo trabajado." 
			));	
        $this->assignType("start_time", "Hora Inicio", BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora de Inicio del Intervalo de Turno." ));
        $this->assignType("end_time", "Hora Final", BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora de Terminación del Intervalo de Turno." ));
        $this->assignType("initial_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE, 
			array( BaseView::TOOLTIP => "Fecha de Inicio de Activación de éste Intervalo de Turno." ));
        $this->assignType("end_date", "Fecha de fin", BaseView::DATE, 
			array( BaseView::TOOLTIP => "Fecha de Finalización de la Activación de éste Intervalo de Turno." ));
		$this->assignType("all_days", "Todos", BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("monday", JText::_("MONDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("tuesday", JText::_("TUESDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("wednesday", JText::_("WEDNESDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("thursday", JText::_("THURSDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("friday", JText::_("FRIDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("saturday", JText::_("SATURDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("sunday", JText::_("SUNDAY"), BaseView::BOOLEAN, array("true", "false"));
		//$this->assignType("holiday", "Festivo", BaseView::BOOLEAN, array("true", "false"));
        
        $func = function($obj) {
            $ret = array();
            if($obj->monday == 'T') {
                $ret[] = "Lu";
            } 
            if($obj->tuesday == 'T') {
                $ret[] = "Ma";
            }
            if($obj->wednesday == 'T') {
                $ret[] = "Mi";
            }
            if($obj->thursday == 'T') {
                $ret[] = "Ju";
            }
            if($obj->friday == 'T') {
                $ret[] = "Vi";
            }
            if($obj->saturday == 'T') {
                $ret[] = "Sa";
            }
            if($obj->sunday == 'T') {
                $ret[] = "Do";
            }
			if($obj->holiday == 'T') {
                $ret[] = "Fe";
            }
            return implode(",", $ret);
        };
        
        $this->assignType("days", "Días", BaseView::FUNC, $func);

        $this->assignType("applies_all_years", "Aplica todos los años", BaseView::HIDDEN);//BOOLEAN, array("true", "false"));
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("creation_date", "Creation Date", BaseView::HIDDEN);
        $this->assignType("change_status_date", "Change Status Date", BaseView::HIDDEN);
		
		$this->assignType("apply_boundaries", "Hora Min-Max",
				BaseView::PICKLIST, array(
									0 => JText::_("COM_CTC_NOT"),
									1 => JText::_("COM_CTC_YES"),	
				BaseView::TOOLTIP => "Aplicar hora minima y maxima para el turno." ));
        $this->assignType("min_in_time", "Hora Mínima Entrada", BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora mínima de marcación para considerarla como entrada de este turno." ));
		$this->assignType("max_in_time", "Hora Máxima Entrada", BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora Máxima de marcación para considerarla como entrada de este turno." ));
        $this->assignType("min_out_time", "Hora Mínima Salida",	BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora mínima de marcación para considerarla como salida de este turno." ));		
        $this->assignType("max_out_time", "Hora Máxima Salida",	BaseView::TIME, 
			array( BaseView::TOOLTIP => "Hora máxima de marcación para considerarla como salida de este turno." ));
	
		$this->addAuthFields();	
		
		$this->assignType("each_week", "Cada", BaseView::STRING,array(
            BaseView::TOOLTIP => "Determina cada cuantas semanas este turno esta disponible." ));
		
		$this->assignType("week_pos", "Semana", BaseView::PICKLIST, array(
			"0" => "Primera Semana.",
			"1" => "Segunda Semana.",
			"2" => "Tercera Semana.",
			"3" => "Cuarta Semana.",
            "4" => "Quinta Semana.",
			"5" => "Sexta Semana.",
			"6" => "Septima Semana.",
			"7" => "Octava Semana.",
			"8" => "Novena Semana.",
            "9" => "Decima Semana.",
			"10" => "Decima Primera Semana.",
			"11" => "Decima Segunda Semana.",
			"12" => "Decima Tercera Semana.",
			"13" => "Decima Cuarta Semana.",
            "14" => "Decima Quinta Semana.",			
			BaseView::TOOLTIP => "Determina la semana en que éste turno esta disponible." 
            ));
		
	
		$this->assignType("flex_duration","Duración del Intervalo Flexible", BaseView::TIME, 
			array( BaseView::TOOLTIP => "Duración del intervalo de turno Flexible." ));
		
		$this->assignType("category_id", "Categoría", BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CalendarTimeCategory",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));	
		
		$this->assignType("subconceptitems", JText::_("COM_CTC_SUBCONCEPTS_ASSO"), BaseView::ENTITIES, array(
			BaseView::ENT_FIELD => "alias_name",
			BaseView::ENT_CLASS => "SubConceptItem",
			BaseView::ENT_FILTER => $filter));		
		
		$filterS = new Filter();
		//$filter->eq_("status_id", 1);
		$filterS->isNull_("pto_id");
		$this->assignType("schedules", "Turnos Asignados", BaseView::ENTITIES, array(
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_CLASS => "Schedule",
			BaseView::ENT_FILTER => $filterS));
		
		$this->assignType("max_time_to_search","Máx. Busqueda", BaseView::STRING, 
			array( BaseView::TOOLTIP => "Máximo tiempo en horas para buscar por el anterior lapso de trabajo."
		));
		
		$filterM = new Filter();
		$filterM->eq_("status_id", 1)->and_()->join_("schedules", Filter::INIT_VALUE )->
				and_()->ne_("id", Filter::INIT_VALUE );
		$filterM->updateByRequest();
		$this->assignType("ctsToMerge", "Intervalos A Unir", BaseView::ENTITIES_TAGS, array(
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_CLASS => "CalendarTime",
			BaseView::ENT_VIEW_FILTER => "category",
			BaseView::ENT_FILTER => $filterM,
			BaseView::OPT_IN_ALL => true,
            BaseView::TOOLTIP => "Lista de Intervalos de Turno de lapsos de trabajo con los que se puede unir un lapso de Trabajo con este intervalo de turno." ));	
				
        /**
         * Definicion de vistas y sus acciones
         */
        $class = "calendar_time";
        $this->addViewEx("form", array("days"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
		$visible = array("name","category_id", "days",  "start_time", "end_time",
				"apply_boundaries", "min_in_time","max_in_time","min_out_time","max_out_time");
		
		$hidden = array( "mode","code","flex_duration","status_id",
			"each_week","week_pos","initial_date","end_date","max_time_to_search" );
		
        $this->addView("table", array_merge($visible, $hidden) );
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
        
        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        
        $classe = "ealendar_time";
        $this->addViewEx("eform", array("days"));
        $this->addAction("eform", $classe . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("eform", $classe . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("etable", array("name", "days", "start_time", "end_time", "initial_date", "end_date"));
        $this->addAction("etable", $classe . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("etable", $classe . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
        
        $this->addView("edialog", array());
        $this->addAction("edialog", $classe . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("edialog", $classe . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
		
		$this->addView("aud", array(
			"name", "days",  "start_time", "end_time","apply_boundaries", "min_in_time","max_in_time","min_out_time","max_out_time"));
    }
}
