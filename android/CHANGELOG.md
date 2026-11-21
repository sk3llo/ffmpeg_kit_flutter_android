## 3.0.0-beta01

* FFmpeg n9.1 (was n8.1.3), with FFmpeg 9's multi-threaded fftools, ported from FFmpegKitNext. The Java API is unchanged.
* HTTPS certificates are checked by default (FFmpeg 9): expired, self-signed and wrong-host certificates now fail, and GnuTLS checks against Android's system certificates. `-tls_verify 0` before an input's `-i` turns the check off for it.
* Removed `ffmpeg` options: `-vsync` (use `-fps_mode`), `-map_channel`, `-psnr`, `-top`, `-absf`, `-vbsf`, `-filter_script`, `-filter_complex_script`, `-qphist` and `-adrift_threshold`. `-copytb` is accepted but has no effect.
* Newer libraries, in the variants that include them: GnuTLS 3.8.14 with GNU Libtasn1 4.21.0, FreeType 2.15.0, HarfBuzz 15.2.0, OpenH264 2.7.0, snappy 1.3.1 and giflib 6.1.3.

## 2.3.0

* FFmpeg n8.1.3. FFmpeg and every third-party library are now built from source at pinned versions, most of them upgraded. `LICENSES/NOTICE.txt` in the AAR lists each library with its version and source.
* Rotation set with `-display_rotation`, `-display_hflip` and `-display_vflip` is now applied, and FFprobe reports each stream's side data again.
* Video with no colour information is no longer tagged as RGB when encoded.
* x86_64: FFmpeg's own x86 assembly is now built in; it was left out before.
* The AAR carries `LICENSES/`: the licence notices for FFmpeg, FFmpegKit and each third-party library in this variant. Apps don't package it.

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