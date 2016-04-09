<?php

/**
 * Configuracion de vistas para la clase "Enter".
 *
 */
class TaskView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "id", BaseView::HIDDEN);
        $this->assignType("created_by", "created_by", BaseView::HIDDEN);
        $this->assignType("code", JText::_("COM_CTC_CODE"), BaseView::STRING);
        $this->assignType("category_id", "Categoría", BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Category",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("mileston_id_ALIAS", "Hito", BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "Milestone",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("mileston_id", "mileston_id", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::HUGE_STRING);
        $funcRes = function($obj) {
            if (strlen($obj->result) > 0) {
                return str_replace("Resultado de la generación del Reporte Exitoso.", "", $obj->result);
            }
        };
        $this->assignType("result", "Resumen", BaseView::FUNC, $funcRes);
        //$this->assignType("result", "Resultado", BaseView::HUGE_STRING);
        $this->assignType("comment", "Comentario", BaseView::BIG_STRING);
        $this->assignType("creation_date", JText::_("COM_CTC_CREATION_DATE"), BaseView::HIDDEN);
        $this->assignType("update_date", "Modificada", BaseView::HIDDEN);
        $this->assignType("creation_date_ALIAS", JText::_("COM_CTC_CREATION_DATE"), BaseView::DATE, array(
            "dateFormat" => 'yy-mm-dd'
        ));
        $this->assignType("update_date_ALIAS", "Modificada", BaseView::DATE, array(
            "dateFormat" => 'yy-mm-dd'
        ));
        $this->assignType("start_date", "Comienzo de tarea", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i",
            "dateFormat" => 'yy-mm-dd'
        ));
        $this->assignType("finish_date", "Fin de tarea", BaseView::DATE_TIME, array(
            "dateFormatPHP" => "Y-m-d H:i",
            "dateFormat" => 'yy-mm-dd'
        ));
        $this->assignType("status", JText::_("COM_CTC_STATUS"), BaseView::PICKLIST, array(
            1 => "Creado",
            2 => "En proceso",
            3 => "Terminado",
            4 => "En revisión"
        ));
        $this->assignType("type", "type", BaseView::HIDDEN);
        $this->assignType("progress", "Progreso (%)", BaseView::STRING);
        $this->assignType("user_id", "Asignada a", BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "UserJ",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->assignType("created_by", "created_by", BaseView::HIDDEN);
        $this->assignType("created_by_ALIAS", "Creada por", BaseView::ENTITY, array(
            BaseView::ENT_CLASS => "UserJ",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("enterprise_id", "enterprise_id", BaseView::HIDDEN);
        $this->assignType("notify_by", JText::_("COM_CTC_MEDIA"), BaseView::PICKLIST, array(
            Task::NONE => JText::_("COM_CTC_NONE"),
            Task::SMS => "SMS",
            Task::EMAIL => "Mail",
            Task::TELEGRAM => "Telegram",
            Task::ALL => JText::_("COM_CTC_ALL_MEDIA"),
                //"3" => "Ambos"
        ));
        /*
          $path_to_joomla_soran = $GLOBALS['path_to_joomla_soran'];
          $dir = $path_to_joomla_soran . 'repository' . DIRECTORY_SEPARATOR .
          BaseComp::getLoggedEnterpriseId() . DIRECTORY_SEPARATOR .
          BaseComp::getLoggedUserId() . DIRECTORY_SEPARATOR .
          session_id();
          if (!file_exists($dir)) {
          mkdir($dir, 0777, true);
          }
          $this->assignType("files_path", "Archivos", BaseView::FILE_LIST, $dir);

          $f = function($row) {
          if (strtotime($row->finish_date) < strtotime($row->update_date)) {
          return "Tarea vencidas";
          } else {
          if ($row->status == 3) {
          return "Tarea terminadas a tiempo";
          } else {
          return "Tarea en curso";
          }
          }
          };
          $this->assignType("cur_state", "Estado actual", BaseView::FUNC, $f); */

        /**
         * Definicion de vistas y sus acciones
         */
        $this->addView("form", array(
            "id",
            "created_by",
            "category_id",
            "mileston_id",
            "name",
            "description",
            "creation_date",
            "update_date",
            "start_date",
            "finish_date",
            "status",
            "type",
            "progress",
            "created_by",
            "user_id",
            "enterprise_id",
            "result",
            //"notify_by",
            //"files_path",
            "comment",
        ));


        $this->addAction("form", "form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", "form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("filterform", array(
            "category_id",
            "mileston_id_ALIAS",
            "code",
            "name",
            "description",
            "creation_date_ALIAS",
            "update_date_ALIAS",
            "start_date",
            "finish_date",
            "status",
            "progress",
            "created_by_ALIAS",
            "user_id"
        ));

        $this->addAction("filterform", "filter", JText::_("COM_CTC_FILTER"), "search.png");
        $this->addAction("filterform", "clearf", JText::_("COM_CTC_CLEAR"), "remove.png");

        $this->addView("reptable", array(
            "code",
            "name",
            "cur_state",
            "description",
            "category_id",
            "mileston_id_ALIAS",
            "creation_date_ALIAS",
            "update_date_ALIAS",
            "start_date",
            "finish_date",
            "status",
            "progress",
            "created_by_ALIAS",
            "user_id"
        ));



        $this->addView("table", array("code", "name", "start_date", "finish_date", "progress", "status", "result"));
        $this->addAction("table", "table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", "table_remove", "Eliminar", "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", "dialog_ok", JText::_("COM_CTC_YES"), "accept.png");
        $this->addAction("dialog", "dialog_cancel", JText::_("COM_CTC_NOT"), "remove.png");

        $this->addView("aud", array("id",
            "name",
            "description",
            "creation_date"));
    }

}
