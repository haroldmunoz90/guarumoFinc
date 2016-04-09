<?php

class ProcessFileView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
		//parent::addCheckBox("table");
		$user = $this->getLoggedUser();
		
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("file_url", "Archivo", BaseView::STRING);
        $this->assignType("type", "Tipo de Archivo",  BaseView::PICKLIST, array(
			0 => "Empleados",
			1 => "Incidencias"
		));
		
        $funcRes = function($obj) {
			if(strlen( $obj->result ) > 0 ) {
				return "<a href=\"javascript:" . "showBiggerText" . "('Resumen del proceso','" . $obj->result . "');\"> Resumen </a>";
			}
        };		
		$this->assignType("result", "Resumen", BaseView::FUNC, $funcRes );
		$funcErr = function($obj) {
			if(strlen( $obj->errors ) > 0 ) {
				return "<a href=\"javascript:" . "showBiggerText" . "('Errores encontrados','" . $obj->errors . "');\"> Errores </a>";
			}
        };		
		$this->assignType("errors", "Errores Encontrados", BaseView::FUNC, $funcErr );
		$this->assignType("processed_date", "Fecha de procesamiento", BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
		$this->assignType("total_register", "Total de Registros", BaseView::STRING);
		$this->assignType("inserts_processed", "Total Insertados", BaseView::STRING);
		$this->assignType("updates_processed", "Total Actualizados", BaseView::STRING);
		$this->assignType("result_type", "Resultado",  BaseView::PICKLIST, array(
			0 => "No procesado.",
			1 => "EXITOSO.",
			2 => "Procesado Con Errores.",
			3 => "Error en el archivo."
		));		

		$this->addAuthFields();	
		
		$enterpriseId = BaseCore::getLoggedEnterpriseId();
		$username = $user->username;
        $dir = $GLOBALS['path_to_repository']. 
			DIRECTORY_SEPARATOR . "uploadcsv".
			DIRECTORY_SEPARATOR .$enterpriseId."_".$username;	
		
        if (!file_exists($dir)) {
            mkdir($dir, 0777, true);
        }
        $this->assignType("csvfiles", "Importar Datos", BaseView::FILE_LIST, $dir);		
		
        
        /**
         * Definicion de vistas y sus acciones
         */
        $class = "procfile";
        $this->addView("form", array("csvfiles"));
        //$this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        //$this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("file_url","processed_date", "type","result","errors","total_register", "inserts_processed","updates_processed","result_type"));
        $this->addAuthView( "table" );
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
        
        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
		
		$this->addView("aud", array(
			"file_url",
			"type",
			"status_id"));
    }
}


