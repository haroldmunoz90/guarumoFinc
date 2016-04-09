<?php

/**
 * Description of ImportPersonCSV
 *
 * @author Leonardo
 */
abstract class ImportBase {
	
	const	ROW_FAIL			  =	 "ROW_FAIL";
	const	ENTERPRISE_NAME   =  "ENTERPRISE_NAME";    
	const	DEVICE_IDENT      =  "DEVICE_IDENT";       
	const	DEVICE_EMPID      =  "DEVICE_EMPID";       
	const	EMP_IDENT         =  "EMP_IDENT";          
	const	EMP_NAME          =  "EMP_NAME";           
	const	EMP_LASTNAME      =  "EMP_LASTNAME";       
	const	EMP_GENRE         =  "EMP_GENRE";          
	const	EMP_POS_CODE      =  "EMP_POS_CODE";       
	const	EMP_POSITION      =  "EMP_POSITION";       
	const	EMP_AREA_CODE     =  "EMP_AREA_CODE";      
	const	EMP_AREA          =  "EMP_AREA";           
	const	EMP_STATUS        =  "EMP_STATUS";       
	const	EMP_SCHED_CODE    =  "EMP_SCHED_CODE";     
	const	EMP_SCHED         =  "EMP_SCHED";          
	const	EMP_BRANCH_CODE   =  "EMP_BRANCH_CODE";    
	const	EMP_BRANCH        =  "EMP_BRANCH";         
	const	EMP_CC_CODE       =  "EMP_CC_CODE";        
	const	EMP_COSTCENTER    =  "EMP_COSTCENTER";     
	const	CNTRACT_TYPE_CODE =  "CNTRACT_TYPE_CODE";  
	const	CONTRACT_TYPE     =  "CONTRACT_TYPE";      
	const	START_DATE        =  "START_DATE";         
	const	END_DATE          =  "END_DATE";           
	const	EMP_ROWS          =  "EMP_ROWS";   	
	const	CATEGORIES		  =	 "CATEGORIES";
	const	CAT_NAME		  = "NAME";
	const	CAT_DESC		  = "DESCRIPTION";
	const	EMP_SALARY		  = "EMP_SALARY";
	
	const ENTERPRISE = "ENTERPRISE";
	const COST_CENT = "COST_CENT";
	const BRANCH_OFF = "BRANCH_OFF";
	const SCHEDULES = "SCHEDULES";
	const DEVICES = "DEVICES";
	const TAGS = "TAGS";
	const AREAS = "AREAS";
	const POSITIONS = "POSITIONS";
	const CONCEPT = "CONCEPT";
	const UPDATE_CONCEPT = "UPDATE_CONCEPT";
	const CONTRACT_TYPES = "CONTRACT_TYPES";
	const CATEGORIES_TAG = "CATEGORIES_TAG";
	const PERSONS_SUCCESS = "PERSONS_SUCCESS";
	const PERSONS_FAIL = "PERSONS_FAIL";
	const NOTICE_SUCCESS = "NOTICE_SUCCESS";
	const NOTICE_FAIL = "NOTICE_FAIL";
	const INSERTS = "INSERTS";
	const UPDATES = "UPDATES";
	const TOTAL = "TOTAL";
	const NUM_COLS = "NUM_COLS";
	
	protected $a_enterprises = array();
	protected $a_cost_centers = array();
	protected $a_branch_off = array();
	protected $a_concept = array();
	protected $a_schedules = array();
	protected $a_devices = array();
	protected $a_persontags = array();
	protected $a_areas = array();
	protected $a_positions = array();	
	protected $a_contracttype = array();
	protected $a_category = array();
	
	protected $i_Counters = array();
	
	protected function resetCounters() {
		$this->i_Counters[self::INSERTS] = 0;
		$this->i_Counters[self::UPDATES] = 0;
		$this->i_Counters[self::TOTAL] = 0;
		foreach ($this->i_Counters as $name ) {
			$this->i_Counters[$name] = 0;
		}
	}	
	
