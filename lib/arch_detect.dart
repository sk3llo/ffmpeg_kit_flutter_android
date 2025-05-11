import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'ffmpeg_kit_config.dart';

/// Detects the running architecture.
class ArchDetect {
  static final FFmpegKitPlatform _platform = FFmpegKitPlatform.instance;

  /// Returns architecture name loaded.
  static Future<String> getArch() async {
    try {
      await FFmpegKitConfig.init();
      return _platform.archDetectGetArch();
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin getArch error: ${e.message}");
      return Future.error("getArch failed.", stack);
    }
  }
}
