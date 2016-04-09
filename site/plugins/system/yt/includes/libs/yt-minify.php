<?php
/*
 * ------------------------------------------------------------------------
 * Copyright (C) 2009 - 2013 The YouTech JSC. All Rights Reserved.
 * @license - GNU/GPL, http://www.gnu.org/licenses/gpl.html
 * Author: The YouTech JSC
 * Websites: http://www.smartaddons.com - http://www.cmsportal.net
 * ------------------------------------------------------------------------
*/
// no direct access
defined('_JEXEC') or die;
if(J_VERSION=='3'){
	jimport('joomla.filesystem.folder');
}elseif(J_VERSION=='2'){
	jimport('joomla.filesystem.file');
}
include_once("minify/lib/Minify/HTML.php");
class YT_Minify extends JObject
{
	var $optimizeFolder;
	var $optimizeCSSExclude;
	var $optimizeJSExclude;
	var $optimizeMergeFile;
	
	function __construct()
	{
		global $app;
		$this->optimizeFolder 		= $app->getTemplate(true)->params->get('optimizeFolder', 'yt-assets');
		$this->optimizeCSSExclude   = $app->getTemplate(true)->params->get('optimizeCSSExclude', '');
		$this->optimizeCSSExclude = str_replace(' ', '', $this->optimizeCSSExclude);
		if(strpos($this->optimizeCSSExclude, ',')){
			$this->optimizeCSSExclude = explode(',', $this->optimizeCSSExclude);
		}
		$this->optimizeJSExclude	= $app->getTemplate(true)->params->get('optimizeJSExclude', '');
		$this->optimizeJSExclude = str_replace(' ', '', $this->optimizeJSExclude);
		if(strpos($this->optimizeJSExclude, ',')){
			$this->optimizeJSExclude = explode(',', $this->optimizeJSExclude); //var_dump($this->optimizeJSExclude); die();
		}
		$this->optimizeMergeFile	= $app->getTemplate(true)->params->get('optimizeMergeFile', 0);
		
		@JFolder::create($this->optimizeFolder);
		$this->setMinifyConfigFile();
	}
	
	function optimizecss()
	{
		// Get body string after render
		$body = JResponse::getBody();
		$body = explode("</head>", $body, 2);
		// Replace CSS library
		$exclude = $this->optimizeCSSExclude;
		$exclude = ($exclude != '') ? (is_array($exclude) ? $exclude : array($exclude)) : array();
		
		if(is_array($exclude)) {
			$exclude = array_merge($exclude, $this->getExclude($body[0]));
		}
		
		$body[0] 	= $this->optimizeReplaceFile($body[0], "css", $exclude, $this->optimizeMergeFile); 
		$body 		= $body[0]."</head>".$body[1];
		
		if($body) {
			JResponse::setBody($body);
		}
		return true;
	}	
	

	function optimizejs()
	{
		// Get body string after render
		$body = JResponse::getBody();
		$body = explode("</head>", $body, 2);
		// Replace CSS library
		$exclude = $this->optimizeJSExclude;
		$exclude = ($exclude != '') ? (is_array($exclude) ? $exclude : array($exclude)) : array();
		
		if(is_array($exclude)) {
			$exclude = array_merge($exclude, $this->getExclude($body[0]));
		}
		
		$body[0] 	= $this->optimizeReplaceFile($body[0], "js", $exclude, $this->optimizeMergeFile);
		$body 		= $body[0]."</head>".$body[1];
		
		if($body) {
			JResponse::setBody($body);
		}
		return true;
	}	
	
	function clearCache()
	{
		@JFolder::delete($this->optimizeFolder);
		@JFolder::create($this->optimizeFolder);
		die('Clear cache successful !');
	}
	