	protected function getCountNoticeResult( ) {
		$retSt = "";
		if( $this->i_Counters[ImportBase::NOTICE_SUCCESS] ) {
			$retSt .= " <p>Registros Exitosos=" . $this->i_Counters[ImportBase::NOTICE_SUCCESS]."</p>";
		}
		if( $this->i_Counters[ImportBase::NOTICE_FAIL] ) {
			$retSt .= " <p>Registros Incorrectos=" . $this->i_Counters[ImportBase::NOTICE_FAIL]."</p>";
		}
		if( $this->i_Counters[ImportBase::UPDATE_CONCEPT] ) {
			$retSt .= " <p>Códigos de Tipos de Novedad Modificados=" . $this->i_Counters[ImportBase::UPDATE_CONCEPT]."</p>";
		}
		return $retSt;
	}
	
	protected function getCountPersonResult( ) {
		$retSt = "";
		if( $this->i_Counters[ImportBase::PERSONS_SUCCESS] ) {
			$retSt .= " <p>Registros Exitosos=" . $this->i_Counters[ImportBase::PERSONS_SUCCESS]."</p>";
		}
		if( $this->i_Counters[ImportBase::PERSONS_FAIL] ) {
			$retSt .= " <p>Registros Incorrectos=" . $this->i_Counters[ImportBase::PERSONS_FAIL]."</p>";
		}
		return $retSt;
	}
		
	protected function getCountResult() {
		$retSt = "<p>Número de entidades creadas:</p>";
		if( $this->i_Counters[self::ENTERPRISE] ) {
			$retSt .= " <p>Empresa=" . $this->i_Counters[self::ENTERPRISE]."</p>";
		}
		if( $this->i_Counters[self::COST_CENT] ) {
			$retSt .= " <p>Centro de Costos=" . $this->i_Counters[self::COST_CENT]."</p>";
		}
		if( $this->i_Counters[self::BRANCH_OFF] ) {
			$retSt .= " <p>Sucursales=" . $this->i_Counters[self::BRANCH_OFF]."</p>";
		}
		if( $this->i_Counters[self::SCHEDULES] ) {
			$retSt .= " <p>Turnos=" . $this->i_Counters[self::SCHEDULES]."</p>";
		}
		if( $this->i_Counters[self::DEVICES] ) {
			$retSt .= " <p>Dispositivos=" . $this->i_Counters[self::DEVICES]."</p>";
		}
		if( $this->i_Counters[self::TAGS] ) {
			$retSt .= " <p>Etiquetas=" . $this->i_Counters[self::TAGS]."</p>";
		}
		if( $this->i_Counters[self::AREAS] ) {
			$retSt .= " <p>Areas=" . $this->i_Counters[self::AREAS]."</p>";
		}
		if( $this->i_Counters[self::POSITIONS] ) {
			$retSt .= " <p>Cargos=" . $this->i_Counters[self::POSITIONS]."</p>";
		}
		if( $this->i_Counters[self::CONTRACT_TYPES] ) {
			$retSt .= " <p>Tipos de Contrato=" . $this->i_Counters[self::CONTRACT_TYPES]."</p>";	
		}
		if( $this->i_Counters[self::CATEGORIES_TAG] ) {
			$retSt .= " <p>Categories=" . $this->i_Counters[self::CATEGORIES_TAG]."</p>";	
		}
		if( $this->i_Counters[self::CONCEPT] ) {
			$retSt .= " <p>Tipos de Novedades=" . $this->i_Counters[self::CONCEPT]."</p>";	
		}
		return $retSt;
	}
	
