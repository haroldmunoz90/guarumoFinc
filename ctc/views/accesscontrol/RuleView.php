<?php

/**
 * Configuracion de vistas para la clase "rule".
 *
 */
class RuleView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("package", "Paquete", BaseView::STRING);
        $this->assignType("version", "Versión", BaseView::STRING);
        $this->assignType("username", JText::_("COM_CTC_USER"), BaseView::STRING);
        $this->assignType("password", JText::_("COM_CTC_PASSWORD"), BaseView::PASSWORD);
        $this->assignType("process", "Proceso", BaseView::PICKLIST, array(
            "ATTENDANCE" => "Asignación de Turno (ATTENDANCE)",
            "PAYROLL" => "Clasificación de Horas (PAYROLL)",
            "AFTERPAYROLL" => "Post Clasificación (AFTERPAYROLL)",
            "HOURPERIOD" => "Clasificación del Período (HOURPERIOD)",
        ));

        $this->assignType("enterprises", "Empresas", BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Enterprise",
            BaseView::ENT_FILTER => null));
        /**
         * Definicion de vistas y sus acciones
         */
        $this->addViewEx("form", array());
        $this->addAction("form", "rule_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", "rule_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        //TODO agregar rule_status_id
        $this->addView("table", array("name",
            "package", "version", "username", "process"));
        $this->addAction("table", "rule_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        //$this->addAction("table", "rule_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", "rule_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", "rule_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "package", "version", "process"));
    }

}

?>
