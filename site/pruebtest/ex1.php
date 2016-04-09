<?php
set_time_limit(0);
$doc = new ExcelBook(null, null, true);

$sheet = $doc->addSheet("foobar");
#write by cell - we skip the first row since libxl will output a demo message

$sheet->write(1,0,'Company');
$sheet->write(1,1,'King Foo');

#write by row
$count = 0;
$rcount = 0;
for($i=1;$i<501;$i++) {
$sheet->writeRow($i, array('Nieuwlandlaan', 16 + $i, 'B135'.$i, 3200 + $i, 'Aarschot'));
if($count >= 5000) {
	usleep(250000);
	$count = 0;
	error_log("Done with $rcount rows");
}
$count++;
$rcount++;
}

$doc->save('example4.xlsx');
