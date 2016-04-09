<?php

class BranchOfficeView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
		parent::addCheckBox("table");
        $user = $this->getLoggedUser();

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
		$this->assignType("lft", "lft", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
		$this->assignType("code", "Código", BaseView::STRING);
		
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
		
		
        if ( $user->getNumAuthEnterprises() != 1 ||
			$user->hasPermission("assign-enterprise") ) {
            $this->assignType("enterprise_id", JText::_("COM_CTC_ENTERPRISE"), BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "Enterprise",
                BaseView::ENT_FILTER => null));
        }		
		if ( $user->getNumAuthBranchOff() != 1 ||
			$user->hasPermission("assign-branch") ) {
            $this->assignType("parent_branch_office_id", "Sucursal Padre", BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "BranchOffice",
                BaseView::ENT_FILTER => null));
        }		

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "branchoffice";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("name", "code","status_id"));
		if ( $user->getNumAuthEnterprises()!= 1 ||
			$user->hasPermission("assign-enterprise") ){
			$this->addFieldView("table",array("enterprise_id"),1);
		}
		if( $user->getNumAuthBranchOff() != 1 ||
			$user->hasPermission("assign-branch") ){
			$this->addFieldView("table",array("parent_branch_office_id"),1);
		}
		
        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
		
		$this->addView("aud", array(
			"name", "code","status_id"));
    }

}
