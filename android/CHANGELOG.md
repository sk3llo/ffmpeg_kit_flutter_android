## 2.2.3

* No library changes: the native libraries are byte-identical to the previous release (FFmpeg n8.1.2).
* Fixed the POM metadata. The name and description no longer say "FFmpeg v8.1.1", and the project and SCM URLs now point to this repository instead of a repository that does not exist.

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