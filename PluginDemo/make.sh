./gradlew clean assembleBeijingPlugin
adb push app/build/outputs/apk/beijing/release/app-beijing-release.apk /sdcard/Test.apk
adb shell am force-stop com.p1.mobile.putong
adb shell am start -n com.p1.mobile.putong/com.didi.virtualapk.MainActivity
