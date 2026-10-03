## 2.2.3

* No library changes: the native libraries are byte-identical to the previous release (FFmpeg n8.1.2).
* Fixed the POM metadata. The name and description no longer say "FFmpeg v8.1.1", and the project and SCM URLs now point to this repository instead of a repository that does not exist.
* Removed GPL-3.0 from the POM licenses. This variant is built without `--enable-gpl`, so it is LGPL-3.0.

## 2.1.0

* Fixed the FFmpeg 8.0 compatibility issue across all platforms. The problem was that `all_channel_counts` was being set AFTER the filter was created, but FFmpeg 8.0 requires it to be set DURING filter creation.

## 2.0.0

* Initial FFmpeg 8.0 release
* Added proguard-rules.pro

## 1.1.0

* Added proguard-rules.pro to keep `ffmpeg` dependencies when minification is enabled
* Upgraded `freetype` from **2.13.0** to **2.13.3**
* Upgraded `harfbuzz` from **8.0.1** to **11.3.3**
* Upgraded `fontconfig` from **2.16.2** to 2.17.1
* Added support for `harfbuzz` library in order to support `drawtext` filter
* Fixed missing `libunibreak` for `libass.sh`
* Downgraded required Kotlin version to `v1.8.22`
* Upgraded com.android.library from `8.11.1` to `8.12.0`

## 1.0.0

* Initial release