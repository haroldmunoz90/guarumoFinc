<?php

require_once "C:\\work2\\wamp\\www\\sorcore\\".'utils/SoranJMX.php';

$servers = array( 
	'kivox3' => array(            // Configurations.
		'url' => 'http://localhost',
		'port' => '7777' ),
	'jboss' => array(            // Configurations.
		'url' => 'http://localhost',
		'port' => '8080' )
	);

$variables = array( 
'0' => array(
	'appname' => 'jboss',
	'showname' => 'Memoria (Non Heap) Usada',
	'showname_eng' => 'Active threads in the system',
	'variable' => 'java.lang:type=Memory/NonHeapMemoryUsage/used' ),          
'1' => array(
	'appname' => 'jboss',
	'showname' => 'Memoria (Non Heap) Máxima Disponible',
	'showname_eng' => 'Maximum available non-heap memory',
	'variable' => 'java.lang:type=Memory/NonHeapMemoryUsage/max' ),           
'2' => array(
	'appname' => 'jboss',
	'showname' => 'Memoria (Heap) Usada',
	'showname_eng' => 'Used heap memory',
	'variable' => 'java.lang:type=Memory/HeapMemoryUsage/used' ),             
'3' => array(
	'appname' => 'jboss',
	'showname' => 'Memoria (Heap) Máxima Disponible',
	'showname_eng' => 'Maximum available heap memory',
	'variable' => 'java.lang:type=Memory/HeapMemoryUsage/max' ),              
'4' => array(
	'appname' => 'jboss',
	'showname' => '',
	'showname_eng' => 'Active threads in the system',
	'variable' => 'java.lang:type=Threading/ThreadCount' ),                   
'5' => array(
	'appname' => 'jboss',
	'showname' => 'Threads Demonios',
	'showname_eng' => 'Count of threads marked as daemons in the system',
	'variable' => 'java.lang:type=Threading/DaemonThreadCount' ),             
'6' => array(
	'appname' => 'jboss',
	'showname' => 'Pico de Threads',
	'showname_eng' => 'Peak thread count',
	'variable' => 'java.lang:type=Threading/PeakThreadCount' ),               
'7' => array(
	'appname' => 'jboss',
	'showname' => 'Threads Iniciados',
	'showname_eng' => 'Count of threads started since system start',
	'variable' => 'java.lang:type=Threading/TotalStartedThreadCount' ),       
'8' => array(
	'appname' => 'jboss',
	'showname' => 'Tiempo Activo',
	'showname_eng' => 'Total uptime of JVM',
	'variable' => 'java.lang:type=Runtime/Uptime' ),                          
'9' => array(
	'appname' => 'jboss',
	'showname' => 'Hora de Inicio del JVM',
	'showname_eng' => 'Time when starting the JVM',
	'variable' => 'java.lang:type=Runtime/StartTime' ),                       
'10' => array(
	'appname' => 'jboss',
	'showname' => 'Clases Cargadas Actualmente',
	'showname_eng' => 'Number of currently loaded classes',
	'variable' => 'java.lang:type=ClassLoading/LoadedClassCount' ),           
'11' => array(
	'appname' => 'jboss',
	'showname' => 'Clases descargadas',
	'showname_eng' => 'Number of unloaded classes',
	'variable' => 'java.lang:type=ClassLoading/UnloadedClassCount' ),         
'12' => array(
	'appname' => 'jboss',
	'showname' => 'Total Clases Cargadas',
	'showname_eng' => 'Number of classes loaded in total',
	'variable' => 'java.lang:type=ClassLoading/TotalLoadedClassCount' ),      
'15' => array(
	'appname' => 'jboss',
	'showname' => 'Memoria Física',
	'showname_eng' => 'The amount of free physical memory for the OS',
	'variable' => 'java.lang:type=OperatingSystem/FreePhysicalMemorySize' ),  
'16' => array(
	'appname' => 'jboss',
	'showname' => 'Tiempo de CPU',
	'showname_eng' => 'The cpu time used by this process',
	'variable' => 'java.lang:type=OperatingSystem/ProcessCpuTime' ), 			
'17' => array(
	'appname' => 'jboss',
	'showname' => 'Promedio de Carga de CPU',
	'showname_eng' => 'CPU average for the overall system',
	'variable' => 'java.lang:type=OperatingSystem/SystemLoadAverage' ),		   
'18' => array(
	'appname' => 'kivox',
	'showname' => 'Porcentaje de Spoof',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/PercentageActiveSpoof' ),		   
'19' => array(
	'appname' => 'kivox',
	'showname' => 'Promedio de Tiempo de Entrenamiento',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/AverageTrainingTime' ),		       
'20' => array(
	'appname' => 'kivox',
	'showname' => 'Promedio de Tiempo de Verificación',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/AverageVerificationTime' ),		   
'21' => array(
	'appname' => 'kivox',
	'showname' => 'Promedio de Tiempo de Spoof',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/AverageActiveSpoofTime' ),		   
'22' => array(
	'appname' => 'kivox',
	'showname' => 'Operaciones de Verificación',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/VerificationOperations' ),		   
'23' => array(
	'appname' => 'kivox',
	'showname' => 'Operaciones de Procesamiento de Audios',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/AudioProcessingOperations' ),		
'24' => array(
	'appname' => 'kivox',
	'showname' => 'Detecciones de Spoof',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/PassiveSpoofDetections' ),		   
'25' => array(
	'appname' => 'kivox',
	'showname' => 'Promedio de tiempo de procesamiento de Audios',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/AverageAudioProcessingTime' ),		
'26' => array(
	'appname' => 'kivox',
	'showname' => 'Operaciones de Entrenamiento',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/TrainingOperations' ),		       
'27' => array(
	'appname' => 'kivox',
	'showname' => 'Número Total de Ejecuciones',
	'showname_eng' => '',
	'variable' => 'Agnitio:type=KivoxServer/NumberOfTotalExecutions' ),	
'28' => array(
	'appname' => 'kivox',
	'showname' => 'Memoria (Non Heap) Usada',
	'variable' => 'java.lang:type=Memory/NonHeapMemoryUsage/used' ),          
'29' => array(
	'appname' => 'kivox',
	'showname' => 'Memoria (Non Heap) Usada',
	'variable' => 'java.lang:type=Memory/NonHeapMemoryUsage/max' ),           
'30' => array(
	'appname' => 'kivox',
	'showname' => 'Memoria (Heap) Usada',
	'variable' => 'java.lang:type=Memory/HeapMemoryUsage/used' ),             
'31' => array(
	'appname' => 'kivox',
	'showname' => 'Memoria (Heap) Usada',
	'variable' => 'java.lang:type=Memory/HeapMemoryUsage/max' ),              
'32' => array(
	'appname' => 'kivox',
	'showname' => '',
	'showname_eng' => 'Active threads in the system',
	'variable' => 'java.lang:type=Threading/ThreadCount' ),                   
'33' => array(
	'appname' => 'kivox',
	'showname' => 'Threads Demonios',
	'showname_eng' => 'Count of threads marked as daemons in the system',
	'variable' => 'java.lang:type=Threading/DaemonThreadCount' ),             
'34' => array(
	'appname' => 'kivox',
	'showname' => 'Pico de Threads',
	'showname_eng' => 'Peak thread count',
	'variable' => 'java.lang:type=Threading/PeakThreadCount' ),               
'35' => array(
	'appname' => 'kivox',
	'showname' => 'Threads Iniciados',
	'showname_eng' => 'Count of threads started since system start',
	'variable' => 'java.lang:type=Threading/TotalStartedThreadCount' ),       
'36' => array(
	'appname' => 'kivox',
	'showname' => 'Tiempo Activo',
	'showname_eng' => 'Total uptime of JVM',
	'variable' => 'java.lang:type=Runtime/Uptime' ),                          
'37' => array(
	'appname' => 'kivox',
	'showname' => 'Hora de Inicio del JVM',
	'showname_eng' => 'Time when starting the JVM',
	'variable' => 'java.lang:type=Runtime/StartTime' ),                       
'38' => array(
	'appname' => 'kivox',
	'showname' => 'Clases Cargadas Actualmente',
	'showname_eng' => 'Number of currently loaded classes',
	'variable' => 'java.lang:type=ClassLoading/LoadedClassCount' ),           
'39' => array(
	'appname' => 'kivox',
	'showname' => 'Clases descargadas',
	'showname_eng' => 'Number of unloaded classes',
	'variable' => 'java.lang:type=ClassLoading/UnloadedClassCount' ),         
'40' => array(
	'appname' => 'kivox',
	'showname' => 'Total Clases Cargadas',
	'showname_eng' => 'Number of classes loaded in total',
	'variable' => 'java.lang:type=ClassLoading/TotalLoadedClassCount' ),      
'41' => array(
	'appname' => 'kivox',
	'showname' => 'Memoria Física',
	'showname_eng' => 'The amount of free physical memory for the OS',
	'variable' => 'java.lang:type=OperatingSystem/FreePhysicalMemorySize' ),  
'42' => array(
	'appname' => 'kivox',
	'showname' => 'Tiempo de CPU',
	'showname_eng' => 'The cpu time used by this process',
	'variable' => 'java.lang:type=OperatingSystem/ProcessCpuTime' ), 			
'43' => array(
	'appname' => 'kivox',
	'showname' => 'Promedio de Carga de CPU',
	'showname_eng' => 'CPU average for the overall system',
	'variable' => 'java.lang:type=OperatingSystem/SystemLoadAverage' ),	

 
	);
                      

$jsonObjs = SoranJMX::getJmxAttributes($servers,$variables);

if (is_array($jsonObjs) && !empty($jsonObjs)) {
	foreach ($jsonObjs as $entity) {
		var_dump($entity);
	}
}

//echo $resp;