	public function renameProcessed($pathfilename) {
		$newfilename = $pathfilename . ".processed.".date('Y-m-dH_i_s');
		while (file_exists($newfilename)) {			
			$randoN = rand(1,100000);
			$newfilename .= ".".$randoN;
		}
		$results = rename($pathfilename,$newfilename );
		
        if (!$results) {
            JLog::add(__FUNCTION__ . " rename $pathfilename res=" . $results, JLog::DEBUG, "cloudtime");
        }
		/*
		$do = unlink($pathfilename);
		if($do=="1"){ 
			JLog::add( "DELETED filename = $pathfilename" ,JLog::DEBUG, "cloudtime" );
		} else {
			$results = print_r(error_get_last(), true);
			JLog::add( "ERROR DELETING filename = $pathfilename " . $results ,JLog::ERROR, "cloudtime" );
			
		} 		*/		
	}	
	
		
	protected function convertHTML( $text ) {
		return str_replace( "'","", $text );
	}
	
	protected static function cutoff_words($text, $init, $length) {
		$initword = strpos($text, ' ', $init);
		if(strlen($text) > $length) {
			$text = substr($text, $initword, strpos($text, ' ', $length) - $initword);
		}
		return $text;
	}
	
	protected function getEnterprise( $name ) {
		$enterprise = $this->a_enterprises[$name];
		if( $enterprise === null ) {
			$user = BaseCore::getLoggedUser();
			if ( $user->hasPermission("assign-enterprise") ) {			
				$enterprise = new Enterprise();
				if( $enterprise->loadWithFields($name, array( "name" ) ) === false ){
					$enterprise->activation_date = date('Y-m-d H:i:S');
					$enterprise->mail = "NONE";
					if (! $enterprise->store(null,true) ){
						throw new ErrorException("Couldn't store: $name",null,null,null,null);
					}
					$this->i_Counters[self::ENTERPRISE]++;
				}
			} else {
				$enterprise = BaseCore::getLoggedEnterprise();
				if ( strcasecmp($enterprise->name, $name) != 0  ){
					throw new ErrorException("Requiere permisos para crear empresa: $name",null,null,null,null);
				}
			}
			$this->a_enterprises[$name] = $enterprise;
		}
		return $enterprise;
	}

	protected function getCostCenter( $code, $name, $enterprise_id ) {
		if( $name === null || $name === false || $name === "" ) {
			if( $code === null || $code === false || $code === "" ) {
				$name = "DEFAULT";
			} else {
				$name = $code;
			}
		}
		$costcenter = $this->a_cost_centers[$name];
		if( $costcenter === null ) {
			$costcenter = new CostCenter();			
			$costcenter->enterprise_id = $enterprise_id;
			if( $costcenter->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$costcenter->status_id = 1;
				$costcenter->code = $code;
				if ( !$costcenter->store(null,true) ){
					throw new ErrorException("Couldn't store: $name",null,null,null,null);
				}
				$this->i_Counters[self::COST_CENT]++;
			} else {
				if( $costcenter->code !== $code ) {
					$costcenter->code = $code;
					$costcenter->store(null,true);
				}
			}
			$this->a_cost_centers[$name] = $costcenter;
		}
		return $costcenter;
	}
	
	protected function getCostCenterCode( $code, $name, $enterprise_id ) {
		if( $code === null || $code === false || $code === "" ) {
			return $this->getCostCenter( $code, $name, $enterprise_id );
		}
		$costcenter = $this->a_cost_centers[$code];
		if( $costcenter === null ) {
			$costcenter = new CostCenter();			
			$costcenter->enterprise_id = $enterprise_id;
			if( $costcenter->loadWithFields($code, array( "code","enterprise_id" ) ) === false ){
				$costcenter->status_id = 1;
				$costcenter->name = $name;
				if ( !$costcenter->store(null,true) ){
					throw new ErrorException("Couldn't store CostCenter: $code",null,null,null,null);
				}
				$this->i_Counters[self::COST_CENT]++;
			} else {
				if( $costcenter->name !== $name ) {
					$costcenter->name = $name;
					$costcenter->store(null,true);
				}
			}
			$this->a_cost_centers[$code] = $costcenter;
		}
		return $costcenter;
	}
	
