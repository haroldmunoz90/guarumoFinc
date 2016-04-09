<?php

include("../libraries/soran/config/config.php");
include("../libraries/soran/utils/mysql.php");
require('../libraries/smarty/libs/Smarty.class.php');

$smarty = new Smarty;
$smarty->template_dir = '/opt/xtek/smarty/asterisk/templates/';
$smarty->compile_dir = '/opt/xtek/smarty/asterisk/templates_c/';
$smarty->config_dir = '/opt/xtek/smarty/asterisk/configs/';
$smarty->cache_dir = '/opt/xtek/smarty/asterisk/cache/';

$pathAsterisk = "/etc/asterisk/";
$pathAsterisk = "/usr/local/etc/asterisk/";  // MAC

$mysql = new mysql;
$mysql->server = $host;
$mysql->user = $user;
$mysql->pass = $pass;
$mysql->connect();
$mysql->select($dbname);

$extensions = Array();
$sql = $mysql->query("SELECT number FROM extensions");
while ($extension = $mysql->f_array($sql)) {
	$extensions[] = $extension["number"];
}

$smarty->assign('assign', '=>');
$smarty->assign('extensions', $extensions);
$sip = $smarty->fetch('sip.tpl');

$fp = fopen($pathAsterisk . 'sip.conf.test', 'w');
fwrite($fp, $sip);
fclose($fp);

$numbers = Array();
$sql = $mysql->query("SELECT number FROM numeration_plan");
while ($number = $mysql->f_array($sql)) {
	$numbers[] = $number["number"];
}

$smarty->assign('numbers', $numbers);
$smarty->assign('ampersand', '&');
$smarty->assign('question', '?');
$extensions = $smarty->fetch('extensions.tpl');
$extensions = str_replace ("_x1", "\${", $extensions);
$extensions = str_replace ("_x2", "}", $extensions);

$fp = fopen($pathAsterisk . 'extensions.conf.test', 'w');
fwrite($fp, $extensions);
fclose($fp);

$io = popen('/opt/xtek/shells/updatedialplan.sh', 'r');
$res = fgets($io, 4096);
pclose($io);
echo $res;
        
?>

