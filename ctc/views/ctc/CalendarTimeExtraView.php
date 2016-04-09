<?php

/**
 * Configuracion de vistas para la clase "IlgCalendarTime".
 *
 */
class CalendarTimeExtraView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("calendar_id", "Calendar", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("date_type_id", JText::_("COM_CTC_TYPE"), BaseView::PICKLIST, array(
            1 => "Ordinario",
            2 => "Feriado"
        ));
        $this->assignType("initial_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_date", "Fecha de fin", BaseView::DATE);
        $this->assignType("start_time", "Desde", BaseView::TIME);
        $this->assignType("end_time", "Hasta", BaseView::TIME);
        $this->assignType("monday", JText::_("MONDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("tuesday", JText::_("TUESDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("wednesday", JText::_("WEDNESDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("thursday", JText::_("THURSDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("friday", JText::_("FRIDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("saturday", JText::_("SATURDAY"), BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("sunday", JText::_("SUNDAY"), BaseView::BOOLEAN, array("true", "false"));

        $func = function($obj) {
            $ret = array();
            if ($obj->monday == 'T') {
                $ret[] = "Lu";
            }
            if ($obj->tuesday == 'T') {
                $ret[] = "Ma";
            }
            if ($obj->wednesday == 'T') {
                $ret[] = "Mi";
            }
            if ($obj->thursday == 'T') {
                $ret[] = "Ju";
            }
            if ($obj->friday == 'T') {
                $ret[] = "Vi";
            }
            if ($obj->saturday == 'T') {
                $ret[] = "Sa";
            }
            if ($obj->sunday == 'T') {
                $ret[] = "Su";
            }
            return implode(",", $ret);
        };

        $this->assignType("days", "Días", BaseView::FUNC, $func);

        $this->assignType("applies_all_years", "Aplica todos los años", BaseView::BOOLEAN, array("true", "false"));
        $this->assignType("date_type_id", "Date Type", BaseView::HIDDEN);
        //$this->assignType("status_id", "Status", BaseView::HIDDEN);
        $this->assignType("creation_date", "Creation Date", BaseView::HIDDEN);
        $this->assignType("change_status_date", "Change Status Date", BaseView::HIDDEN);

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "calendar_time";
        $this->addViewEx("form", array("days"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "days", "initial_date", "end_date", "start_time", "end_time"));
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $classe = "ealendar_time";
        $this->addViewEx("eform", array("days"));
        $this->addAction("eform", $classe . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("eform", $classe . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("etable", array("name", "days", "initial_date", "end_date", "start_time", "end_time"));
        $this->addAction("etable", $classe . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("etable", $classe . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("edialog", array());
        $this->addAction("edialog", $classe . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("edialog", $classe . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}
?>

