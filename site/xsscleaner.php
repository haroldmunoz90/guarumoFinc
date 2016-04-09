<?php

class lx_externalinput_clean {

    public static function cleanArray(&$arr, $func = null) {
        foreach ($arr as $key => $value) {
			$valuebef = $value;
            $arr[$key] = lx_externalinput_clean::xss($value);
            if ($func) {
                $arr[$key] = lx_externalinput_clean::$func($value);
            }
			if( $valuebef !== $arr[$key] ) {
				JLog::Add(__FUNCTION__ . " REQUEST[$key] Change from:" . $valuebef . " to:". $arr[$key],JLog::ERROR, "sorcore" );
			}			
        }
        return $arr;
    }

    public static function xss(&$val) {
        //axe all non printables 
        $val = preg_replace('/([\x00-\x08\x0b-\x0c\x0e-\x19])/', '', $val);

        $search = 'abcdefghijklmnopqrstuvwxyz';
        $search .= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $search .= '1234567890!@#$%^&*()';
        $search .= '~`";:?+/={}[]-_|\'\\';
        for ($i = 0; $i < strlen($search); $i++) {
            //axe all non characters 
            $val = preg_replace('/(&#[xX]0{0,8}' . dechex(ord($search[$i])) . ';?)/i', $search[$i], $val);
            $val = preg_replace('/(&#0{0,8}' . ord($search[$i]) . ';?)/', $search[$i], $val);
        }

        $ra1 = array(
            'javascript', 'vbscript', 'expression',
            'applet', 'meta', 'xml', 'blink', 'link',
            'style', 'script', 'embed', 'object',
            'iframe', 'frame', 'frameset', 'ilayer',
            'layer', 'bgsound', 'title', 'base');
        $ra2 = array(
            'onabort', 'onactivate', 'onafterprint',
            'onafterupdate', 'onbeforeactivate',
            'onbegin',
            'onbeforecopy', 'onbeforecut',
            'onbeforedeactivate', 'onbeforeeditfocus',
            'onbeforepaste', 'onbeforeprint',
            'onbeforeunload', 'onbeforeupdate', 'onblur',
            'onbounce', 'oncellchange', 'onchange', 'onclick',
            'oncontextmenu', 'oncontrolselect', 'oncopy',
            'oncut', 'ondataavailable', 'ondatasetchanged',
            'ondatasetcomplete', 'ondblclick', 'ondeactivate',
            'ondrag', 'ondragend', 'ondragenter',
            'ondragleave', 'ondragover', 'ondragstart',
            'ondrop', 'onerror', 'onerrorupdate',
            'onfilterchange', 'onfinish', 'onfocus',
            'onfocusin', 'onfocusout', 'onhelp', 'onkeydown',
            'onkeypress', 'onkeyup', 'onlayoutcomplete',
            'onload', 'onlosecapture', 'onmousedown',
            'onmouseenter', 'onmouseleave', 'onmousemove',
            'onmouseout', 'onmouseover', 'onmouseup',
            'onmousewheel', 'onmove', 'onmoveend', 'onmovestart',
            'onpaste', 'onpropertychange', 'onreadystatechange',
            'onreset', 'onresize', 'onresizeend', 'onresizestart',
            'onrowenter', 'onrowexit', 'onrowsdelete',
            'onrowsinserted', 'onscroll', 'onselect',
            'onselectionchange', 'onselectstart', 'onstart',
            'onstop', 'onsubmit', 'onunload');
        $ra = array_merge($ra1, $ra2);

        $found = true;
        while ($found == true) {
            $val_before = $val;
            for ($i = 0; $i < sizeof($ra); $i++) {
                $pattern = '/(\b';// leo se adiciona whole word
                for ($j = 0; $j < strlen($ra[$i]); $j++) {
                    if ($j > 0) {
                        $pattern .= '((&#[xX]0{0,8}([9ab]);)||(&#0{0,8}([9|10|13]);))*';
                    }
                    $pattern .= $ra[$i][$j];
                }

                $pattern .= '\b)/i';
                //break all on* 
                $replacement = substr($ra[$i], 0, 2) . '<x>' . substr($ra[$i], 2);
                $val = preg_replace($pattern, $replacement, $val);
                if ($val_before == $val)
                    $found = false;
            }
        }
        return $val;
    }

    public static function getAlphaNum(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNum");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
			if ( $param1 === null ) {
            $val = preg_replace("/[^\p{L}\p{Nd}_]/", '', $val);
			} else {
				$val = preg_replace($param1, '', $val);
			}
        }
        return $val;
    }
	
	public static function getAlphaNumSlash(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNum");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
            $val = preg_replace("/[^\p{L}\p{Nd}_\/]/", '', $val);
        }
        return $val;
    }	
	
    public static function getAlphaNumDot(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNum");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
            $val = preg_replace("/[^\p{L}\p{Nd}_\.]/", '', $val);
        }
        return $val;
    }

    public static function getAlphaNumSpace(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNumSpace");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
            $val = preg_replace("/[^\p{L}\p{Nd}_ ]/", '', $val);
        }
        return $val;
    }

    public static function getNum(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNumSpace");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
            $val = preg_replace("/[^0-9]/", '', $val);
        }
        return $val;
    }

    public static function getFloat(&$val, $xss = true, $param1 = null) {
        if (is_array($val)) {
            $val = lx_externalinput_clean::cleanArray($val, "getAlphaNumSpace");
        } else {
            if ($xss) {
                $val = lx_externalinput_clean::xss($val);
            }
            $val = preg_replace("/[^0-9+-]/", '', $val);
        }
        return $val;
    }

    public static function cleanInput() {
        lx_externalinput_clean::cleanArray($_REQUEST);
        lx_externalinput_clean::cleanArray($_POST);
        lx_externalinput_clean::cleanArray($_GET);
    }

    public static function cleanInputVar($var, $func = null, $xss = true, $param1 = null ) {
        if (array_key_exists($var, $_REQUEST)) {
			$value = $_REQUEST[$var];
            if ($xss) {
                $_REQUEST[$var] = lx_externalinput_clean::xss($_REQUEST[$var]);
            }
            if ($func) {
                $_REQUEST[$var] = lx_externalinput_clean::$func($_REQUEST[$var], $xss,$param1);
            }
			if( $value !== $_REQUEST[$var] ) {
				JLog::Add(__FUNCTION__ . " REQUEST[$var] Change from:" . $value . " to:". $_REQUEST[$var],JLog::ERROR, "sorcore" );
			}
        }
        if (array_key_exists($var, $_POST)) {
            if ($xss) {
                $_POST[$var] = lx_externalinput_clean::xss($_POST[$var]);
            }
            if ($func) {
                $_POST[$var] = lx_externalinput_clean::$func($_POST[$var], $xss,$param1);
            }
        }
        if (array_key_exists($var, $_GET)) {
            if ($xss) {
                $_GET[$var] = lx_externalinput_clean::xss($_GET[$var]);
            }
            if ($func) {
                $_GET[$var] = lx_externalinput_clean::$func($_GET[$var], $xss,$param1);
            }
        }
    }

}

?>