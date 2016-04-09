<?php

/**
 * Configuracion de vistas para la clase "IlgCalendarTime".
 *
 */
class RuleAssetView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    
       
    function __construct() {
		$user = $this->getLoggedUser();
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("concept_id", "Concept", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
    	$this->assignType("identification", "Identificacion", BaseView::HIDDEN);
		$this->assignType("package", "Paquete", BaseView::HIDDEN);

		$class = "ruleasset";	
        $this->addView("form", array("id", "name", "description" ));
        //$this->addView("form", array("id", "name", "post", "post_date"));
        $this->addAction("form", $class."_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class."_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        //$this->addView("table", array("name", "user_id", "post_date"));
        $this->addView("table", array("name", "description"));
        $this->addAction("table", $class."_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class."_table_delete", JText::_("COM_CTC_DELETE"), "delete.png");
		$this->addAction("table", $class."_table_editrule", "Editar Regla", "tools.png");
        
        $this->addView("dialog", array());
		$this->addAction("dialog", $class."_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
		$this->addAction("dialog", $class."_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
        
    }

}

?>

