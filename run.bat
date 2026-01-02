@echo off
setlocal enabledelayedexpansion

set Mode=%1

if "%Mode%"=="" (
    echo Nenhum argumento passado. Para rodar, utilize: compile, run ou test
    goto :eof
)

if not exist bin mkdir bin

del /q bin\* >nul 2>&1

rem =========================
rem Coletar fontes do app
rem =========================
set APP_SOURCES=
for /R src\app %%f in (*.java) do (
    set APP_SOURCES=!APP_SOURCES! %%f
)

rem =========================
rem Coletar fontes do test
rem =========================
set TEST_SOURCES=
for /R src\test %%f in (*.java) do (
    set TEST_SOURCES=!TEST_SOURCES! %%f
)

if "%Mode%"=="compile" (
    javac -d bin -sourcepath src %APP_SOURCES%
    goto :eof
)

if "%Mode%"=="run" (
    javac -d bin -sourcepath src %APP_SOURCES%
    java -cp bin app.Main
    goto :eof
)

if "%Mode%"=="test" (
    javac -d bin -sourcepath src %APP_SOURCES%
    javac -d bin -sourcepath src -classpath bin %TEST_SOURCES%
    java -cp bin test.ClasseTest
    goto :eof
)

echo Comando nao encontrado. Utilize apenas: compile, run ou test
