<?php



/**
 * @package    Joomla.Site
 *
 * @copyright  Copyright (C) 2005 - 2013 Open Source Matters, Inc. All rights reserved.
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

if (version_compare(PHP_VERSION, '5.3.1', '<'))
{
	die('Your host needs to use PHP 5.3.1 or higher to run this version of Joomla!');
}

/**
 * Constant that is checked in included files to prevent direct access.
 * define() is used in the installation folder rather than "const" to not error for PHP 5.2 and lower
 */
define('_JEXEC', 1);

if (file_exists(__DIR__ . '/defines.php'))
{
	include_once __DIR__ . '/defines.php';
}

if (!defined('_JDEFINES'))
{
	define('JPATH_BASE', __DIR__);
	require_once JPATH_BASE . '/includes/defines.php';
}

//cha
require_once JPATH_BASE . '/includes/framework.php';

include_once ('libraries/soran/config/config.php');

$debug = $GLOBALS['debugindex'];
if( $debug ) {
	if( array_key_exists("password", $_REQUEST) ) {
		$reqcopy = $_REQUEST;
		unset( $reqcopy[password] );
		$results = print_r($reqcopy, true);
	} else {
		$results = print_r($_REQUEST, true);
	}
	JLog::add("Index CTC http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]\n" . $results ,JLog::DEBUG, "cloudtime" );
}
/*
require_once JPATH_BASE . '/xsscleaner.php';
lx_externalinput_clean::cleanInput();

if(array_key_exists('QUERY_STRING', $_SERVER)) {
    $_SERVER['QUERY_STRING'] = lx_externalinput_clean::xss($_SERVER['QUERY_STRING']);
}
if(array_key_exists('REQUEST_URI', $_SERVER)) {
    $_SERVER['REQUEST_URI'] = lx_externalinput_clean::xss($_SERVER['REQUEST_URI']);
}


lx_externalinput_clean::cleanInputVar("task", "getAlphaNumDot");
lx_externalinput_clean::cleanInputVar("view", "getAlphaNum",true,"/[^\p{L}\p{Nd}-_\. @\/]/");
lx_externalinput_clean::cleanInputVar("option", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("Itemid", "getNum");
lx_externalinput_clean::cleanInputVar("iDisplayStart", "getNum");
lx_externalinput_clean::cleanInputVar("format", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("sEcho", "getNum");
lx_externalinput_clean::cleanInputVar("class", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("tableName", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("viewClass", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("keyname", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("lastId", "getNum");
lx_externalinput_clean::cleanInputVar("iDisplayLength", "getNum");
lx_externalinput_clean::cleanInputVar("form_class", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("view_class", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("action", "getAlphaNum");
//lx_externalinput_clean::cleanInputVar("name", "getAlphaNum",true,"/[^\p{L}\p{Nd}-_\. ]/");//problemas con ()
lx_externalinput_clean::cleanInputVar("type", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("x_field", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("y_fields", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("label_field", "getAlphaNumSpace");
lx_externalinput_clean::cleanInputVar("labels", "getAlphaNumSpace");
lx_externalinput_clean::cleanInputVar("size", "getAlphaNum");
lx_externalinput_clean::cleanInputVar("applyFilters", "getAlphaNum");
//lx_externalinput_clean::cleanInputVar("header", "getAlphaNumSpace");
lx_externalinput_clean::cleanInputVar("break", "getAlphaNum");


*/

// Mark afterLoad in the profiler.
JDEBUG ? $_PROFILER->mark('afterLoad') : null;

// Instantiate the application.
$app = JFactory::getApplication('site');

// Initialise the application.
$app->initialise();

// Mark afterIntialise in the profiler.
JDEBUG ? $_PROFILER->mark('afterInitialise') : null;

// Route the application.
$app->route();

// Mark afterRoute in the profiler.
JDEBUG ? $_PROFILER->mark('afterRoute') : null;

// Dispatch the application.
$app->dispatch();

// Mark afterDispatch in the profiler.
JDEBUG ? $_PROFILER->mark('afterDispatch') : null;

// Render the application.
$app->render();

// Mark afterRender in the profiler.
JDEBUG ? $_PROFILER->mark('afterRender') : null;

// Return the response.
echo $app;
