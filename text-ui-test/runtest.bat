@echo off
setlocal enableextensions
pushd %~dp0

cd ..
call gradlew shadowJar

cd build\libs
for /f "tokens=*" %%a in (
    'dir /b duke-0.0.1.jar'
) do (
    set jarloc=%%a
)

java -jar %jarloc% < ..\..\text-ui-test\input.txt > ..\..\text-ui-test\ACTUAL.TXT

cd ..\..\text-ui-test

FC ACTUAL.TXT EXPECTED.TXT >NUL && ECHO Test passed! || Echo Test failed!
