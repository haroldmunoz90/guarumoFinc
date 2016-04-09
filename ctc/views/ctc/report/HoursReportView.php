<?php

class HoursReportView extends BaseView {

	function __construct() {
		$this->assignType("id", "id", BaseView::HIDDEN);

		$this->assignType("person_id", JText::_("COM_CTC_USER"), BaseView::HIDDEN);

		$this->assignType("calendar_id", "Intervalo de Turno",BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "CalendarTime", 
            BaseView::ENT_CLASS => "CalendarTime",
            BaseView::ENT_FIELD => array("name"),
            BaseView::FUNC_JS => "goCalendarTime",
			BaseView::TOOLTIP => "Intervalo de turno asignado a este reporte de Trabajo."));	

		$this->assignType("worked_hours", "Totales", BaseView::TIME);
		$this->assignType("start_time", "Fecha de Llegada", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));
		$this->assignType("end_time", "Fecha de Salida", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));

		$this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
			1 => "Dispositivo",
			2 => "Manual",
			3 => "Automática",
			BaseView::TOOLTIP => "Indica el origen de las marcaciones.  Si fueron realizadas por el dispositivo,  manualmente o el sistema la generó automáticamente. "
		));

		$this->assignType("notes", "Notas", BaseView::BIG_STRING);


		$this->addView("formCreate", array("id", "person_id", "start_time", "end_time", "notes"));
		$this->addAction("formCreate", "hourcreate_report_submit", JText::_("COM_CTC_SAVE"), "save.png");
		$this->addAction("formCreate", "hourcreate_report_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

		$this->addView("form", array("id", "person_id",
			"calendar_id",
			"origin_type_id",
			"worked_hours",
			"start_time",
			"end_time",
			"notes"));
		$this->addAction("form", "hour_report_submit", JText::_("COM_CTC_SAVE"), "save.png");
		$this->addAction("form", "hour_report_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

		$this->addView("table", array("start_time", "end_time", "worked_hours", "calendar_id"));
		$this->addAction("table", "hour_report_tableedit", JText::_("COM_CTC_EDIT"), "edit.png");
		$this->addAction("table", "hour_report_tabledelete", JText::_("COM_CTC_DELETE"), "delete.png");
		$this->addAction("table", "hour_report_details", "Detalle", "zoom-in");
		$this->addAction("table", "payrollid", "Clasificar Horas de este lapso trabajado", "refresh.png",array("id"));

		$this->addView("dialog", array());
		$this->addAction("dialog", "deleteHRDialogOk", JText::_("COM_CTC_OK"));
		$this->addAction("dialog", "deleteHRDialogNOk", JText::_("COM_CTC_CANCEL"));

		$this->addView("aud", array( "person_id",
			"calendar_id",
			"origin_type_id",
			"worked_hours",
			"start_time",
			"end_time",
			"notes"));
	}

}

?>
