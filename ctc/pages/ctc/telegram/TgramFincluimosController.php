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
        /*
        if(stripos($msg->stext,"voy") !== false || stripos($msg->stext,"cirug") !== false ){
            
           TgramFincluimosController::onmsgActionDoctor($msg,$curl,$db);
           return;
        }
        */
        if(strtoupper($msg->stext) == "BIENVENIDO" ){
            print_r("Bienvenido a bancontando, te vamos a hacer unas preguntas para poder ofrecerte una solución a tu medida.");
            // TgramFincluimosController::checkQuestions($db,$msg,$curl);
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
        
        // --------------------------------conexion a la db
        
        
        $user = TgramFincluimosController::checkAuthorization($msg, $curl,$db);
        
        
        
        if (!$user){
            return;
        }
        $msg->user = $user;
        
        $msg->cell_phone = $user["cell_phone"];
        if(strtoupper($msg->stext) == "/START" ){
            //print_r("Bienvenido a bancontando, te vamos a hacer unas preguntas para poder ofrecerte una solución a tu medida.");
            TgramFincluimosController::checkQuestions($db,$msg,$curl);
            return; 
        }
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
        
        
        
        
        //ingresó la cedula.
        
        TgramFincluimosController::checkQuestions($db,$msg,$curl);
        
        return;
        
        $action = json_decode( TgramFincluimosController::checkText($db,$msg,$curl));
        
        if($action){
                //$action = json_decode($action);
            
                
                $function = $action->function;
                
                error_log("Status = " . $action->status);
                if($action->status == "waiting"){
                TgramFincluimosController::send_msg($db,$msg,$curl,$action);
                return true;    
                }
                TgramFincluimosController::{$function}($db,$msg,$curl,$action);
                return true;
            }
        return;
        
        if(stripos($msg->stext,"incapacidad")){

            TgramFincluimosController::sendChiefMsg($msg,$employ,"incapacidad",$curl);
            return;
        }

        return;

        error_log("Employ json = " . $employ);


        if(stripos($msg->stext,"help")){

            $curl->tgramApiSendMsg($msg->chat_id, TelegramMsg::message_help);
            return;
        }
        if($msg->stext == "/dates"){

            $curl->tgramApiSendMsg($msg->chat_id, TelegramMsg::message_dates);
            return;
        }
        if($msg->stext == "/examples"){

            $curl->tgramApiSendMsg($msg->chat_id, TelegramMsg::message_examples);
            return;
        }
        if($msg->stext == "/reports"){
            $curl->tgramApiSendMsg($msg->chat_id, TelegramMsg::message_reports);
            return;
        }

        

        //----------------------sacar nombre de usuario y enterprise_id

        $queryUserName = "select username, enterprise_id from bi4cg_users where id = $msg->user_id";
        
        error_log('query user name' . $queryUserName);
        $res = $db->query($queryUserName);
        $row = $res->fetch();
        $username = $row["username"];
        $enterprise_id = $row["enterprise_id"];
        error_log('username' . $username);
        error_log('enterprise_id' . $enterprise_id);

        $msg->username = $username;
        $msg->enterprise_id = $enterprise_id;
        $action = TgramFincluimosController::checkStatus($msg);
        if($action){
            $type = $action->type;
            $employ = $action->employ;
            $date = $action->date;
            $date2 = $action->date2;
            $status = "OK";
            $curl->tgramApiSendMsg($msg->chat_id,"enviado en el status");
            TgramFincluimosController::saveUserMsg($msg,$type,$date,$date2,$employ,$status);
            $curl->tgramSendPhotoByUrl($msg->chat_id , $type, trim($employ), $date,$date2, $username, $enterprise_id);
            return;
        }

        //------Variables-------------
        $status = "";
        $name = "";
        $date = "";
        $employ = "";
        $number = 0;
        $stext = $msg->stext;
        
         
   /*     //----------------Name---------------
        if($employ != ""){
            $empleado = stripos($msg->stext, "empleado");
            $name = "";
            if ($empleado !== false ){
                $de = stripos($msg->stext, " de ", $empleado);
                $del = stripos($msg->stext, " del ", $empleado);
                if( $del !== false || $de !== false){
                    $name = substr ( $stext, $empleado + 8, ( $del !== false ) ? $del - $empleado - 8: $de - $empleado - 8 );
                }else {
                    $name = substr ( $stext, $empleado + 8 );
                }

                $stext = substr($stext,0,$empleado) . " " . substr($stext,$empleado + 8 + strlen($name));
                //error_log("nombre econtrado  " . $name);
            }
            $employ = $name;
        }
        
        */
        //error_log("Texto sin el nombre  " . $name);


        // ------------Sacar palabras que ignorar
        $msgConsult = TgramFincluimosController::takeOffWordsToIgnore(strtoupper($stext));

        $msgConsultArray = explode(" ", $msgConsult);

        error_log("Mensaje de consulta  " . $msgConsult);
        //$this->view->disable();
        //error_log("MENSAJE A ONMSG ACTION" . $msg->stext);
        //|| !stripos($msg->stext, 'llegada') !== false


        // -----------------------------INTERPRETADOR----------------------
        $queryTelegramInterpreter = " select *,  ";
        $firstCase = true;
        $caseSql = " ";
        foreach($msgConsultArray as $element){
            if($element){
                if(!$firstCase){
                    $caseSql .= " + ";
                } else{
                    $firstCase = false;
                }
                $caseSql .= " CASE WHEN message LIKE '%". $element ."%' THEN 1 ELSE 0 END ";
                   
            }
        }

        $queryTelegramInterpreter.= $caseSql. "as Matches FROM telegram_interpreter "
        ." where 1 = 1 and (" . $caseSql . ") > 0 " ;

        $reportWhere = " and type = 'report'";
        $dateWhere = " and type = 'date'";
        $orderBy = " ORDER BY Matches DESC, char_length (message) asc limit 1";



        $reportQuery = $queryTelegramInterpreter . $reportWhere . $orderBy;

        $dateQuery = $queryTelegramInterpreter . $dateWhere . $orderBy;

        //error_log("Query para consultar reporte " . $reportQuery);
        //error_log("Query para consultar date " . $dateQuery);


        //------------------- reporte ----------------------------
        
        $size = "1000,500";
        $res = $db->query($reportQuery);
        error_log("Query de consulta interpretador = $reportQuery");

        $row = $res->fetch();

        error_log('Numero de registros ' . $res->rowCount() );
        if($res->rowCount()>0){
            //$curl->tgramApiSendMsg($msg->chat_id,$row->action);
            $type = $row["action"];
            $size = $row["size"];

            error_log('entro a cuando hay registros' . $res->rowCount() );
        }else{
            $status = "UNKNOWN";
            TgramFincluimosController::saveUserMsg($msg,$type,$date,$date2,$employ,$status);            
            $curl->tgramApiSendMsg($msg->chat_id,"Lo siento, en este momento no puedo entender que reporte quieres.Te informaré cuando lo sepa");
            return;
        }



        //------------------------date---------------------
        $res = $db->query($dateQuery);
        $row = $res->fetch();
        if($res){
            //$curl->tgramApiSendMsg($msg->chat_id,$row->action);
            $dates = TgramFincluimosController::getRepDate($row["action"],$msg->stext);
            $date = $dates[0];
            $date2= $dates[1];
            error_log('date 1 =' . $date  );
            error_log('date 2 =' . $date2  );
        }else{
            error_log('error en la consulta de la fecha ');
        }
        

        //$text = $text . "reporte de " . $type;
        //$number = stripos($msg->stext, $type) + strlen($type);


        $name = TgramFincluimosController::getRepName($msg->stext);

        if(strlen($name) > 0){
            $employ = $name;
            if (is_numeric($employ)){
                $queryAttendanceChart .= "and p.identification = " . $employ;
            }    
                $queryName = str_replace(" ", "%",$name );
                $employQuery = "select * from ilg_person where enterprise_id = $enterprise_id and case when last_name is null then upper(name) else concat(upper(name),' ', upper(last_name)) end like '%$queryName%'";
                error_log('Sql para empleados =  ' . $employQuery );
                $res = $db->query($employQuery);
                
                if($res->rowCount()>1){

                    //$name = str_replace(" ", "%",$name );
                    $keybd = array();
                    $firstName = "";
                    $secondName = "";
                    //$keybd[] = array("");
                    $responseText = "Existen más de una coincidencia en el nombre, tal vez puede ser alguno de los siguientes empleados\n";
                    $i = 0;
                    $posKey = 0;
                    foreach ($res as $row) {
                        //$responseText .= $row['name'] . "\t";
                        //$responseText .= $row['last_name'] . "\n";
                        if($firstName == ""){
                            $firstName = $row['name'] . " " . $row['last_name'];
                        }else{
                            $secondName = $row['name'] . " " . $row['last_name'];
                            $keybd[$posKey] = array($firstName, $secondName);
                            $firstName="";
                            $secondName ="";
                            $posKey++;
                        }
                        error_log('arreglo en posicion ' .  $i . ' ' . $keybd[$i]);
                        if($i > 2){
                            break ;
                        }
                        $i++;
                    }
                    if($i == 2){
                        $keybd[$posKey] = array($firstName);
                    }

                    $status = "waiting_employ";
                    $curl->tgramApiSendMsg($msg->chat_id, $responseText,array(
                                        'keyboard' =>  $keybd,
                                        'resize_keyboard' => true,
                                        'one_time_keyboard'=> true));

                    TgramFincluimosController::saveUserMsg($msg,$type,$date,$date2,$employ,$status);
                    return;
                }elseif($res->rowCount()==0){
                    TgramFincluimosController::saveUserMsg($msg,$type,$date,$date2,$employ,$status);
                    $curl->tgramApiSendMsg($msg->chat_id,"Lo siento, no encuentro el empleado ");
                    return;
                }
        }
        $status = "OK";

        TgramFincluimosController::saveUserMsg($msg,$type,$date,$date2,$employ,$status);
        $curl->tgramSendPhotoByUrl($msg->chat_id , $type, trim($name), $date,$date2, $username, $enterprise_id,null,$size);
/*
        $sentencia = $db->prepare("INSERT INTO `telegram_user_msg` (`chat_id`, `message`, `status`, `action`, `date`, `repeat`)
        VALUES ( :chat_id, :message, :status, :action:, now(), :repeat)");
        $sentencia->bindParam(':chat_id', $msg->chat_id);
        $sentencia->bindParam(':message', $msg->stext);
        */
    }


    private static function checkStatus(TelegramUpdate $msg,$db){
        $condition = "";
        if(!$msg->chat_id){
            $condition = " cell_phone = $msg->cell_phone ";
        }else{
            $condition = " chat_id = $msg->chat_id ";
        }
        
        

        $statusQuery = "select * from fincluimos_user_msg where $condition order by id desc limit 1";
        error_log($statusQuery);
        $resp = $db->query($statusQuery);

        $row = $resp->fetch();
        return $row;
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
        (select question_id from fincluimos_user_answers fu where user_cell_phone = '$cell_phone' )) order by id asc";
        
        
        error_log("question query = ".$statusQuery);
        $resp = $db->query($statusQuery);

        
        $row = $resp->fetch();
        
        if(!$row){
            
            $action = json_decode('{"status":"ok"}');
            $action->function = "ok";
            
            $keydb = array();
            $keydb[] = array("Algunos ejemplos");
            $keydb[] = array("Acerca de nosotros");
            
            $responseText = "Has completado todas las preguntas, muchas gracias!"
                    . " En un momento te enviaremos un mensaje de texto con la información que necesitas.";
            $action->phone_response =    "complete_thanks"; 
            $action->response =    $responseText; 
            
            $action->keydb = $keydb;
            $curl->apiSendMsg($msg, $action);
            $action->status = "ok"; 
            $action->function = "ok";
            
        
            TgramFincluimosController::saveMsg($msg,$db,$action);
            $responseText = "Has completado todas las preguntas, muchas gracias!"
                    . " En un momento te enviaremos un mensaje de texto con la información que necesitas.";
            
            $action = json_decode('{"status":"ok"}');
            
            $responseText = "";
            
            $respuesta = TgramFincluimosController::matchUserToProducts($db,$msg,$curl);
            //$rows = $respuesta->fetchAll();
            foreach ($respuesta as $row){
                error_log("hay respuesta");
                
                $response = "La entidad " .  $row["bank_name"] . " le ofrece el producto '". $row["product_name"] . "', te prestan hasta \$". $row["bank_max_money"] ." con un interes de ". $row["bank_interest"] . "% anual."
                    . " Llama a 318 3599538 y pregunta!" ;
                if(!$msg->chat_id){
                    $action->phone_response =    $response; 
                    error_log("envio sms");
                    $curl->sendSMS("testmail", "testmail", $msg->user["cell_phone"], $action->phone_response);
                    
                }else{
                    $responseText .= $response .  "\n";
                }
            }
            
            if(!$msg->chat_id){
                return;
            }
            $action->response = $responseText;
            $curl->apiSendMsg($msg, $action);
            //$action->response = "";
            return;
            $responseText = "La entidad " .  $respuesta["bank_name"] . " le ofrece el producto '". $respuesta["product_name"] . "' que esta pensado para su necesidad."
                    . " Llama a 318 3599538 y pregunta por este producto, tendrás toda la información necesaria!" ;
                $action->response .=    $responseText . "\n";
                if(!$msg->chat_id){
                    $action->phone_response =    $responseText; 
                    error_log("envio el segundo mensaje");
                    $curl->sendSMS("testmail", "testmail", $msg->user["cell_phone"], $action->phone_response);
                    error_log("envio sms");
                    return;
                }
            $curl->apiSendMsg($msg, $action);
            return;
        }
        $action = json_decode('{"status":"waiting"}');
        $action->question_id = $row["id"];
        $action->question_type;
        $action->function = "wating_question_answer";
        $question = $row["text"];
        $question_type = $row["type"];
        $action->question_type = $question_type;
        
        $action->phone_response = $row["audio"]; 
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
        }else{
            $action->keybd = "";
        }
        $curl->apiSendMsg($msg, $action);
        
        TgramFincluimosController::saveMsg($msg,$db,$action);
        return true;
        
        
    }
    
    
    
    private static function checkUsers($db,TelegramUpdate $msg,$curl){

        $statusQuery = "select * from eltiempo_users where identification = $msg->stext ";
        error_log($statusQuery);
        $resp = $db->query($statusQuery);

        $row = $resp->fetch();
        
        if(!$row){
            $responseText = "Cliente no encontrado, por favor verifique el número ingresado";
            $curl->tgramApiSendMsg($msg->chat_id, $responseText,array(
                                        'keyboard' =>  $keybd,
                                        'resize_keyboard' => true,
                                        'one_time_keyboard'=> true));
            return;
        }
        $responseText = "Ingrese el valor de la compra";
        
        $action = json_decode('{"function":"waiting_sellValue"}');
        $action->status = "waiting";
        $action->identification = $msg->stext;
        
        $curl->tgramApiSendMsg($msg->chat_id, $responseText,array(
                                        'keyboard' =>  $keybd,
                                        'resize_keyboard' => true,
                                        'one_time_keyboard'=> true));
        TgramFincluimosController::saveMsg($msg,$db,$action);
        return true;
    }
    
    //$type,$date,$date2,$employ,$status

    private static function saveHospitalMsg(TelegramUpdate $msg,$db,$to){

      
        $date  = date("Y-m-d H:i:s");
        $repeat = 0;
        
        $insertSql = "INSERT INTO `hospital_msg` (`message`, `from`, `to`, `date`)

VALUES ('$msg->stext', '$msg->chat_id', '$to','$date')";
        
        
        error_log("Query insert = " . $insertSql);

        $res = $db->query($insertSql);
        
        if($res){
           error_log("Insertado "); 
        }
        
       
      
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



    private static function sendChiefMsg($db,$msg, $msgType, $curl){
        
       
        if($msgType === "incapacidad"){
             //----------------------verificar si está el chat id

            $queryUserName = "SELECT cell_phone, chat_id FROM `ilg_person` WHERE `id` = (select head_person_id from ilg_area a inner join ilg_person p on  p.area_id = a.id where chat_id = '$msg->chat_id')";
            
            error_log('query head area ' . $queryUserName);
            $res = $db->query($queryUserName);
            if($res->rowCount()>0){
                $row = $res->fetch();
                $message = "El empleado $msg->user_first_name presenta la siguiente escusa por su ausencia";
                $curl->tgramApiSendMsg($row["chat_id"],$message);

                $curl->telegramInvoke("forwardMessage", 
                    array('chat_id' => $row["chat_id"],
                        'from_chat_id' => $msg->chat_id,
                        'message_id' => $msg->message_id
                        ));
            }
        }
        if($msgType === "Daño_Dispositivo"){
             //----------------------verificar si está el chat id

            $queryUserName = "SELECT cell_phone, chat_id FROM `ilg_person` WHERE `id` = (select head_person_id from ilg_area a inner join ilg_person p on  p.area_id = a.id where chat_id = '$msg->chat_id')";
            
            error_log('query head area ' . $queryUserName);
            $res = $db->query($queryUserName);
            if($res->rowCount()>0){
                $row = $res->fetch();
                $message = "El empleado $msg->user_first_name presenta el siguiente daño en un dispositivo";
                $curl->tgramApiSendMsg($row["chat_id"],$message);

                $curl->telegramInvoke("forwardMessage", 
                    array('chat_id' => $row["chat_id"],
                        'from_chat_id' => $msg->chat_id,
                        'message_id' => $msg->message_id
                        ));
            }
        }
    }

    private static function savePhoto($msg,$path,$type,$employ){

        $path = str_replace("\\","", $path);
        $apikey = "175779496:AAEsuPzFXq67lhlVi4y080v8HEEexW-prQs";

        error_log("path de la foto:  " . $path);

        $jemploy = json_decode($employ);
        $photos_path = TgramConfig::photos_path;
        $employID= $jemploy->identification;
        
        $name= $jemploy->name;
        $last_name= $jemploy->last_name;

        $date = date("Ymd_His");
        
        $filename =  date("Ymd_His");


        error_log("El filename es  = " . $filename);

        $url = "https://api.telegram.org/file/bot$apikey/$path";
        error_log("Url de descarga de la foto:  " . $url);
        $content = file_get_contents($url);

        if ($content){
            error_log("Content tiene algo:  " . $content);

        }else{
            error_log("Content no tiene algo:  ");
            return;
        }
        $path = "" . $photos_path . $employID . "/" . $type;
        $dirmake = mkdir("$path", 0777, true); 
        
        $totalpath= "$path/$filename.jpg";
        error_log("Path total " . $totalpath);

        file_put_contents($totalpath, $content);


    }
    
    private static function waiting_text($db,TelegramUpdate $msg,$curl,$action){
        
        if($action->stext){
            $msg->stext = $action->stext . " " . $msg->stext;
        }
        
        $action = json_decode(TgramFincluimosController::checkText($db,$msg,$curl));
        
        $function = $action->function;
        error_log("la fucnion es $function");
        TgramFincluimosController::{$function}($db,$msg,$curl,$action);
        
        //TgramFincluimosController::send_msg($db,$msg,$curl,$action);
        //TgramFincluimosController::saveMsg($msg,$action);
        
    }
    
    private static function dolar_value($db,TelegramUpdate $msg,$curl,$action){
        
               
        $json = $curl->getDolarValue();
        error_log("la respuesta es =" . $json);
        if ($json){
            $json = json_decode($json);
            
            $dolarValue = $json->trm;
            error_log("la trm es" . $dolarValue);
            
            $action->status = "waiting";
            $action->function = "waiting_text";
            $action->response = "El valor del dolar es \$$dolarValue ";
            $dolarValue = str_replace(".", "", $dolarValue);
            $dolarValue = substr($dolarValue, 0, count($dolarValue)-3);
            error_log($dolarValue);
            $action->phone_response = "El valor del dolar es $dolarValue pesos";
            $curl->apiSendMsg($msg,$action);
            //TgramFincluimosController::saveMsg($msg,$action);
            
        }
        else{
            $action->status = "waiting";
            $action->function = "waiting_text";
            $action->response = "Lo sentimos, ha habido un error, por favor vuelva a intentar";
            $action->phone_response = "Lo sentimos, ha habido un error, por favor vuelva a intentar";
            $curl->apiSendMsg($msg,$action);
            
            
        }
        TgramFincluimosController::saveMsg($msg,$db,$action);
        //$action = json_decode(TgramFincluimosController::checkText($db,$msg,$curl));
        //TgramFincluimosController::{$function}($db,$msg,$curl,$action);
        
        //TgramFincluimosController::send_msg($db,$msg,$curl,$action);
        //TgramFincluimosController::saveMsg($msg,$action);
        
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
        $msg->stext = "";
        TgramFincluimosController::checkQuestions($db,$msg,$curl);
    }
    
    private static function waiting_sellConfirmation($db,TelegramUpdate $msg,$curl,$action){
        
    if($msg->stext == "OK"){
        $date = date("Y-m-d H:i:s");
        $insertSql = "INSERT INTO `eltiempo_sell_report` 
        (`partner_name`, `partner_nit`, `eltiempo_user`, `sellValue`, `dicount`, `total`, `date`)
        VALUES 
        ('$action->partner_name','$action->partner_nit', '$action->eltiempo_user','$action->value','$action->discount','$action->total','$date')";
        
        
        error_log("Query insert = " . $insertSql);

        $res = $db->query($insertSql);
        $action->status = "ok";
        if (!$res){
            $action->status = "canceled";
            error_log("reporte no insertado");
            
            $curl->tgramApiSendMsg($msg->chat_id, "Ha habido un error en la operación, porfavor intente de nuevo." );
           
        }else{
            $responseText="La operacion ha sido guardada con exito";
            $curl->tgramApiSendMsg($msg->chat_id, $responseText);
        }
    }else{
        $action->status = "canceled";
        $responseText="La operacion ha sido cancelada con exito";
        $curl->tgramApiSendMsg($msg->chat_id, $responseText);
    }
    $curl->tgramApiSendMsg($msg->chat_id, "Ingrese el número de identificacion del cliente");
    TgramFincluimosController::saveMsg($msg,$db,$action);    
        
        
       
        //TgramFincluimosController::saveMsg($msg,$action);
        
    }
    
    private static function waiting_sellValue($db,TelegramUpdate $msg,$curl,$action){
        
        if (is_numeric($msg->stext)){
            
            $statusQuery = "select * from eltiempo_partners where name = '" . $msg->user["partner_name"] ."'";
            error_log($statusQuery);
            $resp = $db->query($statusQuery);

            $row = $resp->fetch();
            
            
            $action->partner_name =  $msg->user["partner_name"];
            $action->partner_nit = $row["nit"];
            $action->eltiempo_user = $action->identification;
            $action->value = $msg->stext;
            $action->discount = $row["discount"];
            
           
           
            $action->total = $msg->stext - ($msg->stext*$action->discount/100);
            
            //$date = date("Y-m-d H:i:s");
            
            $responseText="La venta realizada es por un valor de \$$action->value  con un descuento del $action->discount% para un total de \$$action->total\n".
            "Para confirmar oprima OK, de lo contrario presione Cancelar";
            
            $keydb = array();
            $keydb[] = array("OK");
            $keydb[] = array("Cancelar");
            $curl->tgramApiSendMsg($msg->chat_id,$responseText ,array(
                                'keyboard' =>  $keydb,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
            
            $action->status = "waiting";
            $action->function = "waiting_sellConfirmation";
            TgramFincluimosController::saveMsg($msg,$db,$action);
  
        }else{
            
            $keydb = array();
            $keydb[] = array("Cancelar");
            $curl->tgramApiSendMsg($msg->chat_id,"Ingrese un valor numérico por favor" ,array(
                                'keyboard' =>  $keydb,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
            
        }
    }
     private static function waiting_diagnostic($db,TelegramUpdate $msg,$curl,$action){
        
         
        $docKeybd = array();
        $docKeybd[] = array("Voy en 5 minutos","Voy en 10 minutos");
        $docKeybd[] = array("Voy en 20 minutos","Estoy en cirugia");
        $keybd = json_decode(TelegramMsg::keyboard_HospitalMain);
        $responseText = "Doctor ". $action->doctorName. ","
                    . "lo necesitan en ". $msg->user["name"];
        
        $name = utf8_decode($action->doctorName);
        error_log("Nombre = ". $name);
        error_log("Nombre = ". utf8_decode($name));
        error_log("Nombre = ". utf8_encode($name));
        $doctorChat_id = $action->doctorChat_id;
        if(stripos($msg->stext,"no") !== false){
            
            
            
            $curl->tgramApiSendMsg($doctorChat_id, utf8_decode($responseText),array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
             $curl->tgramApiSendMsg("160455008", utf8_decode($responseText),array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
        }else{
            
            
            if($msg->photo!=null){
                
                
                $responseText .= "\nAdjuntan la siguiente imagen: ";
                $curl->tgramApiSendMsg($doctorChat_id, utf8_decode($responseText),array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
                $curl->tgramApiSendMsg("160455008", utf8_decode($responseText),array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
                
                $curl->telegramInvoke("forwardMessage", 
                    array('chat_id' => $action->doctorChat_id,
                        'from_chat_id' => $msg->chat_id,
                        'message_id' => $msg->message_id
                        ));
                $curl->telegramInvoke("forwardMessage", 
                    array('chat_id' => "160455008",
                        'from_chat_id' => $msg->chat_id,
                        'message_id' => $msg->message_id
                        ));
            
            }else{
                
                $responseText .= "\nObservación: $msg->stext";
                $curl->tgramApiSendMsg($doctorChat_id, $responseText,array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
                
                 $curl->tgramApiSendMsg("160455008", $responseText,array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
                
            }
            
            
        }
        
        
        $curl->tgramApiSendMsg($msg->chat_id, "Hemos enviado el mensaje al medico " .  $action->doctorName ,array(
                            'keyboard' =>  $keybd->keyboard,
                            'resize_keyboard' => true,
                            'one_time_keyboard'=> true));

        
        TgramFincluimosController::saveHospitalMsg($msg,$db,$doctorChat_id);
        
        
        $action->status = "ok";
        $action->function = "";
        
        TgramFincluimosController::saveMsg($msg,$db,$action);
        return true;
        //TgramFincluimosController::saveMsg($msg,$action);
        
    }
    
    private static function search_doctor($db,TelegramUpdate $msg,$curl,$action){
        
        
        
        $queryUserName = "SELECT name, specialty FROM `hospital_users` WHERE `specialty` = '$action->specialty'";
        
        error_log("El query de consulta es = " . $queryUserName);
        $keybd = array();
        $firstName = "";
        $secondName = "";
        $responseText = "Existen más de una coincidencia en el nombre, tal vez puede ser alguno de los siguientes empleados\n";
        $i = 0;
        $posKey = 0;
        $res = $db->query($queryUserName);
        foreach ($res as $row) {
            if($firstName == ""){
                $firstName = $row['name'] ;
                error_log("El primer nombre es = " . $firstName);
            }else{
                $keybd[$posKey] = array($firstName, $row['name'] );
                $firstName="";
                $posKey++;
            }

            if($i > 2){
                break ;
            }
            $i++;
        }
        if($i == 2){
            $keybd[$posKey] = array($firstName);
        }

        $action->status = "waiting";
        $action->function = "waiting_doctor";
        $curl->tgramApiSendMsg($msg->chat_id, $action->response,array(
                            'keyboard' =>  $keybd,
                            'resize_keyboard' => true,
                            'one_time_keyboard'=> true));
        
        TgramFincluimosController::saveMsg($msg,$db,$action);
            
       /*
        if($action->stext){
            $msg->stext = $action->stext . " " . $msg->stext;
        }
        
        $action = json_decode(TgramFincluimosController::checkText($db,$msg,$curl));
        TgramFincluimosController::send_msg($db,$msg,$curl,$action);
        TgramFincluimosController::saveMsg($msg,$action);
        * 
        */
        
    }
    private static function waiting_report($db,TelegramUpdate $msg,$curl,$action){
       
        
        $report = TgramFincluimosController::checkText($db,$msg,$curl,"report");
        if(!$report){
            return false;
        }
        $report_type = $report[0];
        $report_size = $report[1];
        
        
        $report_date = TgramFincluimosController::checkText($db,$msg,$curl,"date");
        $dates = TgramFincluimosController::getRepDate($report_date,$msg->stext);
        $date = $dates[0];
        $date2= $dates[1];
        
        
        TgramFincluimosController::send_msg($db,$msg,$curl,$action);
        //TgramFincluimosController::saveMsg($msg,$action);
        $username = "admin";
        $enterprise_id = "2";
        
        $curl->tgramSendPhotoByUrl($msg->chat_id , 
                $report_type,"HAROLD", 
                $date,$date2,
                $username, 
                $enterprise_id,
                null,
                $report_size,
                $branch_office_id);
        return true;
    }
    
     private static function waiting_doctor($db,TelegramUpdate $msg,$curl,$action){
       
        
       $queryUserName = "SELECT name, specialty,chat_id FROM `hospital_users` WHERE `name` = '$msg->stext' and  `specialty` = '$action->specialty'";
        
        error_log("El query de consulta es = " . $queryUserName);
        $keybd = array();
        $firstName = "";
        $secondName = "";
        $i = 0;
        $posKey = 0;
        $res = $db->query($queryUserName);
        
        if($res){
            $row = $res->fetch();
            if($row){
                $doctorChat_id = $row['chat_id'];
                $action->status = "waiting";
                $action->function = "waiting_diagnostic";
                $action->doctorChat_id = $doctorChat_id;
                
                error_log("el nombre es ". $row['name']);
                $action->doctorName =  $row['name'];
                error_log("el nombre es ".$action->doctorName );
                
                $keybd = array();
                $keybd[] = array("No");
                
                $curl->tgramApiSendMsg($msg->chat_id, "Desea enviar un comentario o una foto? " ,array(
                                'keyboard' =>  $keybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));
            }
            
            
            /*
            $keybd = json_decode(TelegramMsg::keyboard_HospitalMain);
            $curl->tgramApiSendMsg($msg->chat_id, "Hemos enviado el mensaje al medico " .  $row['name'] ,array(
                                'keyboard' =>  $keybd->keyboard,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));


            $responseText = "Doctor $msg->stext, "
                    . "lo necesitan en $action->specialty\n";
            
            $docKeybd = array();
            $docKeybd[] = array("Voy en 5 minutos","Voy en 10 minutos");
            $docKeybd[] = array("Voy en 20 minutos","Estoy en cirugia");        

            $curl->tgramApiSendMsg($doctorChat_id, $responseText,array(
                                'keyboard' =>  $docKeybd,
                                'resize_keyboard' => true,
                                'one_time_keyboard'=> true));

            TgramFincluimosController::saveHospitalMsg($msg,$db,$doctorChat_id);

            
         */   
        }
       
        TgramFincluimosController::saveMsg($msg,$db,$action);
        return true;
    }
    
    
    
     private static function waiting_photo($db,TelegramUpdate $msg,$curl,$action){
         
        $file_id="";
        $file_type="";
        if($msg->photo!=null){
            $file_type = "jgp";
            $file_id = $msg->photo[2]->file_id;
        }elseif($msg->document!=null){
            $file_type = substr($msg->document->mime_type, stripos($msg->document->mime_type, "/")+1);
            $file_id = $msg->document->file_id;
        }else{
            $curl->tgramApiSendMsg($msg->chat_id,"Por favor envia una foto del documento requerido o escribe cancelar");
            return;
        }
        $urlphoto = json_decode ($curl->tgramApiGetUrlFile($file_id));
        error_log('URL de la photo = ' . $urlphoto->result->file_path);
        TgramFincluimosController::savePhoto($msg,$urlphoto->result->file_path,$action->reportType,$msg->employ);
        
        TgramFincluimosController::sendChiefMsg($db,$msg,$action->reportType,$curl);
        $msg->stext = "Foto Enviada";
        $action->status = "OK";
        TgramFincluimosController::saveMsg($msg,$db,$action);
        $keybd = json_decode(TelegramMsg::keyboard_main);
        $curl->tgramApiSendMsg($msg->chat_id, "El documento ha sido enviado." ,array(
                                    'keyboard' => $keybd->keyboard,
                                    'resize_keyboard' => true));
        return true;
        
        //TgramFincluimosController::saveMsg($msg,$action);
        
    }
    
     private static function send_msg($db,TelegramUpdate $msg,$curl,$action){
        
        //$action = json_decode($action);
        error_log("el texto de la accion es = $action->response");
        if($action->keyboard){
            $curl->tgramApiSendMsg($msg->chat_id,$action->response,array(
                                    'keyboard' => $action->keyboard,
                                    'resize_keyboard' => true));
        }else{
        $curl->tgramApiSendMsg($msg->chat_id,$action->response);
        }
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
    
    private static function checkText($db,TelegramUpdate $msg,$curl,$type=null){
        
        $msgConsult = TgramFincluimosController::takeOffWordsToIgnore(strtoupper($msg->stext));

        $msgConsultArray = explode(" ", $msgConsult);

        error_log("Mensaje de consulta  " . $msgConsult);
        //$this->view->disable();
        //error_log("MENSAJE A ONMSG ACTION" . $msg->stext);
        //|| !stripos($msg->stext, 'llegada') !== false


        // -----------------------------INTERPRETADOR----------------------
        $queryTelegramInterpreter = " select *,  ";
        $firstCase = true;
        $caseSql = " ";
        foreach($msgConsultArray as $element){
            if($element){
                if(!$firstCase){
                    $caseSql .= " + ";
                } else{
                    $firstCase = false;
                }
                $caseSql .= " CASE WHEN message LIKE '%". $element ."%' THEN 1 ELSE 0 END ";
                   
            }
        }

        $queryTelegramInterpreter.= $caseSql. "as Matches FROM fincluimos_interpreter "
        ." having 1 = 1 and Matches >= min_matches " ;
        $sqlType = "";
        if($type){
            $sqlType = " and type = '$type' ";
        }
        
        $orderBy = " ORDER BY Matches DESC, char_length (message) asc limit 1";



        $checkTextQuery = $queryTelegramInterpreter . $sqlType .  $orderBy;
        
        $res = $db->query($checkTextQuery);
        error_log("Query de consulta interpretador = $checkTextQuery");

        
        if($res->rowCount()>0){
            $row = $res->fetch();
            $action =  $row["action"];
            if ($type == "report"){
                $size = $row["size"];
                return array($action,$size);
            }
            
            return $action;
        }
        
        if ($type == "date"){
                
                return "";
            }
        
        $curl->tgramApiSendMsg($msg->chat_id,"Lo siento, en este momento no puedo entender que reporte quieres.Te informaré cuando lo sepa");
        //TgramFincluimosController::saveUserMsg($msg, "UNKOWN", "UNKOWN");
        return null;
    }
    
    private static function takeOffWordsToIgnore($msg){
        $words = array(" DE ", " DEL ", "QUIERO", " UN ", "RESUMEN", "DESEO", "DAME", "EMPLEADO","SEÑOR","  "," A "," ES ", " AL ", " EL ", " UNA ");
        $msg = trim(str_replace($words, " ", $msg));
        return $msg;
    }
    
    private static function getRepDate($strDate, $text){

        $day=date("d");
        $month=date("m");
        $year=date("Y");
        $date2 = date("Y-m-d H:i:s");
        $resultLogin;

        if(stripos($strDate, "fecha") !== false){
            $posDesde = stripos($text, "desde");
            
            if ($posDesde !== false){

                $str_date = substr($text, $posDesde+6,8);
                if (preg_match('/[0-9]{4}/',$str_date)){
                    
                    $str_date = substr($text, $posDesde+6,10);
                    
                    $year = substr($str_date,0,4);
                    $month =substr($str_date,5,2);
                    $day = substr($str_date,8,2);
                   
                }else{
                    $year = "20" . substr($str_date,0,2);
                    $month =substr($str_date,3,2);
                    $day = substr($str_date,6,2);
                   
                }
                
                
            }

            $posHasta = stripos($text, "hasta");
            if ($posHasta !== false){


                $str_date = substr($text, $posHasta+6,8);

                if (preg_match('/[0-9]{4}/',$str_date)){
                    
                    $str_date = substr($text, $posHasta+6,10);
                    
                    $year2 = substr($str_date,0,4);
                    $month2 =substr($str_date,5,2);
                    $day2 = substr($str_date,8,2);
                   
                }else{
                    $year2 = "20" . substr($str_date,0,2);
                    $month2 =substr($str_date,3,2);
                    $day2 = substr($str_date,6,2);
                   
                }

                
                $date2 = date("Y-m-d H:i:s" , mktime(23, 59, 59, $month2, $day2, $year2));
            }else
            {
                $date2 = date("Y-m-d H:i:s" , mktime(23, 59, 59, date("m"), date("d"), date("Y")));
            }

         }elseif(stripos($strDate, "mes") !== false){
            
             if(stripos($strDate, "pasad") !== false){
                $month=date("m") - 1;
                $day=1;
                $date2 = date("Y-m-d H:i:s" , mktime(0, 0, 0, date("m"), 1, date("y")));  
            } else{
                $day=1;
                $date2 = date("Y-m-d H:i:s");           

            }
            
        }elseif(stripos($strDate, "semana") !== false){
            if(stripos($strDate, "pasad") !== false ){
                $day=date("d") - 6 - date("w");
                $date2 = date("Y-m-d H:i:s" , mktime(0, 0, 0, date("m"), date("d") - date("w") + 1, date("y")));
            }
            else{
                $day=date("d") - date("w") + 1;
                $date2 = date("Y-m-d H:i:s"); 
            }
        }elseif(stripos($strDate, "dia") !== false){
            if(stripos($strDate, "ayer") !== false || stripos($strDate, "anterior") !== false){
                $day=date("d")- 1;
                $date2 = date("Y-m-d H:i:s" , mktime(0, 0, 0, date("m"), date("d"), date("y")));
            }else{
                $day=date("d");
            }
        }elseif(stripos($strDate, "ayer") !== false){
            $day=date("d")- 1;
            $date2 = date("Y-m-d H:i:s" , mktime(0, 0, 0, date("m"), date("d"), date("y")));
        }elseif(stripos($strDate, "hoy") !== false){
            $day=date("d");
        }

        $date = date("Y-m-d" , mktime(0, 0, 0, $month, $day, $year));


        return array($date,$date2);
    }
    
    private static function onmsgActionDoctor(TelegramUpdate $msg, $curl, $db){
        
        $statusQuery = "select * from hospital_msg where `to` = $msg->chat_id order by date desc limit 1";
        error_log($statusQuery);
        $resp = $db->query($statusQuery);
        
        

        $row = $resp->fetch();
        
        if($row){
            $from = $row["from"];
            
            
            $keybd = json_decode(TelegramMsg::keyboard_HospitalMain);
            error_log("Este es el keyboard =  $keybd->keyboard");
            
            $resp = "El doctor $msg->user_first_name ha respondido lo siguiente: $msg->stext";
            
            
            $curl->tgramApiSendMsg($from, $resp ,array(
                                    'keyboard' => $keybd->keyboard,
                                    'resize_keyboard' => true));

            $curl->tgramApiSendMsg($msg->chat_id, "Gracias por responder");
            
            
            
        }
        
        
       
        
    }
    
    
    private static function matchUserToProducts($db,TelegramUpdate $msg, $curl ){
        
        $condition = "";
        if(!$msg->chat_id){
            $condition = " cell_phone = $msg->cell_phone ";
        }else{
            $condition = " chat_id = $msg->chat_id ";
        }
         
         
        $query = "select fq.type as qtype,fua.answer as answer from fincluimos_user_answers fua inner join fincluimos_questions fq on fua.question_id = fq.id where fua.user_cell_phone = '$msg->cell_phone' ";
        error_log("query de respuestas" . $query);
        $resp = $db->query($query);
        
        
        foreach($resp as $row){
            error_log("entro a respuestas tipo = " . $row["qtype"]);
            if($row["qtype"]=="job"){
                $job = $row["answer"]; //obtener el tipo de trabajo
            }
            if($row["qtype"]=="independent_job"){
                $independent_job = $row["answer"];
            }
            if($row["qtype"]=="product_type"){
                $product_type = $row["answer"];
            }
            if($row["qtype"]=="product_type_description"){
                $msg->stext = $row["answer"];
                $action = json_decode( TgramFincluimosController::checkText($db,$msg,$curl,"product_type_description")); 
                error_log("action = ".$action->product_type_description);
                $product_type_description = $action->product_type_description;
            }
        }
        
        //hacer el query de union.
        
        $query = "select * from fincluimos_entities_products fep where product_type = '$product_type' and product_type_description like '%$product_type_description%' limit 3";
        error_log("enteties query = ". $query);
        $resp = $db->query($query);
        
        $rows = $resp->fetchAll();
        foreach($rows as $row){
            
            error_log("entro a asdf" . $row["bank_name"]);
            error_log($row[0]);
        }   
        return  $rows;
    }

}
        //BaseImporter::getLogger()->debug('Recv from tgram org: ' . print_r($jmsg, true));

            

        

