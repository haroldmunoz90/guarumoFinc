<?php

class TodayArrivalsView extends BaseView {

    function __construct() {

        $this->assignType("time", JText::_("COM_SORCORE_DATE"), BaseView::STRING);

        $filter = new Filter();
        $filter->eq_("status_id", 1);

        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"));

        $this->assignType("person_id", "ID", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter));

        $this->assignType("attendance_status_id", JText::_("COM_CTC_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Type",
            BaseView::ENT_CLASS => "AttendanceStatus",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("attendance_type_id", JText::_("COM_CTC_ATT_CLASSIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Class",
            BaseView::ENT_CLASS => "AttendanceType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->addViewEx("table", array()); //"time","person_id","attendance_status_id","attendance_type_id",""));            
    }

}

?>
