<?php
//curl -u test:test --data "task=login" "http://localhost/cloudtimeroot/trunk/site/index.php?option=com_ctc&view=actions&format=raw&XDEBUG_SESSION_START=netbeans-xdebug"
//curl -u soportesuppla:*Pr0w4r3 --data "task=login" "https://127.0.0.1/site_srv2/index.php?option=com_ctc&view=actions&format=raw&XDEBUG_SESSION_START=netbeans-xdebug"
//$sorcorepath = "sorcoreroot/trunk/";
//$joomla_site = "/cloudtimeroot/trunk/site";
//$ctc_site = "/cloudtimeroot/trunk/ctc";
$sorcorepath = "sorcore_srv1/";
$joomla_site = "/site_srv1";
$ctc_site = "/site_srv1/libraries/soran";
//ob_start();
//session_start();
$messageAlert = "Por favor, acceda primero";
$server_list = array (	"https://cloudtimecontrol.com/site_srv1/",
						"https://cloudtimecontrol.com/site_srv2/",
						 );

function findServerUser($server){
	global $sorcorepath;
	require_once $sorcorepath.'utils/SoranJSON.php';
	$url = $server . "index.php?option=com_ctc&view=actions&format=raw";
	$data="task=login";
	
	$jsonObj = SoranJSON::curlPostData($url, $data,false,false,$_POST['username'], $_POST['password']);
	error_log("Login:".print_r($jsonObj, true) . " server:" . $server );
	if( stripos( $jsonObj, '"code":0' ) !== FALSE ) {
		//if ($_POST['username'] == 'soportesuppla' && $_POST['password'] == '*Pr0w4r3') {
		//$_SESSION['valid'] = true;
		//$_SESSION['timeout'] = time();
		//$_SESSION['username'] = '1234';
		//$server = ";
		
		$url = $server . "index.php/component/users/?task=user.login";
?>	  
		<form action='<?php echo $url; ?>' method='post' name='frm'>
			<input type='hidden' name='ctcredirect' value='29jdvksndueru3848jdnvn'>
			<input type='hidden' name='username' value='<?php echo $_POST['username']; ?>'>
			<input type='hidden' name='password' value='<?php echo $_POST['password']; ?>'>
<?php
//			foreach ($_POST as $a => $b) {
//				echo "<input type='hidden' name='".htmlentities($a)."' value='".htmlentities($b)."'>";
//			}
?>
		</form>

		<script language="JavaScript">
			document.frm.submit();
		</script>
<?php	  
		exit;
	} 	
}

if ( !empty($_POST['username']) && !empty($_POST['password'])) {
	foreach ( $server_list as $server ) {
		findServerUser($server);
	}
	$messageAlert = 'Usuario o Password Incorrecto';//Wrong username or password';
}

?>

<html lang="es-es" >
<body id="bd" class="com_users view-login blue sj_plus layout_main-left-right no-slider  yt-jv3" >
<head>
  <title>Cloud Time Control</title>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
  <link rel="stylesheet" href="<?php echo $joomla_site; ?>/templates/sj_plus/asset/bootstrap/css/bootstrap.css" type="text/css">
  <link rel="stylesheet" href="<?php echo $ctc_site; ?>/css/template/ctcTemplate.css" type="text/css">
  <style type="text/css">
  </style>
  

</head>

<div id="content_main" class="span12"><div class="content-main-inner ">        	
<div class="span12 no-minheight">				
<div id="system-message-container">
<div id="system-message">
<div class="alert alert-message">
<a class="close" data-dismiss="alert">×</a>
<h4 class="alert-heading">Mensaje</h4>
<div>
<p><?php echo $messageAlert; ?></p>
</div>
</div>
</div>
</div>
</div>
<div id="yt_component" class="span12">
<div class="component-inner"><div class="component-inner2">
<div class="wrap-login">
	<div class="login">
		<div class="page-header">
			<h1 class="title">
				Iniciar sesión		
			</h1>
		</div>
		<form class="form-horizontal" action="index.php?task=user.login" method="post">
			<fieldset class="well">
						<div class="control-group">
							<div class="control-label">
								<label id="username-lbl" for="username" class=" required">Nombre Usuario<span class="star">&nbsp;*</span></label>					
							</div>
							<div class="controls">
								 <input type="text" name="username" id="username" value="" autocomplete="off" class="validate-username required" size="25" required="required" aria-required="true">			
							</div>
							   
						</div>
																	<div class="control-group">
							<div class="control-label">
								<label id="password-lbl" for="password" class=" required">Contraseña<span class="star">&nbsp;*</span></label>					
							</div>
							<div class="controls">
								 <input type="password" name="password" id="password" value="" autocomplete="off" class="validate-password required" size="25" required="required" aria-required="true">			
							</div>
							   
						</div>
														<div class="control-group">
					<label id="remember-lbl" class="control-label" for="remember">Recordarme</label>
					<input id="remember" type="checkbox" name="remember" class="inputbox" value="yes" alt="Recordarme">
				</div>
							<div class="control-group">
					<div class="controls">
						<button type="submit" class="button">Iniciar sesión</button>
						<input type="hidden" name="return" value="aHR0cDovL2xvY2FsaG9zdC9jbG91ZHRpbWVyb290L3RydW5rL3NpdGUvaW5kZXgucGhwL2FkbWluaXN0cmFjaW9uL3BlcnNvbmFkbWluL2VtcGxlYWRvcw==">
						<input type="hidden" name="7d5f48f3e2866c0f6d2e3574fca9a95f" value="1">				</div>
				</div>
				
				
			</fieldset>
		</form>
	</div>

 </div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>		 