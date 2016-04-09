<?php
/**
 * @package     Joomla.Site
 * @subpackage  mod_logout
 *
 * @copyright   Copyright (C) 2005 - 2013 Open Source Matters, Inc. All rights reserved.
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

JHtml::_('behavior.keepalive');
?>
<form action="<?php echo JRoute::_('index.php', true, $params->get('usesecure')); ?>" method="post" id="logout-form" class="form-vertical">
<?php if ($params->get('greeting')) : ?>
	<div class="logout-greeting">
		<div class="username">
			<?php if ($params->get('name') == 0) : {
				echo $user->get('name');
			} else : {
				echo $user->get('username');
			} endif; ?>
		</div>
		<div class="enterprisename">
			<?php echo $enterprise->name ?>
		</div>
	</div>
<?php endif; ?>
	<div class="logout-button">
		<input type="submit" name="Submit" class="button btn btn-primary" value="<?php echo JText::_('JLOGOUT'); ?>" />
		<input type="hidden" name="option" value="com_users" />
		<input type="hidden" name="task" value="user.logout" />
		<input type="hidden" name="return" value="<?php echo $return; ?>" />
		<?php echo JHtml::_('form.token'); ?>
	</div>
</form>
