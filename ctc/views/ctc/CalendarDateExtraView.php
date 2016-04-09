<?php

/**
 * Configuracion de vistas para la clase "CalendarDate".
 *
 */
class CalendarDateExtraView extends BaseView {

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
        $this->assignType("entry_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_entry_date", "Fecha de fin", BaseView::DATE);
        $this->assignType("start_time", "Desde", BaseView::TIME);
        $this->assignType("end_time", "Hasta", BaseView::TIME);
        $this->assignType("applies_all_years", "Aplica todos los años", BaseView::BOOLEAN, array("true", "false"));

        //$this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::HIDDEN);
        $this->assignType("creation_date", "Creation Date", BaseView::HIDDEN);
        $this->assignType("change_status_date", "Change Status Date", BaseView::HIDDEN);

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "calendar_date";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "entry_date", "end_entry_date", "date_type_id"));
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $classe = "ealendar_date";
        $this->addViewEx("eform", array());
        $this->addAction("eform", $classe . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("eform", $classe . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("etable", array("name", "entry_date", "end_entry_date", "date_type_id"));
        $this->addAction("etable", $classe . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("etable", $classe . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("edialog", array());
        $this->addAction("edialog", $classe . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("edialog", $classe . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}
?>

