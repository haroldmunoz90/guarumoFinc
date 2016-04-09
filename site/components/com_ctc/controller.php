<?php

// Previene el acceso directo al archivo
defined('_JEXEC') or die('Restricted access');

// Importa los componentes de Soran
jimport('soran.config.config');
include_once $GLOBALS['path_to_sorcore'].'components/SoranController.php';
//jimport('soran.components.core.SoranForm');
//jimport('soran.components.core.SoranAccordion');
//jimport('soran.components.core.SoranTabs');
//jimport('soran.components.core.SoranCustom');
//jimport('soran.components.core.SoranDatatable');

// BI Espacio reservado para los imports de generaciones posteriores
// NO QUITAR

// EI
$debug = $GLOBALS['debugging'];
if( $debug ) {
	$req = $_REQUEST;
	if( array_key_exists("password", $_REQUEST) ) {		
		unset ( $req["password"] );
	}
	$results = print_r($req, true);
	JLog::add("CTC http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]\n" . $results  ,JLog::DEBUG, "cloudtime" );
}

class ctcController extends SoranController {
	
	function postload_page() {
		parent::postload_page();
		$enterprise = BaseCore::getLoggedEnterprise();
		$lrt = strtotime($enterprise->expiration_date);
		$nt = time();
		$datediff = $lrt - $nt;
		$nm = floor($datediff / (60 * 60 * 24));
		$days = $enterprise->days_to_message;
		if( !$days ) {
			$days = 8;
		}		
		if ( $nm <= $days ) {
			$message = $enterprise->expiration_message;
			if( !$message ) {
				$message = "Restan %DAYS% días para que expire su subscripción.";
			}
			$message = str_replace("%DAYS%", $nm , $message );
				
			$postload = <<<PAGE
				<script type='text/javascript'>
				$(window).load(function() {
					$.jnotify("$message", 10000);
				});
				</script>
PAGE;
		}
		echo $postload;
	}

	protected function _getUser($user)
	{
		$instance = JUser::getInstance();
		$id = (int) JUserHelper::getUserId($user);
			
		if ($id)
		{
			$instance->load($id);
			return $instance;
		}
	}

	function login_ctc() {
		$loginUser = $_GET["user"];
		$loginPass = $_GET["pass"];
		error_log("HLBM:login:" . $loginUser . " PASSW:" . $loginPass );
		$instance = $this->_getUser($loginUser);
		// If _getUser returned an error, then pass it back.
		if ( !$instance  || $instance instanceof Exception)
		{
			$resultCode = 1;
			$resultMsg = "Login no valido";
			error_log("HLBM:login:Exception" );
		} else
		// If the user is blocked, redirect with an error
		if ($instance->get('block') == 1)
		{
			$resultCode = 1;
			$resultMsg = "Login no valido";
			error_log("HLBM:login:block" );
		} else {
			
			// Register the needed session variables
			$session = JFactory::getSession();
			$session->set('user', $instance);
			
			//error_log("HLBM:login:" . $loginUser . " PASS:" . $loginPass );		
			
			$db = & JFactory::getDBO();
			$query = 'SELECT `id`, `password`'
					. ' FROM `#__users`'
					. ' WHERE username=' . $db->Quote($loginUser)
			;
			$db->setQuery($query);
			$result = $db->loadObject();

			if ($result) {
				$parts = explode(':', $result->password);
				$crypt = $parts[0];
				$salt = @$parts[1];
				$testcrypt = JUserHelper::getCryptedPassword($loginPass, $salt);

				if ($crypt == $testcrypt) {
					$resultCode = 0;
					$resultMsg = "Login Exitoso. Equipo Registrado";
				} else {
					$resultCode = 1;
					$resultMsg = "Login no valido";
				}
			} else {
				$resultCode = 1;
				$resultMsg = "Login no valido";
			}
			
		}
		$result = array("code"=>$resultCode, "msg"=>$resultMsg);
		print_r(json_encode($result));	
	}
	
