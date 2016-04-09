<?php

class TagView extends HelperView {

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
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING, array(
            BaseView::TOOLTIP => "Nombre que se va a mostrar de la etiqueta."
        ));
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);

        $this->assignType("tag_category_id", "Categoría", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "name",
            BaseView::ENT_CLASS => "CategoryTag",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->addAuthFields();

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "tag";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "tag_category_id", "status_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}

?>
