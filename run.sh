#!/usr/bin/env bash
set -e

Mode=$1

mkdir -p bin
rm -rf bin/*

APP_SOURCES=$(find src/app -name "*.java")
TEST_SOURCES=$(find src/test -name "*.java")

if [ -z "$Mode" ]; then
    echo "Nenhum argumento passado. echo \"Uso: ./build.sh [compile|run|test]\""
elif [ "$Mode" = "compile" ]; then
    javac -d bin -sourcepath src $APP_SOURCES
elif [ "$Mode" = "run" ]; then
    javac -d bin -sourcepath src $APP_SOURCES
    java -cp bin app.Main
elif [ "$Mode" = "test" ]; then
    javac -d bin -sourcepath src $APP_SOURCES
    javac -d bin -sourcepath src -classpath bin $TEST_SOURCES
    java -cp bin test.ClasseTest
else
    echo "Comando não encontrado. echo \"Uso: ./build.sh [compile|run|test]\""
fi