<?php

/**
 * Configuracion de vistas para la clase "Enter".
 *
 */
class AuthorizationView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        $this->assignType("id", "id", BaseView::HIDDEN);

        $f = function ($obj) {
            return "<input type='checkbox' data-code='$obj->id' />";
        };
        $this->assignType("hour_concept_id", " ", BaseView::FUNC, $f);

        $filter = new Filter();
        $filter->eq_("status_id", 1);

        $this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"));


        $this->assignType("start_time", "Inicio Concepto", BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("end_time", "Fin Concepto", BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("hours", "Horas", BaseView::STRING);
        $this->assignType("concept_name", JText::_("COM_CTC_CONCEPT"), BaseView::STRING);

        $this->assignType("calendar_time_id", "Intervalo de Turno", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "CalendarTime",
            BaseView::ENT_CLASS => "CalendarTime",
            BaseView::ENT_FIELD => array("name"),
            BaseView::FUNC_JS => "goCalendarTime"));
        /**
         * FORM
         */
        $this->assignType("start_time_form", JText::_("COM_SORCORE_DATE"), BaseView::DATE, array(
            BaseView::TOOLTIP => "Fecha de Inicio de trabajo."));

        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FILTER => $filter,
            BaseView::TOOLTIP => "Empleado a ser autorizado."));

        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter));

        $this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
            1 => "Dispositivo",
            2 => "Manual",
            3 => "Automática",
            BaseView::TOOLTIP => "Modo en que fue creada la marcación."
        ));


        /**
         * Definicion de vistas y sus acciones
         */
        $this->addView("form", array("start_time_form", "person_id_ALIAS_2", "person_id_ALIAS_1", "origin_type_id"));
        $this->addAction("form", "authorization_report_update", JText::_("COM_CTC_FILTER"), "search.png");
        $this->addView("table", array("hour_concept_id", "person_id", "person_id_ALIAS_1",
            "start_time", "end_time", "hours", "concept_name", "calendar_time_id"));
        $exporterConf = array(10, 40, 25, 15, 15, 8, 8, 40, 40);
        $exporterConf['height'] = 20;
        //$exporterConf['format'] = array( 6  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )	);
        $this->addExporterConf("table", $exporterConf);
    }

}
