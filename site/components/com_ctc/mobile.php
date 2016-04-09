<?php

$service = $_GET["service"];

//sleep(3);

if($service == "login") {
	$loginUser = $_GET["user"];
	$loginPass = $_GET["pass"];
	
	$code = null;
	$msg = null;
	
	if($loginUser == "juan" && $loginPass == "soran") {
		$resultCode = 0;
		$resultMsg = "Login Exitoso. Equipo Registrado";
	} else {
		$resultCode = 1;
		$resultMsg = "Login no valido";
	}
	
	$result = array("code"=>$resultCode, "msg"=>$resultMsg);
	print_r(json_encode($result));	
} else if($service == "data") {
	$result = array();
	
	// AREA ----------------------------------------------------------------
	$dataVersion_area = $_GET["dv_area"];
	
	//consultar la version de datos en el servidor
	$dataVersion_area_server = 1;
	
	if($dataVersion_area != $dataVersion_area_server) {
		// consultar la informacion de areas, necesaria en la app movil
		$areas = array(
				array("id"=>1, "name"=>"Comercial", "attendees"=>rand(3, 10)),
				array("id"=>2, "name"=>"Desarrollo", "attendees"=>rand(3, 10)));
		$result["area"] = $areas;
	}
	$result["dv_area"] = $dataVersion_area_server;
	
	
	// COMPANY REPORT MONTH ------------------------------------------------
	$dataVersion_crday = $_GET["dv_crday"];
	
	//consultar la version de datos en el servidor
	$dataVersion_crday_server = 1;
	
	if($dataVersion_crday != $dataVersion_crday_server) {
		// consultar la informacion del reporte, necesario en la app movil
		$report = array(
				array("id"=>1, "areaId"=>1,"label"=>"LLegadas temprano", "value"=>rand(3, 20)),
				array("id"=>2, "areaId"=>1,"label"=>"LLegadas a tiempo", "value"=>rand(3, 20)),
				array("id"=>3, "areaId"=>1,"label"=>"LLegadas tarde", "value"=>rand(3, 20)));
		$result["crday"] = $report;
	} 	
	$result["dv_crday"] = $dataVersion_crday_server;
	
	// AREA REPORT DAY -----------------------------------------------------
	$dataVersion_arday = $_GET["dv_arday"];
	
	//consultar la version de datos en el servidor
	$dataVersion_arday_server = 1;
	
	if($dataVersion_arday != $dataVersion_arday_server) {
		// consultar la informacion del reporte, necesario en la app movil
		$report = array(
				array("id"=>1, "areaId"=>1, "label"=>"LLegadas temprano", "value"=>rand(3, 20)),
				array("id"=>2, "areaId"=>1, "label"=>"LLegadas a tiempo", "value"=>rand(3, 20)),
				array("id"=>3, "areaId"=>1, "label"=>"LLegadas tarde", "value"=>rand(3, 20)),
				array("id"=>4, "areaId"=>2, "label"=>"LLegadas temprano", "value"=>rand(3, 20)),
				array("id"=>5, "areaId"=>2, "label"=>"LLegadas a tiempo", "value"=>rand(3, 20)));
		$result["arday"] = $report;
	} 	
	$result["dv_arday"] = $dataVersion_arday_server;
	
	// AREA ATTENDANCE -----------------------------------------------------
	$dataVersion_aattendance = $_GET["dv_aattendance"];
	
	//consultar la version de datos en el servidor
	$dataVersion_aattendance_server = 1;
	
	if($dataVersion_aattendance != $dataVersion_aattendance_server) {
		// consultar la informacion del reporte, necesario en la app movil
		$report = array(
				array("id"=>1, "areaId"=>1, "name"=>"Radamel Falcao", "date"=>"2013-06-10 08:06:04", "type"=>"A tiempo"),
				array("id"=>2, "areaId"=>1, "name"=>"James Rodriguez", "date"=>"2013-06-10 08:14:04", "type"=>"Tarde"),
				array("id"=>3, "areaId"=>2, "name"=>"Nestor Pekerman", "date"=>"2013-06-10 07:47:04", "type"=>"Temprano"));
		$result["aattendance"] = $report;
	} 	
	$result["dv_aattendance"] = $dataVersion_arday_server;
	
	print_r(json_encode($result));	
}
?>