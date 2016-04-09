<?php

class SubConceptItemView extends HelperView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        parent::addCheckBox("table");

        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_SUBCT_COMPARE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_COMPARE_DESC")
        ));
        $this->assignType("alias_name", JText::_("COM_CTC_SUBCT_IDENTIFY"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_IDENTIFY_DESC")
        ));
        $this->assignType("description", JText::_("COM_CTC_DESCRIPTION"), BaseView::BIG_STRING);

        $this->assignType("type", JText::_("COM_CTC_TYPE"), BaseView::PICKLIST, array(
            SubConceptItem::TYPE_NONE => JText::_("COM_CTC_SUBCT_NONE"),
            SubConceptItem::TYPE_START_POINT => JText::_("COM_CTC_SUBCT_CHANGE_INIT_WORK"),
            SubConceptItem::TYPE_RANGE => JText::_("COM_CTC_SUBCT_FIX_TIME_RANGE"),
            SubConceptItem::TYPE_END_WS => JText::_("COM_CTC_SUBCT_INTERVAL_SINCE_END_SHIFT"),
            SubConceptItem::TYPE_ALL_DAY => JText::_("COM_CTC_SUBCT_A_DAY"),
            SubConceptItem::TYPE_START => JText::_("COM_CTC_SUBCT_INTERVAL_INIT_WORK"),
            SubConceptItem::TYPE_END_HOURS_WS => JText::_("COM_CTC_SUBCT_INTERVAL_END_SHIFT"), // .  param1= duracion lapso.  Si null => hasta final de trabajo",
            SubConceptItem::TYPE_POINTS_RANGE => JText::_("COM_CTC_SUBCT_INTERVAL_POINTS_RANGE"), //intervalo entre puntos de tiempo estandar como inicio de turno, inicio de lapso de trabajo
            SubConceptItem::TYPE_CUSTOM => JText::_("COM_CTC_SUBCT_RULE"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_TYPE_DESC")
        ));

        $this->assignType("param1_type1", JText::_("COM_CTC_SUBCT_CHANGE_INIT_WORK"), BaseView::PICKLIST, array(
            SubConceptItem::P1_T1_NC => JText::_("COM_CTC_SUBCT_NO_CHANGE"),
            SubConceptItem::P1_T1_WS => JText::_("COM_CTC_SUBCT_BY_INIT_WORK"),
            SubConceptItem::P1_T1_ROUND => JText::_("COM_CTC_SUBCT_ROUND"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_CHANGE_INIT_WORK_DESC")
        ));

        $this->assignType("param2_type1", JText::_("COM_CTC_MINUTE"), BaseView::STRING, array(
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_MINUTE_DESC")
        ));

        $this->assignType("param3_type1", JText::_("COM_CTC_ROUND"), BaseView::PICKLIST, array(
            EConstants::ROUND_UP => JText::_("COM_CTC_SUBCT_UP"),
            EConstants::ROUND_DOWN => JText::_("COM_CTC_SUBCT_DOWN"),
            EConstants::ROUND_CEILING => JText::_("COM_CTC_SUBCT_CEILING"),
            EConstants::ROUND_FLOOR => JText::_("COM_CTC_SUBCT_FLOOR"),
            EConstants::ROUND_HALF_UP => JText::_("COM_CTC_SUBCT_HALF_UP"),
            EConstants::ROUND_HALF_DOWN => JText::_("COM_CTC_SUBCT_HALF_DOWN"),
            EConstants::ROUND_HALF_EVEN => JText::_("COM_CTC_SUBCT_HALF_EVEN"),
            //EConstants::ROUND_EVEN_ODD_DOWN_UP => "Impar Arriba",
            //7 => "No Necesario",
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_ROUND_DESC")
        ));

        $this->assignType("param4_type1", JText::_("COM_CTC_SUBCT_EARLY_LATE"), BaseView::PICKLIST, array(
            SubConceptItem::P4_T1_EARLY => JText::_("COM_CTC_SUBCT_IF_EAIN"),
            SubConceptItem::P4_T1_LATE => JText::_("COM_CTC_SUBCT_IF_LAIN"),
            SubConceptItem::P4_T1_BOTH => JText::_("COM_CTC_SUBCT_IF_BOTH"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_EARLY_LATE_DESC")
        ));

        $this->assignType("param1_type2", JText::_("COM_CTC_SUBCT_INIT"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_INIT_DESC")));
        $this->assignType("param2_type2", JText::_("COM_CTC_SUBCT_END"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_END_DESC")));

        $this->assignType("param1_type3", JText::_("COM_CTC_SUBCT_INTERVAL_DURATION"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_INTERVAL_DURATION_DESC")));

        $this->assignType("param1_type4", JText::_("COM_CTC_SUBCT_DAY"), BaseView::PICKLIST, array(
            "1" => JText::_("MONDAY"),
            "2" => JText::_("TUESDAY"),
            "3" => JText::_("WEDNESDAY"),
            "4" => JText::_("THURSDAY"),
            "5" => JText::_("FRIDAY"),
            "6" => JText::_("SATURDAY"),
            "7" => JText::_("SUNDAY"),
            "8" => JText::_("COM_CTC_HOLIDAY"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_DAY_DESC")
        ));

        $this->assignType("param1_type5", JText::_("COM_CTC_SUBCT_SINCE_INIT"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_SINCE_INIT_DESC")));
        $this->assignType("param2_type5", JText::_("COM_CTC_SUBCT_DURATION"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_DURATION_DESC")));
        $this->assignType("param3_type5", JText::_("COM_CTC_SUBCT_CONDITION"), BaseView::PICKLIST, array(
            SubConceptItem::P3_T5_ENTIRE_DURATION => JText::_("COM_CTC_SUBCT_COMPLETE"),
            SubConceptItem::P3_T5_MIN_TIME => JText::_("COM_CTC_SUBCT_MIN_WORK"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_CONDITION_DESC")
        ));
        $this->assignType("param4_type5", JText::_("COM_CTC_SUBCT_MIN_TIME"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_MIN_TIME_DESC")));

        $this->assignType("param1_type7", JText::_("COM_CTC_SUBCT_DURATION"), BaseView::TIME, array(BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_DURATION_DESC")));

        $this->assignType("param1_type8", JText::_("COM_CTC_SUBCT_INTERVAL_INIT"), BaseView::PICKLIST, array(
            SubConceptItem::P1_T8_START_SHIFT => JText::_("COM_CTC_SUBCT_START_SHIFT"),
            SubConceptItem::P1_T8_END_SHIFT => JText::_("COM_CTC_SUBCT_END_SHIFT"),
            SubConceptItem::P1_T8_START_WI => JText::_("COM_CTC_SUBCT_START_WI"),
            SubConceptItem::P1_T8_END_WI => JText::_("COM_CTC_SUBCT_END_WI"),
            SubConceptItem::P1_T8_START_POINT => JText::_("COM_CTC_SUBCT_START_POINT"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_INTERVAL_INIT_DESC")
        ));
        $this->assignType("param2_type8", JText::_("COM_CTC_SUBCT_SINCE_INIT"), BaseView::TIME, array(BaseView::TIME_DURATION => 'true',
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_SINCE_INIT_8_DESC")));

        $this->assignType("param3_type8", JText::_("COM_CTC_SUBCT_INTERVAL_END"), BaseView::PICKLIST, array(
            SubConceptItem::P1_T8_START_SHIFT => JText::_("COM_CTC_SUBCT_START_SHIFT"),
            SubConceptItem::P1_T8_END_SHIFT => JText::_("COM_CTC_SUBCT_END_SHIFT"),
            SubConceptItem::P1_T8_START_WI => JText::_("COM_CTC_SUBCT_START_WI"),
            SubConceptItem::P1_T8_END_WI => JText::_("COM_CTC_SUBCT_END_WI"),
            SubConceptItem::P1_T8_START_POINT => JText::_("COM_CTC_SUBCT_START_POINT"),
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_INTERVAL_END_DESC")
        ));
        $this->assignType("param4_type8", JText::_("COM_CTC_SUBCT_SINCE_END"), BaseView::TIME, array(BaseView::TIME_DURATION => 'true',
            BaseView::TOOLTIP => JText::_("COM_CTC_SUBCT_SINCE_END_8_DESC")));

        $this->assignType("param1", JText::_("COM_CTC_SUBCT_FIRST_PAR"), BaseView::STRING);
        $this->assignType("param2", JText::_("COM_CTC_SUBCT_SECOND_PAR"), BaseView::STRING);
        $this->assignType("param3", JText::_("COM_CTC_SUBCT_THIRD_PAR"), BaseView::STRING);
        $this->assignType("param4", JText::_("COM_CTC_SUBCT_FOURTH_PAR"), BaseView::STRING);

        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "Status",
            BaseView::ENT_FIELD => "name",
            BaseView::ENT_FILTER => null));

        $this->addAuthFields();

        /**
         * Definicion de vistas y sus acciones
         */
        $class = "subconceptitem";
        $this->addViewEx("form", array());
        $this->addAction("form", $class . "_form_submit", JText::_("COM_CTC_SAVE"), "save.png");
        $this->addAction("form", $class . "_form_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");

        $this->addView("table", array("alias_name", "type", "param1", "param2", "param3", "param4", "status_id"));
        $this->addAuthView("table");

        $this->addAction("table", $class . "_table_edit", JText::_("COM_CTC_EDIT"), "edit.png");
        $this->addAction("table", $class . "_table_remove", JText::_("COM_CTC_DELETE"), "delete.png");

        $this->addView("dialog", array());
        $this->addAction("dialog", $class . "_dialog_ok", JText::_("COM_CTC_OK"), "accept.png");
        $this->addAction("dialog", $class . "_dialog_cancel", JText::_("COM_CTC_CANCEL"), "remove.png");
    }

}

?>
