#!/usr/bin/env bash

echo 'Waiting for emulator to boot up...'
$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'
echo ''
echo "Emulator started"

$ANDROID_HOME/platform-tools/adb devices

