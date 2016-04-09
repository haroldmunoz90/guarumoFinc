<?php

class TgramFincluimosController {
	const apikey = "175779496:AAEsuPzFXq67lhlVi4y080v8HEEexW-prQs";
    private $serviceId = 1;
    private $db;

    public function onmsgAction( TelegramUpdate $msg, $curl ) {
    	global $user, $pass, $host;
         $dbname = "telegram";
        //error_log("Variables globales " . $user . " " . $pass . " " . $host . " " . $dbname );
        try {
            $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
            $db->exec("SET CHARACTER SET utf8");
            error_log("db abierta");
        } catch (PDOException $e) {
            error_log('Connection failed: ' . $e->getMessage());
        }

        if(strtoupper($msg->stext) == "BIENVENIDO" ){
            print_r("Bienvenido a bancontando, te vamos a hacer unas preguntas para poder ofrecerte una "
                    . "solucion a tu medida.");
             TgramFincluimosController::checkQuestions($db,$msg,$curl);
             return;
        }
        
        if(strtoupper($msg->stext) == "CANCELAR" ){
            $action = json_decode('{"status":"canceled"}');
            TgramFincluimosController::saveMsg($msg,$db,$action);
            $keybd = json_decode(TelegramMsg::keyboard_HospitalMain);
            error_log("Este es el keyboard =  $keybd->keyboard");
            
            $action->phone_response = TelegramMsg::message_canceled;
            $action->keydb = $keybd;
            $curl->apiSendMsg($msg,$action,array(
                                    'keyboard' => $keybd->keyboard,
                                    'resize_keyboard' => true));
            
            //$curl->tgramApiSendMsg($msg->chat_id, "Ingrese el número de identificacion del cliente");
            return;
        }

        $user = TgramFincluimosController::checkAuthorization($msg, $curl,$db);

        if (!$user){
            return;
        }
        $msg->user = $user;
        $lastMessage = TgramFincluimosController::checkStatus($msg,$db);
        
        if($lastMessage["status"] == "waiting"){
            $action = json_decode($lastMessage["action"]);
            $function = $action->function;
            error_log("Entro a status = $function");
            TgramFincluimosController::{$function}($db,$msg,$curl,$action);
            return;
            //status,msg,kb, funcion,eject msg
            //consultar en el interpreter el msg, ejecutar la funcion.
        }
        
        TgramFincluimosController::checkQuestions($db,$msg,$curl);
        
        return;

    }



