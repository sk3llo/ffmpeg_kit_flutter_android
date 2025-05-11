/*
 * Copyright (c) 2018-2021 Taner Sener
 *
 * This file is part of FFmpegKit.
 *
 * FFmpegKit is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * FFmpegKit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with FFmpegKit.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.arthenica.ffmpegkit;

/**
 * <p>Executes an FFprobe session asynchronously.
 */
public class AsyncFFprobeExecuteTask implements Runnable {
    private final com.arthenica.ffmpegkit.FFprobeSession ffprobeSession;
    private final com.arthenica.ffmpegkit.FFprobeSessionCompleteCallback completeCallback;

    public AsyncFFprobeExecuteTask(final com.arthenica.ffmpegkit.FFprobeSession ffprobeSession) {
        this.ffprobeSession = ffprobeSession;
        this.completeCallback = ffprobeSession.getCompleteCallback();
    }

    @Override
    public void run() {
        com.arthenica.ffmpegkit.FFmpegKitConfig.ffprobeExecute(ffprobeSession);

        if (completeCallback != null) {
            try {
                // NOTIFY SESSION CALLBACK DEFINED
                completeCallback.apply(ffprobeSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside session complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }

        final com.arthenica.ffmpegkit.FFprobeSessionCompleteCallback globalFFprobeSessionCompleteCallback = com.arthenica.ffmpegkit.FFmpegKitConfig.getFFprobeSessionCompleteCallback();
        if (globalFFprobeSessionCompleteCallback != null) {
            try {
                // NOTIFY GLOBAL CALLBACK DEFINED
                globalFFprobeSessionCompleteCallback.apply(ffprobeSession);
            } catch (final Exception e) {
//                android.util.Log.e(FFmpegKitConfig.TAG, String.format("Exception thrown inside global complete callback.%s", Exceptions.getStackTraceString(e)));
            }
        }
    }

}
