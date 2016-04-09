<?php

class AutoPeriodView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
		parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->addAuthFields();	
        $filter = null;
		$this->assignType("period_type", "Tipo de Período", BaseView::PICKLIST, array(
			AutoPeriod::EACH_DAY => "Cada Día",
			AutoPeriod::EACH_WEEK => "Cada Semana",			
			AutoPeriod::EACH_MONTH => "Cada Mes",
			AutoPeriod::EACH_SPECIFIC_DAY => "Día Específico",
		));
		
		$this->assignType("specific_month_day", "Día del Mes", BaseView::PICKLIST, array(
			1      =>    1  ,
			2      =>    2  ,
			3      =>    3  ,
			4      =>    4  ,
			5      =>    5  ,
			6      =>    6  ,
			7      =>    7  ,
			8      =>    8  ,
			9      =>    9  ,
			10     =>    10 ,
			11     =>    11 ,
			12     =>    12 ,
			13     =>    13 ,
			14     =>    14 ,
			15     =>    15 ,
			16     =>    16 ,
			17     =>    17 ,
			18     =>    18 ,
			19     =>    19 ,
			20     =>    20 ,
			21     =>    21 ,
			22     =>    22 ,
			23     =>    23 ,
			24     =>    24 ,
			25     =>    25 ,
			26     =>    26 ,
			27     =>    27 ,
			28     =>    28 ,
			29     =>    29 ,
			30     =>    30 ,
			31     =>    31 ,
		));
		
		$this->assignType("specific_week_day", "Día de la semana", BaseView::PICKLIST, array(
			AutoPeriod::MONDAY		=> JText::_("MONDAY"),
			AutoPeriod::TUESDAY		=> JText::_("TUESDAY"),			
			AutoPeriod::WEDN		=> JText::_("WEDNESDAY"),
			AutoPeriod::THURS		=> JText::_("THURSDAY"),
			AutoPeriod::FRIDAY		=> JText::_("FRIDAY"),
			AutoPeriod::SATURD		=> JText::_("SATURDAY"),
			AutoPeriod::SUNDAY		=> JText::_("SUNDAY"),
		));/// Escoge el día de la semana para los tipos Cada Semana y Día específico
		
		//$this->assignType("expiration_date", JText::_("COM_CTC_EXPIRATION_DATE"), BaseView::DATE);
		
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));		

 
        /**
         * Definicion de vistas y sus acciones
         */
        $class = "autoperiod";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "status_id","period_type","specific_month_day","specific_week_day"));
		$this->addAuthView( "table" );
		
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}

?>
