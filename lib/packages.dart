import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';


import 'ffmpeg_kit_config.dart';

/// Helper class to extract binary package information.
class Packages {
  static final FFmpegKitPlatform _platform = FFmpegKitPlatform.instance;

  /// Returns the FFmpegKit Flutter binary package name.
  static Future<String?> getPackageName() async {
    try {
      await FFmpegKitConfig.init();
      return _platform.getPackageName();
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin getPackageName error: ${e.message}");
      return Future.error("getPackageName failed.", stack);
    }
  }

  /// Returns enabled external libraries by FFmpeg.
  static Future<List<String>> getExternalLibraries() async {
    try {
      await FFmpegKitConfig.init();
      return _platform.getExternalLibraries().then((externalLibraries) {
        if (externalLibraries == null) {
          return List.empty();
        } else {
          return externalLibraries.cast<String>();
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin getExternalLibraries error: ${e.message}");
      return Future.error("getExternalLibraries failed.", stack);
    }
  }
}
