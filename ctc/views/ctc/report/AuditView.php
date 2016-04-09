<?php

/**
 * Configuracion de vistas para la clase "Enter".
 *
 */
class AuditView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("target", "Auditoría", BaseView::STRING);
        $this->assignType("creation_date", JText::_("COM_SORCORE_DATE"), BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
        $this->assignType("operation", "Operación", BaseView::PICKLIST, array(
            "C" => "Creación",
            "R" => "Consulta",
            "U" => "Actualización",
            "D" => "Borrado",
        ));
        
        $this->assignType("user_id", JText::_("COM_CTC_USER"),  BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "UserJ",
            BaseView::ENT_FIELD => "username",
            BaseView::ENT_FILTER => null));
		
		$this->assignType("extra", "Extra", BaseView::STRING);
		$this->assignType("before", "Antes", BaseView::STRING);
		$this->assignType("after", "Después", BaseView::STRING);
        
        /**
         * Definicion de vistas y sus acciones
         */
        $this->addView("form", array(
            "target",
            "creation_date",
            "user_id",
            "operation",
			"extra",
			"before",
			"after"
        ));
        
        $this->addAction("form", "filter", JText::_("COM_CTC_FILTER"), "search.png");

        $this->addView("table", array(
            "target",
            "creation_date",
            "user_id",
            "operation",
			"extra",
			"before",
			"after",
			
        ));
        $this->addAction("table", "table_detail", "Ver detalles", "zoom-in");
        $rule = function($obj) {
            if($obj->before || $obj->after || $obj->extra) {
                return true;
            }
            return false;
        };
        $this->addActionDisplayRule("table", "table_detail", $rule);

        $this->addView("dialog", array());
        $this->addAction("dialog", "dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
    }
}