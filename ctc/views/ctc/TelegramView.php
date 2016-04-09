<?php

class TelegramView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("number", JText::_("COM_CTC_CELLPHONE"), BaseView::STRING);

        $filter = null;
        //$this->assignType("last_execution", "Fecha Ultima Ejecución", BaseView::DATE);
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("user_id", JText::_("COM_CTC_USER"), BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "UserJ",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));


        $this->addAuthFields();


        /**
         * Definicion de vistas y sus acciones
         */
        $class = "Telegram";

        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        $this->addAuthView("form");

        $this->addViewEx("formv2", array());
        $this->addAuthView("formv2");

        $this->addView("table", array("user_id", "number", "status_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}
