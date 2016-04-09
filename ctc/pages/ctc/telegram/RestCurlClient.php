<?php
register_shutdown_function("fatal_handler");
class HttpServerException extends Exception {
    
}

class HttpServerException404 extends Exception {

    function __construct($message = "Not Found") {
        parent::__construct($message, 404);
    }

}

class RestClientException extends Exception {
    
}

class RestCurlClient {

    public $handle;
    public $http_options;
    public $response_object;
    public $response_info;
    public $apiKey;

    function __construct($apiKey) {
        $this->http_options = array();
        $this->http_options[CURLOPT_RETURNTRANSFER] = true;
        $this->http_options[CURLOPT_FOLLOWLOCATION] = false;
        $this->apiKey = $apiKey;
    }

    /**
     * Perform a GET call to server
     * 
     * Additionaly in $response_object and $response_info are the 
     * response from server and the response info as it is returned 
     * by curl_exec() and curl_getinfo() respectively.
     * 
     * @param string $url The url to make the call to.
     * @param array $http_options Extra option to pass to curl handle.
     * @return string The response from curl if any
     */
    public function get($url, $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $this->handle = curl_init($url);

        if (!curl_setopt_array($this->handle, $http_options)) {
            throw new RestClientException("Error setting cURL request options");
        }

        $this->response_object = curl_exec($this->handle);
        $this->http_parse_message($this->response_object);
        curl_close($this->handle);
        return $this->response_object;
    }

    /**
     * Perform a POST call to the server
     * 
     * Additionaly in $response_object and $response_info are the 
     * response from server and the response info as it is returned 
     * by curl_exec() and curl_getinfo() respectively.
     * 
     * @param string $url The url to make the call to.
     * @param string|array The data to post. Pass an array to make a http form post.
     * @param array $http_options Extra option to pass to curl handle.
     * @return string The response from curl if any
     */
    function post($url, $fields = array(), $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $http_options[CURLOPT_POST] = true;
        $http_options[CURLOPT_POSTFIELDS] = $fields;
        if (is_array($fields)) {
            $http_options[CURLOPT_HTTPHEADER] = array("Content-Type: multipart/form-data");
        }
        $this->handle = curl_init($url);

        if (!curl_setopt_array($this->handle, $http_options)) {
            throw new RestClientException("Error setting cURL request options.");
        }

        $this->response_object = curl_exec($this->handle);
        $this->http_parse_message($this->response_object);

        curl_close($this->handle);
        return $this->response_object;
    }

    /**
     * Perform a PUT call to the server
     * 
     * Additionaly in $response_object and $response_info are the 
     * response from server and the response info as it is returned 
     * by curl_exec() and curl_getinfo() respectively.
     * 
     * @param string $url The url to make the call to.
     * @param string|array The data to post.
     * @param array $http_options Extra option to pass to curl handle.
     * @return string The response from curl if any
     */
    function put($url, $data = "", $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $http_options[CURLOPT_CUSTOMREQUEST] = "PUT";
        $http_options[CURLOPT_POSTFIELDS] = $data;
        $this->handle = curl_init($url);

        if (!curl_setopt_array($this->handle, $http_options)) {
            throw new RestClientException("Error setting cURL request options.");
        }

        $this->response_object = curl_exec($this->handle);
        $this->http_parse_message($this->response_object);

        curl_close($this->handle);
        return $this->response_object;
    }

    /**
     * Perform a DELETE call to server
     * 
     * Additionaly in $response_object and $response_info are the 
     * response from server and the response info as it is returned 
     * by curl_exec() and curl_getinfo() respectively.
     * 
     * @param string $url The url to make the call to.
     * @param array $http_options Extra option to pass to curl handle.
     * @return string The response from curl if any
     */
    function delete($url, $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $http_options[CURLOPT_CUSTOMREQUEST] = "DELETE";
        $this->handle = curl_init($url);

        if (!curl_setopt_array($this->handle, $http_options)) {
            throw new RestClientException("Error setting cURL request options.");
        }

        $this->response_object = curl_exec($this->handle);
        $this->http_parse_message($this->response_object);

        curl_close($this->handle);
        return $this->response_object;
    }

    private function http_parse_message($res) {

        if (!$res) {
            throw new HttpServerException(curl_error($this->handle), -1);
        }

        $this->response_info = curl_getinfo($this->handle);
        $code = $this->response_info["http_code"];

        if ($code == 404) {
            throw new HttpServerException404(curl_error($this->handle));
        }

        if ($code >= 400 && $code <= 600) {
            throw new HttpServerException("Server response status was: " . $code .
            " with response: [" . $res . "]", $code);
        }

        if (!in_array($code, range(200, 207))) {
            throw new HttpServerException("Server response status was: " . $code .
            " with response: [" . $res . "]", $code);
        }
    }

