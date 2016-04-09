<?php

/**
 * Configuracion de vistas para la clase "User".
 *
 */
class RolView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $user = $this->getLoggedUser();


        $this->assignType("id", "ID", BaseView::HIDDEN);

        $this->assignType("lft", "lft", BaseView::HIDDEN);
        $this->assignType("rgt", "rgt", BaseView::HIDDEN);
        $this->assignType("title", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::STRING);

        if ($user->hasPermission("assign-enterprise")) {
            $this->assignType("enterprise_id", JText::_("COM_CTC_ENTERPRISE"), BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "Enterprise",
                BaseView::ENT_FILTER => null));
        }

        $vlevels = $user->getAssignedViewLevels();

        $this->assignType("viewlevels", JText::_("COM_CTC_VIEWLEVELS"), BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "description",
            BaseView::ENT_CLASS => "ViewLevel",
            BaseView::ENT_VALUE => $vlevels,
            BaseView::ENT_FILTER => null));

        /**
         * Definicion de vistas y sus acciones
         */
        $this->addView("form", array("id",
            "enterprise_id",
            "lft",
            "rgt",
            "title",
            "description",
            "viewlevels"));

        $class = "Rol";
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("title"));
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "title"));
    }

}
