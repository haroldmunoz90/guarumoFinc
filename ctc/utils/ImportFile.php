<?php

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

include_once 'ImportBase.php';

abstract class ImportFile extends ImportBase {

	
	abstract public function getPersonColumns($fileimport);
	abstract public function getCategoriesColumns( $fileimport );
	
	public function importPersonFile( $pathfilename, DataFile $fileimport ) {
		if( $GLOBALS['logQueries'] ) {
			JLog::add( "Procesando file $pathfilename" ,JLog::DEBUG, "cloudtime" );
		}
		$db = Connection::_getWriterConnection();
		$ret = new stdClass();
		
		$processfile = new ProcessFile();
		$processfile->file_url = pathinfo( $pathfilename, PATHINFO_FILENAME );
		$ret->file = $processfile->file_url;
		$processfile->loadWithFields($processfile->file_url, array( "file_url" ) );
		try {
			$db->beginTransaction();

			$this->resetCounters();
			if ( $fileimport->isReady() ) {				
				$personColumns = $this->getPersonColumns($fileimport);
				if ($GLOBALS['logQueries']) {
					$countcat = count( $personColumns );
					JLog::add( "personColumns = $countcat" ,JLog::DEBUG, "cloudtime" );
				}	
				
				$ENTERPRISE_NAME   =  $personColumns[ImportFile::ENTERPRISE_NAME    ];	  
				$DEVICE_IDENT      =  $personColumns[ImportFile::DEVICE_IDENT       ];	
				$DEVICE_EMPID      =  $personColumns[ImportFile::DEVICE_EMPID       ];	
				$EMP_IDENT         =  $personColumns[ImportFile::EMP_IDENT          ];	
				$EMP_NAME          =  $personColumns[ImportFile::EMP_NAME           ];
				$EMP_LASTNAME      =  $personColumns[ImportFile::EMP_LASTNAME       ];	
				$EMP_GENRE         =  $personColumns[ImportFile::EMP_GENRE          ];	
				$EMP_POS_CODE      =  $personColumns[ImportFile::EMP_POS_CODE       ];	
				$EMP_POSITION      =  $personColumns[ImportFile::EMP_POSITION       ];	
				$EMP_AREA_CODE     =  $personColumns[ImportFile::EMP_AREA_CODE      ];	
				$EMP_AREA          =  $personColumns[ImportFile::EMP_AREA           ];	
				$EMP_STATUS		   =  $personColumns[ImportFile::EMP_STATUS         ];	
				$EMP_SCHED_CODE    =  $personColumns[ImportFile::EMP_SCHED_CODE     ];	
				$EMP_SCHED         =  $personColumns[ImportFile::EMP_SCHED          ];	
				$EMP_BRANCH_CODE   =  $personColumns[ImportFile::EMP_BRANCH_CODE    ];	
				$EMP_BRANCH        =  $personColumns[ImportFile::EMP_BRANCH         ];	
				$EMP_CC_CODE       =  $personColumns[ImportFile::EMP_CC_CODE        ];	
				$EMP_COSTCENTER    =  $personColumns[ImportFile::EMP_COSTCENTER     ];	
				$CNTRACT_TYPE_CODE =  $personColumns[ImportFile::CNTRACT_TYPE_CODE  ];	
				$CONTRACT_TYPE     =  $personColumns[ImportFile::CONTRACT_TYPE      ];	
				$START_DATE        =  $personColumns[ImportFile::START_DATE         ];	
				$END_DATE          =  $personColumns[ImportFile::END_DATE           ];	
				$EMP_SALARY        =  $personColumns[ImportFile::EMP_SALARY          ];
				
				$categories = $this->getCategoriesColumns( $fileimport );
				if ($GLOBALS['logQueries']) {
					$countcat = count( $categories );
					JLog::add( "categories = $countcat" ,JLog::DEBUG, "cloudtime" );
				}			
				
				while ( ( $datos = $fileimport->getNextRow() ) !== FALSE ) { 
					$this->i_Counters[ImportBase::TOTAL]++;
					if ($GLOBALS['logQueries']) {
						$results = print_r($datos, true);
						JLog::add( "process = {$fileimport->getCurrentLine()} data: $results " ,JLog::DEBUG, "cloudtime" );
					}
					if( $datos === DataFile::COUNT_ERROR ) {
						$fila = $fileimport->getCurrentLine();
						$ret->data .= "<p>Numero de campos erroneo en la fila $fila</p>";
						$this->i_Counters[ImportBase::PERSONS_FAIL]++;
						continue;
					}
					$empIdent = $fileimport->getCellValue($datos,$EMP_IDENT);
					if( $empIdent === null || $empIdent === false || $empIdent === "" ) {
						$fila = $fileimport->getCurrentLine();
						$ret->data .= "<p>Identificación de empleado no suministrada en la fila $fila</p>";
						$this->i_Counters[ImportBase::PERSONS_FAIL]++;
						continue;
					}						
					try {
						$entName = $fileimport->getCellValue($datos,$ENTERPRISE_NAME);
						$enterprise = $this->getEnterprise($entName);
						$device_user_id = $fileimport->getCellValue($datos,$DEVICE_EMPID);
						$person = $this->getPerson($empIdent,$device_user_id,$enterprise->id);							
						$person->enterprise_id = $enterprise->id;
						
						$empBranCode = $fileimport->getCellValue($datos,$EMP_BRANCH_CODE);
						$empBranName = $fileimport->getCellValue($datos,$EMP_BRANCH);
						$branchoff = $this->getBranchOffCode($empBranCode,$empBranName,$enterprise->id );
						$person->branch_office_id = $branchoff->id;
						
						$devIdent = $fileimport->getCellValue($datos,$DEVICE_IDENT);
						$devices = $this->getDevices( $devIdent , $enterprise->id,$entName  );				
						$tags = $this->getTags( $categories , $fileimport, $datos, $enterprise->id, $entName  );
						
						$person->name = $fileimport->getCellValue($datos,$EMP_NAME);
						$person->last_name = $fileimport->getCellValue($datos,$EMP_LASTNAME);
						$person->genre = $fileimport->getCellValue($datos,$EMP_GENRE);
						$empPosCode = $fileimport->getCellValue($datos,$EMP_POS_CODE);
						$empPositionName = $fileimport->getCellValue($datos, $EMP_POSITION );
						$position = $this->getPositionCode($empPosCode,$empPositionName , $enterprise->id );
						$person->position_id = $position->id;
						$empAreaCode = $fileimport->getCellValue($datos,$EMP_AREA_CODE);
						$empAreaName = $fileimport->getCellValue($datos,$EMP_AREA);
						$area = $this->getArea($empAreaCode ,$empAreaName, $enterprise->id, $branchoff->id );
						$person->area_id = $area->id;
						$empStatus = $fileimport->getCellValue($datos,$EMP_STATUS);
						$empStatus = strtoupper( trim( $empStatus ) );
						if( $empStatus  === "S" || $empStatus == 1  ) {
							$person->status_id = 1;
						} else {
							$person->status_id = 2;
						}
						$empSchCode = $fileimport->getCellValue($datos,$EMP_SCHED_CODE);
						$empSchName = $fileimport->getCellValue($datos,$EMP_SCHED);
						$schedule = $this->getScheduleCode($empSchCode,$empSchName, $enterprise->id );
						$person->schedule_id = $schedule->id;
						
						$emCCCOde = $fileimport->getCellValue($datos, $EMP_CC_CODE );
						$empCCName = $fileimport->getCellValue($datos,$EMP_COSTCENTER);
						$costcenter = $this->getCostCenterCode($emCCCOde, $empCCName,$enterprise->id );
						$person->cost_center_id = $costcenter->id;
						$coTypCode = $fileimport->getCellValue($datos,  $CNTRACT_TYPE_CODE );
						$conTypName = $fileimport->getCellValue($datos,$CONTRACT_TYPE);
						$contractType = $this->getContractTypeCode($coTypCode ,$conTypName ,$enterprise->id );
						$startDate = $fileimport->getDateValue($datos,$START_DATE,'Y-m-d');
						$endDate = $fileimport->getDateValue($datos,$END_DATE,'Y-m-d');
						
						$salary = $fileimport->getCellValue($datos,$EMP_SALARY );
						$person->salary_month = $salary;

						$isInsert = ($person->id === null );
						$person->delDetail("devices");
						$person->delDetail("tags");
						if ( !$person->store(null, true, $contractType->id,null,$startDate,$endDate ) ){
							//throw new ErrorException("Couldn't store: $datos",$datos,null,null,null,null);
							$data = $this->convertHTML(implode(",",$datos));
							$ret->data .= "<p>$data</p>";
							$this->i_Counters[ImportBase::PERSONS_FAIL]++;
						} else {
							if( $devIdent === "*" ) {
								if( $isInsert ) {
									$person->addDevices($devices, true );
								}
							} else {
								if( strpos($devIdent, "!") === FALSE) {
									$person->addDevices($devices, true );
								} else {
									$person->addDevices($devices, true, false );
								}
							}
							$person->addTags( $tags );
							$this->i_Counters[ImportBase::PERSONS_SUCCESS]++;
							if( $isInsert ) {
								$this->i_Counters[ImportBase::INSERTS]++;
							} else {
								$this->i_Counters[ImportBase::UPDATES]++;
							}
						}

					} catch (ErrorException $e) {
						JLog::add($e->getMessage() . $e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
						$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ));
						$personname = $fileimport->getCellValue($datos,$EMP_NAME);
						$ret->data .= "<p>$personname,$error</p>";
						$this->i_Counters[ImportBase::PERSONS_FAIL]++;
					}
				}
			}
			$fileimport->close();
			foreach( $this->a_enterprises as $name => $enteprise ) {
				Device::reinitAllECounters($enteprise->id,true);
			}
			$ret->result = true;
			$ret->notify = "Se completó la operación con exito.";
			$db->commit();
		} catch (ErrorException $e) {
			$db->rollBack();
			JLog::add($e->getMessage() . $e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
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
		$processfile->type = 0;
		$processfile->processed_date = date('Y-m-d H:i:s');
		$processfile->result = $this->getCountResult().$this->getCountPersonResult() ;
		$processfile->store();
		$this->renameProcessed($pathfilename);

		return $ret;
	}
	
}
