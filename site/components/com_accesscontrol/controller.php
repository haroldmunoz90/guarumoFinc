<?php

// Previene el acceso directo al archivo
defined('_JEXEC') or die('Restricted access');

// Importa los componentes de Soran
jimport('soran.config.config');
include_once $GLOBALS['path_to_sorcore'].'components/SoranController.php';

$debug = $GLOBALS['debugging'];
if( $debug ) {
	$req = $_REQUEST;
	if( array_key_exists("password", $_REQUEST) ) {		
		unset ( $req["password"] );
	}
	$results = print_r($req, true);
	JLog::add("CTC http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]\n" . $results  ,JLog::DEBUG, "sorcore" );
}
class accesscontrolController extends SoranController {

    
}

?>

