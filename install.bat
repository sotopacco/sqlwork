echo Instalador de la base de datos BDUniversidad
echo Autor: Franklin Soto
echo 10-08-2022
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo se ejecuto correctamente la base de datos
pause