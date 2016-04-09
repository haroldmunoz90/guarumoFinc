<?php

/**
 * Configuracion de vistas para la clase "Enter".
 *
 */
class EnterpriseView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        $user = BaseCore::getLoggedUser();
        $filter = new Filter();
        $filter->eq_("status_id", 1);

        $filterAn = new Filter();
        $filterAn->eq_("status_id", 1);
        $filterAn->setIncludeParents(true);

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("lft", "lft", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("address", JText::_("COM_CTC_ADDRESS"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_ADDRESS_DESC")));
        $this->assignType("identification", JText::_("COM_CTC_IDENFIFICATION"), BaseView::STRING);
        $this->assignType("telephone", JText::_("COM_CTC_PHONE"), BaseView::STRING);
        $this->assignType("mail", JText::_("COM_CTC_EMAIL"), BaseView::STRING);

        $this->assignType("initials", "Iniciales", BaseView::STRING);
        $this->assignType("image_dir", "Image Dir", BaseView::HIDDEN);
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("parent_enterprise_id", JText::_("COM_CTC_PARENT_ENTERPRISE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Enterprise",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filterAn));


        if ($user->hasPermission("configuration")) {
            $this->assignType("ilgRules", JText::_("COM_CTC_RULE_EXECUTE"), BaseView::ENTITIES, array(
                BaseView::ENT_FIELD => array("process", "name"),
                BaseView::ENT_FIELD_DEL => " ",
                BaseView::ENT_CLASS => "Rule",
                BaseView::ENT_FILTER => null));
            $this->assignType("expiration_message", JText::_("COM_CTC_EXPIRATION_MSG"), BaseView::STRING, array(
                BaseView::TOOLTIP => JText::_("COM_CTC_EXPIRATION_MSG_DESC")));
            $this->assignType("days_to_message", JText::_("COM_CTC_DAYS_MSG"), BaseView::STRING, array(
                BaseView::TOOLTIP => JText::_("COM_CTC_DAYS_MSG_DESC")));
        }

        if ($user->hasPermission("license_manager")) {
            $this->assignType("activation_date", JText::_("COM_CTC_ACTIVATION_DATE"), BaseView::DATE);
            $this->assignType("expiration_date", JText::_("COM_CTC_EXPIRATION_DATE"), BaseView::DATE);
        }

        $this->assignType("subconceptitems", JText::_("COM_CTC_SUBCONCEPTS_ASSO"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "alias_name",
            BaseView::ENT_CLASS => "SubConceptItem",
            BaseView::ENT_FILTER => null));

        $this->assignType("viewlevels", JText::_("COM_CTC_VIEWLEVELS"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "title",
            BaseView::ENT_CLASS => "ViewLevel",
            BaseView::ENT_FILTER => null));

        $this->assignType("enterprise_id", JText::_("COM_CTC_ENTERPRISE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Enterprise",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("numdev", "Dispositivos", BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de Dispositivos Activos."));
        $this->assignType("numonline", "Online", BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de Dispositivos Online."));

        $this->assignType("max_number_devices", "Num Disp. Contrato", BaseView::STRING, array(
            BaseView::TOOLTIP => "Máximo número de dispositivos en el contrato con el cliente."));
        $this->assignType("numattday", "Marc. Hoy", BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de marcaciones el día de hoy."));
        $func = function( $obj, $param ) {
            $arr = explode(",", $obj->lastlogins);
            if (count($arr) > $param) {
                return $arr[$param];
            }
            return "";
        };
        $this->assignType("lastuser1", JText::_("COM_CTC_USER"), BaseView::FUNC, array(
            BaseView::FUNC_FUNC => $func,
            BaseView::FUNC_PARAM => 0,
            BaseView::TOOLTIP => "Ultimo Usuario que ingresó al sistema."));
        $this->assignType("lastlogindate1", JText::_("COM_SORCORE_DATE"), BaseView::FUNC, array(
            BaseView::FUNC_FUNC => $func,
            BaseView::FUNC_PARAM => 1,
            BaseView::TOOLTIP => "Ultima fecha de ingreso al sistema."));
        $this->assignType("lastuser2", JText::_("COM_CTC_USER"), BaseView::FUNC, array(
            BaseView::FUNC_FUNC => $func,
            BaseView::FUNC_PARAM => 2,
            BaseView::TOOLTIP => "Penultimo Usuario que ingresó al sistema."));
        $this->assignType("lastlogindate2", JText::_("COM_SORCORE_DATE"), BaseView::FUNC, array(
            BaseView::FUNC_FUNC => $func,
            BaseView::FUNC_PARAM => 3,
            BaseView::TOOLTIP => "Penultima fecha de ingreso al sistema."));
        //$this->assignType("lastlogins", "Iniciales", BaseView::STRING,array(
        //    BaseView::TOOLTIP => "." ));

        $this->assignType("numempl", "Empleados", BaseView::STRING, array(
            BaseView::TOOLTIP => "."));
        $this->assignType("max_number_employees", "Num Emp. Contrato", BaseView::STRING, array(
            BaseView::TOOLTIP => "Máximo Número de Empleados en el contrato con el cliente."));
        $this->assignType("max_number_users", "Num Usuarios Contrato", BaseView::STRING, array(
            BaseView::TOOLTIP => "Máximo Número de Usuarios en el contrato con el cliente."));

        /**
         * Definicion de vistas y sus acciones
         */
        $this->addView("form", array("id", "name", "description", "address", "identification",
            "telephone", "mail", "initials", "viewlevels", "image_dir", "status_id",
            "expiration_message", "days_to_message",
            "parent_enterprise_id", "activation_date", "expiration_date", "ilgRules",
            "subconceptitems"));
        $this->addAction("form", "enterprise_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", "enterprise_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("wiz_1", array("id", "name", "description", "address", "filename"));
        $this->addView("wiz_2", array("identification", "telephone", "mail", "initials"));
        $this->addView("wiz_3", array("status_id", "parent_enterprise_id", "activation_date", "expiration_date"));

        $this->addView("table", array("name",
            "expiration_date",
            "telephone",
            "mail"));
        $this->addAction("table", "enterprise_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", "enterprise_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("table1", array("name",
            "identification",
            "mail", "status_id", "chaca"));

        $this->addView("dialog", array());
        $this->addAction("dialog", "enterprise_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", "enterprise_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "identification",
            "mail"));

        $this->addView("formreport", array("enterprise_id", "expiration_date", "status_id"));
        $this->addAction("formreport", "arrival_report_update", JText::_("COM_CTC_UPDATE"), "save.png");


        $this->addView("tablereport", array("name", "expiration_date", "numdev", "numonline",
            "max_number_devices", "numattday", "lastuser1", "lastlogindate1",
            "lastuser2", "lastlogindate2", "numempl", "max_number_employees", "max_number_users"));
    }

}
