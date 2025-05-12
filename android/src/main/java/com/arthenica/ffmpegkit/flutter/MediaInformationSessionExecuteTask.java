package com.arthenica.ffmpegkit.flutter;

import androidx.annotation.NonNull;

import com.arthenica.ffmpegkit.MediaInformationSession;
import com.arthenica.ffmpegkit.FFmpegKitConfig;

import io.flutter.plugin.common.MethodChannel;

public class MediaInformationSessionExecuteTask implements Runnable {
    private final MediaInformationSession mediaInformationSession;
    private final int timeout;
    private final FFmpegKitFlutterMethodResultHandler resultHandler;
    private final MethodChannel.Result result;

    public MediaInformationSessionExecuteTask(@NonNull final MediaInformationSession mediaInformationSession, final int timeout, @NonNull final FFmpegKitFlutterMethodResultHandler resultHandler, @NonNull final MethodChannel.Result result) {
        this.mediaInformationSession = mediaInformationSession;
        this.timeout = timeout;
        this.resultHandler = resultHandler;
        this.result = result;
    }

    @Override
    public void run() {
        FFmpegKitConfig.getMediaInformationExecute(mediaInformationSession, timeout);
        resultHandler.successAsync(result, null);
    }
}
