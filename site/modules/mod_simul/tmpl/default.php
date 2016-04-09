<?php
/**
 * @package     Joomla.Site
 * @subpackage  mod_simul
 *
 * @copyright   Copyright (C) 2005 - 2013 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

JHtml::_('behavior.keepalive');


$imageToclick = new SoranImageButton("simul_device","Simulador Dispositivo Cloud Time Control",
	"executeSimulDialog","/images/FC30Small.png");

$devUrl = str_replace("//", "/", $imageToclick->BASEURL."/images/FC30.png");
$device = <<<DEV
<img alt="Cloud Time Control" src="$devUrl" /> 
DEV;

$classAttSimul = "AttendanceCreate";
$attViewSimul = new AttendanceCreateView();
$attCreateFormSimul = new SoranForm($classAttSimul, "formAttCreateSimul", $attViewSimul, true,true,false );
$attCreateFormSimul->addValidation("person_id_ALIAS", SoranForm::REQUIRED);
$attCreateFormSimul->addFieldAction("att_date", "date_updated");
$attCreateFormSimul->addFieldAction("att_time", "time_updated");

$scanner = new SoranImageButton("scanner", "Scanear Digito", "crea_att", "/images/scanner.png");

$attCOnta = new SoranContainer("scannerDevice");
$attCOnta->addComponent($attCreateFormSimul);
$attCOnta->addContent($device);
$attCOnta->addContent($scanner);

$attCreateDialSimul = new SoranDialog($classAttSimul, true, null, null, "Crear Marcación", null, null, $attCOnta );
$attCreateDialSimul->addSiteImport("js/ctc/attsimul.js");
$attCreateDialSimul->addSiteImport("css/ctc/attsimul.css");

$imageToclick->draw();
$attCreateDialSimul->drawComponent();


