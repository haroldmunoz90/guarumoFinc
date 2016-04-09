<?php

class PayrollNoticeView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        parent::addCheckBox("table");

        $filterType = new Filter();
        $filterType->omit('BranchOffice');
        $filterType->setIncludeParents(true);

        $filter = new Filter();
        $filter->eq_("status_id", 1);
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);

        $this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => $filter));

        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
        ));

        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
        ));


        $this->assignType("type_id", JText::_("COM_CTC_PRN_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "PayrollNoticeType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("type_id_ALIAS_1", JText::_("COM_CTC_DESCRIPTION"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "PayrollNoticeType",
            BaseView::ENT_FIELD => "description",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);

        $this->addAuthFields();

        $this->assignType("start_time", JText::_("COM_CTC_START_DATE"), BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("end_time", "Fecha Final", BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));

        $this->assignType("range_type", "Tipo de Rango", BaseView::PICKLIST, array(
            PayrollNoticeBase::RANGE_DATETIME => "Rango Fecha Hora",
            PayrollNoticeBase::RANGE_HOURS => "Rango de Horas",
            PayrollNoticeBase::RANGE_DATES => "Rango de Fechas",
            PayrollNoticeBase::RANGE_TOTAL_HOURS => "Horas Totales",
            PayrollNoticeBase::RANGE_TOTAL_DAYS => "Días Totales"
        ));
        $this->assignType("aux1", "Auxiliar1", BaseView::DATE);
        $this->assignType("aux2", "Auxiliar2", BaseView::DATE);
        $this->assignType("aux3", "Auxiliar3", BaseView::DATE);
        $this->assignType("paid", "Remunerada", BaseView::PICKLIST, array(
            'F' => "No",
            'T' => "Si"
        ));


        $this->assignType("iden", JText::_("COM_CTC_IDENFIFICATION"), BaseView::STRING);

        $this->assignType("numNovedades", "Cantidad", BaseView::STRING);
        $this->assignType("sumDuration", "Total Horas", BaseView::TIME);

        $this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter,
            BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));

        $this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "CostCenter",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "payrollnotice";
        $this->addView("form", array("id", "person_id", "area_id", "cost_center_id", "type_id", "description", "range_type",
            "start_time", "end_time", "aux1", "aux2", "aux3"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("form");

        $this->addView("reportform", array("start_time", "end_time", "person_id", "iden", "type_id",
            "range_type", "paid", "area_id", "cost_center_id", "contract_type_id"));
        $this->addAction("reportform", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
        $this->addAuthView("reportform");

        $this->addView("table", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "type_id", "start_time", "end_time"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("tablereport", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "type_id", "start_time", "end_time", "area_id", "cost_center_id"));

        $this->addView("tablesummary", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "numNovedades", "sumDuration"));

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("formCal", array("id", "type_id", "description", "range_type",
            "start_time", "end_time", "aux1", "aux2", "aux3"));
        $this->addAction("formCal", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("formCal", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "person_id", "type_id", "start_time", "end_time"));
    }

}
