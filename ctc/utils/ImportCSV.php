<?php
include_once 'ImportFile.php';

/**
 * Description of ImportPersonCSV
 *
 * En la primera fila debe ir el encabezado de cada columna.  Esta fila no se agrega en la base de datos.
 * Descripción de cada columna:
 * A	Nombre de la empresa del empleado.  El usuario que importe el archivo debe tener permisos de escritura en esta empresa.
 * B	Serial de los dispositivos separados por :
 * C	Identificación en el dispositivo.
 * D	Identificación del empleado.
 * E	Nombre del empleado
 * F	Apellido del empleado
 * G	Sexo del empleado.  F = Femenico  M = Masculino
 * H	Código de cargo
 * I	Nombre de cargo
 * J	Código de área
 * K	Nombre de área
 * L	Estado del empleado.    S=Activo   N=Suspendido
 * M	Código de Turno asignado al empleado.
 * N	Nombre de Turno.
 * O	Código de Sucursal
 * P	Nombre de Sucursal
 * Q	Código Centro de Costos
 * R	Nombre Centro de Costos
 * S	Código Tipo de Contrato
 * T	Nombre Tipo de Contrato
 * U	Fecha de inicio de Contrato
 * V	Fecha Finalización de Contrato
	
 * @author Leonardo
 */
class ImportCSV extends ImportFile {
	
	private $personColumns = array(
 			ImportFile::ENTERPRISE_NAME => 0,	//A
			ImportFile::DEVICE_IDENT => 1,		//B	
			ImportFile::DEVICE_EMPID => 2,		//C
			ImportFile::EMP_IDENT => 3,		//D
			ImportFile::EMP_NAME => 4,			//E
			ImportFile::EMP_LASTNAME => 5,		//F
			ImportFile::EMP_GENRE => 6,		//G
			ImportFile::EMP_POS_CODE => 7,		//H
			ImportFile::EMP_POSITION => 8,		//I
			ImportFile::EMP_AREA_CODE => 9,	//J
			ImportFile::EMP_AREA => 10,		//K
			ImportFile::EMP_STATUS => 11,	//L
			ImportFile::EMP_SCHED_CODE => 12,	//M
			ImportFile::EMP_SCHED => 13,		//N
			ImportFile::EMP_BRANCH_CODE => 14,	//O
			ImportFile::EMP_BRANCH => 15,		//P
			ImportFile::EMP_CC_CODE => 16,		//Q
			ImportFile::EMP_COSTCENTER => 17,	//R
			ImportFile::CNTRACT_TYPE_CODE => 18,//S
			ImportFile::CONTRACT_TYPE => 19,	//T
			ImportFile::START_DATE => 20,		//U
			ImportFile::END_DATE => 21,			//V
			ImportFile::EMP_ROWS => 22,	
			);	
	
