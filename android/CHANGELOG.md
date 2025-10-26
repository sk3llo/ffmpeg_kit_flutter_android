## 2.1.0

* Fixed the FFmpeg 8.0 compatibility issue across all platforms. The problem was that `all_channel_counts` was being set AFTER the filter was created, but FFmpeg 8.0 requires it to be set DURING filter creation.

## 2.0.0

* Initial FFmpeg 8.0 release
* Added proguard-rules.pro

## 1.0.3

* Updated jniLibs

## 1.0.2

* Downgraded Kotlin from v2.2.0 to v1.8.22

## 1.0.1

- Fixed packaging issues


## 1.0.0

- Initial release