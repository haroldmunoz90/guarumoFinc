<?php

$row['10']['something'] = "21";
$row['5']['something'] = "42";

//$row = array( 10 => "diez",  5 => "cinco" );
echo "<p>row:<p>" ;
print_r( $row );

$maxIdx = max(array_keys($row)) + 1;
$newarray = array_fill(0,  $maxIdx , 0 );

echo "<p>newarray:<p>" ;
print_r( $newarray );

$newrow = $row + $newarray;
ksort($newrow);
echo "<p>newrow:<p>" ;
print_r( $newrow );