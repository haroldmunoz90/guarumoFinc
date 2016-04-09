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
$sql = $mysql->query("SELECT audio FROM numeration_plan WHERE number = '" . $dnis . "'");
$result = $mysql->f_obj($sql);
if ($result) {
	echo $result->audio;
} else {
	echo "NOK";
}