	function setMinifyConfigFile()
	{
		// Read config file content and Write to it.
		$content = JFile::read(JPATH_PLUGINS.J_SEPARATOR."system".J_SEPARATOR."yt".J_SEPARATOR."includes".J_SEPARATOR."libs".J_SEPARATOR."minify".J_SEPARATOR."config_default.php");
		$content = explode("\n", $content);
		
		if(stristr(PHP_OS, 'WIN'))
		{
			$path1 = str_replace(J_SEPARATOR, "/", JPATH_ROOT.J_SEPARATOR);
			$path2 = str_replace(J_SEPARATOR, "/", JPATH_ROOT.J_SEPARATOR.$this->optimizeFolder.J_SEPARATOR);
		}
		else
		{
			$path1 = JPATH_ROOT.J_SEPARATOR;
			$path2 = JPATH_ROOT.J_SEPARATOR.$this->optimizeFolder.J_SEPARATOR;
		}
		
		$content[13] = '$min_allowDebugFlag = 1;';
		$content[40] = '$min_cachePath = \''.$path2.'\';';
		$content[54] = '$min_documentRoot = \''.$path1.'\';';
		$content[86] = '$min_serveOptions[\'maxAge\'] = 0;';
		//$content[112] = '$min_serveOptions[\'minApp\'][\'noMinPattern\'] = \'\';';
		
		JFile::write(JPATH_PLUGINS.J_SEPARATOR."system".J_SEPARATOR."yt".J_SEPARATOR."includes".J_SEPARATOR."libs".J_SEPARATOR."minify".J_SEPARATOR."config.php", implode("\n", $content));
	}
	
