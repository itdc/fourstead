@echo off

set foursteadRoot=%HOMEDRIVE%%HOMEPATH%\.fourstead

mkdir "%foursteadRoot%"

copy /-y src\stubs\Fourstead.yaml "%foursteadRoot%\Fourstead.yaml"
copy /-y src\stubs\after.sh "%foursteadRoot%\after.sh"
copy /-y src\stubs\aliases "%foursteadRoot%\aliases"

set foursteadRoot=
echo Fourstead initialized!
