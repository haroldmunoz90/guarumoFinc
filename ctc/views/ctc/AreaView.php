<?php

class AreaView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("lft", "lft", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->addAuthFields();
        $filter = new Filter();
        $filter->eq_("status_id", 1);
        $this->assignType("parent_area_id", "Area padre", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "parentArea",
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));
        /*
          $this->assignType("area_category_id", "Categoria", BaseView::ENTITY, array(
          BaseView::ENT_VAR_NAME => "areaCategory",
          BaseView::ENT_CLASS => "AreaCategory",
          BaseView::ENT_FIELD => "name",
          BaseView::ENT_FILTER => $filter));
         */
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);
        $this->assignType("expiration_date", JText::_("COM_CTC_EXPIRATION_DATE"), BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));
        $this->assignType("activation_date", "Fecha de activacion", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i"
        ));
        $this->assignType("head_person_id", "Supervisor", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
                "last_name",
                "identification"),
            BaseView::ENT_FILTER => $filter));

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "area";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "status_id", "code", "parent_area_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "description",
            "status_id"));
    }

}
