<?php


include_once "RestCurlClient.php";
include_once "TelegramUpdate.php";
include_once "TgramConfig.php";
include_once "telegram_msg.php";
include_once "TgramFincluimosController.php";


error_log("Entro al webhook de Fincluimos -> " . TgramConfig::enviroment);
$jmsg = file_get_contents('php://input');
$msg = new TelegramUpdate($jmsg);

if(!$msg->chat_id){
    //print_r("no hay texto");
    $msg = new TelegramUpdate();
    
    $msg->cell_phone = $_POST["cell_phone"];
    $msg->stext = trim( $_POST["text"]);
    
    error_log("el texto es $msg->stext");
}

error_log("Employ message !!!!" . $jmsg);

/*
$apikey = "171489843:AAGFNwvA2ikSac20gTvy3MuKaooaopKToxo";
$curl = new RestCurlClient($apikey);
 * 
 * if($telup->stext == null || $telup->stext == ""){
    
    $text = $_POST["text"];
    error_log("el texto dice" . $text);
    print_r($text);
    return;
 * 
 * //dolar!! http://www.set-fx.com/stats
}

*/
$apikey ="182574296:AAG-Pq7i86JLKC-IjeMh-hYtdLFN6XDq1hI"; // TgramConfig::elTiempoApikey;// "175779496:AAEsuPzFXq67lhlVi4y080v8HEEexW-prQs";

$curl = new RestCurlClient($apikey);

$tgramElTiempoController = new TgramFincluimosController();

$resp = $tgramElTiempoController->onmsgAction($msg, $curl);
