<?php

class AttendanceCreateView extends BaseView {

    function __construct() {
        $filter = new Filter();
        $filter->eq_("status_id", 1);
        $this->assignType("id", "id", BaseView::HIDDEN);
        $this->assignType("device_id", JText::_("COM_CTC_DEVICE"), BaseView::ENTITY, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Device",
            BaseView::ENT_FILTER => null));
        $this->assignType("person_id", JText::_("COM_CTC_USER"), BaseView::HIDDEN);
        $this->assignType("time", "Fecha de Marcación", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));
        $this->assignType("end_time", "Fecha de Salida", BaseView::DATE_TIME, array(
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

        $this->assignType("person_id_ALIAS", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => $filter));
        $this->assignType("att_date", "Fecha de Marcación", BaseView::DATE);
        $this->assignType("att_time", "Hora de Marcación", BaseView::TIME);
        $this->assignType("workcode", JText::_("COM_CTC_PRN_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FIELD_ID => "workcode",
            BaseView::ENT_FIELD_ID_ISNOTID => true,
            BaseView::ENT_FILTER => null));
        $this->assignType("notes", JText::_("COM_CTC_ATT_NOTE"), BaseView::BIG_STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_ATT_NOTE_DESC")
        ));

        $this->addView("formAttCreate", array("id", "person_id", "time", "workcode", "notes"));
        $this->addAction("formAttCreate", "attendance_create_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("formAttCreate", "attendance_create_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("formAttCreateSimul", array("id", "person_id_ALIAS", "att_date", "att_time", "workcode"));

        $this->addView("dialogDelete", array());
        $this->addAction("dialogDelete", "deleteAttDialogOk", JText::_("COM_CTC_OK"));
        $this->addAction("dialogDelete", "deleteAttDialogNOk", JText::_("COM_CTC_CANCEL"));
    }

}
