@echo off
setlocal

rem Android AAR download URL
set ANDROID_URL=https://github.com/sk3llo/ffmpeg_kit_flutter/releases/download/7.0/ffmpeg-kit-full-gpl-7.0.aar

rem Create libs directory if it doesn't exist
if not exist libs (
    mkdir libs
)

rem Download the AAR file
curl -L %ANDROID_URL% -o libs\com.arthenica.ffmpegkit-flutter-7.0.aar

endlocal
