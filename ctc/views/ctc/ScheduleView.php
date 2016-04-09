<?php

/**
 * Configuracion de vistas para la clase "Schedule".
 *
 */
class ScheduleView extends HelperView {

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
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);

        $this->assignType("apply_tolerance", "Tolerancia", BaseView::PICKLIST, array(
            0 => "No",
            1 => "Si",
            BaseView::TOOLTIP => "Aplicar Tolerancia de entrada y salida para éste Turno."
        ));
        $this->assignType("pre_tolerance_in", "Minutos antes de entrada", BaseView::STRING);
        $this->assignType("post_tolerance_in", "Minutos después de entrada", BaseView::STRING);
        $this->assignType("pre_tolerance_out", "Minutos antes de salida", BaseView::STRING);
        $this->assignType("post_tolerance_out", "Minutos después de salida", BaseView::STRING);

        $this->addAuthFields();

        $this->assignType("apply_pto", "Apply Pto", BaseView::HIDDEN);
        $this->assignType("pto_id", "Pto", BaseView::HIDDEN);

        $this->assignType("creation_date", "Creation Date", BaseView::HIDDEN);

        $this->assignType("subconceptitems", JText::_("COM_CTC_SUBCONCEPTS_ASSO"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "alias_name",
            BaseView::ENT_CLASS => "SubConceptItem",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("calendartimes", JText::_("COM_CTC_CALENDAR_TIME_2"), BaseView::ENTITIES_TAGS, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "CalendarTime",
            BaseView::ENT_VIEW_FILTER => "category",
            BaseView::ENT_FILTER => $filter,
            BaseView::OPT_IN_ALL => true,
            BaseView::TOOLTIP => "Agregar Intervalos para El Turno."));

        $this->assignType("period_id", JText::_("COM_CTC_PERIOD"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "period",
            BaseView::ENT_CLASS => "Period",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null,
            BaseView::TOOLTIP => "Período en el cual se evaluará la asignación de horas extras."));

        $this->assignType("period_hours_complete", "Mínimo Horas Período", BaseView::STRING, array(BaseView::TOOLTIP => "Horas que el empleado debe cumplir en el período escogido."
        ));

        $this->assignType("period_concept_id", JText::_("COM_CTC_CONCEPT"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Concept",
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "code"),
            //BaseView::ENT_FIELD_ID => "name",
            BaseView::FUNC_JS => "goConcept",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("concepts_discount", "Orden de Descuento", BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FILTER => null,
            BaseView::TOOLTIP => "Orden de los conceptos a descontar si el empleado no alcance el número de horas en el período."
            . "Si selecciona un Orden de Descuento los empleados deben cumplir un tiempo de horas en un período para acceder a extras."
            . "En caso contrario se descuentan las horas de los conceptos por el orden entregado."));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "schedule";
        $this->addViewEx("form", array());

        $visible = array("name", "code", "apply_tolerance");
        $hidden = array(
            "pre_tolerance_in", "post_tolerance_in",
            "pre_tolerance_out", "post_tolerance_out",
            "period_hours_complete", "period_concept_id");
        $this->addView("table", array_merge($visible, $hidden));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name", "code",
            "apply_tolerance",
            "pre_tolerance_in",
            "post_tolerance_in",
            "pre_tolerance_out",
            "post_tolerance_out"));
    }

}
