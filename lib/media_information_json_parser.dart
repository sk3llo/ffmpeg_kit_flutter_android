import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'ffmpeg_kit_config.dart';
import 'media_information.dart';

/// A parser that constructs "MediaInformation" from FFprobe's json output.
class MediaInformationJsonParser {
  static final FFmpegKitPlatform _platform = FFmpegKitPlatform.instance;

  /// Extracts MediaInformation from the given FFprobe json output. Note that
  /// this method does not fail as [fromWithError] does and returns null on
  /// error.
  static Future<MediaInformation?> from(String ffprobeJsonOutput) async {
    try {
      await FFmpegKitConfig.init();
      return _platform
          .mediaInformationJsonParserFrom(ffprobeJsonOutput)
          .then((properties) {
        if (properties == null || properties.isEmpty) {
          return null;
        } else {
          return MediaInformation(properties);
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin from error: ${e.message}");
      return Future.error("from failed.", stack);
    }
  }

  /// Extracts MediaInformation from the given FFprobe json output.
  static Future<MediaInformation> fromWithError(
      String ffprobeJsonOutput) async {
    try {
      await FFmpegKitConfig.init();
      return _platform
          .mediaInformationJsonParserFromWithError(ffprobeJsonOutput)
          .then((properties) => MediaInformation(properties));
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin fromWithError error: ${e.message}");
      return Future.error("fromWithError failed.", stack);
    }
  }
}
