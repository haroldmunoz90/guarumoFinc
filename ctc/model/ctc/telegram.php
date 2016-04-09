<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of TelegramConfirm
 *
 * @author rmelo
 */
include_once 'C:\wamp\www\Cloudtime\ctc\pages\ctc\telegram\tgramAuth.php';
class Telegram  extends TgramAuth {

   


    protected static function getTable() {
        return 'tgram_auth';
    }

    protected static function getPrimaryKeyFields() {
        return array('id');
    }

    protected static function getRelationArray() {
        return array();
    }

    /**
     * Permite verificar si un usuario ya se ha autenticado con el sistema
     * @param TelegramUpdate $telup Mensaje enviado por telegram
     * @param bool $whitelist Indica si cualquier usuario puede registrarse o el n�mero debe estar previamente configurado
     * @param string $apikey La llave de API de telegram
     * @param int $serviceId El id del producto a autorizar
     * @param bool $sent Indica si se envio un mensaje al usuario
     * @return bool TRUE si autoriza, FALSE si no
     */
   

}

