<?php
class PersonReportView extends BaseView {
    function __construct() {
    	//$this->assignType("name", JText::_("COM_CTC_NAME"), BaseView::STRING);
    	
    	$filter = null;
        $this->assignType("id", JText::_("COM_CTC_NAME"), BaseView::ENTITY, array(
            BaseView::ENT_VAR_NAME => "Person", 
            BaseView::ENT_CLASS => "Person",
            BaseView::ENT_FIELD => array("name", "last_name"),
            BaseView::ENT_FILTER => $filter,
            BaseView::FUNC_JS => "goPerson"));
            
    	$this->assignType("identification", "ID", BaseView::STRING);
		$this->assignType("time", JText::_("COM_SORCORE_DATE"), BaseView::STRING);
        $this->addViewEx("table", array());
		$this->addViewEx("abstable", array(time));
		
    }
}
