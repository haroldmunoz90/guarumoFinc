<?php

class AbsenceDailyView extends BaseView {

    function __construct() {
        $filter = new Filter();
        $filter->eq_("status_id", 1);

        $this->assignType("calendar_time_id", "Intervalo de Turno", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "CalendarTime",
            BaseView::ENT_CLASS => "CalendarTime",
            BaseView::ENT_FIELD => array("name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goListAbsenceByCT"));


        $this->assignType("nAbsences", "Empleados Ausentes", BaseView::STRING);
        $this->assignType("totalEmpTurno", "Total Empleados del Turno", BaseView::STRING);
        $this->assignType("inicioTurno", "Hora de Inicio", BaseView::STRING);

        $this->addViewEx("table", array());
    }

}

?>
