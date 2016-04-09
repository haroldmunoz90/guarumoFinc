<?php

class HourConceptView extends HelperView {

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
        $this->assignType("id", "id", BaseView::HIDDEN);

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
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->addAuthFields();

        $this->assignType("hour_report_id", "Reporte", BaseView::HIDDEN);

        $this->assignType("concept_id", JText::_("COM_CTC_CONCEPT"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Concept",
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "code"),
            //BaseView::ENT_FIELD_ID => "name",
            BaseView::FUNC_JS => "goConcept",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("concept_id_ALIAS_2", JText::_("COM_CTC_CONCEPT"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Concept",
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name"),
            //BaseView::ENT_FIELD_ID => "name",
            BaseView::FUNC_JS => "goConcept",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("concern_to", JText::_("COM_CTC_CONCERN_TO"), BaseView::PICKLIST, array(
            Concept::CONCERN_TO_IN => JText::_("COM_CTC_CONCERN_TO_IN"),
            Concept::CONCERN_TO_OUT => JText::_("COM_CTC_CONCERN_TO_OUT"),
            Concept::CONCERN_TO_ALL_DAY => JText::_("COM_CTC_CONCERN_TO_ALL_DAY"),
            BaseView::TOOLTIP => JText::_("COM_CTC_CONCERN_TO_DESC")
        ));

        $this->assignType("concept_id_ALIAS_1", JText::_("COM_CTC_DESCRIPTION"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Concept",
            BaseView::ENT_FIELD => "description",
            BaseView::ENT_FILTER => $filterType));

        $this->assignType("hours", "Horas", BaseView::TIME);
        $this->assignType("start_time", "Hora Inicio", BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("end_time", "Hora Final", BaseView::DATE_TIME, array("dateFormatPHP" => "Y-m-d H:i"));
        $this->assignType("extension_time", "Fecha de Extensión", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));

        $this->assignType("range_type", "Tipo de Rango", BaseView::PICKLIST, array(
            HourConcept::RANGE_DATETIME => "Rango Fecha Hora",
            HourConcept::RANGE_HOURS => "Rango de Horas",
            HourConcept::RANGE_DATES => "Rango de Fechas",
            HourConcept::RANGE_TOTAL_HOURS => "Horas Totales",
            HourConcept::RANGE_TOTAL_DAYS => "Días Totales"
        ));
        $this->assignType("aux1", "Auxiliar1", BaseView::DATE);
        $this->assignType("aux2", "Auxiliar2", BaseView::DATE);
        $this->assignType("aux3", "Auxiliar3", BaseView::DATE);


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

        $this->assignType("paid", "Remunerada", BaseView::PICKLIST, array(
            'F' => "No",
            'T' => "Si"
        ));
        $this->assignType("numNovedades", "Cantidad", BaseView::STRING);
        $this->assignType("sumDuration", "Total Horas", BaseView::TIME);
        $this->assignType("type", JText::_("COM_CTC_CONC_TYPE"), BaseView::HIDDEN);
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "hourconcept";
        $this->addView("form", array("id", "person_id", "range_type", "start_time", "end_time", "aux1", "aux2", "aux3", "hours", "area_id",
            "concept_id_ALIAS_1", "cost_center_id", "concept_id", "description", "concern_to", "extension_time", "code"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("form");

        $this->addView("formCreate", array("id", "person_id", "concept_id", "concept_id_ALIAS_1", "description", "concern_to", "range_type",
            "start_time", "end_time", "aux1", "aux2", "aux3", "hours"));
        $this->addAction("formCreate", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("formCreate", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("reportform", array("start_time", "end_time", "person_id", "concept_id",
            "range_type", "paid", "area_id", "cost_center_id", "contract_type_id"));
        $this->addAction("reportform", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
        $this->addAuthView("reportform");

        $this->addView("table", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "concept_id", "start_time", "end_time", "hours", "concern_to", "range_type", "paid", "extension_time", "code"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("tablereport", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "concept_id", "start_time", "end_time", "area_id", "cost_center_id", "extension_time", "code"));

        $this->addView("tablesummary", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "numNovedades", "sumDuration"));

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("formCal", array("id", "concept_id", "description", "range_type",
            "start_time", "end_time", "aux1", "aux2", "aux3"));
        $this->addAction("formCal", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("formCal", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("details", array("concept_id_ALIAS_2", "hours", "start_time", "end_time"));

        $this->addView("aud", array(
            "person_id",
            "concept_id",
            "hours",
            "start_time",
            "end_time"));
    }

}

?>
