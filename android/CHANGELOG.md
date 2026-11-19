## 2.3.0

* First release of the converter-gpl variant (sk3llo/ffmpeg_kit_flutter#166): FFmpeg n8.1.3 with the external encoders that converting between common audio and video formats needs: H.264 (x264 core 165), HEVC (x265 4.2), MP3 (LAME 3.100), Opus (1.6.1), Vorbis (libvorbis 1.3.7), VP8 and VP9 (libvpx 1.17.0) and WebP (libwebp 1.6.0), plus the dav1d 1.5.5 AV1 decoder. Licensed GPL-3.0-or-later.
* Its version matches the other variants' 2.3.0, which are built from the same FFmpeg source and build scripts.
* The AAR carries `LICENSES/`: the licence notices for FFmpeg, FFmpegKit and each third-party library in this variant. Apps don't package it.
