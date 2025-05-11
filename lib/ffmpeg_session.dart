import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'abstract_session.dart';
import 'ffmpeg_kit_config.dart';
import 'ffmpeg_session_complete_callback.dart';
import 'log_callback.dart';
import 'log_redirection_strategy.dart';
import 'src/ffmpeg_kit_factory.dart';
import 'statistics.dart';
import 'statistics_callback.dart';

/// An FFmpeg session.
class FFmpegSession extends AbstractSession {
  /// Creates a new FFmpeg session with [argumentsArray].
  static Future<FFmpegSession> create(List<String> argumentsArray,
      [FFmpegSessionCompleteCallback? completeCallback,
      LogCallback? logCallback,
      StatisticsCallback? statisticsCallback,
      LogRedirectionStrategy? logRedirectionStrategy]) async {
    final session = await AbstractSession.createFFmpegSession(
        argumentsArray, logRedirectionStrategy);
    final sessionId = session.getSessionId();

    FFmpegKitFactory.setFFmpegSessionCompleteCallback(
        sessionId, completeCallback);
    FFmpegKitFactory.setLogCallback(sessionId, logCallback);
    FFmpegKitFactory.setStatisticsCallback(sessionId, statisticsCallback);

    return session;
  }

  /// Returns the session specific statistics callback.
  StatisticsCallback? getStatisticsCallback() =>
      FFmpegKitFactory.getStatisticsCallback(getSessionId());

  /// Returns the session specific complete callback.
  FFmpegSessionCompleteCallback? getCompleteCallback() =>
      FFmpegKitFactory.getFFmpegSessionCompleteCallback(getSessionId());

  /// Returns all statistics entries generated for this session. If there are
  /// asynchronous statistics that are not delivered yet, this method waits for
  /// them until [waitTimeout].
  Future<List<Statistics>> getAllStatistics([int? waitTimeout]) async {
    try {
      await FFmpegKitConfig.init();
      return FFmpegKitPlatform.instance
          .ffmpegSessionGetAllStatistics(getSessionId(), waitTimeout)
          .then((allStatistics) {
        if (allStatistics == null) {
          return List.empty();
        } else {
          return allStatistics
              .map((dynamic statisticsObject) =>
                  FFmpegKitFactory.mapToStatistics(
                      statisticsObject as Map<dynamic, dynamic>))
              .toList();
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin getAllStatistics error: ${e.message}");
      return Future.error("getAllStatistics failed.", stack);
    }
  }

  /// Returns all statistics entries delivered for this session. Note that if
  /// there are asynchronous statistics that are not delivered yet, this method
  /// will not wait for them and will return immediately.
  Future<List<Statistics>> getStatistics() async {
    try {
      await FFmpegKitConfig.init();
      return FFmpegKitPlatform.instance
          .ffmpegSessionGetStatistics(getSessionId())
          .then((statistics) {
        if (statistics == null) {
          return List.empty();
        } else {
          return statistics
              .map((dynamic statisticsObject) =>
                  FFmpegKitFactory.mapToStatistics(
                      statisticsObject as Map<dynamic, dynamic>))
              .toList();
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin getStatistics error: ${e.message}");
      return Future.error("getStatistics failed.", stack);
    }
  }

  /// Returns the last received statistics entry.
  Future<Statistics?> getLastReceivedStatistics() async =>
      getStatistics().then((statistics) {
        if (statistics.isNotEmpty) {
          return statistics[statistics.length - 1];
        } else {
          return null;
        }
      });

  @override
  bool isFFmpeg() => true;

  @override
  bool isFFprobe() => false;

  @override
  bool isMediaInformation() => false;
}
