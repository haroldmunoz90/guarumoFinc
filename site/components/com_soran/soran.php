<?php

//Previene el acceso directo al archivo
defined('_JEXEC') or die('Restricted access');

//Imports de Joomla
jimport('joomla.application.component.controller');
jimport("soran.config.config");
jimport("soran.utils.logger");

//Obtiene el controlador de soran
$controller = JControllerLegacy::getInstance('soran');

//Ejecuta la operacion solicitada
$controller->execute(JRequest::getCmd('task'));

//Redirije a donde diga el controlador, si lo tiene configurado
$controller->redirect();

?>
