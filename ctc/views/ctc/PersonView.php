<?php

/**
 * Configuracion de vistas para la clase "Enter".
 *
 */
class PersonView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        parent::addCheckBox("table");

        $user = $this->getLoggedUser();
        $filter = new Filter();
        $filter->eq_("status_id", 1);

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("last_name", JText::_("COM_CTC_LASTNAME"), BaseView::STRING);
        $this->addAuthFields();
        $this->assignType("notes", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("address", JText::_("COM_CTC_ADDRESS"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_ADDRESS_DESC")));
        $this->assignType("password", JText::_("COM_CTC_PASSWORD"), BaseView::STRING);
        $this->assignType("identification", JText::_("COM_CTC_IDENFIFICATION"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_EMP_IDENTIFICATION_DESC")));
        $this->assignType("device_user_id", JText::_("COM_CTC_DEVICE_USERID"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_DEVICE_USERID_DESC")));
        $this->assignType("telephone", JText::_("COM_CTC_PHONE"), BaseView::STRING);
        $this->assignType("cell_phone", JText::_("COM_CTC_CELLPHONE"), BaseView::STRING);
        $this->assignType("email", JText::_("COM_CTC_EMAIL"), BaseView::STRING);
        $this->assignType("Image_id", "Image Dir", BaseView::HIDDEN);
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("schedule_id", JText::_("COM_CTC_SCHEDULE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Schedule",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("Privilege", JText::_("COM_CTC_PRIVILEDGE"), BaseView::PICKLIST, array(
            0 => "Normal",
            2 => "Registrar",
            6 => "Administrador",
            14 => "Supervisor"
        ));

        $this->assignType("genre", JText::_("COM_CTC_GENRE"), BaseView::PICKLIST, array(
            'F' => "Femenino",
            'M' => "Masculino"
        ));

        $this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter,
            BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO"),
            BaseView::TOOLTIP => JText::_("COM_CTC_AREA_DESC")));

        $this->assignType("numFPs", JText::_("COM_CTC_NUMFP"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_NUMFP_DESC")));

        $this->assignType("contractTypeName", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_CONTRACT_TYPE_DESC")));

        $this->assignType("devices", JText::_("COM_CTC_DEVICES_ALLOW"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Device",
            BaseView::ENT_FILTER => $filter,
            BaseView::TOOLTIP => JText::_("COM_CTC_DEVICES_ALLOW_DESC")));

        $this->assignType("tags", "Etiquetas", BaseView::ENTITIES_TAGS, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Tag",
            BaseView::ENT_VIEW_FILTER => "category",
            BaseView::ENT_FILTER => $filter,
            BaseView::OPT_IN_ALL => true,
            BaseView::TOOLTIP => JText::_("COM_CTC_EMP_TAGS_DESC")));

        $this->assignType("position_id", JText::_("COM_CTC_POSITION"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Position",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "CostCenter",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));


        $this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => null));

        /// This four attributes are going to create the contract entity in Person::store
        /// and are shown only en create person not in editing.
        $this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("contract_detail_id", JText::_("COM_CTC_CONTRACT_DETAIL"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractDetail",
            BaseView::ENT_FIELD => "title",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("start_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_date", JText::_("COM_CTC_END_DATE"), BaseView::DATE);
        $this->assignType("expected_end_date", JText::_("COM_CTC_EXPECTED_END_DATE"), BaseView::DATE);

        $this->assignType("started_date_ct", JText::_("COM_CTC_CONTRACT_START_DATE"), BaseView::DATE);

        $this->assignType("Card", JText::_("COM_CTC_CARD"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_CARD_DESC")));

        if ($user->hasPermission("modify-device")) {
            $this->assignType("AccGroup", JText::_("COM_CTC_DEVICE_GROUP"), BaseView::STRING);
            $this->assignType("TimeZones", JText::_("COM_CTC_TIMEZONE"), BaseView::STRING);
            $this->assignType("creation_date", JText::_("COM_CTC_CREATION_DATE"), BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
            $this->assignType("change_status_date", JText::_("COM_CTC_LAST_UPDATE"), BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        }

        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
        ));
        $this->assignType("salary_month", JText::_("COM_CTC_SALARY_MONTH"), BaseView::NUMBER, array(
            BaseView::NUM_TYPE => BaseView::CURRENCY,
            BaseView::TOOLTIP => JText::_("COM_CTC_SALARY_MONTH_DESC")));

        $this->assignType("salary_hour", JText::_("COM_CTC_SALARY_HOUR"), BaseView::NUMBER, array(
            BaseView::NUM_TYPE => BaseView::CURRENCY,
            BaseView::TOOLTIP => JText::_("COM_CTC_SALARY_HOUR_DESC")));

        $this->assignType("haspassword", JText::_("COM_CTC_PASSWORD"), BaseView::PICKLIST, array(
            0 => JText::_("COM_CTC_NOT"),
            1 => JText::_("COM_CTC_YES"),
        ));

        $this->assignType("hascard", JText::_("COM_CTC_CARD"), BaseView::PICKLIST, array(
            0 => JText::_("COM_CTC_NOT"),
            1 => JText::_("COM_CTC_YES"),
        ));

        /**
         * Definicion de vistas y sus acciones
         */
        $this->addViewEx("form", array("numFPs", "person_id",
            "person_id_ALIAS_1", "contractTypeName",
            "started_date_ct", "haspassword", "hascard"));
        if ($user->hasPermission("editemployee")) {
            $this->addAction("form", "person_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        }
        $this->addAction("form", "person_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("formquery", array(
            "id",
            //"name",
            //"last_name",
            "notes",
            "address",
            "password",
            //"identification",
            //"device_user_id",
            "telephone",
            "cell_phone",
            "email",
            "Image_id",
            "status_id",
            "schedule_id",
            "Privilege",
            "genre",
            "area_id",
            "devices",
            "tags",
            "position_id",
            "cost_center_id",
            "contract_type_id",
            "contract_detail_id",
            "start_date",
            "end_date",
            "expected_end_date",
            //"Card",
            "AccGroup",
            "TimeZones",
            "creation_date",
            "change_status_date",
            "salary_month",
            "salary_hour",
        ));
        if ($user->hasPermission("editemployee")) {
            $this->addAction("formquery", "person_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        }
        $this->addAction("formquery", "person_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");


        $this->addView("formReport", array("end_date", "area_id",
            "cost_center_id", "person_id", "contract_type_id", "status_id",
            "devices", "tags", "haspassword", "hascard"));
        $this->addAuthView("formReport");

        $this->addAction("formReport", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");

        $this->addView("tableReport", array("person_id_ALIAS_1",
            "identification",
            "branch_office_id",
            "area_id",
            "position_id",
            "cost_center_id",
            "status_id",
            "start_date",
            "end_date",
            "numFPs",
            "contractTypeName",
            "telephone",
            "cell_phone",
            "email",
            "schedule_id",
            "Privilege",
            "expected_end_date",
            "salary_hour",
            "salary_month",
            "haspassword", "hascard", "id"
        ));

        $this->addView("cform", array("person_id", "area_id",
            "cost_center_id",
            "position_id", "schedule_id", "contract_type_id"));
        $this->addAuthView("cform");

        $this->addAction("cform", "person_form_filter", JText::_("COM_CTC_FILTER"), "save.png");
        //$this->addAction("cform", "person_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $initialHideCols = array("telephone",
            "cell_phone",
            "email",
            "schedule_id",
            "Privilege",
            "position_id",
            "cost_center_id",
            "salary_hour",
            "salary_month",
            "id");

        $tableRe = array_merge(array("name",
            "last_name",
            "identification",
            "status_id",
            "start_date",
            "numFPs",
            "contractTypeName",
            "area_id"), $initialHideCols);
        $this->addView("table", $tableRe);

        $this->addAction("table", "person_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        if ($user->hasPermission("editemployee")) {
            $this->addAction("table", "person_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
            $this->addActionObj("table", "deleteFingerprints", JText::_("COM_CTC_FP_DELETE"), "remove", "deleteFingerprintsCB", JText::_("COM_CTC_FP_DELETE_Q"));
            $this->addActionObj("table", "deleteCard", JText::_("COM_CTC_CARD_DELETE"), "cut", "deleteCardCB", JText::_("COM_CTC_CARD_DELETE_Q"));
        }
        if ($user->hasPermission("hours")) {
            $this->addAction("table", "person_view_report", JText::_("COM_CTC_HOUR_REPORT_VIEW"), "page.png", array("name",
                "last_name",
                "identification",
                "cell_phone",
                "status_id",
                "Privilege"));
        }
        $this->addView("dialog", array());
        $this->addAction("dialog", "person_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", "person_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "last_name",
            "identification",
            "status_id",
            "position_id",
            "branch_office_id",
            "schedule_id"));
    }

}
