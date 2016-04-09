INSERT INTO `bi4cg_extensions` (`name`, `type`, `element`, `folder`, `client_id`, `enabled`, `access`, `protected`, `manifest_cache`, `params`, `custom_data`, `system_data`, `checked_out`, `checked_out_time`, `ordering`, `state`)
SELECT 'com_xsms', 'component', 'com_xsms', '', '0', '1', '1', '1', '{\"name\":\"com_xsms\",\"type\":\"component\",\"creationDate\":\"April 2006\",\"author\":\"Joomla! Project\",\"copyright\":\"(C) 2005 - 2013 Open Source Matters. All rights reserved.\\t\",\"authorEmail\":\"admin@joomla.org\",\"authorUrl\":\"www.joomla.org\",\"version\":\"3.0.0\",\"description\":\"COM_MAILTO_XML_DESCRIPTION\",\"group\":\"\"}', '', '', '', '0', '0000-00-00 00:00:00', '0', '0'
FROM `bi4cg_extensions`
WHERE (`extension_id` = '1' COLLATE utf8_bin);

INSERT INTO `bi4cg_menu` (`menutype`, `title`, `alias`, `note`, `path`, `link`, `type`, `published`, `parent_id`, `level`, `component_id`, `checked_out`, `checked_out_time`, `browserNav`, `access`, `img`, `template_style_id`, `params`, `lft`, `rgt`, `home`, `language`, `client_id`)
SELECT 'mainmenu', 'Plantillas', 'templates', '', 'templates', 'index.php?option=com_xsms&view=vtemplate', 'component', '1', '1', '1', '22', '0', '0000-00-00 00:00:00', '0', '1', '', '0', '', '29', '30', '1', '*', '0'
FROM `bi4cg_menu`
WHERE (`id` = '101' COLLATE utf8_bin);