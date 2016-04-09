<?php

class ContractTypeView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);

        $filter = null;

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));


        $this->addAuthFields();


        /**
         * Definicion de vistas y sus acciones
         */
        $class = "contracttype";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "code", "status_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}