	protected function getConcept( $name, $code, $enterprise_id ) {		
		if( $name === null || $name === false || $name === "" ) {
			$name = $code;
			if( $name === null || $name === false || $name === "" ) {
				$name = "DEFAULT";
			}
		}
		$concept = $this->a_concept[$name];
		if( $concept->code != $code ) {					
			if( $GLOBALS['logQueries'] ) {
				JLog::add( "Código de Tipo de Novedad diferente al encontrado.  Actualizando Tipo de Novedad" ,JLog::DEBUG, "cloudtime" );
			}
			$concept = null;
			unset($this->a_concept[$name]);
			$this->i_Counters[self::UPDATE_CONCEPT]++;
		}		
		if( $concept === null ) {
			$concept = new Concept();
			$concept->enterprise_id = $enterprise_id;
			$found = $concept->loadWithFields($name, array( "name","enterprise_id" ) );
			
			if( $found !== false ) {
				if( $concept->code != $code ) {					
					if( $GLOBALS['logQueries'] ) {
						JLog::add( "Código de Tipo de Novedad diferente al encontrado.  Actualizando Tipo de Novedad" ,JLog::DEBUG, "cloudtime" );
					}
					$found = false;
					$this->i_Counters[self::UPDATE_CONCEPT]++;
				}
			}			
			if( $found === false  ) {
				$concept->status_id = 1;
				$concept->code = $code;
				$concept->type = Concept::TYPE_NOTICE;
				$concept->description = $name;
				if ( !$concept->store(null,true) ){
					throw new ErrorException("Couldn't store: $name",null,null,null,null);
				}
				$this->i_Counters[self::CONCEPT]++;
			}
			$this->a_concept[$name] = $concept;
		}
		return $concept;
	}
	
	
	protected function getConceptCode( $name, $code, $enterprise_id ) {		
		if( $code === null || $code === false || $code === "" ) {
			return $this->getConcept( $name, $code, $enterprise_id );
		}
		$concept = $this->a_concept[$code];
		if( $concept === null ) {
			$concept = new Concept();
			$concept->enterprise_id = $enterprise_id;
			$found = $concept->loadWithFields($code, array( "code","enterprise_id" ) );
						
			if( $found === false  ) {
				$concept->status_id = 1;
				$concept->name = $name;
				$concept->type = Concept::TYPE_NOTICE;
				$concept->description = $name;
				if ( !$concept->store(null,true) ){
					throw new ErrorException("Couldn't store Concept code : $code",null,null,null,null);
				}
				$this->i_Counters[self::CONCEPT]++;
			}
			$this->a_concept[$code] = $concept;
		}
		return $concept;
	}	
	
	protected function getBranchOff($code, $name, $enterprise_id ) {
		if( $name === null || $name === false || $name === "" ) {
			if( $code === null || $code === false || $code === "" ) {
				$name = "DEFAULT";
			} else {
				$name = $code;
			}
		}
		$branchoff = $this->a_branch_off[$name];
		if( $branchoff === null ) {
			$branchoff = new BranchOffice();
			$branchoff->enterprise_id = $enterprise_id;
			if( $branchoff->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$branchoff->status_id = 1;
				$branchoff->code = $code;
				if ( !$branchoff->store(null,true) ){
					throw new ErrorException("Couldn't store: $name",null,null,null,null);
				}
				$this->i_Counters[self::BRANCH_OFF]++;
			} else {
				if( $branchoff->code !== $code ) {
					$branchoff->code = $code;
					$branchoff->store(null,true);
				}
			}
			$this->a_branch_off[$name] = $branchoff;
		}
		return $branchoff;
	}
	
	protected function getBranchOffCode($code, $name, $enterprise_id ) {
		if( $code === null || $code === false || $code === "" ) {
			return $this->getBranchOff($code, $name, $enterprise_id );
		}
		if( !ctype_alnum($code) ) {
			throw new ErrorException("Código Sucursal no alfanumérico: $code",null,null,null,null);
		}
		$branchoff = $this->a_branch_off[$code];
		if( $branchoff === null ) {
			$branchoff = new BranchOffice();
			$branchoff->enterprise_id = $enterprise_id;
			if( $branchoff->loadWithFields($code, array( "code","enterprise_id" ) ) === false ){
				$branchoff->status_id = 1;
				$branchoff->name = $name;
				if ( !$branchoff->store(null,true) ){
					throw new ErrorException("Couldn't store BranchOffice: $code",null,null,null,null);
				}
				$this->i_Counters[self::BRANCH_OFF]++;
			} else {
				if( $branchoff->name !== $name ) {
					$branchoff->name = $name;
					$branchoff->store(null,true);
				}
			}
			$this->a_branch_off[$code] = $branchoff;
		}
		return $branchoff;
	}
	