	protected function insertRowWithArea( &$array , $areadId, $label , $value )
	{
		$this->insertRowWithLabels( $array, 'areaId', $areadId , $label , $value);
	}
	
	protected function insertRowWithDate( &$array , $date, $label , $value )
	{
		$this->insertRowWithLabels( $array, 'date', $date , $label , $value);
	}
	
	protected function insertRowWithLabels( &$array , $label0, $value0, $label , $value )
	{
		$row_array1 = array();
		$row_array1[$label0] = $value0;
		$this->insertRowFilled( $array, $row_array1, $label , $value);
	}
	
	protected function insertRow( &$array , $label , $value )
	{
		$row_array1 = array();
		$this->insertRowFilled( $array,$row_array1, $label , $value);
	}
	
	protected function insertRowFilled( &$array , &$arrayfilled, $label , $value )
	{
		$arrayfilled['label'] = $label;
		$arrayfilled['value'] = $value;
		array_push($array,$arrayfilled);
	}		
			
	function saveGcm() {
		$gcmKey = $_GET["gcmKey"];
	
		$user = JFactory::getUser();		
		error_log("user:" . $user);
		if (!$user->enterprise_id) {			
			$result = array("code"=>-1, "msg"=>"Error");
			print_r(json_encode($result));	
			return;
		} else {
			$enterprise_id = $user->enterprise_id;
			error_log("HLBM:saveGcm:logged:" . $user->name . " enterprise_id:" . $enterprise_id .
				" \ngcmKey:".$gcmKey	);
		}
		$user = BaseCore::getLoggedUser();
		$user->google_key = $gcmKey;
		$user->store();
		
		$notification = new Notification();
		$filter = new Filter();
		$filter->eq_("owner_user_id", BaseCore::getLoggedUser()->id )->and_()->
				eq_("media_type", "ANDROID");
		$fobjs = $notification->getAll($filter);
		
		foreach ($fobjs as $fobj) {
			error_log("HLBM:notify:Update:" . $fobj );
			$fobj->rule_data = $gcmKey;
			$fobj->store(false);
		}
		
		//actualizar la tabla en el servidor
		$resultCode = 0;
		$resultMsg = "OK";
		
		
		$result = array();
		$result = array("code"=>$resultCode, "msg"=>$resultMsg);
		print_r(json_encode($result));
	}
	
	function notifyTypes() {
		$result = array(
            "FIRST" => "En la Primera Entrada de la empresa",
			"FIRST_AREA" => "En la Primera Entrada del área",
			//"FIRST_SHIFT" => "En la Primera Entrada del turno",
			"LAST" => "En la última Salida de la empresa",
			"LAST_AREA" => "En la última Salida del área",
			//"LAST_SHIFT" => "En la última Salida del turno",
			"PERSON_INOUT" => "Cuando ocurra una marcación de la persona",
            "PERSON" => "Cuando ingrese la persona",			
			"PERSON_INONTIME" => "Cuando ingrese a tiempo la persona",
			"PERSON_INEARLY" => "Cuando ingrese temprano la persona",
			"PERSON_INLATE" => "Cuando ingrese tarde la persona",
			"PERSON_OUT" => "Cuando salga la persona",
			"PERSON_OUTONTIME" => "Cuando salga a tiempo la persona",
			"PERSON_OUTEARLY" => "Cuando salga temprano la persona",
			"PERSON_OUTLATE" => "Cuando salga tarde la persona"
            );
		
		print_r(json_encode($result));
	}
	
