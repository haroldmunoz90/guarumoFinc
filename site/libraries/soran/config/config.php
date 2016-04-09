<?php

$host = 'localhost';
//$hosts_reader = array( 'localhost' => 30, 'localhost' => 70 );
$dbname = 'ctc_srvtest';
$user = 'root';
$pass = 'dbpwd';

$db_connections = array(
  "con1" => array(
    'host' => "localhost",
    'dbname' => "ctc_srvtest",
    'user' => "root",
    'pass' => "dbpwd",
  ),
  "con2" => array(
    'host' => "localhost",
    'dbname' => "ctc_srvtest",
    'user' => "root",
    'pass' => "dbpwd",
  ),
);



$server_url = 'localhost';
$jboss_port = '8083';

$article404 = 27;
$articleChangePassword = 200;

$guvnor_server = 'localhost';
$guvnor_port = '8083';
$guvnor_user = 'admin';
$guvnor_pass = 'admin';

$PARTITION_DATE = '2015-03-01';

$debugindex = true;
$debugging = true;
$debugjs = true;
$logQueries = true;
$logMemory = true;
$import_repository = false;

$corename = "sorcore";

$path_to_www = "C:\\wamp\\www";
//$path_to_www = "/srv/www/htdocs";
//$path_to_www = "/var/www/html";
$SEP = DIRECTORY_SEPARATOR;

$url_to_repository = "/repository";
$path_to_repository = $path_to_www.$SEP."repository";


$url_to_sorcore = "/sorcore/trunk";
$url_to_ct = "/fincluimos/ctc";
$url_to_soran_site = "/fincluimos/ctc";


$path_to_ct = $path_to_www.$SEP.$url_to_ct.$SEP;
$path_to_joomla_soran = $path_to_ct;//."libraries".$SEP."soran".$SEP;
$path_to_sorcore = $path_to_www.$SEP.$url_to_sorcore.$SEP;

$template_config = 'ctc';

$authentities = array(
    "Enterprise" => array(
        "access_level" => "assign-enterprise",
  "field" => "enterprise_id",
  "userFunc" => "getEnterprises",//UserJ function to call to get enterprises allowed for this user
  "userAncestorFunc" => "getEnterpriseAncestors",// UserJ function to get ancestors
  "fieldToShow" => "name",
  "desc" => "Empresa",
    ),
 "BranchOffice" => array(
        "access_level" => "assign-branch",
  "field" => "branch_office_id",
  "userFunc" => "getBranchOffices",
  "userAncestorFunc" => null,
  "fieldToShow" => "name",
  "desc" => "Sucursal",  
    ),
);

// Include the JLog class.
jimport('joomla.log.log');
// Add the logger.
JLog::addLogger(
     // Pass an array of configuration options
    array(
            // Set the name of the log file
            'text_file' => 'cloudtime.log.php',
            // (optional) you can change the directory
            'text_file_path' => 'C:/work/wamp/logs'  //'/var/log/joomla'
     ),
 JLog::ALL,//DEBUG,//INFO,  //WARNING,   //ERROR   //  ALL
 array('cloudtime','query','sorcore','jerror')//,'deprecated'
);

JLog::addLogger(
     // Pass an array of configuration options
    array(
            // Set the name of the log file
            'text_file' => 'cloudtime.error.log.php',
            // (optional) you can change the directory
            'text_file_path' => 'C:/work/wamp/logs'  //'/var/log/joomla'
     ),
 JLog::ERROR,//DEBUG,//INFO,  //WARNING,   //ERROR   //  ALL
 array('cloudtime','query','sorcore','jerror')//,'deprecated'
);

/*
try {
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass, array(
        PDO::ATTR_PERSISTENT => true,
  //PDO::MYSQL_ATTR_USE_BUFFERED_QUERY => true 
    ));
    $db->exec("SET CHARACTER SET utf8");
    
} catch (PDOException $e) {
    error_log("Error!: " . $e->getMessage() . "<br/>");
    die("Could not connect to database.");
}*/

$GLOBALS['debugjs'] = $debugjs;
$GLOBALS['debugindex'] = $debugindex;
$GLOBALS['debugging'] = $debugging;
$GLOBALS['path_to_www'] = $path_to_www;
$GLOBALS['path_to_ct'] = $path_to_ct;
$GLOBALS['url_to_soran'] = $url_to_sorcore;
$GLOBALS['corename'] = $corename;
$GLOBALS['db'] = $db;
$GLOBALS['path_to_joomla_soran'] = $path_to_joomla_soran;
$GLOBALS['path_to_sorcore'] = $path_to_sorcore;
$GLOBALS['server_url'] = $server_url;
$GLOBALS['jboss_port'] = $jboss_port;

$GLOBALS['logQueries'] = $logQueries; 

$GLOBALS['logMemory'] = $logMemory;
$GLOBALS['url_to_repository'] = $url_to_repository;
$GLOBALS['path_to_repository'] = $path_to_repository;
$GLOBALS['import_repository'] = $import_repository;
$GLOBALS['soran_template_config'] = $template_config;

$GLOBALS['guvnor_server']  = $guvnor_server;
$GLOBALS['guvnor_port']    = $guvnor_port;
$GLOBALS['guvnor_user']    = $guvnor_user;
$GLOBALS['guvnor_pass']    = $guvnor_pass;
$GLOBALS['authentities']    = $authentities;
//$GLOBALS['system_breadcrumb'] = $authentities;

$GLOBALS['article404'] = $article404;
$GLOBALS['articleChangePassword'] = $articleChangePassword;

$GLOBALS['servername'] = $servername;

$GLOBALS['PARTITION_DATE'] = $PARTITION_DATE;

//$GLOBALS['debug_date']
//$GLOBALS['sendsmsemails']