    public static function checkAuthorization(TelegramUpdate $msg, $curl,$db){
        // --------------------------------conexion a la db

        

        //----------------------verificar si está el chat id

        $queryUserName = "select * "             
                . " from fincluimos_auth where chat_id = '$msg->chat_id' or (cell_phone = '$msg->cell_phone')";
        
        error_log('query person' . $queryUserName);
        $res = $db->query($queryUserName);
        if($res->rowCount()>0){
            $row = $res->fetch();

            if($row["validated"]==1 or !$msg->chat_id){
                error_log('json de la fila' . json_encode($row));
                return $row;
                

            }else{

                if (is_numeric($msg->stext) && trim($msg->stext) == $row["code"]) {

                    $curl->tgramApiSendMsg($msg->chat_id, "El código es correcto. Ahora puedes comenzar a recibir y enviar"
                                . " información a través de la aplicación");
                    
                    $queryUpdate = " UPDATE fincluimos_auth SET validated = 1 WHERE chat_id = '$msg->chat_id'";

                    $statment = $db->prepare($queryUpdate);
                    $res = $statment->execute();
                    error_log("query de update = " . $queryUpdate);
                    error_log("respuesta de update = " . $res);
                    
                }
                else{

                    $curl->tgramSendMsg(array(
                        'chat_id' => $msg->chat_id,
                        'text' => "El código es incorrecto,  Te enviamos un nuevo SMS con un código, ingresalo para completar la autenticación."
                    ));

                    $code = rand(1034, 9871);


                    $queryUpdate = " UPDATE fincluimos_auth SET telegram_code = '$code' , chat_id = '$msg->chat_id', validated = 1 WHERE cell_phone = '$msg->stext'";
                    $statment = $db->prepare($queryUpdate);
                    $res = $statment->execute();

                    error_log("query de update = " . $queryUpdate);
                    error_log("respuesta de update = " . $res);
                    
                   
                    error_log("guardado en la base de datos " . $res);

                    //$curl->sendSMS("testmail", "testmail", $msg->stext, "Hola $msg->user_first_name, tu codigo es $code");


                }


            }
           

        }else{

            if (is_numeric($msg->stext)) {
                
                $curl->tgramSendMsg(array(
                        'chat_id' => $msg->chat_id,
                        'text' => "Muchas gracias! Te enviamos un SMS con un código, ingresalo para completar la autenticación."
                    ));
                
                $code = rand(1034, 9871);
                $curl->sendSMS("testmail", "testmail", $msg->stext, "Hola $msg->user_first_name, tu codigo es $code");

                $queryConsult = "select chat_id, cell_phone from fincluimos_auth where cell_phone = '$msg->stext'";
                error_log("Query cellnumber = " . $queryConsult);

                $res = $db->query($queryConsult);
                if($res->rowCount()>0){
                    $queryUpdate = " UPDATE fincluimos_auth SET code = '$code' , chat_id = '$msg->chat_id', validated = 0 WHERE cell_phone = '$msg->stext'";
                    $statment = $db->prepare($queryUpdate);
                    $res = $statment->execute();
                } 
                else{
                    
                $insertSql = "INSERT INTO `fincluimos_auth` (`chat_id`, `cell_phone`, `code`, `validated`)
                    
                VALUES ('$msg->chat_id', '$msg->stext', $code,'0')";
                
                error_log("Query insert = " . $insertSql);

                $res = $db->query($insertSql);
                    
                    
               
            }  

            }elseif($msg->chat_id){
                $curl->tgramSendMsg(array(
                    'chat_id' => $msg->chat_id,
                    'text' => "Bienvenido $msg->user_first_name! Para empezar a usar nuestros servicios, necesitamos que nos envíes tu numero celular."
                ));
            }else{
                
                $insertSql = "INSERT INTO `fincluimos_auth` (`chat_id`, `cell_phone`, `code`, `validated`)
                    
                VALUES ('null', '$msg->cell_phone', '0','0')";
                
                error_log("Query insert = " . $insertSql);

                $res = $db->query($insertSql);
                
                if($res){
                    print_r("bienvenido a la fincluimos");
                }else{
                    print_r("No te hemos podido registrar, por favor cuelga e intenta de nuevo");
                }
                
                
            }
        }
        


        
    }


    private static function checkQuestions($db,TelegramUpdate $msg,$curl){
        
        $cell_phone = $msg->user["cell_phone"];

        $statusQuery = "select * from fincluimos_questions fq where (fq.id not in 
        (select question_id from fincluimos_user_answers fu where user_cell_phone = '$cell_phone' ) 
        and question_parent_id is null) 
        or (question_parent_id in (select question_id from  
        fincluimos_user_answers fu 
        where user_cell_phone = '$cell_phone' 
        and fu.answer like case when fq.answer_parent is null then '%' else  answer_parent end ) and 
        fq.id not in  
        (select question_id from fincluimos_user_answers fu where user_cell_phone = '$cell_phone' ))";
        
        
        error_log("question query = ".$statusQuery);
        $resp = $db->query($statusQuery);

        
        $row = $resp->fetch();
        
