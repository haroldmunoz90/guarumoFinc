<?php

class HttpServerException extends Exception {
    
}

class HttpServerException404 extends Exception {

    function __construct($message = 'Not Found') {
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

    function __construct() {
        $this->http_options = array();
        $this->http_options[CURLOPT_RETURNTRANSFER] = true;
        $this->http_options[CURLOPT_FOLLOWLOCATION] = false;
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
    function get($url, $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $this->handle = curl_init($url);
		curl_setopt($this->handle, CURLOPT_SSL_VERIFYPEER, false);
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
            $http_options[CURLOPT_HTTPHEADER] = array('Content-Type: multipart/form-data');
        }	
		
        $this->handle = curl_init($url);
		//curl_setopt ($ch, CURLOPT_CAINFO, "c:/work2/cacert.pem");
		curl_setopt($this->handle, CURLOPT_SSL_VERIFYPEER, false);
        if (!curl_setopt_array($this->handle, $http_options)) {
            throw new RestClientException("Error setting cURL request options.");
        }

        $this->response_object = curl_exec($this->handle);
        if ($GLOBALS['logQueries']) {
            JLog::add(__FUNCTION__ . " sendMail:" . print_r($http_options,true) . " resp " . $this->response_object ,JLog::INFO, "sorcore" );
        }
        if (curl_errno($this->handle)) {
            if ($this->response_object === false || $this->response_object === "") {
                $this->response_object = curl_error($this->handle);
            }
            JLog::add(curl_error($this->handle) ,JLog::ERROR, "sorcore" );
        }		
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
    function put($url, $data = '', $http_options = array()) {
        $http_options = $http_options + $this->http_options;
        $http_options[CURLOPT_CUSTOMREQUEST] = 'PUT';
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
        $http_options[CURLOPT_CUSTOMREQUEST] = 'DELETE';
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
        $code = $this->response_info['http_code'];

        if ($code == 404) {
            throw new HttpServerException404(curl_error($this->handle));
        }

        if ($code >= 400 && $code <= 600) {
            throw new HttpServerException('Server response status was: ' . $code .
            ' with response: [' . $res . ']', $code);
        }

        if (!in_array($code, range(200, 207))) {
            throw new HttpServerException('Server response status was: ' . $code .
            ' with response: [' . $res . ']', $code);
        }
    }

    public function sendMail($user, $pass, $subject, $destination, $temp, $globalparams = array()) {
		if( !$destination || $destination == "" || $GLOBALS['sendsmsemails'] === false ) {
			JLog::add(__FUNCTION__ . " " . "subject=$subject destination=$destination temp=$temp",
				JLog::ERROR, "sorcore");
			return;
		}
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
            $this->post('https://contactalos.com/services/remail.php', array("data" => json_encode($data)));
        } catch (Exception $e) {
			JLog::add(__FUNCTION__ . " " . $e->getMessage(), JLog::ERROR, "sorcore");
        }
    }

    public function sendSMS($user, $pass, $destination, $text) {
		if( !$destination || $destination == "" || $GLOBALS['sendsmsemails'] === false ) {
			JLog::add(__FUNCTION__ . " " . " destination=$destination text=$text ",
				JLog::ERROR, "sorcore");
			return;
		}		
        $data = array();
        $data['user'] = $user;
        $data['pass'] = $pass;
        $data['dest'] = $destination;
        $data['text'] = $text;

        try {
			$url = 'https://contactalos.com/services/resmssrh.php';
			//'https://contactalos.com/services/resms.php'
            $this->post($url, $data);
        } catch (Exception $e) {
            error_log($e->getMessage());
        }
    }
    
     public function sendTelegram($destination, $text) {
        include_once $GLOBALS['path_to_joomla_soran']."pages/ctc/telegram/TgramConfig.php";
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

}