	protected function getSchedule($code, $name, $enterprise_id ) {
		if( $name === null || $name === false || $name === "" ) {
			if( $code === null || $code === false || $code === "" ) {
				$name = "DEFAULT";
			} else {
				$name = $code;
			}
		}
		$schedule = $this->a_schedules[$name];
		if( $schedule === null ) {
			$schedule = new Schedule();
			$schedule->enterprise_id = $enterprise_id;
			if( $schedule->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$schedule->creation_date = date('Y-m-d H:i:S');
				$schedule->status_id = 1;
				$schedule->code = $code;
				if ( !$schedule->store(null,true) ){
					throw new ErrorException("Couldn't store Schedule: $name",null,null,null,null);
				}
				$this->i_Counters[self::SCHEDULES]++;
			} else {
				if( $schedule->code !== $code ) {
					$schedule->code = $code;
					$schedule->store(null,true);
				}
			}
			$this->a_schedules[$name] = $schedule;
		}
		return $schedule;
	}
	
	protected function getScheduleCode($code, $name, $enterprise_id ) {
		if( $code === null || $code === false || $code === "" ) {
			return $this->getSchedule($code, $name, $enterprise_id );
		}
		if( $name === null || $name === false || $name === "" ) {			
			$name = $code;
		}
		$schedule = $this->a_schedules[$code];
		if( $schedule === null ) {
			$schedule = new Schedule();
			$schedule->enterprise_id = $enterprise_id;
			if( $schedule->loadWithFields($code, array( "code","enterprise_id" ) ) === false ){
				$schedule->creation_date = date('Y-m-d H:i:S');
				$schedule->status_id = 1;
				$schedule->name = $name;
				if ( !$schedule->store(null,true) ){
					throw new ErrorException("Couldn't store Schedule: $code",null,null,null,null);
				}
				$this->i_Counters[self::SCHEDULES]++;
			} else {
				if( $schedule->name !== $name ) {
					$schedule->name = $name;
					$schedule->store(null,true);
				}
			}
			$this->a_schedules[$code] = $schedule;
		}
		return $schedule;
	}
	
	protected function getAllDevices( $enterprise_id ) {
		$alldev = $enterprise_id.'*';
		$devices = $this->a_devices[$alldev];
		if( $devices === null ) {
			$device = new Device();
			$filter = new Filter();
			$filter->omitAllAuth(true);
            $filter->eq_("enterprise_id", $enterprise_id);
			$devices = $device->getAll( $filter );
			$this->a_devices[$alldev] = $devices;
		}
		return $devices;
	}
	
	protected function getTags( $categories, $fileimport, $datos, $enterprise_id  ) {
		$persontags = array();
		foreach( $categories as $nameCat => $arrayCols ) {
			$tagname = $fileimport->getCellValue( $datos, $arrayCols[ self::CAT_NAME ] );
			$persontag = $this->a_persontags[$tagname];
			if( $persontag === null ) {
				$objCat = $this->getCategory($nameCat, $enterprise_id);
				$persontag = new Tag();
				$persontag->enterprise_id = $enterprise_id;
				$persontag->tag_category_id = $objCat->id;
				if( $persontag->loadWithFields($tagname, array( "name","enterprise_id","tag_category_id" ) ) === false ){
					$persontag->description = $fileimport->getCellValue( $datos, $arrayCols[ self::CAT_DESC ] );
					if ( !$persontag->store(null,true,false) ){
						throw new ErrorException("Couldn't store: $tagname",$tagname,null,null,null,null);
					}
					$this->i_Counters[self::TAGS]++;
				}
				$this->a_persontags[$tagname] = $persontag;
			}
			array_push($persontags, $persontag);
		}		
		return $persontags;
	}
	
