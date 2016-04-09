<?php
/**
 * @package     Joomla.Site
 * @subpackage  mod_simul
 *
 * @copyright   Copyright (C) 2005 - 2013 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;
/*
// Include the logout functions only once
require_once __DIR__ . '/helper.php';

$params->def('greeting', 1);

$type	= ModLogoutHelper::getType();
$return	= ModLogoutHelper::getReturnURL($params, $type);*/
$user	= JFactory::getUser();
$layout = $params->get('layout', 'default');

if( ! class_exists('BaseCore') ) {
	return;
}
$enterprise = BaseCore::getLoggedEnterprise();

// Logged users must load the logout sublayout
if ($user->guest)
{
	return;
}

require JModuleHelper::getLayoutPath('mod_simul', $layout);