	function optimizeReplaceFile($bodyString, $type, $arrFileExclude, $optimizeMergeFile = 1)
	{
		$strLink 		= JURI::root()."plugins/system/yt/includes/libs/minify/?f=";
		//$strLink 		= JURI::root()."templates/".JFactory::getApplication()->getTemplate()."/libs/minify/?f=";
		$strFullLink 	= ($type=="js") ? '<script language="javascript" charset="utf-8" type="text/javascript" src="'.$strLink.'"></script>' : 
		'<link rel="stylesheet" href="'.$strLink.'" type="text/css" />';
		
		// Find file
		$scriptRegex =($type=="js")?"/<script[^>]*?>[\s\S]*?<\/script>/i":"/<link [^>]+(\/>)/i";
		preg_match_all($scriptRegex, $bodyString, $matches);
			
		// Find link...
		$regString = "/([^\"\'=]+\.(".$type."))[\"\']/i";	
		$remotePath = str_replace(str_replace(J_SEPARATOR, "/", $_SERVER['DOCUMENT_ROOT']), "", str_replace(J_SEPARATOR, "/", JPATH_SITE)) . '/'; //die($remotePath);
		
		$stroptimizeMergeFile = "";
		$strPath = "";
		//echo '<pre>'; var_dump($matches[0]); die();
		//echo JPATH_SITE;
		foreach($matches[0] as $match)
		{
			preg_match_all($regString, $match, $arrMatchs);
			//echo '<pre>'; var_dump($arrMatchs); die();
			if(isset($arrMatchs[1][0])){ //echo'----------'.($arrMatchs[1][0]).'<br>';
				$filePath = $arrMatchs[1][0];		
				if(strpos($filePath, 'http') !== 0) {
					if( JURI::root(true)!="" && strpos($filePath, JURI::root(true)) !== false ){ 
						$strTemp = str_replace(JURI::root(true), "", $filePath);			
					}else{
						$strTemp = str_replace($remotePath, "", $filePath);			
					}
							
				} else {
					if(strpos($filePath, JURI::root()) === false) continue;
					$strTemp = "/".substr($filePath, strlen(JURI::root()));
				}
				//echo'+++'.($strTemp).'<br>';
				$strTemp = str_replace("//", "/", $strTemp);
				if(substr($strTemp, 0, 1)!=='/'){
					$strTemp = '/'.$strTemp;
				}
				
				if(!file_exists(str_replace(J_SEPARATOR, "/", JPATH_SITE)."/".$strTemp)) continue;			
				
				$replace = true;
				if($arrFileExclude != '')
				{
					foreach($arrFileExclude as $string)
					{
						if(@strpos($filePath, $string) !== false  && $string != '')
						{
							$replace = false;
							if($type == "js" && $stroptimizeMergeFile != "" && 1==0)
							{
								preg_match_all("/<script[^>]*?>[\s\S]*?<\/script>/i", $match, $result);
								if(isset($result[0][0]))
								{
									$stroptimizeMergeFile   = substr($stroptimizeMergeFile, 0, strlen($stroptimizeMergeFile)-1);
									$bodyString = str_replace($match, str_replace($strLink, $strLink.$stroptimizeMergeFile, $strFullLink)."\n".$match, $bodyString);
									$stroptimizeMergeFile   = "";
								}
							}
							break;
						}
					}
				}
				// Replace with another link
				if($replace)
				{
					// Not optimizeMergeFile files
					if($optimizeMergeFile == 0)
					{
						$strTemp    = $strLink.$strTemp;
						$bodyString = str_replace($filePath, $strTemp, $bodyString);
					}
					if($optimizeMergeFile == 1)
					{
						if(substr($strTemp, 0, 1)==='/'){
							$strTemp = substr($strTemp, 1);
						}
						// optimizeMergeFile files
						$strReplace = "";
						if(strpos($stroptimizeMergeFile, $strTemp) === false) $stroptimizeMergeFile .= $strTemp.",";				
						// Remove link to css, js file
						foreach($matches[0] as $string)
						{
							if(strpos($string, $filePath) !== false)
							{
								$bodyString = str_replace($string, $strReplace, $bodyString);
							}
						}					
					}				
				}
			}
			else
			{
				// Process internal javascript
				if($type == "js" && $stroptimizeMergeFile != "" && $optimizeMergeFile == 1  && 1==0)
				{
					preg_match_all("/<script[^>]*?>[\s\S]*?<\/script>/i", $match, $result);
					if(isset($result[0][0]))
					{
						$stroptimizeMergeFile   = substr($stroptimizeMergeFile, 0, strlen($stroptimizeMergeFile)-1);
						$bodyString = str_replace($match, str_replace($strLink, $strLink.$stroptimizeMergeFile, $strFullLink)."\n".$match, $bodyString);
						$stroptimizeMergeFile   = "";
					}
				}
			}
		}
		// optimizeMergeFile file
		if($optimizeMergeFile == "1" && $stroptimizeMergeFile != "")
		{
			$stroptimizeMergeFile = substr($stroptimizeMergeFile, 0, strlen($stroptimizeMergeFile)-1);			
			if($type == "js") {
				$bodyString = $bodyString."\n".str_replace($strLink, $strLink.$stroptimizeMergeFile, $strFullLink)."\n";
			} else {
				$bodyString = str_replace("</title>", "</title>\n".str_replace($strLink, $strLink.$stroptimizeMergeFile, $strFullLink), $bodyString);
			}
		}
		$bodyString = str_replace(array("  \n  \n", "\n  \n  ", "" ), '', $bodyString); 
		return $bodyString; 
	}
	
	/* Get list of CSS link avoid by: <!--[if ... <![endif]-->*/
	function getExclude($bodyString)
	{
		// Find script		
		$scriptRegex = "/<!--\[if[^\]]*?\][\s\S]*?<!\[endif\]-->/i";
		preg_match_all($scriptRegex, $bodyString, $matches);
		$regString   = "/([^\"\'=]+\.(css))[\"\']/i";
		
		if(isset($matches[0]))
			preg_match_all($regString, implode("", $matches[0]), $arrMatchs);
		else
			return array();
		
		if(isset($arrMatchs[1]))
			return $arrMatchs[1];
		else
			return array();
	}
}