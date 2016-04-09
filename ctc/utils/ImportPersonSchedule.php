<?php
include_once 'ImportFileBase.php';

/**
 * Description of ImportPersonCSV
 * @author Leonardo
 */
class ImportPersonSchedule extends ImportFileBase {
	
	const USER_IDENT = "USER_IDENT";
	const EMP_SCHED_CODE = "EMP_SCHED_CODE";
	const EMP_SCHED = "EMP_SCHED";
	const START_DATE = "START_DATE";
	const END_DATE = "END_DATE";	
	
	private $perschColumns = array(
 			self::USER_IDENT => 0,	//A
			self::EMP_SCHED_CODE => 1,		//B	
			self::EMP_SCHED => 2,		//C
			self::START_DATE => 3,		//D
			self::END_DATE => 4,			//E
			ImportBase::NUM_COLS => 5,
			);
	
	public function __construct() {
        $this->fixedColumns = $this->perschColumns;
    }
	
	protected function getCountResult() {
		return ImportBase::getCountResult();
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
		
		$empSchCode = $this->getValue( $fileimport, $datos, self::EMP_SCHED_CODE );
		$empSchName = $this->getValue( $fileimport, $datos, self::EMP_SCHED );
		$schedule = $this->getScheduleCode($empSchCode,$empSchName, $person->enterprise_id );
		
		$startDate = $this->getDateValue( $fileimport, $datos, self::START_DATE );
		$endDate = $this->getDateValue( $fileimport, $datos, self::END_DATE );
		
		$perSch = new PersonSchedule();
		$perSch->enterprise_id = $person->enterprise_id;							
		$perSch->initial_date = $startDate;
		$perSch->end_date = $endDate;
		$perSch->loadWithFields( $person->id, 
			array( "person_id","enterprise_id","initial_date","end_date" ) );
		$perSch->schedule_id = $schedule->id;
		$perSch->branch_office_id = $person->branch_office_id;
											
		if ( !$perSch->store(null,true ) ){
			$data = $this->convertHTML(implode(",",$datos) );
			$retData .= "<p>$data</p>";
			return false;
		}
		return true;
	}

}
