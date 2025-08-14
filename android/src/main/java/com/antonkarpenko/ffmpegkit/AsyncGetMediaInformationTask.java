package com.antonkarpenko.ffmpegkit;

/**
 * <p>Executes a MediaInformation session asynchronously.
 */
public class AsyncGetMediaInformationTask implements Runnable {
    private final MediaInformationSession mediaInformationSession;
    private final MediaInformationSessionCompleteCallback completeCallback;
    private final Integer waitTimeout;

    public AsyncGetMediaInformationTask(final MediaInformationSession mediaInformationSession) {
        this(mediaInformationSession, AbstractSession.DEFAULT_TIMEOUT_FOR_ASYNCHRONOUS_MESSAGES_IN_TRANSMIT);
    }

    public AsyncGetMediaInformationTask(final MediaInformationSession mediaInformationSession, final Integer waitTimeout) {
        this.mediaInformationSession = mediaInformationSession;
        this.completeCallback = mediaInformationSession.getCompleteCallback();
        this.waitTimeout = waitTimeout;
    }

    @Override
    public void run() {
        FFmpegKitConfig.getMediaInformationExecute(mediaInformationSession, waitTimeout);

        if (completeCallback != null) {
            try {
                // NOTIFY SESSION CALLBACK DEFINED
                completeCallback.apply(mediaInformationSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside session complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }

        final MediaInformationSessionCompleteCallback globalMediaInformationSessionCompleteCallback = FFmpegKitConfig.getMediaInformationSessionCompleteCallback();
        if (globalMediaInformationSessionCompleteCallback != null) {
            try {
                // NOTIFY GLOBAL CALLBACK DEFINEDs
                globalMediaInformationSessionCompleteCallback.apply(mediaInformationSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside global complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }
    }

}
