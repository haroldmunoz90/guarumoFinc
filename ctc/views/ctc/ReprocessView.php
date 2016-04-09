<?php

/**
 * Configuracion de vistas para la clase "Notification".
 *
 */
class ReprocessView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $filter = new Filter();
        $filter->eq_("status_id", 1);
        $this->addAuthFields();
        $this->assignType("person_id", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => $filter));
        $this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter,
            BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));

        $this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "CostCenter",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        $this->assignType("start_date", JText::_("COM_CTC_START_DATE"), BaseView::DATE);
        $this->assignType("end_date", JText::_("COM_CTC_END_DATE"), BaseView::DATE);
        $this->assignType("noDelete", JText::_("COM_CTC_REGENERATE"), BaseView::PICKLIST, array(
            "F" => JText::_("COM_CTC_REGENERATE_ALL"),
            "T" => JText::_("COM_CTC_REGENERATE_NP") //"Unicamente no procesados."		
        ));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "Reprocess";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_REPROCESS"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("form");

        $gclass = "generate";
        $this->addViewEx("formgpr", array());
        $this->addAction("formgpr", $gclass . "_form_submit", JText::_("COM_CTC_CLASSIFY"), "save.png");
        $this->addAction("formgpr", $gclass . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("formgpr");

        $HPCclass = "HPC";
        $this->addViewEx("formHPC", array());
        $this->addAction("formHPC", $HPCclass . "_form_submit", JText::_("COM_CTC_PERIOD_CLASSIFY"), "save.png");
        $this->addAction("formHPC", $HPCclass . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("formHPC");
    }

}
