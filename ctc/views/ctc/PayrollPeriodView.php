<?php

class PayrollPeriodView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        $user = $this->getLoggedUser();

        $this->assignType("initial_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_date", "Fecha Final", BaseView::DATE);
        $this->assignType("att_not_processed", "MNP", BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_ATTS_NOTPROCESSED")));
        $this->assignType("hours_not_processed", "TLTNP", BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_HR_NOTPROCESSED")));
        $this->assignType("hours_not_auth", "HNA", BaseView::STRING, array(
            BaseView::TOOLTIP => "Total de Horas No Autorizadas"));
        $this->assignType("worked_hours", "Horas", BaseView::TIME, array(
            BaseView::TOOLTIP => "Horas de trabajo totales"));
        $this->assignType("att_duplicated", "DUP", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones duplicadas"));
        $this->assignType("att_automatic", "AUTO", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Automáticas"));
        $this->assignType("att_manual", "MM", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Manuales"));
        $this->assignType("att_total", "MT", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales"));
        $this->assignType("att_total_in", "TE", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Entrada"));
        $this->assignType("att_total_out", "TS", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Salida"));
        $this->assignType("att_out_late", "STar", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones totales de Salida tarde"));
        $this->assignType("att_out_on_time", "SAT", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Salida a Tiempo"));
        $this->assignType("att_out_early", "STem", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones totales de Salida Temprano"));
        $this->assignType("att_in_late", "ETar", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Entrada Tarde"));
        $this->assignType("att_in_on_time", "EAT", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Entrada a Tiempo"));
        $this->assignType("att_in_early", "ETem", BaseView::STRING, array(
            BaseView::TOOLTIP => "Marcaciones Totales de Entrada Temprano"));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "payrollperiod";
        $this->addView("form", array("id", "person_id"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");


        $this->addViewEx("table", array());
        if ($user->hasPermission("reprocess_large")) {
            $this->addAction("table", $class . "_reprocess_large", "Reprocesar Marcaciones", "save.png", array("initial_date", "end_date"));
            $this->addAction("table", $class . "_payroll_large", "Reprocesar Lapsos de Trabajo", "refresh.png", array("initial_date", "end_date"));
        } else {
            $this->addAction("table", $class . "_reprocess", "Reprocesar Marcaciones", "save.png", array("initial_date", "end_date"));
            $this->addAction("table", $class . "_payroll", "Reprocesar Lapsos de Trabajo", "refresh.png", array("initial_date", "end_date"));
        }
        $this->addAction("table", $class . "_report", "Generar Reporte de Prenomina", "page.png", array("initial_date", "end_date"));
        $this->addAction("table", $class . "_delete", "Borrar Período", "delete.png", array("id"));

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array("initial_date", "end_date"));
    }

}

?>