	public function importNoticeFile( $pathfilename, $enterpriseId ) {
		if( $GLOBALS['logQueries'] ) {
			JLog::add( "Procesando file Notice $pathfilename" ,JLog::DEBUG, "cloudtime" );
		}
		$db = Connection::_getWriterConnection();
		$ret = new stdClass();
		$processfile = new ProcessFile();
		$processfile->file_url = pathinfo( $pathfilename, PATHINFO_FILENAME );
		$processfile->loadWithFields($processfile->file_url, array( "file_url" ) );
		try {
			$db->beginTransaction();
			$USER_IDENT = 0;		//A
			$PAYROLL_CODE = 1;		//B
			$PAYROLL_NAME = 2;		//C
			$START_DATE = 3;		//D
			$END_DATE = 4;			//E
			$PR_ROWS = 5;

			if ($GLOBALS['logQueries']) {
				JLog::add( "filename = $pathfilename" ,JLog::DEBUG, "cloudtime" );
			}
			$this->resetCounters();

			$fila = 1;
			if (($gestor = fopen($pathfilename, "r")) !== FALSE) {
				$delimiter = ',';
				while (($datos = fgetcsv($gestor, 0, $delimiter)) !== FALSE) {
					$numero = count($datos);
					if ($GLOBALS['logQueries']) {
						JLog::add( "$numero campos en la línea $fila: " ,JLog::DEBUG, "cloudtime" );
					}
					if( $numero === 1 ) {
						$delimiter = ';';
						if( $fila > 1 ){
							JLog::add( "Numero de campos erroneo $numero " ,JLog::ERROR, "cloudtime" );
						}
					}
					if( $fila > 1 ) {
						$this->i_Counters[ImportBase::TOTAL]++;
						if( $numero !== $PR_ROWS ) {
							JLog::add( "Numero de campos erroneo $numero " ,JLog::ERROR, "cloudtime" );
							$ret->data .= "<p>Numero de campos erroneo en la fila $fila</p>";
							$fila++;
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							continue;
						}
						if( $datos[$USER_IDENT] === null || $datos[$USER_IDENT] === false || $datos[$USER_IDENT] === "" ) {
							$ret->data .= "<p>Identificación de empleado no suministrada en la fila $fila</p>";
							$fila++;
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							continue;
						}
						
						try {
							$person = $this->getPerson($datos[$USER_IDENT],null, $enterpriseId );
							if( $person->id === null ) {
								$ret->data .= "<p>Empleado con identificación $datos[$USER_IDENT] no se encuentra registrado</p>";
								$fila++;
								$this->i_Counters[ImportBase::NOTICE_FAIL]++;
								continue;
							}
							$concept = $this->getConceptCode($datos[$PAYROLL_NAME],
								$datos[$PAYROLL_CODE],$person->enterprise_id);
							
							$startDate = $datos[$START_DATE];
							$endDate = $datos[$END_DATE];
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
							$hourConcept->branch_office_id = $person->branch_office_id;
							$hourConcept->concept_id = $concept->id;
							$isInsert = ($hourConcept->id === null );															
							if ( !$hourConcept->store(null,true ) ){
								//throw new ErrorException("Couldn't store: $datos",$datos,null,null,null,null);
								$data = $this->convertHTML(implode(",",$datos) );
								$ret->data .= "<p>$data</p>";
								$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							} else {								
								$this->i_Counters[ImportBase::NOTICE_SUCCESS]++;
								if( $isInsert ) {
									$this->i_Counters[ImportBase::INSERTS]++;
								} else {
									$this->i_Counters[ImportBase::UPDATES]++;
								}
							}
							
						} catch (ErrorException $e) {
							JLog::add($e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
							$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ));
							//$data = implode(",",$datos);
							$ret->data .= "<p>$datos[$USER_IDENT],$error</p>";
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
						}
					}			
					$fila++;
					if ($GLOBALS['logQueries']) {
						for ($c=0; $c < $numero; $c++) {
							JLog::add( $datos[$c]  ,JLog::DEBUG, "cloudtime" );
						}
					}
				}
				fclose($gestor);
			}
			$ret->result = true;
			$ret->notify = "Se completó la operación con exito.";
			$db->commit();
		} catch (ErrorException $e) {
			$db->rollBack();
			JLog::add($e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
			$ret->result = false;
			$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ) );
			$ret->data = $error;
			$ret->notify = "Se presentó un error en la operación";
			$ret->sticky = true;
			$processfile->result_type = 3;
		}
		
		if( $ret->result === true ) {
			if( $ret->data === null ) {
				$ret->data = "Todos los registros se adicionaron Exitosamente";
				$processfile->result_type = 1;
			} else {
				$processfile->result_type = 2;
			}
		}
		
		$processfile->errors = $this->convertHTML( $ret->data );		
		$processfile->total_register = $this->i_Counters[ImportBase::TOTAL];
		$processfile->inserts_processed = $this->i_Counters[ImportBase::INSERTS];
		$processfile->updates_processed = $this->i_Counters[ImportBase::UPDATES];
		$processfile->type = 1;
		$processfile->processed_date = date('Y-m-d H:i:s');
		$processfile->result = $this->getCountResult().$this->getCountNoticeResult() ;
		$processfile->store();
		$this->renameProcessed($pathfilename);
		return $ret;		
	}

	public function importATTFile( $pathfilename, $enterpriseId ) {
		if( $GLOBALS['logQueries'] ) {
			JLog::add( "Procesando file attendance $pathfilename" ,JLog::DEBUG, "cloudtime" );
		}
		$ret = new stdClass();
		$processfile = new ProcessFile();
		$processfile->file_url = pathinfo( $pathfilename, PATHINFO_FILENAME );
		$processfile->loadWithFields($processfile->file_url, array( "file_url" ) );
		try {
 			$ENTERPRISE_NAME = 0;	//A		Este campo no puede estar vacio y el usuario tiene que tener permisos para importar datos sobre la empresa
			$DEVICE_IDENT = 1;		//B		identificacion del dispositivo.  Si el campo está vacío utiliza un dispositivo cualquiera de la empresa.  Si el campo tiene * se escoge cualquier dispositivo de la mpers.  Si el campo no esta vacío y la identificación del dispositivo no se encuentra en la base de datos,  se crea un dispositivo con la identificación suministrada para la empresa.
			$DEVICE_USERID = 2;		//C		Identificación del usuario en el dispositivo.
			$USER_IDENT = 3;		//D		Si el anterior parámetro está vacío utiliza éste para encontrar al usuario mediante su identificación.
			$ATT_DATE_TIME = 4;		//E		Hora y fecha de la marcación en formato 'yyyy-MM-dd hh:mm:ss'
			$STATUS = 5;			//F		0 = Entrada		1=Salida.  Si vacio 0 por defecto.
			$WORKCODE = 6;			//G		Codigo de Novedad asociado a esta marcación.
			$VERIFY = 7;			//H		Modo de verificación del usuario.  Vacío por defecto.  0 = Password,  1 = Huella,  2 =Tarjeta
			$ATT_ROWS = 8;

			if ($GLOBALS['logQueries']) {
				JLog::add( "filename = $pathfilename" ,JLog::DEBUG, "cloudtime" );
			}
			$this->resetCounters();
			$listAtt = array();
			$device = null;
			$fila = 1;
			if (($gestor = fopen($pathfilename, "r")) !== FALSE) {
				$delimiter = ',';
				while (($datos = fgetcsv($gestor, 0, $delimiter)) !== FALSE) {
					$numero = count($datos);
					if ($GLOBALS['logQueries']) {
						JLog::add( "$numero campos en la línea $fila: " ,JLog::DEBUG, "cloudtime" );
					}
					if( $numero === 1 ) {
						$delimiter = ';';
						if( $fila > 1 ){
							JLog::add( "Numero de campos erroneo $numero " ,JLog::ERROR, "cloudtime" );
						}
					}
					if( $fila > 1 ) {
						$this->i_Counters[ImportBase::TOTAL]++;
						$time = null;
						if( $numero !== $ATT_ROWS ) {
							JLog::add( "Numero de campos erroneo $numero " ,JLog::ERROR, "cloudtime" );
							$ret->data .= "<p>Numero de campos erroneo en la fila $fila</p>";
							$fila++;
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							continue;
						}
						if( $datos[$ATT_DATE_TIME] === null || $datos[$ATT_DATE_TIME] === false || $datos[$ATT_DATE_TIME] === "" ) {
							$ret->data .= "<p>Fecha de la marcación no suministrada en la fila $fila</p>";
							$fila++;
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							continue;
						}
						if (preg_match('(^(((\d\d)(([02468][048])|([13579][26]))-02-29)|(((\d\d)(\d\d)))-((((0\d)|(1[0-2]))-((0\d)|(1\d)|(2[0-8])))|((((0[13578])|(1[02]))-31)|(((0[1,3-9])|(1[0-2]))-(29|30)))))\s(([01]\d|2[0-3]):([0-5]\d):([0-5]\d))$)',
							$datos[$ATT_DATE_TIME])) {
							$time = $datos[$ATT_DATE_TIME];
						}else{
							$ret->data .= "<p>Fecha de la marcación INVALIDA en la fila $fila</p>";
							$fila++;
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
							continue;
						}						
						try {
							$att = new Attendance();
							$deviceUserId = null;
							$enterprise = $this->getEnterprise($datos[$ENTERPRISE_NAME]);
							if( $datos[$DEVICE_USERID] != "" ){
								$deviceUserId = $datos[$DEVICE_USERID];
							} else
							if( $datos[$USER_IDENT] != "" ){
								$person = $this->getPerson($datos[$USER_IDENT],null,$enterprise->id);
								$deviceUserId = $person->device_user_id;
								if( !$deviceUserId ){
									$deviceUserId = $datos[$USER_IDENT];
								}
							}
							
							if( !$deviceUserId ){
								$ret->data .= "<p>Identificación de empleado no suministrada en la fila $fila</p>";
								$fila++;
								$this->i_Counters[ImportBase::NOTICE_FAIL]++;
								continue;
							}
							$att->time = $time;
							$att->setDeviceUserId($deviceUserId);
							$identifications = $datos[$DEVICE_IDENT];
							if( $identifications === null || $identifications === false || $identifications === "" ) {
								$identifications = "*";
							}
							$devices = $this->getDevices( $identifications, $enterprise->id,$datos[$ENTERPRISE_NAME]  );
							$devicechosen = null;
							foreach( $devices as $deviceAnalizing ){
								if( $deviceAnalizing->device_type_id != DeviceType::ENROLLER_ONLY ) {
									$devicechosen = $deviceAnalizing;
								}
							}
							if( !$devicechosen ) {
								$ret->data .= "<p>Dispositivo Tipo Marcador no encontrado en la fila $fila</p>";
								$fila++;
								$this->i_Counters[ImportBase::NOTICE_FAIL]++;
								continue;								
							}
							
							if( $datos[$STATUS] != "" ) {
								$att->attendance_status_id = $datos[$STATUS];
							}
							else {
								$att->attendance_status_id = 0;
							}
							$att->work_code = $datos[$WORKCODE];							
							if( $datos[$VERIFY] != "" ) {
								$att->verification_mode_id = $datos[$VERIFY];
							} else {
								$att->verification_mode_id = 12;
							}
							
							if( !$device ){
								$device = $devicechosen;
							}
							if( $device && $devicechosen && $device->id != $devicechosen->id  ){
								Attendance::store_list($device,$listAtt);
								$this->i_Counters[ImportBase::NOTICE_SUCCESS] += count($listAtt);
								$this->i_Counters[ImportBase::INSERTS] += count($listAtt);
								$listAtt = array();
								$device = $devicechosen;
							}
							$listAtt[] = $att;
						} catch (ErrorException $e) {
							JLog::add($e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
							$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ));
							//$data = implode(",",$datos);
							$ret->data .= "<p>Empleado $datos[$USER_IDENT] en la fila $fila ERROR:$error</p>";
							$this->i_Counters[ImportBase::NOTICE_FAIL]++;
						}
					}			
					$fila++;
					if ($GLOBALS['logQueries']) {
						for ($c=0; $c < $numero; $c++) {
							JLog::add( $datos[$c]  ,JLog::DEBUG, "cloudtime" );
						}
					}
				}
				fclose($gestor);				
				Attendance::store_list($device,$listAtt);
				$this->i_Counters[ImportBase::NOTICE_SUCCESS] += count($listAtt);
				$this->i_Counters[ImportBase::INSERTS] += count($listAtt);				
			}
			$ret->result = true;
			$ret->notify = "Se completó la operación con exito.";
		} catch (ErrorException $e) {
			JLog::add($e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
			$ret->result = false;
			$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ) );
			$ret->data = $error;
			$ret->notify = "Se presentó un error en la operación";
			$ret->sticky = true;
			$processfile->result_type = 3;
		}
		
		if( $ret->result === true ) {
			if( $ret->data === null ) {
				$ret->data = "Todos los registros se adicionaron Exitosamente";
				$processfile->result_type = 1;
			} else {
				$processfile->result_type = 2;
			}
		}
		
		$processfile->errors = $this->convertHTML( $ret->data );		
		$processfile->total_register = $this->i_Counters[ImportBase::TOTAL];
		$processfile->inserts_processed = $this->i_Counters[ImportBase::INSERTS];
		$processfile->updates_processed = $this->i_Counters[ImportBase::UPDATES];
		$processfile->type = 1;
		$processfile->processed_date = date('Y-m-d H:i:s');
		$processfile->result = $this->getCountResult().$this->getCountNoticeResult() ;
		$processfile->store();
		$this->renameProcessed($pathfilename);		
		return $ret;		
	}
	
	public function importPersonFile( $pathfilename , $enterprise_id ) {
		require_once $GLOBALS['path_to_sorcore']."utils/CSVFile.php";
		$fileimport = new CSVFile( $pathfilename, $this->personColumns[ImportFile::EMP_ROWS], "r");
		return parent::importPersonFile($pathfilename, $fileimport);
	}

	public function getPersonColumns( $fileimport ) {
		$datos1 = $fileimport->getNextRow();
		return $this->personColumns;
	}
	public function getCategoriesColumns( $fileimport ) {
		return array();
	}

}
