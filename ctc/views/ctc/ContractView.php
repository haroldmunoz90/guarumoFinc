<?php

class ContractView extends HelperView {

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


        $this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => $filter));
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => null));

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("started_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("expected_end_date", JText::_("COM_CTC_EXPECTED_END_DATE"), BaseView::DATE);
        $this->assignType("end_date", JText::_("COM_CTC_END_DATE"), BaseView::DATE);
        $this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractType",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("contract_detail_id", JText::_("COM_CTC_CONTRACT_DETAIL"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "ContractDetail",
            BaseView::ENT_FIELD => "title",
            BaseView::ENT_FILTER => $filter));

        $this->addAuthFields();


        // Campos de formularios de Reporte
        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"
        ));

        $this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter,
            BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));

        $this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "CostCenter",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));


        $this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "BranchOffice",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "contract";
        $this->addViewEx("form", array("person_id", "person_id_ALIAS_1", "person_id_ALIAS_2", "area_id", "cost_center_id"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("status_id",
            "started_date", "expected_end_date", "end_date",
            "contract_type_id", "contract_detail_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        ///  Vistas de Reporte
        $this->addView("reportform", array("status_id", "started_date", "person_id",
            "contract_detail_id", "contract_type_id", "area_id", "branch_office_id", "cost_center_id"));
        $this->addAction("reportform", "contract_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
        $this->addView("tablereport", array("person_id_ALIAS_1", "person_id_ALIAS_2",
            "started_date", "status_id", "end_date", "contract_detail_id",
            "contract_type_id", "area_id", "cost_center_id"));

        ///  Dialogo
        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "person_id",
            "started_date", "end_date", "status_id",
            "contract_detail_id", "contract_type_id"));
    }

}
