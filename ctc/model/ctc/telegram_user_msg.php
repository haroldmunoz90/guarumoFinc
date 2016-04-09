<?php
class Telegram_user_msg extends Base {

    public $id;
    public $chat_id ;
    public $message;
    public $status;
    public $action;
    public $date;
    public $repeat;
  
    protected static function getTable() {
        return 'telegram_user_msg';
    }

    protected static function getPrimaryKeyFields() {
        return array('id');
    }

    protected static function getRelationArray() {
        return array();
    }
    
    
}