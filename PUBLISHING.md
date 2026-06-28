# Publishing the Android Maven artifacts

This repo publishes one Maven Central artifact per variant **branch** —
`com.antonkarpenko:ffmpeg-kit-<variant>` — via the
[`com.vanniktech.maven.publish`](https://github.com/vanniktech/gradle-maven-publish-plugin)
plugin configured in `android/build.gradle.kts`. The native FFmpeg libraries are
bundled in `android/src/main/jniLibs/<abi>/` and shipped inside the artifact.

| branch | artifact |
|-----------|--------------------------------------------|
| min       | `com.antonkarpenko:ffmpeg-kit-min`         |
| min-gpl   | `com.antonkarpenko:ffmpeg-kit-min-gpl`     |
| https     | `com.antonkarpenko:ffmpeg-kit-https`       |
| https-gpl | `com.antonkarpenko:ffmpeg-kit-https-gpl`   |
| audio     | `com.antonkarpenko:ffmpeg-kit-audio`       |
| video     | `com.antonkarpenko:ffmpeg-kit-video`       |
| full      | `com.antonkarpenko:ffmpeg-kit-full`        |
| full-gpl  | `com.antonkarpenko:ffmpeg-kit-full-gpl`    |

> `master` is not a Maven producer (different layout) — nothing to publish there.

## Prerequisites

- **JDK 17.**
- **Credentials + signing** live in `android/gradle.properties` (gitignored, local
  only): `mavenCentralUsername` / `mavenCentralPassword`, and the `signing.*` key.
  Never commit this file.
- **Native libraries built for the target FFmpeg version.** A version bump alone does
  not change the bundled `.so`. Build them in `ffmpeg-kit-6.0.LTS` (`./android.sh …`
  with the variant's `--enable-*` flags) and copy per ABI into
  `android/src/main/jniLibs/`:

  | build output (ffmpeg-kit-6.0.LTS) | jniLibs ABI dir |
  |-----------------------------------|-----------------|
  | `prebuilt/android-arm/.../*.so`    | `armeabi-v7a/`  |
  | `prebuilt/android-arm64/.../*.so`  | `arm64-v8a/`    |
  | `prebuilt/android-x86/.../*.so`    | `x86/`          |
  | `prebuilt/android-x86_64/.../*.so` | `x86_64/`       |

  Mirror the exact filename set already present in each `jniLibs/<abi>/`
  (`libffmpegkit*.so`, `libav*.so`, `libsw*.so`, `libffmpegkit_abidetect.so`, and the
  `_neon` variants under `armeabi-v7a/`).

## Publish one variant

Check out the variant branch, then:

```bash
scripts/publish-maven.sh            # upload a STAGED deployment (recommended first)
scripts/publish-maven.sh --release  # upload AND auto-release (irreversible)
```

`publishToMavenCentral` uploads a staged deployment you review and release manually at
<https://central.sonatype.com>. `publishAndReleaseToMavenCentral` does both in one shot.

## Publish all variants

```bash
for b in min min-gpl https https-gpl audio video full full-gpl; do
  echo "=== $b ==="
  git checkout "$b"
  # >>> copy the FFmpeg 8.1.1 .so into android/src/main/jniLibs/<abi>/ for THIS variant <<<
  scripts/publish-maven.sh || { echo "FAILED: $b"; break; }
done
```

## Verify

- Central Portal → Deployments → confirm `com.antonkarpenko:ffmpeg-kit-<variant>:<version>`
  validated (and released).
- Maven Central propagation can take ~10–30 min. Afterwards, a `flutter pub get` in a
  project depending on the matching `ffmpeg_kit_flutter` variant (which references the
  same `:<version>`) resolves the new artifact.

## Notes

- Maven Central is **immutable per version** — you cannot overwrite a released version;
  bump the version in `android/build.gradle.kts` (`coordinates(...)` + `version`) for any
  re-publish.
- Confirm task names on a new machine with `cd android && ./gradlew tasks --group publishing`.