	function notify() {
		$employeeId = $_GET["employeeId"];
		$notify = $_GET["notify"];// true/false
		$resultCode = 0;
		$resultMsg = 'OK';
		$user = JFactory::getUser();		
		error_log("user:" . $user);
		if (!$user->enterprise_id) {			
			$result = array("code"=>-1, "msg"=>"Error");
			print_r(json_encode($result));	
			return;
		} else {
			$enterprise_id = $user->enterprise_id;
			error_log("HLBM:notify:logged:" . $user->name . " enterprise_id:" . $enterprise_id .
				" \nnotify:".$notify . " employeeId:". $employeeId .
				" userId:" . BaseCore::getLoggedUser()->id );
		}
		$notification = new Notification();
		$filter = new Filter();
		$filter->eq_("owner_user_id", BaseCore::getLoggedUser()->id )->and_()->
				eq_("rule_person_id", $employeeId )->and_()->
				eq_("media_type", "ANDROID" );
		$fobjs = $notification->getAll($filter);
		error_log("HLBM:notify:Count " . count( $fobjs ) );
		if( strcasecmp($notify, 'true') == 0 ) {
			if( count( $fobjs ) == 0 ) {				
				$notification->name = BaseCore::getLoggedUser()->name;
				$notification->rule_name = "PERSON";
				$notification->rule_data = BaseCore::getLoggedUser()->google_key;
				$notification->status_id = 1;
				$notification->period_id = 1;
				$fecha = new DateTime();
				$notification->start_date = $fecha->format('Y-m-d H:i:s');//'now()';
				$notification->owner_user_id = BaseCore::getLoggedUser()->id;
				$notification->rule_person_id = $employeeId;
				$notification->media_type = "ANDROID";
				$notification->store();
			}
		} else {
			foreach ($fobjs as $fobj) {
				error_log("HLBM:notify:Delete:" . $fobj );
				$fobj->delete();
			}
		}
		
		
		$result = array( "code"=>$resultCode, "msg"=>$resultMsg, "employeeId"=>$employeeId );
		print_r(json_encode($result));
	}
	
	protected function isUpdatedTable( $tableName, $enterprise_id, $dataVersion, &$timestamp ) {
		$db = & JFactory::getDBO();		
		$fecha = new DateTime();
		$fecha->setTimestamp($dataVersion);//"1383518712");
		$sFecha = $fecha->format('Y-m-d H:i:s');
		$query = "SELECT modified_date ".
					" FROM ilg_table_modified tm ".
					" WHERE tm.enterprise_id = $enterprise_id".
					" AND tm.table_name =  '$tableName' ".
					" AND tm.modified_date > '$sFecha' order by tm.modified_date desc"
		;
		//error_log("isUpdatedTable query:\n" . $query);
		$db->setQuery($query);
		$result2 = $db->loadRowList();
		foreach ($result2 as $row) {
			$date = new DateTime($row['0']);	
			$timestamp = $date->getTimestamp();		
			error_log("table:". $tableName . " getTimestamp:".$timestamp . " date:" . $row['0'] );
			return true;
		}		
		return false;		
	}
	
	protected function getReportAREA( $enterprise_id, $dataVersion  ) {	
		$result = array();
		$return_arr = array();
		$row_array = array();
		
		$db = & JFactory::getDBO();

		$query = "SELECT ar.id AS id, ar.name AS name,    ".
					" (       SELECT COUNT( * )          ".
					" 		FROM ilg_person       ".
					" 		WHERE area_id = ar.id  ".
					" ) AS nEmployees , ".
					" (   SELECT   count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end )      ".
					" 		FROM ilg_attendance AS t1      ".
					" 		LEFT OUTER JOIN ilg_attendance AS t2 ON   t1.person_id = t2.person_id     ".
					" 			AND (    t1.time < t2.time       ".
					" 			OR (     t1.time = t2.time ".
					" 					AND t1.Id < t2.Id ".
					" 			) ".
					" 		), ilg_person p      ".
					" 	WHERE t2.person_id IS NULL       ".
					" 	AND t1.person_id = p.id      ".
					" 	AND p.area_id = ar.id     ".
					" 	AND t1.enterprise_id = $enterprise_id      ".
					" 	AND DATE(t1.time) >= DATE(NOW()  - INTERVAL 1 DAY)      ".
					" ) as TotalInside    ".
					" FROM ilg_area ar    ".
					" WHERE ar.enterprise_id = $enterprise_id    ";
		
		
		
		error_log("getReportAREA query:\n" . $query);

		$db->setQuery($query);
		$result = $db->loadRowList();
		$resFormatAREA = array();
		foreach ($result as $row) {
			//print_r(  $row );
			$row_array['id'] = $row['0'];
			$row_array['name'] = $row['1'];
			$row_array['nEmployees'] = $row['2'];
			$row_array['attendees'] = $row['3'];
			array_push($resFormatAREA,$row_array);
		}
		return $resFormatAREA;
	}
	
