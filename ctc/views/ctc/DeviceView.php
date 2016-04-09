<?php

/**
 * Configuracion de vistas para la clase "Device".
 *
 */
class DeviceView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        parent::addCheckBox("table");

        $user = $this->getLoggedUser();

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);
        $this->assignType("identification", JText::_("COM_CTC_IDENFIFICATION"), BaseView::STRING);
        $this->assignType("location", "Localización", BaseView::STRING);
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::HIDDEN);
        $this->assignType("activation_date", JText::_("COM_CTC_ACTIVATION_DATE"), BaseView::DATE);
        $this->assignType("expiration_date", JText::_("COM_CTC_EXPIRATION_DATE"), BaseView::DATE);

        $this->assignType("device_type_id", "Tipo de Unidad Biométrica", BaseView::PICKLIST, array(
            DeviceType::ENROLLER_ATT => "Enroladora y Marcadora",
            DeviceType::ENROLLER_ONLY => "Solo Enroladora",
            DeviceType::ATT_ONLY => "Solo Marcadora",
            BaseView::TOOLTIP => "Determina el comportamiento del sistema cuando llega una marcación de éste dispositivo."));

        //$this->assignType("STATE", "Conexión", BaseView::STRING,array(
        //    BaseView::TOOLTIP => "Estado de Conexión del dispositivo con el servidor." ));

        $funcRes = function($obj) {
            $coler = "red";
            if ($obj->STATE !== "OFFLINE") {
                $coler = "green";
            }
            $textOLINE = <<<TE
			<p style="color:$coler">$obj->STATE</p>
TE;
            return $textOLINE;
        };
        $this->assignType("STATE", "Conexión", BaseView::FUNC, $funcRes);

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->addAuthFields();

        // Informativo
        $this->assignType("ip_address", "Dirección IP", BaseView::STRING);
        $this->assignType("ip_address_wan", "Dirección IP WAN", BaseView::STRING);
        $this->assignType("pushver", "Versión", BaseView::STRING);
        $this->assignType("language", "Lenguaje", BaseView::STRING);
        $this->assignType("numDevAtts", "Marcaciones", BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de Marcaciones en dispositivo."));
        $this->assignType("numDevFPs", JText::_("COM_CTC_NUMFP"), BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de Huellas  en dispositivo."));
        $this->assignType("numDevUsers", "Empleados", BaseView::STRING, array(
            BaseView::TOOLTIP => "Número de Empleados  en dispositivo."));
        $this->assignType("LastActivity", "Last Activity", BaseView::STRING);

        if ($user->hasPermission("modify-device")) {
            $this->assignType("auto_process", "Automático", BaseView::PICKLIST, array(
                'F' => JText::_("COM_CTC_NOT"),
                'T' => JText::_("COM_CTC_YES")
            ));
            $this->assignType("cmdPermissions", "Comandos Permitidos", BaseView::STRING);
            $this->assignType("TransTimes", "Trans Times", BaseView::STRING);
            $this->assignType("TransInterval", "Trans Interval", BaseView::STRING);
            $this->assignType("LogStamp", "Log Stamp", BaseView::STRING);
            $this->assignType("UpdateDB", "Update Db", BaseView::STRING);
            $this->assignType("OpLogStamp", "Op Log Stamp", BaseView::STRING);
            $this->assignType("PhotoStamp", "Photo Stamp", BaseView::STRING);
            $this->assignType("TZAdj", "Tzadj", BaseView::PICKLIST, array(
                -12 => JText::_('UTC__12_00__INTERNATIONAL_DATE_LINE_WEST'),
                -11 => JText::_('UTC__11_00__MIDWAY_ISLAND__SAMOA'),
                -10 => JText::_('UTC__10_00__HAWAII'),
                -9.5 => JText::_('UTC__09_30__TAIOHAE__MARQUESAS_ISLANDS'),
                -9 => JText::_('UTC__09_00__ALASKA'),
                -8 => JText::_('UTC__08_00__PACIFIC_TIME__US__AMP__CANADA_'),
                -7 => JText::_('UTC__07_00__MOUNTAIN_TIME__US__AMP__CANADA_'),
                -6 => JText::_('UTC__06_00__CENTRAL_TIME__US__AMP__CANADA___MEXICO_CITY'),
                -5 => JText::_('UTC__05_00__EASTERN_TIME__US__AMP__CANADA___BOGOTA__LIMA'),
                -4 => JText::_('UTC__04_00__ATLANTIC_TIME__CANADA___CARACAS__LA_PAZ'),
                -4.5 => JText::_('UTC__04_30__VENEZUELA'),
                -3.5 => JText::_('UTC__03_30__ST__JOHN_S__NEWFOUNDLAND__LABRADOR'),
                -3 => JText::_('UTC__03_00__BRAZIL__BUENOS_AIRES__GEORGETOWN'),
                -2 => JText::_('UTC__02_00__MID_ATLANTIC'),
                -1 => JText::_('UTC__01_00__AZORES__CAPE_VERDE_ISLANDS'),
                0 => JText::_('UTC_00_00__WESTERN_EUROPE_TIME__LONDON__LISBON__CASABLANCA'),
                1 => JText::_('UTC__01_00__AMSTERDAM__BERLIN__BRUSSELS__COPENHAGEN__MADRID__PARIS'),
                2 => JText::_('UTC__02_00__ISTANBUL__JERUSALEM__KALININGRAD__SOUTH_AFRICA'),
                3 => JText::_('UTC__03_00__BAGHDAD__RIYADH__MOSCOW__ST__PETERSBURG'),
                3.5 => JText::_('UTC__03_30__TEHRAN'),
                4 => JText::_('UTC__04_00__ABU_DHABI__MUSCAT__BAKU__TBILISI'),
                4.5 => JText::_('UTC__04_30__KABUL'),
                5 => JText::_('UTC__05_00__EKATERINBURG__ISLAMABAD__KARACHI__TASHKENT'),
                5.5 => JText::_('UTC__05_30__BOMBAY__CALCUTTA__MADRAS__NEW_DELHI__COLOMBO'),
                5.75 => JText::_('UTC__05_45__KATHMANDU'),
                6 => JText::_('UTC__06_00__ALMATY__DHAKA'),
                6.5 => JText::_('UTC__06_30__YAGOON'),
                7 => JText::_('UTC__07_00__BANGKOK__HANOI__JAKARTA__PHNOM_PENH'),
                8 => JText::_('UTC__08_00__BEIJING__PERTH__SINGAPORE__HONG_KONG'),
                8.75 => JText::_('UTC__08_00__WESTERN_AUSTRALIA'),
                9 => JText::_('UTC__09_00__TOKYO__SEOUL__OSAKA__SAPPORO__YAKUTSK'),
                9.5 => JText::_('UTC__09_30__ADELAIDE__DARWIN__YAKUTSK'),
                10 => JText::_('UTC__10_00__EASTERN_AUSTRALIA__GUAM__VLADIVOSTOK'),
                10.5 => JText::_('UTC__10_30__LORD_HOWE_ISLAND__AUSTRALIA_'),
                11 => JText::_('UTC__11_00__MAGADAN__SOLOMON_ISLANDS__NEW_CALEDONIA'),
                11.5 => JText::_('UTC__11_30__NORFOLK_ISLAND'),
                12 => JText::_('UTC__12_00__AUCKLAND__WELLINGTON__FIJI__KAMCHATKA'),
                12.75 => JText::_('UTC__12_45__CHATHAM_ISLAND'),
                13 => JText::_('UTC__13_00__TONGA'),
                14 => JText::_('UTC__14_00__KIRIBATI')
            ));
            $this->assignType("error_delay", "Retraso ante Error", BaseView::STRING, array(
                BaseView::TOOLTIP => "Indica el Intervalo en segundos entre intentos de reconexión al servidor despues una conexión fallida."));
            $this->assignType("delay", "Retraso", BaseView::STRING, array(
                BaseView::TOOLTIP => "Indica el Intervalo en segundos entre intentos de conexión"));
            $this->assignType("realtime", "Sincronización", BaseView::PICKLIST, array(
                0 => "En los Tiempos específicados en Trans Times.",
                1 => "En cuanto ocurra la marcación.",
                BaseView::TOOLTIP => "Indica si se transfieren  nuevos registros en tiempo real. Opción 1 Indica que las marcaciones solo se envian en los tiempos Indicados en Trans Times y Trans Interval. Opción 2 Indica que se envian las marcaciones en cuanto ocurran.  "));
            $this->assignType("encrypt", "Encripción", BaseView::PICKLIST, array(
                0 => JText::_("COM_CTC_NOT"),
                1 => JText::_("COM_CTC_YES"),
                BaseView::TOOLTIP => "Indica si el dispositivo encripta los datos enviados."));
            $this->assignType("numAtts", "Marcaciones Servidor", BaseView::STRING, array(
                BaseView::TOOLTIP => "Número de Marcaciones Sincronizadas."));
            $this->assignType("numFPs", "Huellas Servidor", BaseView::STRING, array(
                BaseView::TOOLTIP => "Número de Huellas  Sincronizadas."));
            $this->assignType("numUsers", "Empleados Servidor", BaseView::STRING, array(
                BaseView::TOOLTIP => "Número de Empleados  Sincronizadas."));
        }


        /**
         * Definicion de vistas y sus acciones
         */
        $this->addViewEx("form", array("STATE", "numAtts",
            "numFPs",
            "numUsers"));
        $this->addAction("form", "device_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", "device_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        //TODO agregar device_status_id
        $this->addView("table", array("name",
            "identification",
            "status_id",
            "STATE",
            "numDevAtts",
            "numDevFPs",
            "numDevUsers"));
        $this->addAction("table", "device_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAuthView("table");


        if ($user->hasPermission("modify-device")) {
            $this->addAction("table", "resyncDevice", "Sincronizar Con Dispositivo", "repeat.png");
            $this->addAction("table", "device_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");
        }
        $this->addAction("table", "rebootDevice", "Reiniciar Dispositivo", "shut-down.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", "device_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", "device_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("aud", array(
            "name",
            "identification",
            "status_id",
            "STATE"));
    }

}
