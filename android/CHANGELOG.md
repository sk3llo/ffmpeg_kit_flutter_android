## 3.0.0-beta01

* FFmpeg n9.1 (was n8.1.3), with FFmpeg 9's multi-threaded fftools, ported from FFmpegKitNext. The Java API is unchanged.
* HTTPS certificates are checked by default (FFmpeg 9): expired, self-signed and wrong-host certificates now fail, and GnuTLS checks against Android's system certificates. `-tls_verify 0` before an input's `-i` turns the check off for it.
* Removed `ffmpeg` options: `-vsync` (use `-fps_mode`), `-map_channel`, `-psnr`, `-top`, `-absf`, `-vbsf`, `-filter_script`, `-filter_complex_script`, `-qphist` and `-adrift_threshold`. `-copytb` is accepted but has no effect.
* Newer libraries, in the variants that include them: GnuTLS 3.8.14 with GNU Libtasn1 4.21.0, FreeType 2.15.0, HarfBuzz 15.2.0, OpenH264 2.7.0, snappy 1.3.1 and giflib 6.1.3.

## 2.3.0

* First release of the converter-gpl variant (sk3llo/ffmpeg_kit_flutter#166): FFmpeg n8.1.3 with the external encoders that converting between common audio and video formats needs: H.264 (x264 core 165), HEVC (x265 4.2), MP3 (LAME 3.100), Opus (1.6.1), Vorbis (libvorbis 1.3.7), VP8 and VP9 (libvpx 1.17.0) and WebP (libwebp 1.6.0), plus the dav1d 1.5.5 AV1 decoder. Licensed GPL-3.0-or-later.
* Its version matches the other variants' 2.3.0, which are built from the same FFmpeg source and build scripts.
* The AAR carries `LICENSES/`: the licence notices for FFmpeg, FFmpegKit and each third-party library in this variant. Apps don't package it.
