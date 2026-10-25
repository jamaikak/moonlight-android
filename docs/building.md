# Building and CI

## Local build

1. `git submodule update --init --recursive`
2. Install JDK 17, the Android SDK (platform 36, build-tools 36.0.0) and NDK 27.0.12077973.
3. Put `ndk.dir=<path to your NDK>` in `local.properties`.
4. `./gradlew assembleNonRoot_gameDebug`

The APK is written to `app/build/outputs/apk/nonRoot_game/debug/`.

Flavours: `nonRoot_game` is the normal build. `root` is the rooted variant with a different application id (`com.limelight.root`). Unit test commands are in [android_test_setup.md](../android_test_setup.md).

## GitHub Actions

The **Android build** workflow (`.github/workflows/android.yml`) runs only when started by hand:

1. Open the repo's **Actions** tab, choose **Android build**, then **Run workflow** and pick the branch.
2. When it finishes, open the run and download the `artemis-fork-debug-apks` artifact (a zip containing the APK). You need to be signed in to GitHub.

Artifacts expire after GitHub's retention period (90 days by default), so re-run the workflow if a link has gone stale.

## Installing

Debug builds use the fixed key in `app/fork-debug.keystore`, so a new build installs over an older one from this fork without uninstalling. A build signed with a different key (for example the upstream release) must be uninstalled first.

On an NVIDIA Shield, install with `adb install -r <apk>`. If it fails with `INSTALL_FAILED_VERIFICATION_FAILURE`, turn off the package verifier on the device.
