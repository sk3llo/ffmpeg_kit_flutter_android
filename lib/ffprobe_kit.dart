import 'package:ffmpeg_kit_flutter_platform_interface/ffmpeg_kit_flutter_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'ffmpeg_kit_config.dart';
import 'ffprobe_session.dart';
import 'ffprobe_session_complete_callback.dart';
import 'log_callback.dart';
import 'media_information_session.dart';
import 'media_information_session_complete_callback.dart';
import 'src/ffmpeg_kit_factory.dart';

/// Main class to run "FFprobe" commands.
class FFprobeKit {
  static final FFmpegKitPlatform _platform = FFmpegKitPlatform.instance;

  /// Synchronously executes FFprobe command provided. Space character is used
  /// to split command into arguments. You can use single or double quote
  /// characters to specify arguments inside your command.
  static Future<FFprobeSession> execute(String command) async =>
      FFprobeKit.executeWithArguments(FFmpegKitConfig.parseArguments(command));

  /// Synchronously executes FFprobe with arguments provided.
  static Future<FFprobeSession> executeWithArguments(
    List<String> commandArguments,
  ) async {
    final session = await FFprobeSession.create(
      commandArguments,
      null,
      null,
      null,
    );

    await FFmpegKitConfig.ffprobeExecute(session);

    return session;
  }

  /// Starts an asynchronous FFprobe execution for the given command. Space character is used to split the command
  /// into arguments. You can use single or double quote characters to specify arguments inside your command.
  ///
  /// Note that this method returns immediately and does not wait the execution to complete. You must use an
  /// [FFprobeSessionCompleteCallback] if you want to be notified about the result.
  static Future<FFprobeSession> executeAsync(
    String command, [
    FFprobeSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
  ]) async => FFprobeKit.executeWithArgumentsAsync(
    FFmpegKitConfig.parseArguments(command),
    completeCallback,
    logCallback,
  );

  /// Starts an asynchronous FFprobe execution with arguments provided.
  ///
  /// Note that this method returns immediately and does not wait the execution to complete. You must use an
  /// [FFprobeSessionCompleteCallback] if you want to be notified about the result.
  static Future<FFprobeSession> executeWithArgumentsAsync(
    List<String> commandArguments, [
    FFprobeSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
  ]) async {
    final session = await FFprobeSession.create(
      commandArguments,
      completeCallback,
      logCallback,
      null,
    );

    await FFmpegKitConfig.asyncFFprobeExecute(session);

    return session;
  }

  /// Extracts media information for the file specified with path.
  static Future<MediaInformationSession> getMediaInformation(
    String path, [
    int? waitTimeout,
  ]) async {
    final commandArguments = [
      "-v",
      "error",
      "-hide_banner",
      "-print_format",
      "json",
      "-show_format",
      "-show_streams",
      "-show_chapters",
      "-i",
      path,
    ];
    return FFprobeKit.getMediaInformationFromCommandArguments(
      commandArguments,
      waitTimeout,
    );
  }

  /// Extracts media information using the command provided. The command
  /// passed to this method must generate the output in JSON format in order to
  /// successfully extract media information from it.
  static Future<MediaInformationSession> getMediaInformationFromCommand(
    String command, [
    int? waitTimeout,
  ]) async => FFprobeKit.getMediaInformationFromCommandArguments(
    FFmpegKitConfig.parseArguments(command),
    waitTimeout,
  );

  /// Extracts media information using the command arguments provided. The
  /// command passed to this method must generate the output in JSON format in
  /// order to successfully extract media information from it.
  static Future<MediaInformationSession>
  getMediaInformationFromCommandArguments(
    List<String> commandArguments, [
    int? waitTimeout,
  ]) async {
    final session = await MediaInformationSession.create(
      commandArguments,
      null,
      null,
    );

    await FFmpegKitConfig.getMediaInformationExecute(session, waitTimeout);

    final mediaInformation = await _platform
        .mediaInformationSessionGetMediaInformation(session.getSessionId())
        .then(FFmpegKitFactory.mapToNullableMediaInformation);
    if (mediaInformation != null) {
      session.setMediaInformation(mediaInformation);
    }

    return session;
  }