        if(!$row){
            
            $action = json_decode('{"status":"waiting"}');
            $action->function = "wating_text";
            
            $keydb = array();
            $keydb[] = array("Algunos ejemplos");
            $keydb[] = array("Acerca de nosotros");
            
            $responseText = "Has completado todas las preguntas, muchas gracias!"
                    . " En un momento te enviaremos un mensaje de texto con la información que necesitas.";
            $action->phone_response =    $responseText; 
            $action->response =    $responseText; 
            
            $action->keydb = $keydb;
            $curl->apiSendMsg($msg, $action);
            $action->status = "waiting"; 
            $action->function = "waiting_text";
        
            TgramFincluimosController::saveMsg($msg,$db,$action);
            return;
        }
        $action = json_decode('{"status":"waiting"}');
        $action->question_id = $row["id"];
        $action->question_type;
        $action->function = "wating_question_answer";
        $question = $row["text"];
        $question_type = $row["type"];
        $action->question_type = $question_type;
        
        $action->phone_response = $question;
        $action->response = $question;
        $answersQuery = "select * from fincluimos_answers fa where fa.question_type = '$question_type' ";
        error_log("answer query = ".$answersQuery);
        $resp = $db->query($answersQuery);
        $answers = array();
        
        
        $i=1;
        $j=0;
        $temp = array();
        foreach ($resp as $row){
            error_log("$i%2 =  " . $i%2);
            
            $temp[] = $row["text"];
            if($i%2 == 0 ){
                $answers[] = $temp;
                $temp= array();
                
            }
            $i++;
            error_log($row["text"]);
        }
        
        error_log("esto es temp" . $temp);
        error_log("$i%2 =  " . $i%2);
        if ($i-1%2 !=0){
            error_log("entro a ultimo");
           $answers[] = $temp; 
        }
        
        
        if(count($answers)>0){
            $action->keybd = $answers;
        }
        $curl->apiSendMsg($msg, $action);
        
        TgramFincluimosController::saveMsg($msg,$db,$action);
        return true;
        
        
    }


    private static function saveMsg(TelegramUpdate $msg,$db,$action){
        
        $chat_id  = $msg->chat_id;
        $cell_phone = $msg->user["cell_phone"];
        $message  = $msg->stext;
        $status = $action->status;
        $action = utf8_decode(json_encode($action));
        
        error_log($action);
        $date  = date("Y-m-d H:i:s");
        $repeat = 0;
        
        $insertSql = "INSERT INTO `fincluimos_user_msg` (`chat_id`,`cell_phone`, `message`, `status`, `action`, `date`)

VALUES ('$chat_id','$cell_phone', '$message', '$status','$action','$date')";
        
        
        error_log("Query insert = " . $insertSql);

        $res = $db->query($insertSql);
        
        if($res){
           error_log("Insertado "); 
        }
        
        
        /*
        error_log("se va a grabas en saveMsg");
        $action->stext = $msg->stext;
        
        $tc = new Telegram_user_msg();
        $tc->chat_id = $msg->chat_id;
        $tc->message = $msg->stext;
        $tc->status = $action->status;
        $tc->action = json_encode($action);
        $tc->date = date("Y-m-d H:i:s");
        $tc->repeat = 0;
        $tc->store();
         * 
         * 
         */
    }

    private static function wating_question_answer($db,TelegramUpdate $msg,$curl,$action){
        
        
        $user_cell_phone = $msg->user["cell_phone"];
        $question_id = $action->question_id;
        $answer = $msg->stext;
        
        $insertSql = "INSERT INTO `fincluimos_user_answers` (`user_cell_phone`,`question_id`, `answer`)
        VALUES ('$user_cell_phone','$question_id', '$answer')";
        error_log("Query insert = " . $insertSql);
        $res = $db->query($insertSql);
        if($res){
           error_log("Insertado "); 
        }else{
            //TODO: enviar mensaje de error
        }
        
        
        $action->status = "ok"; 
        $action->function = "";
        
        TgramFincluimosController::saveMsg($msg,$db,$action);
        
        TgramFincluimosController::checkQuestions($db,$msg,$curl);
    }




}