	function getReportCRDAY( $enterprise_id, $dataVersion  ) {
		$db = & JFactory::getDBO();	
		$query = "SELECT count(*) as Total, ".		
					" ( ".
					" SELECT  ".
					" count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end ) as INSIDE ".
					" FROM ilg_attendance AS t1  ".
					" LEFT OUTER JOIN ilg_attendance AS t2 ON  ".
					" t1.person_id = t2.person_id ".
					" AND ( ".
					" 	t1.time < t2.time ".
					" 	OR ( ".
					" 		t1.time = t2.time ".
					" 		AND t1.Id < t2.Id ".
					" 	) ".
					" ) ".
					" WHERE t2.person_id IS NULL  ".
					" AND t1.enterprise_id = $enterprise_id ".
					" AND DATE(t1.time) >= DATE(NOW()  - INTERVAL 1 DAY) 		 ".
					" ) ,".
					" SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, ".
					" SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano,".
					" SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, ".
					" SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, ".
					" SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,".
					" SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde ".
					" FROM ilg_attendance at, ilg_device dev".
					" WHERE dev.id = at.device_id".
					" AND dev.enterprise_id = $enterprise_id".
					" AND DATE( at.time ) = DATE( NOW() ) ".
					" GROUP BY DATE(at.time)"
		;
		$db->setQuery($query);
		$result2 = $db->loadRowList();
		$resFormatCRDAY = array();
		$row_array2 = array();
		foreach ($result2 as $row2) {
			//print_r(  $row2 );
			$this->insertRow($resFormatCRDAY,"Total Marcaciones", $row2['0']);	
			$this->insertRow($resFormatCRDAY,"Total En Sitio", $row2['1']);			
			$this->insertRow($resFormatCRDAY,'LLegadas a tiempo', $row2['2']);
			$this->insertRow($resFormatCRDAY,'LLegadas Temprano', $row2['3']);
			$this->insertRow($resFormatCRDAY,'LLegadas Tarde', $row2['4']);
			$this->insertRow($resFormatCRDAY,'Salidas a tiempo', $row2['5']);
			$this->insertRow($resFormatCRDAY,'Salidas Temprano', $row2['6']);
			$this->insertRow($resFormatCRDAY,'Salidas Tarde', $row2['7']);
		}
		return $resFormatCRDAY;
	}
	