  /// Starts an asynchronous FFprobe execution to extract the media information for the specified file.
  ///
  /// Note that this method returns immediately and does not wait the execution to complete. You must use an
  /// [MediaInformationSessionCompleteCallback] if you want to be notified about the result.
  static Future<MediaInformationSession> getMediaInformationAsync(
    String path, [
    MediaInformationSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
    int? waitTimeout,
  ]) async {
    final commandArguments = [
      "-v",
      "error",
      "-hide_banner",
      "-print_format",
      "json",
      "-show_format",
      "-show_streams",
      "-show_chapters",
      "-i",
      path,
    ];
    return FFprobeKit.getMediaInformationFromCommandArgumentsAsync(
      commandArguments,
      completeCallback,
      logCallback,
      waitTimeout,
    );
  }

  /// Starts an asynchronous FFprobe execution to extract media information using a command. The command passed to
  /// this method must generate the output in JSON format in order to successfully extract media information from it.
  ///
  /// Note that this method returns immediately and does not wait the execution to complete. You must use an
  /// [MediaInformationSessionCompleteCallback] if you want to be notified about the result.
  static Future<MediaInformationSession> getMediaInformationFromCommandAsync(
    String command, [
    MediaInformationSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
    int? waitTimeout,
  ]) async => FFprobeKit.getMediaInformationFromCommandArgumentsAsync(
    FFmpegKitConfig.parseArguments(command),
    completeCallback,
    logCallback,
    waitTimeout,
  );

  /// Starts an asynchronous FFprobe execution to extract media information
  /// using command arguments. The command passed to this method must generate
  /// the output in JSON format in order to successfully extract media
  /// information from it.
  ///
  /// Note that this method returns immediately and does not wait the execution
  /// to complete. You must use an [MediaInformationSessionCompleteCallback] if you want to be
  /// notified about the result.
  static Future<MediaInformationSession>
  getMediaInformationFromCommandArgumentsAsync(
    List<String> commandArguments, [
    MediaInformationSessionCompleteCallback? completeCallback,
    LogCallback? logCallback,
    int? waitTimeout,
  ]) async {
    final session = await MediaInformationSession.create(
      commandArguments,
      completeCallback,
      logCallback,
    );

    await FFmpegKitConfig.asyncGetMediaInformationExecute(session, waitTimeout);

    final mediaInformation = await _platform
        .mediaInformationSessionGetMediaInformation(session.getSessionId())
        .then(FFmpegKitFactory.mapToNullableMediaInformation);
    if (mediaInformation != null) {
      session.setMediaInformation(mediaInformation);
    }

    return session;
  }

  /// Lists all FFprobe sessions in the session history.
  static Future<List<FFprobeSession>> listFFprobeSessions() async {
    try {
      await FFmpegKitConfig.init();
      return _platform.ffprobeKitListFFprobeSessions().then((sessions) {
        if (sessions == null) {
          return List.empty();
        } else {
          return sessions
              .map(
                (dynamic sessionObject) => FFmpegKitFactory.mapToSession(
                  sessionObject as Map<dynamic, dynamic>,
                ),
              )
              .map((session) => session as FFprobeSession)
              .toList();
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin listFFprobeSessions error: ${e.message}");
      return Future.error("listFFprobeSessions failed.", stack);
    }
  }

  /// Lists all MediaInformation sessions in the session history.
  static Future<List<MediaInformationSession>>
  listMediaInformationSessions() async {
    try {
      await FFmpegKitConfig.init();
      return _platform.ffprobeKitListMediaInformationSessions().then((
        sessions,
      ) {
        if (sessions == null) {
          return List.empty();
        } else {
          return sessions
              .map(
                (dynamic sessionObject) => FFmpegKitFactory.mapToSession(
                  sessionObject as Map<dynamic, dynamic>,
                ),
              )
              .map((session) => session as MediaInformationSession)
              .toList();
        }
      });
    } on PlatformException catch (e, stack) {
      debugPrint("Plugin listMediaInformationSessions error: ${e.message}");
      return Future.error("listMediaInformationSessions failed.", stack);
    }
  }
}
