<?php

$str = 'SELECT * from ( select * ) limit 10';

echo preg_replace('/select/i', 'SELECT SQL_CALC_FOUND_ROWS', $str, 1);