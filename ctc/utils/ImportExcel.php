<?php

include_once 'ImportFile.php';

/**
 * Description of ImportPersonCSV
 *
 * En las tres primeras filas debe ir el encabezado de cada columna.  Esta fila no se agrega en la base de datos.
 * Descripción de cada encabezado:
 * ENTERPRISE_NAME	Nombre de la empresa del empleado.  El usuario que importe el archivo debe tener permisos de escritura en esta empresa.
 * DEVICE_IDENT		Serial de los dispositivos separados por :
 * DEVICE_EMPID		Identificación en el dispositivo.
 * EMP_IDENT		Identificación del empleado.
 * EMP_NAME			Nombre del empleado
 * EMP_LASTNAME		Apellido del empleado
 * EMP_GENRE		Sexo del empleado.  F = Femenico  M = Masculino
 * EMP_POS_CODE		Código de cargo
 * EMP_POSITION		Nombre de cargo
 * EMP_AREA_CODE	Código de área
 * EMP_AREA			Nombre de área
 * EMP_STATUS		Estado del empleado.    S=Activo   N=Suspendido
 * EMP_SCHED_CODE	Código de Turno asignado al empleado.
 * EMP_SCHED		Nombre de Turno.
 * EMP_BRANCH_CODE	Código de Sucursal
 * EMP_BRANCH		Nombre de Sucursal
 * EMP_CC_CODE		Código Centro de Costos
 * EMP_COSTCENTER	Nombre Centro de Costos
 * CNTRACT_TYPE_CODE	Código Tipo de Contrato
 * CONTRACT_TYPE	Nombre Tipo de Contrato
 * START_DATE		Fecha de inicio de Contrato
 * END_DATE			Fecha Finalización de Contrato
	EMP_SALARY		Salario del empleado
 * @author Leonardo
 */

class ImportExcel  extends ImportFile  {
	
	protected $first = null;
	protected $second = null;
	protected $secondFlip = null;
	protected $third = null;
	protected $thirdFlip = null;
			
	public function importPersonFile( $pathfilename , $enterprise_id ) {
		require_once $GLOBALS['path_to_sorcore']."utils/ExcelFile.php";
		$fileimport = new ExcelFile( $pathfilename );
		return parent::importPersonFile($pathfilename, $fileimport);
	}

	/**
	 * Get the columns for data
	 * @param DataFile $fileimport
	 */
	public function getPersonColumns( $fileimport ) {
		$datos1 = $fileimport->getNextRow();
		$this->first = array_flip($datos1);
		$this->secondFlip = $fileimport->getNextRow();
		$this->second = array_flip($this->secondFlip);
		$this->thirdFlip = $fileimport->getNextRow();
		$this->third = array_flip($this->thirdFlip);
		return $this->third;		
	}
	
	public function getCategoriesColumns( $fileimport ) {
		$ret = array();
		$initCat = $this->first[ImportFile::CATEGORIES];
		for( $i = $initCat; ;$i++  ) {
			$countCols = count( $this->secondFlip );
			if( $countCols <= $i ) {
				break;
			}
			$catName = $this->secondFlip[$i];
			if( $catName == "" ) {
				break;
			}
			$nameCol = null;
			$descCol = null;
			if( $this->thirdFlip[$i] === ImportFile::CAT_NAME ){
				$nameCol = $i;
				$nextCol = $i + 1;
				if( $this->secondFlip[$nextCol] === ""  ||
						$this->secondFlip[$nextCol] === null ) {
					$descCol = $nextCol;
					$i = $nextCol;
				}
			} else
			if( $this->thirdFlip[$i] === ImportFile::CAT_DESC ){
				$descCol = $i;
				$nameCol = $i;
				$nextCol = $i + 1;
				if( $this->secondFlip[$nextCol] === "" ||
						$this->secondFlip[$nextCol] === null ) {
					$nameCol = $nextCol;
					$i = $nextCol;
				}
			}
			$ret[$catName] = array( ImportFile::CAT_NAME => $nameCol , 
				ImportFile::CAT_DESC => $descCol	);
		}
		return $ret;
	}
	
}
