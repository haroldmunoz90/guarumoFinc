<?php

class HRSummaryIntervalMonthView extends BaseView {

    function __construct() {
        $this->assignType("id", "id", BaseView::HIDDEN);

        $filter = new Filter();
		$filter->eq_("status_id", 1 );
		
        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"));


        $this->assignType("person_id", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter));

        $this->assignType("month_id", "Mes", BaseView::PICKLIST, array(
            '1' => "Enero",
            '2' => "Febrero",
            '3' => "Marzo",
            '4' => "Abril",
            '5' => "Mayo",
            '6' => "Junio",
            '7' => "Julio",
            '8' => "Agosto",
            '9' => "Septiembre",
            '10' => "Octubre",
            '11' => "Noviembre",
            '12' => "Diciembre"));

        $this->assignType("worked_hours", "Totales", BaseView::TIME);
        $this->assignType("manuales", "Manuales", BaseView::STRING);

        $this->addViewEx("table", array("id"));
    }

}

?>
