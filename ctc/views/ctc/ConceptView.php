<?php

/**
 * Configuracion de vistas para la clase "Schedule".
 *
 */
class ConceptView extends HelperView {

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
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->addAuthFields();

        $this->assignType("type", JText::_("COM_CTC_CONC_TYPE"), BaseView::PICKLIST, array(
            Concept::TYPE_CONCEPT => JText::_("COM_CTC_TYPE_CONCEPT"),
            Concept::TYPE_NOTICE => JText::_("COM_CTC_TYPE_NOTICE")
        ));
        $this->assignType("paid", JText::_("COM_CTC_PAID"), BaseView::PICKLIST, array(
            'F' => JText::_("COM_CTC_NOT"),
            'T' => JText::_("COM_CTC_YES")
        ));
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);
        $this->assignType("initial_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_date", JText::_("COM_CTC_END_DATE"), BaseView::DATE);
        $this->assignType("require_authorization", JText::_("COM_CTC_REQUIRE_AUTH"), BaseView::PICKLIST, array(
            'F' => JText::_("COM_CTC_NOT"),
            'T' => JText::_("COM_CTC_YES"),
            BaseView::TOOLTIP => JText::_("COM_CTC_REQUIRE_AUTH_DESC")
        ));
        $this->assignType("affects_payroll", JText::_("COM_CTC_AFFECTS_PAYROLL"), BaseView::PICKLIST, array(
            'F' => JText::_("COM_CTC_NOT"),
            'T' => JText::_("COM_CTC_YES"),
            BaseView::TOOLTIP => JText::_("COM_CTC_AFFECTS_PAYROLL_DESC")
        ));
        $this->assignType("concern_to", JText::_("COM_CTC_CONCERN_TO"), BaseView::PICKLIST, array(
            Concept::CONCERN_TO_IN => JText::_("COM_CTC_CONCERN_TO_IN"),
            Concept::CONCERN_TO_OUT => JText::_("COM_CTC_CONCERN_TO_OUT"),
            Concept::CONCERN_TO_ALL_DAY => JText::_("COM_CTC_CONCERN_TO_ALL_DAY"),
            BaseView::TOOLTIP => JText::_("COM_CTC_CONCERN_TO_DESC")
        ));

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::PICKLIST, array(
            2 => "Inactivo",
            1 => "Activo"
        ));
        $this->assignType("surcharge", JText::_("COM_CTC_SURCHARGE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_SURCHARGE_DESC")));

        $this->assignType("mustHaveSubConceptItems", JText::_("COM_CTC_OVER_SUBCONCEPTS"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "alias_name",
            BaseView::ENT_CLASS => "SubConceptItem",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("mustNotHaveSubConceptItems", JText::_("COM_CTC_NOTOVER_SUBCONCEPTS"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "alias_name",
            BaseView::ENT_CLASS => "SubConceptItem",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("workcode", JText::_("COM_CTC_WORKCODE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_WORKCODE_DESC")));

        $this->assignType("round_min", JText::_("COM_CTC_MINUTE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_MINUTE_DESC")
        ));

        $this->assignType("round_mode", JText::_("COM_CTC_ROUND"), BaseView::PICKLIST, array(
            EConstants::ROUND_UP => JText::_("COM_CTC_SUBCT_UP"),
            EConstants::ROUND_DOWN => JText::_("COM_CTC_SUBCT_DOWN"),
            EConstants::ROUND_CEILING => JText::_("COM_CTC_SUBCT_CEILING"),
            EConstants::ROUND_FLOOR => JText::_("COM_CTC_SUBCT_FLOOR"),
            EConstants::ROUND_HALF_UP => JText::_("COM_CTC_SUBCT_HALF_UP"),
            EConstants::ROUND_HALF_DOWN => JText::_("COM_CTC_SUBCT_HALF_DOWN"),
            EConstants::ROUND_HALF_EVEN => JText::_("COM_CTC_SUBCT_HALF_EVEN"),
            EConstants::ROUND_EVEN_ODD_DOWN_UP => "Impar Arriba",
            //7 => "No Necesario",
            BaseView::TOOLTIP => JText::_("COM_CTC_ROUND_DESC")
        ));



        /**
         * Definicion de vistas y sus acciones
         */
        $class = "concept";
        $this->addView("form", array("id", "name", "description", "code", "initial_date",
            "end_date", "status_id", "require_authorization", "affects_payroll", "surcharge", "type",
            "paid", "concern_to", "round_min", "round_mode", "workcode",
            "mustHaveSubConceptItems", "mustNotHaveSubConceptItems"));
        $this->addAuthView("form");

        $this->addView("formnotice", array("id", "name", "description", "code", "initial_date",
            "end_date", "require_authorization", "affects_payroll", "surcharge", "type", "paid", "concern_to", "workcode",
            "status_id"));
        $this->addAuthView("formnotice");
        $this->addAction("formnotice", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("formnotice", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");


        $this->addView("table", array("name", "code",
            "require_authorization", "affects_payroll", "initial_date", "end_date",
            "surcharge", "status_id",
            "type", "paid", "concern_to", "workcode",
            "round_mode", "round_min",));

        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "status_id",
            "require_authorization",
            "affects_payroll", "initial_date",
            "end_date"));
    }

}
