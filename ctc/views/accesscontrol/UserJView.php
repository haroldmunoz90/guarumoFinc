<?php

/**
 * Configuracion de vistas para la clase "User".
 *
 */
class UserJView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");
        /**
         * Definicion de tipos de campos
         */
        $user = $this->getLoggedUser();

        $this->assignType("id", "ID", BaseView::HIDDEN);

        if ($user->getNumAuthEnterprises() != 1 ||
                $user->hasPermission("assign-enterprise")) {
            $this->assignType("enterprise_id", JText::_("COM_CTC_ENTERPRISE"), BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "Enterprise",
                BaseView::ENT_FILTER => null));
        }
        /*
          if ( $user->getNumAuthBranchOff() > 1 ||
          $user->hasPermission("assign-branch") ) {
          $this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
          BaseView::ENT_FIELD => "name",
          BaseView::ENT_CLASS => "BranchOffice",
          BaseView::ENT_FILTER => null));
          } */

        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("fakeusername", "Login", BaseView::STRING);
        $this->assignType("fakepassword", JText::_("COM_CTC_PASSWORD"), BaseView::PASSWORD);
        $this->assignType("username", "Login", BaseView::STRING);
        $this->assignType("password", JText::_("COM_CTC_PASSWORD"), BaseView::PASSWORD);
        $this->assignType("lastvisitDate", "Ultima Visita", BaseView::DATE);
        $this->assignType("reppassword", "Repetir Password", BaseView::PASSWORD);
        $this->assignType("email", JText::_("COM_CTC_EMAIL"), BaseView::STRING);
        $this->assignType("cellphone", JText::_("COM_CTC_CELLPHONE"), BaseView::STRING);
        $this->assignType("block", JText::_("COM_CTC_STATUS"), BaseView::PICKLIST, array(
            0 => "Activo",
            1 => "Inactivo"
        ));
        $filter = new Filter();
        $filter->omitAllAuth(true);
        if (!$user->hasPermission("assign-enterprise")) {
            $filter->open_()->in_("enterprise_id", BaseCore::getAuthEntityIdsString())->or_()->eq_("enterprise_id", "0")->close_();
            $filter->and_();
        }
        $filter->gt_("id", 8);
        $this->assignType("rols", "Perfiles", BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "title",
            BaseView::ENT_CLASS => "Rol",
            BaseView::ENT_FILTER => $filter));

        $this->assignType("enterprises", "Empresas Autorizadas", BaseView::ENTITIES, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Enterprise",
            BaseView::ENT_FILTER => null));

        $funcNamePS = function( $obj ) {
            $ps = new Enterprise();
            if ($ps->loadWithFields($obj->enterprise_id, array("id"))) {
                return $ps->name . " " . $obj->name;
            }
            return $obj->name;
        };
        $this->assignType("branchoffices", "Sucursales Autorizadas", BaseView::ENTITIES, array(
            BaseView::ENT_FIELD_SORT => "name",
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => $funcNamePS,
            BaseView::ENT_CLASS => "BranchOffice",
            BaseView::ENT_FILTER => null));



        /**
         * Definicion de vistas y sus acciones
         */
        $class = "user";
        $this->addView("form", array(
            "id",
            "enterprise_id",
            "name",
            "fakeusername",
            "fakepassword",
            "username",
            "password",
            "enterprises",
            "email",
            "cellphone",
            "block",
            "rols",
            "branchoffices"));
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("username",
            "email", "lastvisitDate",
            "block", "cellphone", "lastvisitDate", "name"));
        /* if( $user->getNumAuthBranchOff() > 1 ||
          $user->hasPermission("assign-branch") ){
          $this->addFieldView("table",array("branch_office_id"),1);
          } */
        if ($user->getNumAuthEnterprises() != 1 ||
                $user->hasPermission("assign-enterprise")) {
            $this->addFieldView("table", array("enterprise_id"), 1);
        }
        $this->addAction("table", $class . "_chg_status", "Cambiar estado", "unlock.png");
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $class = "moduser";
        $this->addView("uform", array("password", "reppassword"));
        $this->addAction("uform", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");

        $this->addView("aud", array(
            "username",
            "email",
            "block"));
    }

}
