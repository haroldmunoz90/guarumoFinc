<?php

class tlgRepView extends BaseView {

    function __construct() {

        // ------------------- MARCACIONES HORA --------------
        $this->assignType("totalname", "Empleado", BaseView::STRING);
        $this->assignType("atTime", "Tiempo", BaseView::STRING);
        $this->assignType("attendanceType", "Tipo de marcación", BaseView::STRING);
        $hourAttendence = array("totalname", "atTime", "attendanceType");
        $this->addView("hourAttendence", $hourAttendence);


        // ------------------- TIEMPO ACUMULADO DE MARCACIONES --------------
        $this->assignType("totalname", "Empleado", BaseView::STRING);
        $this->assignType("elapsedTime", "Tiempo (horas)", BaseView::TIME);
        $accumulatedAttendence = array("totalname", "elapsedTime");
        $this->addView("accumulatedAttendence", $accumulatedAttendence);


        //-------------------EMPLEADOS SIN MARCACIONES--------------
        $this->assignType("person_id", "Empleado", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::FUNC_JS => "goPerson"));

        $this->assignType("person_id_ALIAS_1", "Identificación", BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification")));

        $this->assignType("adate", "Fecha", BaseView::DATE);
        $this->assignType("GC_NOVEDADES0", "Novedades", BaseView::STRING);

        $tabledatenotatt = array("person_id", "person_id_ALIAS_1", "adate", "GC_NOVEDADES0");
        $this->addView("tabledatenotatt", $tabledatenotatt);



        //-------------------- PRENOMINA --------------------


        $this->assignType("person_id_ALIAS_3", JText::_("COM_CTC_IDENFIFICATION"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("identification"),
            BaseView::ENT_FIELD_DEL => " "));

        $this->assignType("person_id_ALIAS_2", JText::_("COM_CTC_EMPLOYEE"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person",
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::ENT_FIELD_DEL => " ",
            BaseView::FUNC_JS => "goPerson"));

        $concType = BaseView::TIME;

        $arrayConNames = $this->getConceptNamesDesc();
        $concArr = array();
        foreach ($arrayConNames as $value) {
            $this->assignType($value["name"], $value["name"], $concType, array(
                BaseView::TOOLTIP => $value["description"]));
            $concArr[] = $value["name"];
        }

        $this->assignType("date_arr", JText::_("COM_SORCORE_DATE"), BaseView::DATE);
        $this->assignType("time_arr", "Ingreso", BaseView::STRING);
        $this->assignType("time_left", JText::_("COM_CTC_DEPART"), BaseView::STRING);
        $this->assignType("worked_hours", "Totales", $concType);


        $tableRe4 = array();
        $format4 = array(3 => array('type' => 'AS_DATE', 'date_format' => 'NUMFORMAT_DATE'),
            6 => array('type' => 'AS_DATE', 'custom' => '[h]:mm')
        );



        $exporterConf4 = array(15, 40, 10, 10, 10, 8);
        $this->addViewConcepts("tableper", $tableRe4, $concArr, $exporterConf4, array(), $format4);



//------------  daily Attendance  view
        $user = $this->getLoggedUser();
        if ( $user->getNumAuthBranchOff() != 1 ||
			$user->hasPermission("assign-branch") ) {
            
        }
        
        $this->assignType("parent_branch_office_id", "Sucursal", BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "BranchOffice",
                BaseView::ENT_FILTER => null));

        $this->assignType("id_ALIAS_1", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => JText::_("COM_CTC_AREA"),
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => array("name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goListPersonByArea"));
        $this->assignType("TotalInside", "Empleados en sitio", BaseView::STRING);
        $this->assignType("nEmployees", "Total Empleados", BaseView::STRING);
        $this->addView("tableDailyAtt", array("parent_branch_office_id", "id_ALIAS_1", "TotalInside", "nEmployees"));
    }

    function getConceptNamesDesc() {
        $authC = BaseCore::formatAuthWhere("c", array("BranchOffice"));
        $varSessName = "ConceptNamesDesc" . preg_replace('/\s+/', '', $authC);
        $arrayConNames = BaseCore::getSeVaExp($varSessName, BaseCore::ONE_DAY_IN_MILLIS);
        if ($arrayConNames !== null && count($arrayConNames) > 0) {
            //return $arrayConNames;
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
            JLog::add("PayEmplReportDate " . $select, JLog::DEBUG, "cloudtime");
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
        $_SESSION[$varSessName] = $arrayConNames;
        return $arrayConNames;
    }

    function addViewConcepts($name, $tableRe, $concArr, $exporterConf, $right = array(), $format = array()) {
        $initRow = count($exporterConf);
        $exporterConf['height'] = 20;
        $exporterConf['format'] = $format;
        for ($i = 0; $i < count($concArr); $i++) {
            $rowCurr = $initRow + $i + 1;
            $exporterConf[$rowCurr] = 6;
            $exporterConf['format'][$rowCurr] = array('type' => 'AS_DATE', 'custom' => '[h]:mm');
        }
        $tableRe = array_merge($tableRe, $concArr);
        $tableRe = array_merge($tableRe, $right);
        $this->addView($name, $tableRe);
        $this->addExporterConf($name, $exporterConf);
    }

}

?>