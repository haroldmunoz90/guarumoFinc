<?php

class PayRollReportBaseView extends BaseView {

    function __construct( ) {
		
		$funcNamePS = function( $obj ) {
			$bo = new BranchOffice();
			if( $bo->loadWithFields($obj->branch_office_id,array("id")) ){
				return $bo->name . " $obj->initial_date - $obj->end_date";
			}
			return "$obj->initial_date - $obj->end_date";
		};
		
		$this->assignType("start_time", JText::_("COM_SORCORE_DATE"), BaseView::DATE_TIME,
				array(             "dateFormatPHP" => "Y-m-d H:i"         ));
		
		$filterPRP = new Filter();
		$filterPRP->subquery_("initial_date > now() - interval 4 month" );
		$filterPRP->orderBy_("initial_date", "DESC");
		$this->assignType("payroll_period_id", JText::_("COM_CTC_REP_PR_PERIOD"), BaseView::ENTITY, array(
            BaseView::ENT_FIELD_SORT => "initial_date",
			BaseView::ENT_FIELD_DEL => " ",
			BaseView::ENT_FIELD => $funcNamePS,
            BaseView::ENT_CLASS => "PayrollPeriod",
            BaseView::ENT_FILTER => $filterPRP ));
		
		$filter = new Filter();
		$filter->eq_("status_id", 1 );
		
		$filtroBO = new Filter();
		$filtroBO->omit("BranchOffice", true);
		$filtroBO->updateByRequest();
		$filtroBO->open_()->
					isNull_("branch_office_id")->
						or_()->
					eq_("branch_office_id", Filter::INIT_VALUE )->
				close_()->
				and_()->eq_("status_id", 1 );		
		
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
			1 => "Dispositivo",
            2 => "Manual",
            3 => "Automática"
            ));
		$this->assignType("status_id", "Estado Empleado", BaseView::PICKLIST, array(
            1 => "Activo",
            2 => "Suspendido"
            ));

		$this->assignType("authorized", "Incluir Autorizadas",  BaseView::PICKLIST, array(
            "T" => JText::_("COM_CTC_YES"),
            "F" => JText::_("COM_CTC_NOT")
		));
		
		$this->assignType("contract_type_id", JText::_("COM_CTC_CONTRACT_TYPE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "ContractType",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filtroBO));	
		
		$this->assignType("cost_center_id", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => array("name",
				"code"),
			BaseView::ENT_FILTER => $filtroBO));
		
		$this->assignType("branch_office_id", JText::_("COM_CTC_BRANCH_OFFICE"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "BranchOffice",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filter));
		
		$this->assignType("area_id", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Area",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filtroBO,
			BaseView::CUSTOM_OPER => JText::_("COM_CTC_BELONG_TO")));
		
		$this->assignType("position_id", JText::_("COM_CTC_POSITION"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "Position",
			BaseView::ENT_FIELD => "name",
			BaseView::ENT_FILTER => $filtroBO));
				
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name", "identification"),
            BaseView::ENT_FILTER => $filter,
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::FUNC_JS => "goPerson"));

		
		/// Views		
        $this->addView("formReport", array("start_time","payroll_period_id","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id",
			"branch_office_id","area_id",
			"contract_type_id","cost_center_id",
			"status_id")); 		
        $this->addAction("formReport", "filter", JText::_("COM_CTC_UPDATE"), "save.png");
		$this->addAction("formReport", "clearf", JText::_("COM_CTC_CLEAR"), "remove.png");
    }
	
	function addConceptsAndValues() {
		$arrayConNames = $this->getConceptNamesDesc();
		$concArr = array();
        foreach($arrayConNames as $value){
			$name = $value["name"];
            $this->assignType( $name , $name, BaseView::STRING, array(
				BaseView::TOOLTIP => $value["description"] ));			
			$concArr[] = $name;
			$nameValue = "value_".$value["name"];
			$this->assignType( $nameValue , JText::_("COM_CTC_COST"). " " . $name , BaseView::STRING, array(
				BaseView::TOOLTIP => $value["description"] ));
			$concArr[] = $nameValue;
        }		
		/// Views
		
		$tableRe = array( "person_id_ALIAS_2", "cost_center_id","dateti","mintime","maxtime", );
		$tableRe = array_merge($tableRe, $concArr);
        $this->addView("tableReport", $tableRe );
		
		$exporterConf = array( 40, 15, 15, 10, 10 );
		$this->addExportValues("tableReport", $concArr , $exporterConf);
	}
		
	function addExportValues($name, $concArr, $exporterConf,  $format = array()  ) {
		$initRow = count( $exporterConf ) ;
		$exporterConf['height'] = 20;
		$exporterConf['format'] = $format;
		$exporterConf['footprint'] = array();
		for( $i = 0 ; $i < count( $concArr ); $i++  ) {
			$rowCurr = $initRow + $i + 1;
			$exporterConf[$rowCurr - 1] = 6;
			if( $i % 2 !== 0 ) {
				$exporterConf['format'][$rowCurr] = array( 'type' => 'AS_NUMERIC_STRING'  );
				$exporterConf['footprint'][$rowCurr] = 
					array(	'type' => 'AS_FORMULA',
							'formula' => "SUM(%COL%%INIT_ROW%:%COL%%END_ROW%)",
							'custom' => '[h]:mm'  );
			} else {
				$exporterConf['format'][$rowCurr] = array( 'type' => 'AS_DATE', 'custom' => '[h]:mm'  );
			}
		}
		$exporterConf['footprint2'][1] = 
				array(	'type' => 'AS_TEXT',
						'text' => "Total" );
		$exporterConf['footprint2'][2] = 
				array(	'type' => 'AS_FORMULA',
						'formula' => "SUM(A%END_ROW+1%:%LAST_COL%%END_ROW+1%)" );
		$this->addExporterConf( $name, $exporterConf );
	}
	
	function addConcepts() {
		$arrayConNames = $this->getConceptNamesDesc();
		$concArr = array();
        foreach($arrayConNames as $value){
            $this->assignType($value["name"], $value["name"], BaseView::STRING, array(
				BaseView::TOOLTIP => $value["description"] ));			
			$concArr[] = $value["name"];
        }		
		/// Views
		
		$tableRe = array( "person_id_ALIAS_2", "cost_center_id","dateti","mintime","maxtime", );
		$tableRe = array_merge($tableRe, $concArr);
        $this->addView("tableReport", $tableRe );
		
		$exporterConf = array(40, 15, 15, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		$exporterConf['height'] = 20;
		$this->addExport("tableReport", $concArr , $exporterConf);		
	}

	
	function addExport($name, $concArr, $exporterConf,  $format = array()  ) {
		$initRow = count( $exporterConf ) ;
		$exporterConf['height'] = 20;
		$exporterConf['format'] = $format;
		$exporterConf['footprint'] = array();
		for( $i = 0 ; $i < count( $concArr ); $i++ ) {
			$rowCurr = $initRow + $i + 1;
			$exporterConf[$rowCurr] = 6;
			$exporterConf['format'][$rowCurr] = array( 'type' => 'AS_DATE', 'custom' => '[h]:mm'  );
			$exporterConf['footprint'][$rowCurr] = 
				array(	'type' => 'AS_FORMULA',
						'formula' => "SUM(%COL%%INIT_ROW%:%COL%%END_ROW%)",
						'custom' => '[h]:mm'  );
		}
		$exporterConf['footprint2'][1] = 
				array(	'type' => 'AS_TEXT',
						'text' => "Total" );
		$exporterConf['footprint2'][2] = 
				array(	'type' => 'AS_FORMULA',
						'formula' => "SUM(A%END_ROW+1%:%LAST_COL%%END_ROW+1%)",
						'custom' => '[h]:mm'  );
		$this->addExporterConf( $name, $exporterConf );
	}
	
	function getConceptNamesDesc() {
        $db = Connection::_getWriterConnection();
		$authC = BaseCore::formatAuthWhere("c",array("BranchOffice"));
        $select = <<<QU
			SELECT name, description 
            FROM ilg_concept c
            WHERE $authC
				AND c.status_id = '1' 
				AND c.affects_payroll = "T" 
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
        return $arrayConNames;
    }
 
    function getConceptNames() {
        $db = Connection::_getWriterConnection();
        $authC = BaseCore::formatAuthWhere("c",array("BranchOffice"));
        $select = <<<QU
			SELECT name 
            FROM ilg_concept c
            WHERE $authC 
				AND status_id = '1' 
				AND c.affects_payroll = "T" 
			ORDER BY `report_order` asc
QU;
        if ($GLOBALS['logQueries']) {
            JLog::add( "PayEmplReportDate " . $select ,JLog::DEBUG, "cloudtime" );
        }
        $statement = $db->prepare($select);
        $statement->execute();
		$err = $db->errorInfo();
		if ($err[2]) {
			JLog::add(__FUNCTION__ . " " . implode(":", $err), JLog::ERROR, "sorcore");
		}
		$err = $statement->errorInfo();
		if ($err[2]) {
			JLog::add(__FUNCTION__ . " " . implode(":", $err), JLog::ERROR, "sorcore");
		}			
        $arrayConNames = $statement->fetchAll(PDO::FETCH_COLUMN,0);
        return $arrayConNames;
    }
	
}
