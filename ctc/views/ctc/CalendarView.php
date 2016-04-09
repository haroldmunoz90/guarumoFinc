<?php

/**
 * Configuracion de vistas para la clase "Calendar".
 *
 */
include_once 'core/BaseView.php';

class CalendarView extends BaseView {

    /**
     * Constructor usado para definir los tipos de los campos de la clase y las diferentes vistas configuradas
     */
    function __construct() {
        /**
         * Definicion de tipos de campos
         */
        $this->assignType("id", "ID", BaseView::HIDDEN);
        $this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
        $this->assignType("description", "Descripcion", BaseView::BIG_STRING);
        $this->addAuthFields();
        $this->assignType("parent_calendar_id", "Calendario padre", BaseView::HIDDEN);
        $this->assignType("status_id", JText::_("COM_CTC_STATUS"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "status",
            BaseView::ENT_CLASS => "IlgStatus",
            BaseView::ENT_CLASS => "name",
            BaseView::ENT_FILTER => null));
        $this->assignType("creation_date", JText::_("COM_CTC_CREATION_DATE"), BaseView::HIDDEN);
        $this->assignType("change_status_date", "Change Status Date", BaseView::HIDDEN);

        $this->assignType("apply_boundaries", "Aplica límites de tiempo para considerar este turno", PICKLIST, array(
            1 => "Si",
            0 => "No"));
        $this->assignType("min_in_time", "Hora Mínima Entrada", BaseView::TIME, array(BaseView::TOOLTIP => "Hora mínima de marcación para considerarla como entrada de este turno."));
        $this->assignType("max_in_time", "Hora Máxima Entrada", BaseView::TIME, array(BaseView::TOOLTIP => "Hora Máxima de marcación para considerarla como entrada de este turno."));
        $this->assignType("min_out_time", "Hora Mínima Salida", BaseView::TIME, array(BaseView::TOOLTIP => "Hora mínima de marcación para considerarla como salida de este turno."));
        $this->assignType("max_out_time", "Hora Máxima Salida", BaseView::TIME, array(BaseView::TOOLTIP => "Hora máxima de marcación para considerarla como salida de este turno."));


        /**
         * Definicion de vistas y sus acciones
         */
    }

}
