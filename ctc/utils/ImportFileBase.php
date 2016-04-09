<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
include_once 'ImportBase.php';

abstract class ImportFileBase extends ImportBase {
	
	public $expectedColumns = null;
	public $expectedColumnsFlip = null;
	public $fixedColumns = null;
	
	
	abstract function processData($fileimport, $datos, $fila, $enterpriseId,&$retData );

	function getExpectedNumColumns(){
		return $this->fixedColumns[ImportBase::NUM_COLS];
	}
	
	public function import( $pathfilename, $enterpriseId ) {
		$ext = pathinfo($pathfilename, PATHINFO_EXTENSION);
		$fileimport = null;
		if( $ext === "xlsx" || $ext === "xls"  ) {
			require_once $GLOBALS['path_to_sorcore']."utils/ExcelFile.php";
			$fileimport = new ExcelFile( $pathfilename );
		} else if( $ext === "csv"  ) {
			require_once $GLOBALS['path_to_sorcore']."utils/CSVFile.php";
			$fileimport = new CSVFile( $pathfilename, $this->getExpectedNumColumns(), "r");			
		}
		return $this->import_file($pathfilename, $enterpriseId, $fileimport);
	}
	
	public function getExpectedColumns( $fileimport ) {
		$this->expectedColumnsFlip = $fileimport->getNextRow();
		if( $this->expectedColumnsFlip === DataFile::COUNT_ERROR ) {
			throw new ErrorException("Wrong Column Numbers:",null,null,null,null);
		}
		$this->expectedColumns = array_flip($this->expectedColumnsFlip);
		return $this->expectedColumns;		
	}
	
	public function getColumnNumber( $name ) {
		if( isset( $this->expectedColumns [$name] ) ){
			return $this->expectedColumns [$name];
		}
		return $this->fixedColumns [$name];
	}
	
	public function getValue( $fileimport, $datos, $name  ) {
		$colNum = $this->getColumnNumber($name);
		$value = $fileimport->getCellValue($datos,$colNum);
		return $value;
	}
	
	public function getDateValue( $fileimport, $datos, $name  ) {
		$colNum = $this->getColumnNumber($name);
		$value = $fileimport->getDateValue($datos,$colNum,'Y-m-d');
		return $value;
	}
	
	public function import_file( $pathfilename, $enterpriseId, DataFile $fileimport ) {
		if( $GLOBALS['logQueries'] ) {
			JLog::add( "Procesando file Notice $pathfilename" ,JLog::DEBUG, "cloudtime" );
		}
		$db = Connection::_getWriterConnection();
		$ret = new stdClass();
		
		$processfile = new ProcessFile();
		$processfile->file_url = pathinfo( $pathfilename, PATHINFO_FILENAME );
		$processfile->enterprise_id = $enterpriseId;
		$ret->file = $processfile->file_url;
		$processfile->loadWithFields($processfile->file_url, array( "file_url", "enterprise_id" ) );
		try {
			$db->beginTransaction();

			$this->resetCounters();
			if ( $fileimport->isReady() ) {				
				$expectedColumns = $this->getExpectedColumns($fileimport);
				if ($GLOBALS['logQueries']) {
					$countcat = count( $expectedColumns );
					JLog::add( "expectedColumns = $countcat" ,JLog::DEBUG, "cloudtime" );
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
						$this->i_Counters[ImportBase::ROW_FAIL]++;
						continue;
					}	
					try {
						if( !$this->processData( $fileimport, $datos, $fileimport->getCurrentLine(),$enterpriseId, $ret->data ) ) {
							$this->i_Counters[ImportBase::ROW_FAIL]++;
							continue;
						}						
						if( true ) {
							$this->i_Counters[self::INSERTS]++;
						} else {
							$this->i_Counters[self::UPDATES]++;
						}
					} catch (ErrorException $e) {
						JLog::add($e->getTraceAsString() ,JLog::ERROR, "cloudtime" );
						$error = $this->convertHTML(ImportBase::cutoff_words( $e->getMessage(), 12, 60 ));
						//$data = implode(",",$datos);
						$ret->data .= "<p>$datos[0],$error</p>";
						$this->i_Counters[ImportBase::ROW_FAIL]++;
					}
				}
			}
			$fileimport->close();
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
		$processfile->type = 1;
		$processfile->processed_date = date('Y-m-d H:i:s');
		$processfile->result = $this->getCountResult();
		$processfile->store();
		$this->renameProcessed($pathfilename);
		return $ret;		
	}
	
		
}