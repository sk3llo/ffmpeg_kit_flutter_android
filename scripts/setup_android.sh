#!/bin/bash

# Android AAR 下载
ANDROID_URL="https://github.com/sk3llo/ffmpeg_kit_flutter/releases/download/6.0.2/ffmpeg-kit-full-gpl-6.0.LTS.aar"
mkdir -p libs
curl -L $ANDROID_URL -o libs/com.arthenica.ffmpegkit-flutter-6.0.aar