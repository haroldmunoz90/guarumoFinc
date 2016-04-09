<?php

include("../libraries/soran/config/config.php");
include("../libraries/soran/utils/mysql.php");

$mysql = new mysql;
$mysql->server = $host;
$mysql->user = $user;
$mysql->pass = $pass;
$mysql->connect();
$mysql->select($dbname);

$dnis = $_GET["dnis"];
$option = $_GET["option"];
$sql = $mysql->query("SELECT e.number AS number FROM numeration_plan np, extensions e WHERE np.number = '" . $dnis . "' AND e.option = " . $option . " AND np.id = e.id_np");
$result = $mysql->f_obj($sql);
if ($result) {
	echo $result->number;
} else {
	echo "NOK";
}


