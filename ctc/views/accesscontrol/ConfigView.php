<?php

/**
 * Configuracion de vistas para la clase "config".
 *
 */
class ConfigView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        $user = $this->getLoggedUser();
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->addAuthFields();

        $this->assignType("max_job_time", "Max Tiempo Perm", BaseView::STRING, array(
            BaseView::TOOLTIP => "Máximo tiempo de trabajo permitido en horas"));
        $this->assignType("rule_server_url_prefix", "Prefijo URL", BaseView::STRING, array(
            BaseView::TOOLTIP => "Prefijo de la url del servicio de reglas"));
        if ($user->hasPermission("license_manager")) {
            $this->assignType("sms", "Habilitar SMS", BaseView::BOOLEAN, array("true", "false",
                BaseView::TOOLTIP => "Habilitar las notificaciones por SMS."));
            $this->assignType("sms_audio", "Llamadas Telefónicas", BaseView::BOOLEAN, array("true", "false",
                BaseView::TOOLTIP => "Habilitar las notificaciones mediante Llamadas Telefónicas."));
            $this->assignType("mess_mail", "Habilitar Correos", BaseView::BOOLEAN, array("true", "false",
                BaseView::TOOLTIP => "Habilitar las notificaciones por correo."));
            $this->assignType("max_number_employees", "Licencias Empleados", BaseView::STRING, array(
                BaseView::TOOLTIP => "Licencias Máximo número de empleados."));
            $this->assignType("max_number_users", "Licencias Usuarios", BaseView::STRING, array(
                BaseView::TOOLTIP => "Licencias Máximo número de usuarios."));
            $this->assignType("max_number_devices", "Licencias Biométricos", BaseView::STRING, array(
                BaseView::TOOLTIP => "Licencias Máximo número de Dispositivos Biométricos"));
            $this->assignType("max_telegram_users", "Licencias Telegram", BaseView::STRING, array(
                BaseView::TOOLTIP => "Licencias Máximo número de Usuarios registrados en Telegram"));
        }
        $this->assignType("sms_ws_url", "URL SMS", BaseView::STRING, array(
            BaseView::TOOLTIP => "URL del web service para envio de sms"));
        $this->assignType("photo_path", "Carpeta de Fotos", BaseView::STRING, array(
            BaseView::TOOLTIP => "Path donde se almacenan las fotos."));
        $this->assignType("min_time_since_last_to_accept", "Marcación Válida.", BaseView::STRING, array(
            BaseView::TOOLTIP => "Tiempo en minutos desde la última marcación para aceptarla como válida"));
        $this->assignType("max_time_to_notify", "Lapso para Notificar", BaseView::STRING, array(
            BaseView::TOOLTIP => "Máximo lapso permitido en minutos entre la hora actual y la hora de la marcación para notificar"));

        $this->assignType("ignore_middle_att", "Ignorar las marcaciones intermedias", BaseView::PICKLIST, array(
            "T" => JText::_("COM_CTC_YES"),
            "F" => JText::_("COM_CTC_NOT")
        ));

        $this->assignType("generate_auto_att", "Generar Marcaciones Automáticas", BaseView::PICKLIST, array(
            "T" => JText::_("COM_CTC_YES"),
            "F" => JText::_("COM_CTC_NOT")
        ));
        $this->assignType("hours_per_period", "Horas Al Mes", BaseView::STRING, array(
            BaseView::TOOLTIP => "Tiempo de trabajo al mes en horas. 240 Por defecto."));


        $this->assignType("max_time_to_search", "Máx. Busqueda", BaseView::STRING, array(BaseView::TOOLTIP => "Máximo tiempo en horas para buscar por el anterior lapso de trabajo."
        ));
        /* 		
          $this->assignType("pay_extras_after", "Pagar Extras", BaseView::PICKLIST, array(
          "-2" => "Después de la cantidad de horas del intervalo de turno.",
          "-1" => "Después de Finalización de intervalo.",
          "0" => "Después de Número de Horas."
          ));

          $this->assignType("pay_extras_after_hours", "Número de horas", BaseView::STRING,array(
          BaseView::TOOLTIP => "Después de este número de horas se pagarán extras." ));
         */
        /**
         * Definicion de vistas y sus acciones
         */
        $this->addViewEx("form", array());
        $this->addAction("form", "config_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", "config_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        //TODO agregar config_status_id
        $this->addView("table", array("enterprise_id",
            "max_job_time", "max_time_to_notify", "min_time_since_last_to_accept",
            "rule_server_url_prefix", "sms", "sms_audio", "mess_mail", "max_number_employees",
            "max_number_users", "max_number_devices", "max_telegram_users", "sms_ws_url", "photo_path", "ignore_middle_att",
            "generate_auto_att", "hours_per_period", "max_time_to_search",
        ));


        $this->addAction("table", "config_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        //$this->addAction("table", "config_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", "config_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", "config_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "enterprise_id",
            "max_job_time", "max_time_to_notify", "min_time_since_last_to_accept"));
    }

}
