<?php

$name = "FirsRule3";

$atom = <<<ATOM
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<atom:entry xmlns:atom="http://www.w3.org/2005/Atom">
<atom:title>$name</atom:title>
<atom:summary>First Rule via Rest8</atom:summary>
<metadata>
	<categories>
		<value>PayRoll</value>
		<value>PayRoll</value>
	</categories>
	<format><value>brl</value></format>
	<state/>
</metadata>
</atom:entry>
ATOM;

$ruleDSL = <<<RULE
<rule>  
<name>RegularHour14</name>  
<modelVersion>1.0</modelVersion>  
<attributes/>  
<metadataList/>  
<lhs>    
	<fact>      
		<constraintList>        
			<constraints>          
				<fieldConstraint>            
				<value>REGULARHOUR</value>            
				<operator>==</operator>            
				<constraintValueType>1</constraintValueType>            
				<expression>              
				<parts/>            
				</expression>            
				<factType>Concept</factType>            
				<fieldName>name</fieldName>            
				<fieldType>String</fieldType>          
				</fieldConstraint>        
			</constraints>      
		</constraintList>      
		<factType>Concept</factType>      
		<boundName>concept</boundName>      
		<isNegated>false</isNegated>    
	</fact>  
</lhs>  
<rhs>    
	<assert>      
		<fieldValues>        
			<fieldValue>          
				<field>concept_id</field>          
				<value>=concept.id</value>          
				<nature>3</nature>          
				<type>Integer</type>        
			</fieldValue>        
			<fieldValue>          
				<field>hours</field>          
				<value>15</value>          
				<nature>1</nature>          
				<type>BigDecimal</type>        
			</fieldValue>      
		</fieldValues>      
		<factType>HourConcept</factType>      
		<boundName>hourConcept</boundName>      
		<isBound>true</isBound>    
	</assert>  
</rhs>  
<isNegated>false</isNegated>
</rule>
RULE;

$your_username = "admin";
$your_password  = "admin";

$headers  =  array( 
"Content-type: application/atom+xml",
"Accept: application/atom+xml"
);



//$url = "http://cloudtimecontrol.com:8083/iclock/cdata?SN=" . 
//$url = "http://localhost:8082/iclock/cdata?SN=" . 
//$url = "http://".$GLOBALS['server_url'].":".$GLOBALS['jboss_port']."/iclock/cdata?
$url = "http://cloudtimecontrol.com:8083/reglas/rest/packages/Datacontrol/assets";

error_log("HLBM:url " . $url );
$ch = curl_init($url);
		
//curl_setopt($ch, CURLOPT_URL, "https://www.blogger.com/atom/".$blog_id);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_TIMEOUT, 4);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_USERPWD, $your_username.':'.$your_password);
curl_setopt($ch, CURLOPT_POSTFIELDS, $atom );
$data = curl_exec($ch);


error_log("HLBM:data".$data);

$tag_regex = "/<uuid><value>(.*)?<\/value><\/uuid>/";
$found = preg_match($tag_regex , $data, $matches);
if( $found ) {
	error_log("HLBM:matches=" . $matches[1] );
}


if (curl_errno($ch)) {
 print curl_error($ch);
} else {
 curl_close($ch);
}


$headers  =  array( 
"Content-type: application/xml",
"Accept: application/xml"
);
$url = "http://cloudtimecontrol.com:8083/reglas/rest/packages/Datacontrol/assets/$name/source";

error_log("HLBM:url2 " . $url );
$ch = curl_init($url);
		
//curl_setopt($ch, CURLOPT_URL, "https://www.blogger.com/atom/".$blog_id);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_TIMEOUT, 4);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_USERPWD, $your_username.':'.$your_password);
curl_setopt($ch, CURLOPT_POSTFIELDS, $ruleDSL );
$data = curl_exec($ch);

if (curl_errno($ch)) {
 print curl_error($ch);
} else {
 curl_close($ch);
}


/*
$data = <<<RSA
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><atom:entry xmlns:atom="http://www.w3.org/2005/Atom" xml:base="http://cloudtimecontrol.com:8083/reglas/rest/packages/Datacontrol/assets/FirstRule20"><atom:title>FirstRule20</atom:title><atom:id>http://cloudtimecontrol.com:8083/reglas/rest/packages/Datacontrol/assets/FirstRule20</atom:id><atom:published>2014-06-11T00:56:08.962-05:00</atom:published><atom:author><atom:name></atom:name></atom:author><atom:content type="application/octet-stream" src="http://cloudtimecontrol.com:8083/reglas/rest/packages/Datacontrol/assets/FirstRule20/binary"/><atom:summary>First Rule via Rest8</atom:summary><metadata><uuid><value>88c63d00-39dc-4c5d-8859-e9480d135fc4</value></uuid><categories><value>PayRoll</value><value>PayRoll</value></categories><format><value>brl</value></format><state><value>Draft</value></state><versionNumber><value>0</value></versionNumber><checkinComment><value>Initial</value></checkinComment><archived><value>false</value></archived></metadata></atom:entry>
RSA;
$tag_regex = "/<uuid><value>(.*)?<\/value><\/uuid>/";


echo $data;
$found = preg_match($tag_regex , $data, $matches);
if( $found ) {
	error_log("HLBM:matches=" . $matches[1] . " found=".$found );
}
print_r($matches);
//<primaryAddress>(.+?)<\/primaryAddress>/
error_log("matches=".$matches[0]);
// $data contains the result of the post...
echo $matches;
echo "hola";

$a = '<page>
<username>someone</username>
  <id>3020778</id>
  <text xml:space="preserve"> The quick brown fox. </text>
</page>';

//preg_match_all("(\<.+\>(.+)\<\/.+\>)U",$a, $r);  
preg_match("/<id>(.*)?<\/id>/",$a, $r); 
print_r($r);
*/

?>