	protected function getDevices( $identifications, $enterprise_id, $enterprise_name ) {
		if( $identifications === "*" ) {
			$devices = $this->getAllDevices(  $enterprise_id );
			if( count( $devices )) {
				return $devices;
			}
		}
		if( $identifications === null || $identifications === false || $identifications === "" ) {
			$identifications = "DEFAULT_".$enterprise_name;
		}
		$strDevices = explode(":", $identifications );
		$devices = array();
		foreach( $strDevices as $identification ) {
			if( $identification === "!" ) {
				continue;
			}
			$device = $this->a_devices[$identification];
			if( $device === null ) {
				$device = new Device();
				$device->enterprise_id = $enterprise_id;
				if( $device->loadWithFields($identification, array( "identification","enterprise_id" ) ) === false ){
					$device->activation_date = date('Y-m-d H:i:S');
					$device->status_id = 1;
					$device->device_type_id = 1;
					$device->name = $identification;
					if ( !$device->store(null,true,false) ){
						throw new ErrorException("Couldn't store: $identification",$identification,null,null,null,null);
					}
					$this->i_Counters[self::DEVICES]++;
				}
				$this->a_devices[$identification] = $device;
			}
			array_push($devices, $device);
		}		
		return $devices;
	}
	
	protected function getArea($code, $name, $enterprise_id, $branchOfId ) {
		if( $name === null || $name === false || $name === "" ) {			
			$area = new Area();
			$area = $area->createDefaultRoot();
			$area->enterprise_id = $enterprise_id;
			$area->branch_office_id = $branchOfId;
			if( $area->loadWithFields($area->area_category_id, array( "area_category_id","enterprise_id","branch_office_id" ) ) === false ){	
				$area->lft = Nested::INIT_TREE;
				$area->rgt = Nested::INIT_TREE + 1;
				$area->code = $code;
				$area->store(null,true);
			}
			$name = $area->name;
		}		

		$area = $this->a_areas[$name.$enterprise_id.$branchOfId];
		if( $area === null ) {
			$area = new Area();
			$area->enterprise_id = $enterprise_id;
			$area->branch_office_id = $branchOfId;
			if( $area->loadWithFields($name, array( "name","enterprise_id","branch_office_id" ) ) === false ){				
				$area->activation_date = date('Y-m-d H:i:S');
				$area->status_id = 1;
				$area->code = $code;
				if ( !$area->store(null,true) ){
					throw new ErrorException("Couldn't store: $name",null,null,null,null);
				}
				$this->i_Counters[self::AREAS]++;
			} else {
				if( $area->code !== $code ) {
					$area->code = $code;
					$area->store(null,true);
				}
			}
			$this->a_areas[$name.$enterprise_id.$branchOfId] = $area;
		}
		return $area;
	}
		
	protected function getCategory( $name, $enterprise_id ) {
		$category = $this->a_category[$name];
		if( $category === null ) {
			$category = new CategoryTag();
			$category->enterprise_id = $enterprise_id;
			if( $category->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$category->status_id = 1;
				if ( !$category->store(null,true) ){
					throw new ErrorException("Couldn't store CategoryTag : $name",null,null,null,null);
				}
				$this->i_Counters[self::CATEGORIES_TAG]++;
			}
			$this->a_category[$name] = $category;
		}
		return $category;
	}
	
