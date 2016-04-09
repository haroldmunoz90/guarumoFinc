<?php

/**
 * Configuracion de vistas para la clase "Notification".
 *
 */
class NotificationView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        $user = $this->getLoggedUser();
        parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("rule_name", JText::_("COM_CTC_RULE"), BaseView::PICKLIST, array(
            "FIRST" => "En la Primera Entrada de la empresa",
            "FIRST_AREA" => "En la Primera Entrada del área",
            //"FIRST_SHIFT" => "En la Primera Entrada del turno",
            "LAST" => "En la última Salida de la empresa",
            "LAST_AREA" => "En la última Salida del área",
            //"LAST_SHIFT" => "En la última Salida del turno",
            "PERSON_INOUT" => "Cuando ocurra una marcación de la persona",
            "PERSON" => "Cuando ingrese la persona",
            "PERSON_INONTIME" => "Cuando ingrese a tiempo la persona",
            "PERSON_INEARLY" => "Cuando ingrese temprano la persona",
            "PERSON_INLATE" => "Cuando ingrese tarde la persona",
            "PERSON_OUT" => "Cuando salga la persona",
            "PERSON_OUTONTIME" => "Cuando salga a tiempo la persona",
            "PERSON_OUTEARLY" => "Cuando salga temprano la persona",
            "PERSON_OUTLATE" => "Cuando salga tarde la persona",
            Notification::REPORT => "Reporte",
            Notification::PROCESS => "Reprocesamiento"
        ));

        $this->assignType("send_to_contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("send_to_enterprise_id", JText::_("COM_CTC_ENTERPRISE"), BaseView::ENTITY, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Enterprise",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("send_to_person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name", "last_name", "identification"),
            BaseView::ENT_FILTER => $filter));


        $filter = new Filter();
        $filter->eq_("status_id", 1);

        $this->assignType("rule_person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("rule_parameters", "Parametros Adicionales", BaseView::STRING);

        $this->assignType("file_type", "Tipo Exportación", BaseView::PICKLIST, array(
            1 => "Excel",
            2 => "CSV",
            //3 => "TXT",
            BaseView::TOOLTIP => "Tipo de Archivo de Exportación."
        ));

        $this->assignType("media_type", JText::_("COM_CTC_MEDIA"), BaseView::PICKLIST, array(
            Notification::SMS => "SMS",
            Notification::EMAIL => JText::_("COM_CTC_EMAIL"),
            //Notification::BOTH => "Ambos Medios",
            Notification::TELEGRAM => "Telegram",
            Notification::ALL => JText::_("COM_CTC_ALL_MEDIA"),
            Notification::NONE => JText::_("COM_CTC_NONE")
        ));
        $f = function ($obj) {
            $ret = str_replace(",", " ", $obj->rule_data);
            $ret = str_replace(";", " ", $ret);
            return $ret;
        };
        $this->assignType("rule_data", JText::_("COM_CTC_DESTINATIONS"), BaseView::FUNC, $f);

        $this->addAuthFields();
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("start_date", JText::_("COM_CTC_ACTIVATION_DATE"), BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("end_date", JText::_("COM_CTC_EXPIRATION_DATE"), BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));

        $immediately = new Period();
        $immediately->id = 1;
        $immediately->name = "Inmediato";
        $this->assignType("period_id", JText::_("COM_CTC_PERIOD"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "period",
            BaseView::ENT_CLASS => "Period",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_VALUE_ADD => array($immediately),
            BaseView::ENT_FILTER => $filter));

        $disablemass = "disabled";
        if ($user->hasPermission("massive_notification")) {
            $disablemass = "enabled";
        }
        $this->assignType("send_to_type", "Enviar a", BaseView::PICKLIST, array(
            Notification::LOGGED_USER => array("Usuario Logeado", "enabled"),
            Notification::HEAD_AREA => array("Supervisor de Area", "enabled"),
            Notification::EMPLOYEE => array(JText::_("COM_CTC_EMPLOYEE"), $disablemass),
            Notification::AREA => array("Empleados de Area", $disablemass),
            Notification::BRANCH_OFF => array("Empleados de Sucursal", $disablemass),
            Notification::ENTERPRISE => array("Empleados de Empresa", $disablemass),
            Notification::CONTRACT_TYPE => array("Empleados con Tipo de Contrato", $disablemass),
            Notification::COST_CENTER => array("Empleados en Centro de Costos", $disablemass),
            BaseView::TOOLTIP => "A que tipo de persona(s) va dirigido la notificación."
        ));

        $this->assignType("send_to_cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "CostCenter",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("send_to_branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "BranchOffice",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("send_to_area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter,
            BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));


        /**
         * Definicion de vistas y sus acciones
         */
        $class = "notification";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "rule_name", "status_id", "start_date", "end_date", "media_type",
            "period_id", "send_to_type", "rule_data"));
        $this->addAuthView("table");
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addAction("table", "showValueVariable", "Mostrar Valores Variables", "zoom-in", array("id"));
        $rule = function($obj) {
            if ($obj->rule_name == Notification::REPORT ||
                    $obj->rule_name == Notification::PROCESS) {
                return true;
            }
            return false;
        };
        $this->addActionDisplayRule("table", "showValueVariable", $rule);

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "rule_name",
            "rule_person_id",
            "rule_data",
            "media_type"));
    }

}
