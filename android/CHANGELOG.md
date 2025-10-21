## 2.0.1

* Added missing includes: <stddef.h> and "libavutil_file.h"
* Fixed uncommenting the SAF protocol injection: ~/scripts/android/ffmpeg.sh

## 2.0.0

* Initial FFmpeg 8.0 release
* Added proguard-rules.pro

## 1.1.0

# UPGRADED LIBS AND SCRIPTS:
- Upgraded `freetype` from 2.13.0 to 2.13.3 (scripts/source.sh)
- Upgraded `harfbuzz` from 8.0.1 to 11.3.3 (scripts/source.sh)
- Upgraded `fontconfig` from 2.16.2 to 2.17.1 (scripts/source.sh)
- Added support for `harfbuzz` library for Android (scripts/android/ffmpeg.sh) and iOS (scripts/apple/ffmpeg.sh)
- Removed `sudo` from `libass.sh` script to fix missing libunibreak link in (scripts/apple/libass.sh)

# RESULT
- Fixed `ERROR: libass >= 0.11.0 not found using pkg-config`
- Fixed missing `drawtext` filter (by adding harfbuzz)

## 1.0.0

* Initial release