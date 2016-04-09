<?php

class HRSummaryIntervalView extends BaseView {

    function __construct( $concType = null ) {
	
		if( $concType === "PayEmplContract" ) {
			$concType = BaseView::STRING;
		} else {
			$concType = BaseView::TIME;
		}
        $this->assignType("id", "id", BaseView::HIDDEN);
		
		$this->assignType("start_time", JText::_("COM_SORCORE_DATE"), BaseView::DATE_TIME, array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
		$this->assignType("startCutDate", "Inicio Corte", BaseView::STRING,array(
				BaseView::TOOLTIP => "Fecha de Inicio de corte de Nómina" ));		
		$this->assignType("endCutDate", "Fin Corte", BaseView::STRING,array(
				BaseView::TOOLTIP => "Fecha de Finalización de corte de Nómina" ));
		$this->assignType("emplStarted", "Ingreso", BaseView::STRING,array(
				BaseView::TOOLTIP => "Fecha de Ingreso del empleado" ));
		$this->assignType("emplEnd", "Retiro", BaseView::STRING,array(
				BaseView::TOOLTIP => "Fecha de Retiro del empleado" ));
		
        $this->assignType("person_id", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FIELD => array("name",
				"last_name",
				"identification"),
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FILTER => null));  // no podemos filtrar por estado porque pueden requerir filtrar por suspedidos.
		
        $this->assignType("person_id_ALIAS_1", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FILTER => null)); 
		
		$this->assignType("origin_type_id", "Origen", BaseView::PICKLIST, array(
			Attendance::ORIG_TYPE_DEVICE => "Dispositivo",
            Attendance::ORIG_TYPE_MANUAL => "Manual",
            Attendance::ORIG_TYPE_AUTO => "Automática"
            ));	

		$this->assignType("authorized", "Incluir Autorizadas",  BaseView::PICKLIST, array(
            "T" => JText::_("COM_CTC_YES"),
            "F" => JText::_("COM_CTC_NOT")
		));
		