	function getReportCRMONTH( $enterprise_id, $dataVersion ) {
		$db = & JFactory::getDBO();		
		$query = "SELECT DATE_FORMAT(at.time,'%Y-%m') as Fecha, count(*) as Total, ".
					" SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 0 then 1 else 0 end ) as EATiempo, ".
					" SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 0 then 1 else 0 end ) as ETemprano, ".
					" SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 0 then 1 else 0 end ) as ETarde, ".
					" SUM( case when at.attendance_type_id = 0 and at.attendance_status_id = 1 then 1 else 0 end ) as SATiempo, ".
					" SUM( case when at.attendance_type_id = 1 and at.attendance_status_id = 1 then 1 else 0 end ) as STemprano,".
					" SUM( case when at.attendance_type_id = 2 and at.attendance_status_id = 1 then 1 else 0 end ) as STarde ".
					" FROM ilg_attendance at, ilg_device dev".
					" WHERE dev.id = at.device_id".
					" AND dev.enterprise_id =  $enterprise_id".
					" GROUP BY DATE_FORMAT(at.time,'%Y-%m')"
		;		
		$db->setQuery($query);
		$result2 = $db->loadRowList();
		$resFormatCRMONTH = array();
		$row_array2 = array();
		foreach ($result2 as $row2) {
			//print_r(  $row2 );
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],"Total Marcaciones", $row2['1'] );			
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'LLegadas a tiempo', $row2['2']);
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'LLegadas Temprano', $row2['3']);
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'LLegadas Tarde', $row2['4']);
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'Salidas a tiempo', $row2['5']);
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'Salidas Temprano', $row2['6']);
			$this->insertRowWithDate($resFormatCRMONTH,$row2['0'],'Salidas Tarde', $row2['7']);
		}
		return $resFormatCRMONTH;
	}
	
	function getReportARDAY ( $enterprise_id, $dataVersion ) {
		$db = & JFactory::getDBO();	

		$query = " SELECT  ".
					"  ia.area_id , ( ".
					" 	SELECT ".
					" 	count( case when `t1`.`attendance_status_id` = 0 then `t1`.`attendance_status_id` end ) ".
					" 	FROM ilg_attendance AS t1 ".
					" 	LEFT OUTER JOIN ilg_attendance AS t2 ON ".
					" 	t1.person_id = t2.person_id".
					" 	AND ( ".
					" 		t1.time < t2.time ".
					" 	), ilg_person p ".
					" 	WHERE t2.person_id IS NULL  ".
					" 	AND t1.person_id = p.id ".
					" 	AND p.area_id = ia.area_id  ".
					" 	AND t1.enterprise_id = $enterprise_id ".
					" 	AND DATE(t1.time) >= DATE(NOW()  - INTERVAL 1 DAY)  ".
					" 	 )	as TotalInside ,  ".
					"  sum(`in_on_time`)  as EATiempo,  ".
					"  sum(`in_early`) as ETemprano,  ".
					"  sum(`in_late`) as ETarde,  ".
					"  sum(`out_on_time`) as SATiempo,  ".
					"  sum(`out_early`) as STemprano,  ".
					"  sum(`out_late`) as STarde  ".
					"  FROM `ilg_interval_attendance`  ia ".
					"  WHERE   ".
					"  enterprise_id =  $enterprise_id ".
					"  AND DATE( `interval_started` ) = DATE( NOW() )  ".
					"  group by ia.area_id " ; 
		
		$db->setQuery($query);
		$result2 = $db->loadRowList();
		$resFormatARDAY = array();
		$row_array2 = array();
		foreach ($result2 as $row2) {
			//print_r(  $row2 );			
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],"Total En Sitio", $row2['1'] );			
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'LLegadas a tiempo', $row2['2']);
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'LLegadas Temprano', $row2['3']);
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'LLegadas Tarde', $row2['4']);
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'Salidas a tiempo', $row2['5']);
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'Salidas Temprano', $row2['6']);
			$this->insertRowWithArea($resFormatARDAY,$row2['0'],'Salidas Tarde', $row2['7']);
		}
		return $resFormatARDAY;
	}
	
	function getReportATT($enterprise_id, $dataVersion, &$timestamp) {
		$db = & JFactory::getDBO();		
		$fecha = new DateTime();
		$fecha->setTimestamp($dataVersion);//"1383518712");
		$sFecha = $fecha->format('Y-m-d H:i:s');

		//solo envia los que estan adentro
		$query = "SELECT  ".
					" t1.id as id, ar.id as areaId,  ".
					" CONCAT( IFNULL(pe.name,''),  ' ', IFNULL(pe.last_name,'') ) as name , ".
 					" t1.time as date,   ".
					" case          when  t1.attendance_type_id = 0 and t1.attendance_status_id = 0 then 'Entrada a Tiempo'          ".
					" when  t1.attendance_type_id = 1 and t1.attendance_status_id = 0 then 'Entrada Temprano'                 ".
					" when  t1.attendance_type_id = 2 and t1.attendance_status_id = 0 then 'Entrada Tarde'                 ".
					" when  t1.attendance_type_id = 0 and t1.attendance_status_id = 1 then 'Salida a Tiempo'               ".
					" when  t1.attendance_type_id = 1 and t1.attendance_status_id = 1 then 'Salida a Temprano'                ". 
					" when  t1.attendance_type_id = 2 and t1.attendance_status_id = 1 then 'Salida Tarde'                  ".
					" else ''     end as type  ".
					" FROM ilg_attendance AS t1  ".
					" LEFT OUTER JOIN ilg_attendance AS t2 ON  ".
					" t1.person_id = t2.person_id ".
					" AND ( ".
					" 	t1.time < t2.time ".
					" 	OR ( ".
					" 		t1.time = t2.time ".
					" 		AND t1.Id < t2.Id ".
					" 	) ".
					" ), ilg_area ar, ilg_person pe  ".
					" WHERE t2.person_id IS NULL  ".
					" AND t1.person_id = pe.id ".
					" AND `t1`.`attendance_status_id` = 0 ".
					" AND ar.id = pe.area_id ".
					" AND t1.enterprise_id = $enterprise_id ".
					" AND DATE(t1.time) >= DATE(NOW()  - INTERVAL 1 DAY)  ".
					" order by t1.time asc ";

					//" AND t1.time > '$sFecha'  ".
		//error_log("getReportATT:query:" . $query);
		$db->setQuery($query);
		$result2 = $db->loadRowList();
		$row_array = array();
		$resFormatATT = array();
		if( count( $result2 ) == 0 ) {
			return $resFormatATT;
		}
		foreach ($result2 as $row) {
			//print_r(  $row );
			$row_array['id'] = $row['0'];
			$row_array['areaId'] = $row['1'];
			$row_array['name'] = $row['2'];
			$row_array['date'] = $row['3'];
			$row_array['type'] = $row['4'];
			array_push($resFormatATT,$row_array);
		}
		$date = new DateTime($row['3']);	
		//$timestamp = $date->getTimestamp();		
		error_log("getTimestampATT:".$timestamp . " date:" . $row['3'] );
		return $resFormatATT;
	}
	
	function getReportEMP($enterprise_id, $dataVersion) {
		$db = & JFactory::getDBO();			
		$result = array();
		$row_array = array();
		$owner_user_id = BaseCore::getLoggedUser()->id;

		$query = "SELECT pe.id id, CONCAT( IFNULL(pe.name,''),  ' ', IFNULL(pe.last_name,'') ) as name, 'true' as notify".
					" FROM   ilg_person pe".
					" WHERE pe.enterprise_id = $enterprise_id".
					" AND pe.id in (".
					" select rule_person_id from ilg_notification where media_type = 'ANDROID' and owner_user_id = $owner_user_id   ".
					" )".
					" union".
					" SELECT pe.id id, CONCAT( IFNULL(pe.name,''),  ' ', IFNULL(pe.last_name,'') ) as name, 'false' as notify".
					" FROM   ilg_person pe".
					" WHERE pe.enterprise_id = $enterprise_id".
					" AND pe.id not in (".
					" select rule_person_id from ilg_notification where media_type = 'ANDROID' and owner_user_id = $owner_user_id ".
					" )";	
		
		//error_log("getReportEMP:query:" . $query);

		$db->setQuery($query);
		$result = $db->loadRowList();
		$resFormatEMP = array();
		foreach ($result as $row) {
			//print_r(  $row );
			$row_array['id'] = $row['0'];
//			$row_array['areaId'] = $row['1'];
			$row_array['name'] = $row['1'];
			$row_array['notify'] = $row['2'];
			array_push($resFormatEMP,$row_array);
		}
		return $resFormatEMP;
	}
	
	function data() {
		$dataVersion = $_GET["dv"];		
		if (!$dataVersion ) {	
			$dataVersion = 0;
		} else {
			$dataVersion = trim($dataVersion);
			if($dataVersion == '') {
				$dataVersion = 0;
			}
		}
		$resFormatAREA = array();
		$resFormatEMP = array();
		$resFormatARDAY = array();
		$resFormatCRDAY = array();
		$resFormatCRMONTH = array();
		$dataVersion = (int)$dataVersion;
		$timestamp = (int)$dataVersion;
		$enterprise_id = 2;
		$user = JFactory::getUser();		
		error_log("user:" . $user);
		if (!$user->enterprise_id) {			
			$result = array("code"=>-1, "msg"=>"Error.  Login Again.");
			print_r(json_encode($result));	
			return;
		} else {
			$enterprise_id = $user->enterprise_id;
			error_log("HLBM:data:logged:" . $user->name . " enterprise_id:" . $enterprise_id .
				" \ndataVersion:".$dataVersion	);
		}

		if( $this->isUpdatedTable( 'ilg_area',$enterprise_id, $dataVersion, $timestampAREA  ) ) {
			$resFormatAREA = $this->getReportAREA( $enterprise_id, $dataVersion );
		}
		if( $this->isUpdatedTable( 'ilg_person',$enterprise_id, $dataVersion, $timestampEMP  ) ) {
			$resFormatEMP = $this->getReportEMP( $enterprise_id, $dataVersion );
		}
		if( $this->isUpdatedTable( 'ilg_attendance',$enterprise_id, $dataVersion, $timestamp  ) ) {		
			$resFormatATT = $this->getReportATT( $enterprise_id, $dataVersion, $timestamp );
		}
		
		error_log("HLBM:data:timestampAREA:" . $timestampAREA . " timestampEMP:" . $timestampEMP .
				" timestampATT:".$timestamp	);
		if( $timestampAREA > $timestampEMP && $timestampAREA > $timestamp ) {
			error_log("HLBM:data:timestampAREA:" . $timestampAREA	);
			$timestamp = $timestampAREA;
		} else if ( $timestampEMP > $timestampAREA && $timestampEMP > $timestamp ) {
			error_log("HLBM:data:timestampEMP:" . $timestampEMP	);
			$timestamp = $timestampEMP;
		}
		
		if( count( $resFormatATT ) > 0 ) {
			if( count( $resFormatAREA ) == 0 ) {
				$resFormatAREA = $this->getReportAREA( $enterprise_id, $dataVersion );
			}
			$resFormatARDAY	 = 	$this->getReportARDAY( $enterprise_id, $dataVersion );
			$resFormatCRDAY	 = 	$this->getReportCRDAY( $enterprise_id, $dataVersion );
			$resFormatCRMONTH	 = 	$this->getReportCRMONTH( $enterprise_id, $dataVersion );
			$return_arr["aattendance"] = $resFormatATT;
			if( count( $resFormatARDAY ) > 0 ) {
				$return_arr["arday"] = $resFormatARDAY;	
			}
			if( count( $resFormatCRMONTH ) > 0 ) {
				$return_arr["crmonth"] = $resFormatCRMONTH;	
			}
			if( count( $resFormatCRDAY ) > 0 ) {
				$return_arr["crday"] = $resFormatCRDAY;
			}
		}
		if( count( $resFormatAREA ) > 0 ) {
			$return_arr["area"] = $resFormatAREA;
		}
		if( count( $resFormatEMP ) > 0 ) {
			$return_arr["employee"] = $resFormatEMP;
		}
		$return_arr["dv"] = $timestamp;
		print_r(json_encode($return_arr));
		//error_log("HLBM:data:return:\n" . json_encode($return_arr) );
		return;
	
	}
    
}

?>

