#!/bin/bash

# Define the URL of the APK file
APK_URL="https://lonelyteapot.github.io/open-transit-app/open-transit.apk"

# Define the local filename for the APK
APK_FILE="/tmp/open-transit.apk"

# Download the APK file
echo "Downloading $APK_URL"
wget "$APK_URL" -O "$APK_FILE"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Success"

    # Install the APK using adb (make sure your device is connected and adb is installed)
    echo "Installing $APK_FILE"
    adb install -r "$APK_FILE"

    # Clean up the downloaded APK file
    rm "$APK_FILE"
else
    echo "Failed to download the APK"
fi
