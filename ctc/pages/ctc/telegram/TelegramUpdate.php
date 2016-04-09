<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of TelegramUpdate
 *
 * @author rmelo
 */
class TelegramUpdate {
    
    public $update_id;
    public $message_id;
    public $user_id;
    public $user_first_name;
    public $user_last_name;
    public $chat_id;
    public $chat_first_name;
    public $chat_last_name;
    public $sdate;
    public $stime;
    public $stext;
    public $photo;
    public $photo_id;
    public $document;
    
    public function __construct($jmsg) {
        $msg = json_decode($jmsg);
        $this->update_id = $msg->update_id;
        $this->message_id = $msg->message->message_id;
        $this->user_id = $msg->message->from->id;
        $this->user_first_name = $msg->message->from->first_name;
        $this->user_last_name = $msg->message->from->last_name;
        $this->chat_id = $msg->message->from->id;
        $this->chat_first_name = $msg->message->chat->first_name;
        $this->chat_last_name = $msg->message->chat->last_name;
        $this->sdate = date('Y-m-d', $msg->message->date);
        $this->stime = date('H:i:s', $msg->message->date);
        $this->stext = $msg->message->text;
        $this->photo= $msg->message->photo;
        $this->photo_id= $msg->message->photo[2]->file_id;
        $this->document= $msg->message->document;   
    }

    
    
    /*Received stdClass Object
(
    [update_id] => 696549120
    [message] => stdClass Object
        (
            [message_id] => 11
            [from] => stdClass Object
                (
                    [id] => 40778085
                    [first_name] => Ronald
                    [last_name] => Melo
                )

            [chat] => stdClass Object
                (
                    [id] => 40778085
                    [first_name] => Ronald
                    [last_name] => Melo
                )

            [date] => 1443642903
            [text] => /start
        )

)*/
    
}
