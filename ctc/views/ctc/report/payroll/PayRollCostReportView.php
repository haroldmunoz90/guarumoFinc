<?php

class PayRollCostReportView extends PayRollReportBaseView {

    function __construct( ) {
		parent::__construct();

		/// table fields
		$this->assignType("dateti", JText::_("COM_SORCORE_DATE"), BaseView::DATE );
		$this->assignType("mintime", JText::_("COM_CTC_REP_FIRST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_FIRST_DESC") ));
		$this->assignType("maxtime", JText::_("COM_CTC_REP_LAST"), BaseView::STRING,array(
            BaseView::TOOLTIP => JText::_("COM_CTC_REP_LAST_DESC") ));
		
		parent::addConceptsAndValues();
		
    }	
	
}
