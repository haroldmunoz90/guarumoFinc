<?php

/**
 * Configuracion de vistas para la clase "Notification".
 *
 */
class ValueVariableView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("type", "Renovación", BaseView::PICKLIST, array(
            ValueVariable::TYPE_FIXED => "Datos Fijos",
            ValueVariable::TYPE_LT => "Menor a Fecha y Hora de Generacion de reporte",
            ValueVariable::TYPE_GT => "Mayor a Fecha y Hora de Generacion de reporte",
            ValueVariable::TYPE_EQ => "Igual a Fecha de Generacion de reporte",
            ValueVariable::TYPE_PERIOD => "Período Anterior a Fecha y Hora de Generacion de reporte",
            ValueVariable::TYPE_PER_EMPLOYEE => "Se genera un reporte diferente por empleado y se envía.",
            BaseView::TOOLTIP => "Determina si el valor de la variable es fijo o menor, mayor o igual a la fecha de generación de Reporte."
        ));
        $this->assignType("field_label", "Nombre Variable", BaseView::STRING, array(
            BaseView::TOOLTIP => "Nombre de la Variable."
        ));
        $this->assignType("field_oper", "Operador", BaseView::STRING, array(
            BaseView::TOOLTIP => "Operador a de Comparación."
        ));
        $this->assignType("field_name", "Nombre Campo", BaseView::STRING, array(
            BaseView::TOOLTIP => "Nombre del campo."
        ));
        $this->assignType("field_value", "Valor", BaseView::STRING, array(
            BaseView::TOOLTIP => "Valor a ser analizado."
        ));
        $this->assignType("field_type", "Tipo Variable", BaseView::PICKLIST, array(
            BaseView::STRING => "Cadena Carateres",
            BaseView::PICKLIST => "Lista",
            BaseView::BIG_STRING => "Cadena Caracteres",
            BaseView::BOOLEAN => "Valor Lógico.",
            BaseView::DATE => JText::_("COM_SORCORE_DATE"),
            BaseView::DATE_TIME => "Fecha y Hora",
            BaseView::TIME => "Hora",
            BaseView::ENTITY => "Entidad",
            BaseView::TOOLTIP => "Tipo de Variable."
        ));
        $this->assignType("range_type", "Rango", BaseView::PICKLIST, array(
            0 => "Horas",
            1 => "Días",
            2 => "Semanas",
            3 => "Meses",
            BaseView::TOOLTIP => "Rango entre horas, días, semanas y meses, cuando la variable va a ser comparada con un período de tiempo."
        ));
        $this->assignType("amount", "Cantidad", BaseView::STRING, array(
            BaseView::TOOLTIP => "Cantidad de horas, dias, semanas o meses escogido en el período."
        ));
        $this->assignType("start_time", "Hora Inicio", BaseView::TIME, array(
            BaseView::TOOLTIP => "Hora de Inicio del período."
        ));
        $this->assignType("end_time", "Hora Fin", BaseView::TIME, array(
            BaseView::TOOLTIP => "Hora de Fin del período."
        ));


        /**
         * Definicion de vistas y sus acciones
         */
        $class = "valuevariable";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("field_label", "field_oper", "field_value", "field_type", "amount", "range_type", "start_time", "end_time", "type"));
        //$this->addAuthView( "table" );

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
        $rule = function($obj) {
            if ($obj->type != ValueVariable::TYPE_FIXED) {
                return true;
            }
            return false;
        };
        $this->addActionDisplayRule("table", $class . "_table_edit", $rule);
        $this->addActionDisplayRule("table", $class . "_table_remove", $rule);


        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}