		$this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "ContractType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));	
		$this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => array("name",
				"code"),
			BaseView::ENT_FILTER => $filter));
		
		$this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "BranchOffice",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		$this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Area",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter,
			BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));
		$this->assignType("position_id", JText::_("COM_CTC_POSITION"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Position",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));		
		$this->assignType("cost_center_id_ALIAS_1", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => array("code"),
			BaseView::ENT_FILTER => $filter));

        $this->assignType("person_id_ALIAS_3", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FILTER => $filter));
				
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::FUNC_JS => "goPerson"));

		$this->assignType("date_arr", JText::_("COM_SORCORE_DATE"), BaseView::DATE );
		$this->assignType("time_arr", "Ingreso", BaseView::STRING);		
		$this->assignType("time_left", JText::_("COM_CTC_DEPART"), BaseView::STRING);

		
        $this->assignType("worked_hours", "Totales", $concType );        
        $this->assignType("manuales", "Manuales", BaseView::STRING);        

        $this->assignType("deviceIdStart", "Disp. Entrada", BaseView::ENTITY, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Device",
            BaseView::ENT_FILTER => null,
			BaseView::TOOLTIP => "Dispositivo de Entrada.  Unidad Biométrica donde se realizó la marcación de entrada."));		
        $this->assignType("deviceIdEnd", "Disp. Salida", BaseView::ENTITY, array(
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_CLASS => "Device",
            BaseView::ENT_FILTER => null,
			BaseView::TOOLTIP => "Dispositivo de Salida.  Unidad Biométrica donde se realizó la marcación de salida."));	
		
		$arrayConNames = $this->getConceptNamesDesc();
		$concArr = array();
        foreach($arrayConNames as $value){
            $this->assignType($value["name"], $value["name"], $concType,array(
				BaseView::TOOLTIP => $value["description"] ));
			$concArr[] = $value["name"];
        }

		$this->assignType("GC_NOVEDADES", "Novedades", BaseView::STRING);
		$this->assignType("status_id", "Estado Empleado", BaseView::PICKLIST, array(
            1 => "Activo",
            2 => "Suspendido"
            ));
		$this->assignType("paid", "Remunerada", BaseView::PICKLIST, array(
			'F' => JText::_("COM_CTC_NOT"),
			'T' => JText::_("COM_CTC_YES")
		));				
		$this->assignType("showallempl", "Mostrar Todos los empleados",  BaseView::PICKLIST, array(
            "1" => "Todos los empleados",
			BaseView::CUSTOM_OPER => "Mostrar",
			BaseView::TOOLTIP => "Al seleccionar éste filtro se mostraran todos los empleados sin importar que tenga o no tenga actividad."
            ));
		
        $this->addView("form", array("start_time","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id",
			"contract_type_id","cost_center_id",
			"branch_office_id","status_id","area_id")); 		
        $this->addAction("form", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
		
        $this->addView("formDevReport", array("start_time","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id",
			"contract_type_id","cost_center_id","paid",
			"branch_office_id","status_id","area_id")); 		
        $this->addAction("formDevReport", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		
		
        $this->addView("formContract", array("start_time","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id","paid",
			"contract_type_id","cost_center_id","showallempl",
			"branch_office_id","status_id","area_id")); 		
        $this->addAction("formContract", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");
		
		$this->addView("formmanual", array("start_time","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id")); 
		$this->addAction("formmanual", "payempldate_report_update", JText::_("COM_CTC_UPDATE"), "save.png");		

		/**************   Tablas             **********/	
	
		$tableRe2 = array( "person_id_ALIAS_3","person_id_ALIAS_2","worked_hours" );
		$format2 = array( 3  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )
			);
		$exporterConf2 =  array( 15, 40, 8, );
		$this->addViewConcepts( "table", $tableRe2, $concArr, $exporterConf2, array(), $format2 );
		
		$tableRe3 = array( "person_id_ALIAS_3","person_id_ALIAS_2","date_arr","time_arr","time_left","worked_hours", );
		$format3 = array(  3  => array( 'type' => 'AS_DATE', 'date_format' => 'NUMFORMAT_DATE' ),
				6  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )
			);
		$exporterConf3 =  array( 15, 40, 20, 10,10, 8 );
		$this->addViewConcepts( "tablenosumm", $tableRe3, $concArr, $exporterConf3, array("GC_NOVEDADES"), $format3 );
				
		$tableRe4 = array( "person_id_ALIAS_3","person_id_ALIAS_2","date_arr","time_arr","time_left","worked_hours" );
		$format4 = array(  3  => array( 'type' => 'AS_DATE', 'date_format' => 'NUMFORMAT_DATE' ),
				6  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )
			);
		$exporterConf4 =  array( 15, 40, 10, 10,10, 8 );
		$this->addViewConcepts( "tableper", $tableRe4, $concArr, $exporterConf4, array(), $format4 );
		
		$tableRe5 = array( "person_id_ALIAS_3","person_id_ALIAS_2","worked_hours","manuales" );
		$format5 = array(  3  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )
			);
		$exporterConf5 =  array( 40, 20, );
		$this->addViewConcepts( "tablemanual", $tableRe5, $concArr, $exporterConf5, array(), $format5 );
		
		$tableRe6 = array("startCutDate","endCutDate","emplStarted" ,"emplEnd", 
			"contract_type_id",	"branch_office_id","position_id","cost_center_id_ALIAS_1",
			"person_id_ALIAS_3", "person_id_ALIAS_2","worked_hours", );
		$format6 = array( 11  => array( 'type' => 'AS_DATE', 'custom' => '[h]:mm' )
			);
		$exporterConf6 =  array( 25, 25, 14, 14, 
			25, 25,	25, 8,
			15, 40,8
			);
		$this->addViewConcepts( "tablecontract", $tableRe6, $concArr, $exporterConf6, array("GC_NOVEDADES"), $format6 );
		
		$tableRe7 = array( "contract_type_id","cost_center_id_ALIAS_1","person_id_ALIAS_3",
			"person_id_ALIAS_2","date_arr","time_arr","time_left","deviceIdStart",
			"deviceIdEnd", );
		$format7 = array(  5  => array( 'type' => 'AS_DATE', 'date_format' => 'NUMFORMAT_DATE' )
			);
		$exporterConf7 =  array( 25, 10, 15, 40,14, 8,8, 14,14, );
		$this->addViewConcepts( "tablecontractdevice", $tableRe7, $concArr, 
				$exporterConf7, array("GC_NOVEDADES"), $format7, array(20, '0format' => array( 'type' => 'AS_NUMERIC_STRING' )) );
		
    }
	
	function addViewConcepts($name, $tableRe, $concArr, 
			$exporterConf, $right = array(), $format = array(),
			$rightExpCon = array()  ) {
		$initRow = count( $exporterConf ) ;
		$exporterConf['height'] = 20;
		$exporterConf['format'] = $format;
		$exporterConf['footprint'] = array();
		for( $i = 0 ; $i < count( $concArr ); $i++ ) {
			$rowCurr = $initRow + $i + 1;
			$exporterConf[$rowCurr - 1] = 6;
			$exporterConf['format'][$rowCurr] = array( 'type' => 'AS_DATE', 'custom' => '[h]:mm'  );
			$exporterConf['footprint'][$rowCurr] = 
				array(	'type' => 'AS_FORMULA',
						'formula' => "SUM(%COL%%INIT_ROW%:%COL%%END_ROW%)",
						'custom' => '[h]:mm'  );
		}
		for( $i = 0 ; $i < count( $rightExpCon ); $i++ ) {
			if( isset( $rightExpCon[$i] ) ) {
				$rowCurr++;
				$exporterConf[$rowCurr - 1] = $rightExpCon[$i];
				$exporterConf['format'][$rowCurr] = $rightExpCon[$i.'format'];
			}
		}
		//$exporterConf['format'][$rowCurr + 1] = array( 'type' => 'AS_TEXT', 'text' => 'text'  );
		$exporterConf['footprint2'][1] = 
				array(	'type' => 'AS_TEXT',
						'text' => "Total" );
		$exporterConf['footprint2'][2] = 
				array(	'type' => 'AS_FORMULA',
						'formula' => "SUM(A%END_ROW+1%:%LAST_COL%%END_ROW+1%)",
						'custom' => '[h]:mm'  );
		$tableRe = array_merge($tableRe, $concArr );
		$tableRe = array_merge($tableRe, $right );
		$this->addView( $name , $tableRe );
		$this->addExporterConf( $name, $exporterConf );
	}
	
	function getConceptNamesDesc() {
		$authC = BaseCore::formatAuthWhere("c",array("BranchOffice"));
		$varSessName = "ConceptNamesDesc" . preg_replace('/\s+/', '', $authC);
		$arrayConNames = BaseCore::getSeVaExp( $varSessName , BaseCore::ONE_DAY_IN_MILLIS );
		if( $arrayConNames !== null && count($arrayConNames) > 0 ) {
			return $arrayConNames;
		}
        $db = Connection::_getWriterConnection();
		
		$notType = Concept::TYPE_CONCEPT;
        $select = <<<QU
			SELECT name, description 
            FROM ilg_concept c
            WHERE $authC
				AND c.status_id = '1' 
				AND c.type = {$notType}
			ORDER BY report_order asc
QU;
        if ($GLOBALS['logQueries']) {
            JLog::add( "PayEmplReportDate " . $select ,JLog::DEBUG, "cloudtime" );
        }
        $statement = $db->prepare($select);
        $ret = $statement->execute();
		$err = $db->errorInfo();
		if ($err[2]) {
			JLog::add(__FUNCTION__ . " " . implode(":", $err), JLog::ERROR, "sorcore");
		}
		$err = $statement->errorInfo();
		if ($err[2]) {
			JLog::add(__FUNCTION__ . " " . implode(":", $err), JLog::ERROR, "sorcore");
		}		
        $arrayConNames = $statement->fetchAll(PDO::FETCH_ASSOC);
		$_SESSION[ $varSessName ] = $arrayConNames;
        return $arrayConNames;
    }

    
    function getConceptNames() {
        $arrayConNames = $this->getConceptNamesDesc();
		$retA = array();
		foreach($arrayConNames as $value){
			$retA[]=$value["name"];
		}
		return $retA;
    }

}
