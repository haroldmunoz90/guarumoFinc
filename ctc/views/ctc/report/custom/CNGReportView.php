<?php

class CNGReportView extends BaseView {

    function __construct( ) {

        $this->assignType("id", "id", BaseView::HIDDEN);
		
		$this->assignType("start_time", JText::_("COM_SORCORE_DATE"), BaseView::DATE, 
				array( "dateFormatPHP" => "Y-m-d" ));
		
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
		/*
		$this->assignType("cost_center_id_ALIAS_1", JText::_("COM_CTC_COST_CENTER"), BaseView::ENTITY, array(
			BaseView::ENT_CLASS => "CostCenter",
			BaseView::ENT_FIELD => array("code"),
			BaseView::ENT_FILTER => $filter));*/

        $this->assignType("person_id_ALIAS_3", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::ENT_FILTER => $filter));
				
        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name", "identification"),
            BaseView::ENT_FILTER => $filter,
			BaseView::ENT_FIELD_DEL => " ",
            BaseView::FUNC_JS => "goPerson"));

		/// table fields
		$this->assignType("dateti", JText::_("COM_SORCORE_DATE"), BaseView::DATE );
		$this->assignType("mintime", JText::_("COM_CTC_REP_FIRST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_FIRST_DESC") ));
		$this->assignType("maxtime", JText::_("COM_CTC_REP_LAST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_LAST_DESC") ));
		

		$arrayConNames = $this->getConceptNamesDesc();
		$concArr = array();
        foreach($arrayConNames as $value){
            $this->assignType($value["name"], $value["name"], BaseView::STRING, array(
				BaseView::TOOLTIP => $value["description"] ));			
			$concArr[] = $value["name"];
        }
		
		/// Views
		
        $this->addView("formReport", array("start_time","authorized",
			"origin_type_id","person_id_ALIAS_1","person_id",
			"branch_office_id","area_id",
			"contract_type_id","cost_center_id",
			"status_id")); 		
        $this->addAction("formReport", "filter", JText::_("COM_CTC_UPDATE"), "save.png");
		$this->addAction("formReport", "clearf", JText::_("COM_CTC_CLEAR"), "remove.png");
			

		$tableRe = array( "person_id_ALIAS_2", "cost_center_id","dateti","mintime","maxtime", );
		$tableRe = array_merge($tableRe, $concArr);
        $this->addView("tableReport", $tableRe );
		
		$exporterConf = array(40, 15, 15, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
		$exporterConf['height'] = 20;
		$this->addExporterConf("tableReport", $exporterConf);
		
    }
	
	function getConceptNamesDesc() {
        $db = Connection::_getWriterConnection();
		$authC = BaseCore::formatAuthWhere("c",array("BranchOffice"));
		$notType = Concept::TYPE_CONCEPT;
        $select = <<<QU
			SELECT name, description 
            FROM ilg_concept c
            WHERE $authC
				AND c.status_id = '1' 
				AND c.type = {$notType}
				AND c.name like "HE%" 
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
		$notType = Concept::TYPE_CONCEPT;
        $select = <<<QU
			SELECT name 
            FROM ilg_concept c
            WHERE $authC 
				AND status_id = '1' 
				AND c.type = {$notType}
				AND c.name like "HE%" 
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
