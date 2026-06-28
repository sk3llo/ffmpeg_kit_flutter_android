#!/usr/bin/env bash
#
# Publish the CURRENT branch's `com.antonkarpenko:ffmpeg-kit-<variant>` artifact
# to Maven Central via the com.vanniktech.maven.publish plugin.
#
# Run ONE variant branch at a time (each branch = a distinct artifact).
#
# Usage:
#   scripts/publish-maven.sh            # upload a STAGED deployment (review + release in Central Portal)
#   scripts/publish-maven.sh --release  # upload AND auto-release (irreversible once released)
#
# Prerequisites:
#   - JDK 17 on PATH
#   - android/gradle.properties holds the Maven Central creds + signing key (gitignored; local only)
#   - The FFmpeg 8.1.1 native libraries are already copied into
#     android/src/main/jniLibs/<abi>/ for THIS variant (the version bump alone does
#     not change the bundled .so)
#
set -euo pipefail
cd "$(dirname "$0")/.."

TASK="publishToMavenCentral"
if [ "${1:-}" = "--release" ]; then
  TASK="publishAndReleaseToMavenCentral"
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
COORD="$(grep -oE 'coordinates\("[^"]+", "[^"]+", "[^"]+"\)' android/build.gradle.kts | head -1)"

echo "Branch:   ${BRANCH}"
echo "Artifact: ${COORD:-<not found in android/build.gradle.kts>}"
echo "Task:     ${TASK}"
echo

# Sanity check: native libs must be present for all four ABIs.
missing=0
for abi in armeabi-v7a arm64-v8a x86 x86_64; do
  if [ ! -f "android/src/main/jniLibs/${abi}/libffmpegkit.so" ]; then
    echo "ERROR: missing android/src/main/jniLibs/${abi}/libffmpegkit.so" >&2
    missing=1
  fi
done
if [ "${missing}" -ne 0 ]; then
  echo "Drop the FFmpeg 8.1.1 .so into android/src/main/jniLibs/<abi>/ before publishing." >&2
  exit 1
fi

echo ">>> Confirm the jniLibs .so are the FFmpeg 8.1.1 build (not 8.0) before continuing."
echo

( cd android && ./gradlew clean "${TASK}" --no-daemon --no-configuration-cache )

echo
echo "Done: ${COORD} -> ${TASK}"
if [ "${TASK}" = "publishToMavenCentral" ]; then
  echo "Review and release the staged deployment at https://central.sonatype.com"
fi