	protected function getContractType($code, $name, $enterprise_id ) {
		if( $name === null || $name === false || $name === "" ) {
			if( $code === null || $code === false || $code === "" ) {
				$name = "DEFAULT";
			} else {
				$name = $code;
			}
		}		
		$contracttype = $this->a_contracttype[$name];
		if( $contracttype === null ) {
			$contracttype = new ContractType();
			$contracttype->enterprise_id = $enterprise_id;
			if( $contracttype->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$contracttype->status_id = 1;
				$contracttype->code = $code;
				if ( !$contracttype->store(null,true) ){
					throw new ErrorException("Couldn't store ContractType : $name",null,null,null,null);
				}
				$this->i_Counters[self::CONTRACT_TYPES]++;
			} else {
				if( $contracttype->code !== $code ) {
					$contracttype->code = $code;
					$contracttype->store(null,true);
				}
			}
			$this->a_contracttype[$name] = $contracttype;
		}
		return $contracttype;
	}
	
	protected function getContractTypeCode($code, $name, $enterprise_id ) {
		if( $code === null || $code === false || $code === "" ) {
			return $this->getContractType($code, $name, $enterprise_id );
		}		
		$contracttype = $this->a_contracttype[$code];
		if( $contracttype === null ) {
			$contracttype = new ContractType();
			$contracttype->enterprise_id = $enterprise_id;
			if( $contracttype->loadWithFields($code, array( "code","enterprise_id" ) ) === false ){
				$contracttype->status_id = 1;
				$contracttype->name = $name;
				if ( !$contracttype->store(null,true) ){
					throw new ErrorException("Couldn't store ContractType: $code",null,null,null,null);
				}
				$this->i_Counters[self::CONTRACT_TYPES]++;
			} else {
				if( $contracttype->name !== $name ) {
					$contracttype->name = $name;
					$contracttype->store(null,true);
				}
			}
			$this->a_contracttype[$code] = $contracttype;
		}
		return $contracttype;
	}
	
	protected function getPosition($code, $name, $enterprise_id ) {
		if( $name === null || $name === false || $name === "" ) {
			if( $code === null || $code === false || $code === "" ) {
				$name = "DEFAULT";
			} else {
				$name = $code;
			}
		}		
		$position = $this->a_positions[$name];
		if( $position === null ) {
			$position = new Position();
			$position->enterprise_id = $enterprise_id;
			if( $position->loadWithFields($name, array( "name","enterprise_id" ) ) === false ){
				$position->status_id = 1;
				$position->code = $code;
				if ( !$position->store(null,true) ){
					throw new ErrorException("Couldn't store: $name",null,null,null,null);
				}
				$this->i_Counters[self::POSITIONS]++;
			} else {
				if( $position->code !== $code ) {
					$position->code = $code;
					$position->store(null,true);
				}
			}
			$this->a_positions[$name] = $position;
		}
		return $position;
	}
	
	protected function getPositionCode( $code, $name, $enterprise_id ) {
		if( $code === null || $code === false || $code === "" ) {
			return $this->getPosition($code, $name, $enterprise_id );
		}		
		$position = $this->a_positions[$code];
		if( $position === null ) {
			$position = new Position();
			$position->enterprise_id = $enterprise_id;
			if( $position->loadWithFields($code, array( "code","enterprise_id" ) ) === false ){
				$position->status_id = 1;
				$position->name = $name;
				if ( !$position->store(null,true) ){
					throw new ErrorException("Couldn't store Position: $code",null,null,null,null);
				}
				$this->i_Counters[self::POSITIONS]++;
			} else {
				if( $position->name !== $name ) {
					$position->name = $name;
					$position->store(null,true);
				}
			}
			$this->a_positions[$code] = $position;
		}
		return $position;
	}
	
	protected function getPerson( $identification, $device_user_id, $enterprise_id ) {		
		$person = new Person();
		$person->identification = $identification;
		$person->enterprise_id = $enterprise_id;
		if( $person->loadWithFields($identification, array( "identification", "enterprise_id" ) )  === false  ) {
			if( $device_user_id !== null && strlen(trim($device_user_id)) > 0 ) {
				$person->loadWithFields($device_user_id, array( "device_user_id", "enterprise_id" ) );
			}
			$person->identification = $identification;
		} else {
			if( $device_user_id !== null && strlen(trim($device_user_id)) > 0 ) {
				$person->device_user_id = $device_user_id;
			}
		}
		return $person;
	}
	
}
