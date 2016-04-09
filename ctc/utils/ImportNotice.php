<?php
include_once 'ImportFileBase.php';

/**
 * Description of ImportPersonCSV
 * @author Leonardo
 */
class ImportNotice extends ImportFileBase {
	
	const USER_IDENT = "USER_IDENT";
	const PAYROLL_CODE = "PAYROLL_CODE";
	const PAYROLL_NAME = "PAYROLL_NAME";
	const START_DATE = "START_DATE";
	const END_DATE = "END_DATE";	
	const HOURS = "HOURS";	
	
	private $noticeColumns = array(
 			self::USER_IDENT => 0,	//A
			self::PAYROLL_CODE => 1,		//B	
			self::PAYROLL_NAME => 2,		//C
			self::START_DATE => 3,		//D
			self::END_DATE => 4,			//E
			self::HOURS => 5,		//F
			ImportBase::NUM_COLS => 6,
			);
	
	public function __construct() {
        $this->fixedColumns = $this->noticeColumns;
    }
	
	protected function getCountResult() {
		return ImportBase::getCountResult().ImportBase::getCountNoticeResult();
	}
		
	function processData( $fileimport, $datos, $fila, $enterpriseId, &$retData ){			
		$USER_IDENT = $this->getValue( $fileimport, $datos, self::USER_IDENT );
		if( $USER_IDENT === null || $USER_IDENT === false || $USER_IDENT === "" ) {
			$retData .= "<p>Identificación de empleado no suministrada en la fila $fila</p>";			
			return false;
		}
		$person = $this->getPerson($USER_IDENT,null, $enterpriseId );
		if( $person->id === null ) {
			$retData .= "<p>Empleado con identificación $USER_IDENT no se encuentra registrado</p>";
			return false;
		}
		$PAYROLL_NAME = $this->getValue( $fileimport, $datos, self::PAYROLL_NAME );
		$PAYROLL_CODE = $this->getValue( $fileimport, $datos, self::PAYROLL_CODE );
		$concept = $this->getConceptCode($PAYROLL_NAME,
			$PAYROLL_CODE,$person->enterprise_id);

		$startDate = $this->getDateValue( $fileimport, $datos, self::START_DATE );
		$endDate = $this->getDateValue( $fileimport, $datos, self::END_DATE );
		$hours = $this->getValue( $fileimport, $datos, self::HOURS );
		
		$rangeType = HourConcept::RANGE_DATETIME;
		if( strpos($startDate, ":") === FALSE ) {
			$rangeType = HourConcept::RANGE_DATES;
		}
		$hourConcept = new HourConcept();
		$hourConcept->enterprise_id = $person->enterprise_id;							
		$hourConcept->start_time = $startDate;
		$hourConcept->end_time = $endDate;
		$hourConcept->loadWithFields( $person->id, 
			array( "person_id","enterprise_id","start_time","end_time" ) );
		$hourConcept->range_type = $rangeType;
		$hourConcept->aux1 = $startDate;
		$hourConcept->aux2 = $endDate;
		if( $hours !== null && $hours !== false && $hours !== "" ) {
			$hourConcept->hours = $hours;
		}
		$hourConcept->branch_office_id = $person->branch_office_id;
		$hourConcept->concept_id = $concept->id;
											
		if ( !$hourConcept->store(null,true ) ){
			$data = $this->convertHTML(implode(",",$datos) );
			$retData .= "<p>$data</p>";
			return false;
		}
		return true;
	}

}
