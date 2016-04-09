<?php

class DashboardSupportView extends BaseView {

    function __construct() {
       
        $funcSum_bought = function($obj) {
			$sum_bought = $obj->sum_bought;
            
            if($sum_bought == 0){
                return "Ilimitados";
            }
            else{
                return $sum_bought;
            }
		};
        
        $funcTotal = function($obj) {
			$sum_bought = $obj->sum_bought;
            
            if($sum_bought == 0){
                return "Ilimitados";
            }
            else{
                return $obj->total;
            }
		};
        //2015-11-18 00:00:00
        $hourIntervals = function($obj) {
            $hour = substr($obj->time, 11,2);
            switch ($hour) {
                case '00':
                     return "00:00 -> 00:59";
                case '01':
                    return "01:00 -> 01:59";
                case '02':
                    return "02:00 -> 02:59";
                case '03':
                    return "03:00 -> 03:59";
                case '04':
                    return "04:00 -> 04:59";
                case '05':
                    return "05:00 -> 05:59";
                case '06':
                    return "06:00 -> 06:59";        
                case '07':
                    return "07:00 -> 07:59";        
                case '08':
                    return "08:00 -> 08:59";        
                case '09':
                    return "09:00 -> 09:59";        
                case '10':
                    return "10:00 -> 10:59";        
            
                case '11':
                    return "11:00 -> 11:59";        
                case '12':
                    return "12:00 -> 12:59";        
                case '13':
                    return "13:00 -> 13:59";        
                case '14':
                    return "14:00 -> 14:59";        
                case '15':
                    return "15:00 -> 15:59";        
                case '16':
                    return "16:00 -> 16:59";        
                case '17':
                    return "17:00 -> 17:59";        
                case '18':
                    return "18:00 -> 18:59";        
                case '19':
                    return "19:00 -> 19:59";        
                case '20':
                    return "20:00 -> 20:59";        
                case '21':
                    return "21:00 -> 21:59";        
                case '22':
                    return "22:00 -> 22:59";        
                case '23':
                    return "23:00 -> 23:59";        
            
            }
            
       
          
                return $obj->time;
                

                
            
        };

        //offline table
        $this->assignType("deviceName", "Nombre del dispositivo", BaseView::STRING);
        $this->assignType("deviceState", "Estado del dispositivo", BaseView::STRING);
        $offlineTable_fields = array("deviceName","deviceState");
        $this->addView("offlineTable", $offlineTable_fields);
        
        //hourAttendence table BaseView::FUNC, $hourIntervals
        $this->assignType("time", "Hora",BaseView::FUNC, $hourIntervals);
        $this->assignType("attendence", "Número de marcaciones", BaseView::STRING);
        $hourAttendenceTable_fields = array("time","attendence");
        $this->addView("hourAttendenceTable", $hourAttendenceTable_fields);
        
        //clientAttendence
        $this->assignType("clientName", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("clientAttendence", "Número de marcaciones", BaseView::STRING);
        $clientAttendenceTable_fields = array("clientName","clientAttendence");
        $this->addView("clientAttendenceTable", $clientAttendenceTable_fields);
        
        //onLine
        $this->assignType("enterpriseName", JText::_("COM_CTC_ENTERPRISE"), BaseView::STRING);
        $this->assignType("loginAmount", "Cantidad", BaseView::STRING);
        $this->assignType("lastvisitDate", "Ultima Conexión", BaseView::STRING);
        $onlineTable_fields = array("enterpriseName","loginAmount","lastvisitDate");
        $this->addView("onlineClientsTable", $onlineTable_fields);
        
        
        //offLine
        //$this->assignType("enterpriseName", JText::_("COM_CTC_ENTERPRISE"), BaseView::STRING);
        //$this->assignType("loginAmount", "Cantidad", BaseView::STRING);
        //$this->assignType("lastvisitDate", "Ultima Conexión", BaseView::STRING);
        $offlineTable_fields = array("enterpriseName","lastvisitDate");
        $this->addView("offlineClientsTable", $offlineTable_fields);
        
        $this->assignType("name", "Cliente", BaseView::STRING);
        $this->assignType("sum_bought", "Comprado", BaseView::FUNC, $funcSum_bought);
        
        $this->assignType("sum_used", "Utilizados", BaseView::STRING);
        $this->assignType("total", "Disponibles", BaseView::FUNC, $funcTotal);
        
        $this->assignType("renew_date", "Fecha de renovacion", BaseView::STRING);
        $this->assignType("total_messages", "Total de mensajes", BaseView::STRING);
        $this->assignType("priority", "Prioridad", BaseView::STRING);
        
        $this->assignType("camp_status_id", JText::_("COM_CTC_STATUS"), BaseView::PICKLIST, array(
            "0" => "En configuración",
            "1" => "Programada",
            "2" => "En progreso",
            "3" => "Envío finalizado",
            "4" => "Pausada",
            "5" => "Cancelada",
            "6" => "Esperando reintentos",
            "7" => "Sin saldo",
            "8" => "Esperando confirmaciones"
        ));
        
        $this->assignType("name", "cliente", BaseView::STRING);
        
        $this->assignType("amount", "Cantidad", BaseView::STRING);
        $this->assignType("id", "Alarmas", BaseView::STRING);
        $this->assignType("description", "Descripión", BaseView::STRING);
        //$this->assignType("smsToday", "hola", BaseView::HIDE);
        $exporterConf = array(15,15,30,15);
        //$table_fields = array("number", "date", "text", "status_id");
        //$filter_fields = array("number", "date", "status_id");
        $sum_fields = array("success","undelivered","errored","rejected","delivered","total");
        $sms_fields = array("state","amount");
        
        //$sum_fields = array("success","undelivered","errored","rejected","delivered","total");
        $sumExporterConf = array(15, 15, 15, 15, 15, 15);
        
        
        $table_fields = array("name","sum_bought","sum_used","total","renew_date");
        $alarmsTable_fields = array("id","description","amount");
        $campaingTable_fields = array("name","total_messages","priority");
        
        $this->addView("table", $table_fields);
        $this->addView("alarmsTable", $alarmsTable_fields);
        $this->addView("campaingTable", $campaingTable_fields);
        $this->addView("smalltable", $sum_fields);
        $this->addView("smstable", $table_fields);
        $exporterConf['height'] = 30;
        $sumExporterConf['height'] = 30;
        $this->addExporterConf("table", $exporterConf);
        $this->addExporterConf("smalltable", $sumExporterConf);
        //$this->addView("filter", $filter_fields);
        //$this->addAction("filter", "filter_", JText::_("COM_CTC_FILTER"), "search");
        //$this->addAction("filter", "clean_", JText::_("COM_CTC_CLEAR"), "remove");
        //$this->addAction("filter", "export_", "Exportar", "process");
        $this->addAction("alarmsTable", "table_edit", JText::_("COM_CTC_EDIT"), "accept");
    }

}

?>