    public function sendMail($user, $pass, $subject, $destination, $temp, $globalparams = array()) {
        $data = new stdClass();
        $data->user = $user;
        $data->pass = $pass;
        $data->subj = $subject;
        $data->dest = $destination;
        $data->temp = $temp;
        $data->repl = new stdClass();
        $data->repl->globals = array();

        foreach ($globalparams as $name => $value) {
            $userparam = new stdClass();
            $userparam->name = $name;
            $userparam->value = $value;
            $data->repl->globals[] = $userparam;
        }
        try {
            $this->post("https://contactalos.com/services/remail.php", array("data" => json_encode($data)));
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }

    public function sendSMS($user, $pass, $destination, $text) {
        $data = array();
        $data["user"] = $user;
        $data["pass"] = $pass;
        $data["dest"] = $destination;
        $data["text"] = $text;

        try {
            $this->post("https://contactalos.com/services/resmssrh.php", $data);
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    
    /**
     * Metodo para enviar un mensaje via telegram. Documentacion tomada de https://core.telegram.org/bots/api/#sendmessage
     * @param type $chatId Unique identifier for the target chat or username of the target channel
     * @param type $text Text of the message to be sent
     * @param type $keyboardMarkup This object represents a custom keyboard with reply options https://core.telegram.org/bots/api/#replykeyboardmarkup
     * @param type $keyboardHide Upon receiving a message with this object, Telegram clients will hide the current custom keyboard and display the default letter-keyboard. https://core.telegram.org/bots/api/#replykeyboardhide
     */
    
    
    public function tgramApiSendMsg($chatId, $text, $keyboardMarkup = null, $keyboardHide = null) {
        
        $params = array(
                "chat_id" => $chatId,
                "text" => $text);
        if($keyboardMarkup) {
            $params["reply_markup"] = json_encode($keyboardMarkup);
        } else if($keyboardHide) {
            $params["reply_markup"] = json_encode($keyboardHide);
        }
        $this->tgramSendMsg($params);
    }
    
    public function apiSendMsg(TelegramUpdate $msg, $action, $keyboardMarkup = null, $keyboardHide = null) {
        
        if(!$msg->chat_id){
            if($action->keybd){
                $action->phone_response .= ". Diga una de las siguientes opciones. ";
                print_r($action->phone_response);
                foreach($action->keybd as $answer){
                    if(is_array($answer)){
                        foreach($answer as $word){
                            print_r($word . ".");
                        }
                    }else{
                    print_r($answer . ".");
                        
                    }
                    error_log($answer);
                }
            }else{
                
                print_r($action->phone_response);
            }
            
            return;
        }
        
        
        $chatId = $msg->chat_id;
        $text = $action->response;
        
        
        
        $this->tgramApiSendMsg($msg->chat_id, $text,array(
                                        'keyboard' =>  $action->keybd,
                                        'resize_keyboard' => true,
                                        'one_time_keyboard'=> true));
        /*
        $params = array(
                "chat_id" => $chatId,
                "text" => $text);
        if($keyboardMarkup) {
            $params["reply_markup"] = json_encode($keyboardMarkup);
        } else if($keyboardHide) {
            $params["reply_markup"] = json_encode($keyboardHide);
        }
        $this->tgramSendMsg($params);*/
    }   
    
    
    public function tgramApiSendPhoto($chatId, $photo, $isFile = true, $caption = null, $keyboardMarkup = null, $keyboardHide = null) {
        $params = array(
                "chat_id" => $chatId,
                "photo" => "@" . realpath("/var/www/html/repository_srv2/telegram" . $photo));
        if($caption) {
            $params["caption"] = $caption;
        }
        if($keyboardMarkup) {
            $params["reply_markup"] = json_encode($keyboardMarkup);
        } else if($keyboardHide) {
            $params["reply_markup"] = json_encode($keyboardHide);
        }
        if($isFile) {
            //$params["file_contents"] = "@" . realpath("/usr/share/nginx/html/reachsite/public/" . $photo);
        }
        
        $url = "https://api.telegram.org/bot{$this->apiKey}/sendPhoto";
        try {
            $obj = $this->post($url, $params);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    
    public function tgramSendMsg($params) {
        $url = "https://api.telegram.org/bot{$this->apiKey}/sendMessage";
        $final = $url . "?" . http_build_query($params);
        try {
            error_log($final);
            $obj = $this->get($final);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    public function getFile() {
        $url = "https://api.telegram.org/file/bot162036052:AAH0ybfBOYhfpy-tmBzAyrFX_GpG0L-Ue4k/AgADAQADq6cxG2BZkAksFAABTrsK-4vpn9IvAARseIRp2G0xB3vxAAIC";
        $final = $url . "?" . http_build_query($params);
        try {
            $obj = $this->get($url);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }

    public function tgramApiGetUrlFile($file_id) {

        $params = array(
                "file_id" => $file_id
                );
        return $this->tgramGetUrlFile($params);
        
        
    }


    public function tgramGetUrlFile($params) {
        $url = "https://api.telegram.org/bot{$this->apiKey}/getFile";
        $final = $url . "?" . http_build_query($params);
        try {
            $obj = $this->get($final);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    public function getDolarValue($params) {
        $url = "http://www.set-fx.com/stats";
        try {
            $obj = $this->get($url);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }

    //http://www.set-fx.com/stats
    //https://api.telegram.org/file/bot162036052:AAH0ybfBOYhfpy-tmBzAyrFX_GpG0L-Ue4k/AgADAQADq6cxG2BZkAksFAABTrsK-4vpn9IvAARseIRp2G0xB3vxAAIC
    
    public function telegramInvoke($method, $params) {
        $url = "https://api.telegram.org/bot{$this->apiKey}/$method";
        $final = $url . "?" . http_build_query($params);
        try {
            $obj = $this->get($final);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }

    public function tgramSendPhotoByUrl($chat_id, $repType, $employ, 
            $date,$date2, $username, $enterprise_id, 
            $keyboard = null,$size,$branch_office_id,$ordering,$area) { 
        //https://cloudtimecontrol.com/site_srv2/index.php?option=com_ctc&view=tablero-de-control/tlgRep&repType=marcaciones&date=2015-11-2&employ=VANESSA%20Maldo
        $arrSize = explode(",", $size);
        $width = $arrSize[0];
        $height = $arrSize[1];
        
        //$urlRep = "http://52.23.230.247/index.php/tablero-de-control/tlgRep?repType=marcaciones&width=500&height=500&caption=Reporte";
        $repUrl = urlencode(TgramConfig::tlgRep_url . "&".
        "repType={$repType}&".
        "date={$date}&".
        "date2={$date2}&".
        "employ={$employ}&".
        "username={$username}&".
        "enterprise_id={$enterprise_id}&".
        "branch_office_id={$branch_office_id}&". 
        "ordering={$ordering}&".
        "area={$area}");
        error_log(TgramConfig::tlgRep_url . "&".
        "repType={$repType}&".
        "date={$date}&".
        "date2={$date2}&".
        "employ={$employ}&".
        "username={$username}&".
        "enterprise_id={$enterprise_id}&".
        "branch_office_id={$branch_office_id}&". 
        "ordering={$ordering}&".
        "area={$area}");
    /*
        $keybd = array();
        $keybd[] = array("/help", "/dates");
        $keybd[] = array("/examples", "/reports"); */
        $keybd = json_decode(TelegramMsg::keyboard_main);
        
        
        $url = "http://ctls.co/srvs/snap?chat_id={$chat_id}&api_key={$this->apiKey}&".
        "width={$width}&height={$height}&".
        "keyb= {\"keyboard\":[[\"Reportar novedad\", \"Sacar reporte \"],[\"Certificados\", \"Ejemplos \"]],\"resize_keyboard\":true}&".
        "url={$repUrl}&".
        "delay=3000";
        $this->http_options[CURLOPT_RETURNTRANSFER] = false;
        $this->http_options[CURLOPT_TIMEOUT] = 12;
        //$keyb = keyb= {"keyboard":[["Regresar","Total "]],"resize_keyboard":false}
        error_log("url de envio = " . $url);
        try {
            $obj = $this->get($url);
            return $obj;
        } catch (Exception $e) {
            $this->tgramApiSendMsg($chat_id, "Tenemos una demora en la plataforma, por favor espera un momento o intenta más tarde");
            error_log("Error en la consulta a la pagina");
            return "ok";
        }
    }
    
    public function sendTelegram($destination, $text) {
        
        $text = urlencode($text);
        
        $url = TgramConfig::tlgWebhook_url . "&text=$text&numbers=$destination";
               
            
	try {
            error_log($url);
            $obj = $this->get( $url);
            return $obj;
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    
    function fatal_handler() { 
    $last_error = error_get_last();
    if ($last_error['type'] === E_ERROR) {
        error_log("Fatal Error found\n" . print_r($last_error, true));//Aca haces lo que quieras
    }
}

}
