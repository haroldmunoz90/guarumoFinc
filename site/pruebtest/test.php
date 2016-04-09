<?php
define('_JEXEC', 1);
if (!defined('_JDEFINES'))
{
	define('JPATH_BASE', __DIR__);
	require_once JPATH_BASE . '/includes/defines.php';
}
require_once JPATH_BASE . '/includes/framework.php';
include_once ('libraries/soran/config/config.php');
include_once $GLOBALS['path_to_joomla_soran'] . 'utils' . DIRECTORY_SEPARATOR . "ImportExcel.php";
require_once $GLOBALS['path_to_sorcore']."utils/ExcelFile.php";
$filename = "/var/www/html/repository/test.xlsx";
$fileimport = new ExcelFile( $filename );
$fileimport->isReady();
$importExcel = new ImportExcel();
$personsCols = $importExcel->getPersonColumns($fileimport);
$catcols = $importExcel->getCategoriesColumns($fileimport);

/*
$doc = new ExcelBook(null,null,true);
$ret1 = $doc->loadFile($filename);
$ret1 = $doc->getActiveSheet();
$ret2 = $doc->getSheet();
$ret2 = get_class($ret2);
if( $GLOBALS['logQueries'] ) {
	JLog::add( "ExcelFile2 ret=$ret1 sh=$ret2" ,JLog::DEBUG, "cloudtime" );
}
*/
