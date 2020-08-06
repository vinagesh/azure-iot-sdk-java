#!/usr/bin/env bash

echo '## START EMULATOR ASYNCHRONOUSLY ##'

echo 'Listing available android sdks for installation'
$ANDROID_HOME/tools/bin/sdkmanager --list | grep system-images

emulatorImage='system-images;android-28;google_apis;x86_64'
avdName='Pixel_9.0'

echo ''
echo "Installing emulator image ${emulatorImage}"
echo "y" | $ANDROID_HOME/tools/bin/sdkmanager --install $emulatorImage

echo ''
echo "Creating android emulator with name ${avdName}"
echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n $avdName -k $emulatorImage --force

echo ''
echo 'Listing active android emulators'
$ANDROID_HOME/emulator/emulator -list-avds

echo ''
echo "Starting emulator in background thread"
nohup $ANDROID_HOME/emulator/emulator -avd $avdName -no-snapshot > /dev/null 2>&1 &


## MVN INSTALL TO BUILD TEST JARS ##
mvn -DskipTests=true -Dmaven.javadoc.skip=true --projects :iot-e2e-common --also-make clean install


echo '## GRADLE BUILD APKs ##'

cd %build-root%\iot-e2e-tests\android
gradle wrapper
gradlew :clean :app:clean :app:assembleDebug
gradlew :app:assembleDebugAndroidTest -PIOTHUB_CONNECTION_STRING=%IOTHUB_CONNECTION_STRING% -PIOTHUB_CONN_STRING_INVALIDCERT=%IOTHUB_CONN_STRING_INVALIDCERT% -PIOT_DPS_CONNECTION_STRING=%IOT_DPS_CONNECTION_STRING% -PIOT_DPS_ID_SCOPE=%DEVICE_PROVISIONING_SERVICE_ID_SCOPE% -PDPS_GLOBALDEVICEENDPOINT_INVALIDCERT=%INVALID_DEVICE_PROVISIONING_SERVICE_GLOBAL_ENDPOINT% -PPROVISIONING_CONNECTION_STRING_INVALIDCERT=%INVALID_DEVICE_PROVISIONING_SERVICE_CONNECTION_STRING% -PFAR_AWAY_IOTHUB_CONNECTION_STRING=%FAR_AWAY_IOTHUB_CONNECTION_STRING% -PCUSTOM_ALLOCATION_POLICY_WEBHOOK=%CUSTOM_ALLOCATION_POLICY_WEBHOOK% -PIS_BASIC_TIER_HUB=%IS_BASIC_TIER_HUB% -PIS_PULL_REQUEST=%isPullRequestBuild%


echo '## WAIT FOR EMULATOR ##'
echo 'Waiting for emulator to boot up...'
$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'
echo ''
echo "Emulator started"

$ANDROID_HOME/platform-tools/adb devices
