#!/usr/bin/env bash

mvn -DskipTests=true -Dmaven.javadoc.skip=true --projects :iot-e2e-common --also-make clean install