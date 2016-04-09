SET mypath=%~dp0
::set database=kivox
set database=ctc_srv2
::set file=kivox0808  cloudtimetest_15-06-30-20-43-20
set file=%database%
mysqladmin -u root -pnicolas drop %database%
mysqladmin -u root -pnicolas create %database%
::mysqldump -u root -pnicolas %database% > %mypath%\janusLeo.sql
mysql -h localhost -u root -pnicolas %database% < %mypath%\%file%.sql
pause