<?php

class AttendanceDailyView extends BaseView {

    function __construct() {
        $filter = null;
        
        $this->assignType("parent_branch_office_id", "Sucursal", BaseView::ENTITY, array(
                BaseView::ENT_FIELD => "name",
                BaseView::ENT_CLASS => "BranchOffice",
                BaseView::ENT_FILTER => null));

        
        $this->assignType("id_ALIAS_1", JText::_("COM_CTC_AREA"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => JText::_("COM_CTC_AREA"),
            BaseView::ENT_CLASS => "Area",
            BaseView::ENT_FIELD => array("name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goListPersonByArea"));


        $this->assignType("TotalInside", "Empleados en sitio", BaseView::STRING);
        $this->assignType("nEmployees", "Total Empleados", BaseView::STRING);
        
        

        //$this->assignType("EATiempo", "Entrada a tiempo", BaseView::STRING);
        //$this->assignType("ETemprano", "Entrada temprano", BaseView::STRING);
        //$this->assignType("ETarde", "Entrada tarde", BaseView::STRING);
        //$this->assignType("SATiempo", "Salida a tiempo", BaseView::STRING);
        //$this->assignType("STemprano", "Salida temprano", BaseView::STRING);
        //$this->assignType("STarde", "Salida tarde", BaseView::STRING);
        $this->addViewEx("table", array());
    }

}
