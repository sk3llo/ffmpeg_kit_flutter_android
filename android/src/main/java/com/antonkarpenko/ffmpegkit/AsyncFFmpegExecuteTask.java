package com.antonkarpenko.ffmpegkit;

/**
 * <p>Executes an FFmpeg session asynchronously.
 */
public class AsyncFFmpegExecuteTask implements Runnable {
    private final FFmpegSession ffmpegSession;
    private final FFmpegSessionCompleteCallback completeCallback;

    public AsyncFFmpegExecuteTask(final FFmpegSession ffmpegSession) {
        this.ffmpegSession = ffmpegSession;
        this.completeCallback = ffmpegSession.getCompleteCallback();
    }

    @Override
    public void run() {
        FFmpegKitConfig.ffmpegExecute(ffmpegSession);

        if (completeCallback != null) {
            try {
                // NOTIFY SESSION CALLBACK DEFINED
                completeCallback.apply(ffmpegSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside session complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }

        final FFmpegSessionCompleteCallback globalFFmpegSessionCompleteCallback = FFmpegKitConfig.getFFmpegSessionCompleteCallback();
        if (globalFFmpegSessionCompleteCallback != null) {
            try {
                // NOTIFY GLOBAL CALLBACK DEFINED
                globalFFmpegSessionCompleteCallback.apply(ffmpegSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside global complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }
    }
}
