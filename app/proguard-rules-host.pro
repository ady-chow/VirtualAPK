# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/23.0.3/tools/proguard/proguard-android.txt
# You can general_edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose
-dontoptimize
-dontshrink
-allowaccessmodification
-keepattributes *Annotation*
-keepattributes Exceptions
-keepattributes JavascriptInterface
-keepattributes LineNumberTable
-keepattributes Signature
-keepattributes SourceFile
-keepattributes EnclosingMethod

-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService


# this is for keep the method name unique, so we can use the map file to get readable

# for debug purpose
-keep public class com.immomo.mmdns.**{*;}
-keep class com.tencent.** { *; }
-printconfiguration "build/outputs/mapping/merged_proguard.txt"

-renamesourcefileattribute SourceFile

-keepattributes SourceFile, LineNumberTable

-useuniqueclassmembernames

# android

-keep class io.requery.android.database.** {*;}

# 这个类已没有再使用，需要重新打videokit.so包，把这部分去除掉。
-keep class com.p1.mobile.android.media.FFmpegMediaMetadataRetriever {
    native <methods>;
}
-keep class wseemann.media.FFmpegMediaMetadataRetriever { *; }

-keepclasseswithmembernames class com.p1.mobile.android.media.FFmpegCommand {
    native <methods>;
}

-keep class com.netease.** {*;}

-keep class androidx.renderscript.** { *; }

-keep public class androidx.cardview.widget.CardView {
   private static ** IMPL;
}

-keep public class androidx.fragment.app.FragmentPagerAdapter { *; }

-keep public class androidx.viewpager.widget.ViewPager {
    private android.widget.Scroller mScroller;
}

-keep interface androidx.cardview.widget.CardViewImpl {
   void initStatic();
}



## should be supported by default settings
# -keep @android.support.annotation.Keep class *

# -keepclassmembers class * {
#    @android.support.annotation.Keep *;
# }

# app project

# -keep public class * extends com.p1.mobile.putong.api.api.Excep

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

-keep class androidx.appcompat.widget.Toolbar {*;}


# -keep public class * extends com.p1.mobile.putong.app.PutongFrag

#-keepresources drawable/ic_launcher
#
#-keepresourcefiles **.so
#
#-keepresourcefiles **.glsl
#
#-keepresourcefiles **.mt
#
#-keepresourcefiles **.svga

# -dontoptimize
-optimizations method/inlining/unique,method/inlining/short,class/marking/final,method/marking/static,method/marking/final



##  -optimizationpasses 2

-keep,allowshrinking,allowobfuscation class com.facebook.soloader.SysUtil$LollipopSysdeps {
  <methods>;
}

-keep,allowobfuscation,allowshrinking class com.fasterxml.jackson.core.sym.** { *; }

-keep class com.p1.mobile.putong.api.api.Network{*;}
#-keep class com.p1.mobile.putong.core.api.**{*;}
#-keep class com.p1.mobile.putong.account.api.**{*;}
#-keep class com.p1.mobile.putong.live.module.api.**{*;}
#-keep class com.p1.mobile.putong.feed.api.**{*;}
#-keep class com.twmacinta.util.***{*;}
#-keep class org.bouncycastle.***{*;}
#-keep class org.spongycastle.***{*;}
#-keep class com.guardsquare.dexguard.runtime.***{*;}

#-encryptstrings class com.p1.mobile.putong.api.api.**
#
#-encryptstrings class com.p1.mobile.putong.account.api.**
#
#-encryptstrings class com.p1.mobile.putong.core.api.**
#
#-encryptstrings class com.p1.mobile.putong.feed.api.**
#
#-encryptstrings class com.p1.mobile.putong.live.module.api.**
#
#-obfuscatecode,high class com.p1.mobile.putong.api.api.Network
#
#-encryptstrings class com.p1.mobile.android.app.Au2
#
#-obfuscatecode,high class com.p1.mobile.android.app.Au2
#
#-encryptstrings class com.twmacinta.util.**
#
#-obfuscatecode,high class com.twmacinta.util.**
#
#-encryptstrings class org.bouncycastle.**
#
#-obfuscatecode,high class org.bouncycastle.**
#
#-encryptclasses org.bouncycastle.**
#
#-encryptstrings class org.spongycastle.**
#
#-obfuscatecode,high class org.spongycastle.**
#
#-encryptstrings class com.p1.mobile.android.os.DeviceUuidFactory
#
#-obfuscatecode,high class com.p1.mobile.android.os.DeviceUuidFactory
#
#-encryptclasses org.spongycastle.**
#
#-encryptclasses com.guardsquare.dexguard.runtime.**

#-keepresourcexmlelements manifest/application/meta-data

#-keepresourcefiles res/**/ic_launcher.png

# keep them for logging purposes

-keepnames public class * extends android.app.Activity

-keepnames public class * extends androidx.fragment.app.Fragment

-repackageclasses abc

#-allowaccessmodification


#-keepresourcexmlattributenames manifest/**

# umeng
-keep class com.umeng.** {*;}

-keepclassmembers class * {
  public <init>(org.json.JSONObject);
}

-keep public class com.idea.fifaalarmclock.app.R$*{
  public static final int *;
}

-keep class com.igexin.** { *; }

-keepclassmembers class u.aly.** { *; }

-keep class com.mob.**{*;}
-dontwarn com.mob.tools.**

# jpush

-dontwarn cn.jpush.**

-keep class cn.jpush.** { *; }

-keep class com.google.gson.jpush.** { * ; }

-keep class com.google.protobuf.jpush.** { * ; }

-keep class * extends cn.jpush.android.helpers.JPushMessageReceiver { *; }

-dontwarn cn.jiguang.**

-keep class cn.jiguang.** { *; }

# mi push

-keep class com.p1.mible.putong.api.push.MiPushReceiver {*;}

-keep class com.xiaomi.push.service.**

-dontwarn com.xiaomi.push.**

# getui push

-dontwarn com.igexin.**

-keep class com.igexin.** { *; }

-keep class org.json.** { *; }

# oppo push

-keep class * extends com.heytap.mcssdk.PushService { *; }
-keep class * extends com.heytap.mcssdk.AppPushService { *; }
-dontwarn  com.heytap.mcssdk.**

# share sdk
-dontwarn com.tencent.mm.**
-keep class com.p1.mobile.putong.wxapi.**
-keep class com.tencent.mm.**{*;}
-keep class com.sina.weibo.sdk.** { *; }

-dontwarn org.codehaus.mojo.**

## umeng push
#
#
#-dontwarn com.taobao.**
#-dontwarn anet.channel.**
#-dontwarn anetwork.channel.**
#-dontwarn org.android.**
#-dontwarn org.apache.thrift.**
#-dontwarn com.xiaomi.**
#-dontwarn com.huawei.**
#
#-keepattributes *Annotation*
#
#-keep class com.taobao.** {*;}
#-keep class org.android.** {*;}
#-keep class anet.channel.** {*;}
#-keep class com.umeng.** {*;}
#-keep class com.xiaomi.** {*;}
#-keep class com.huawei.** {*;}
#-keep class org.apache.thrift.** {*;}
#

#


# rxjava

-keep class rx.schedulers.Schedulers {
    public static <methods>;
}

-keep class rx.schedulers.ImmediateScheduler {
    public <methods>;
}

-keep class rx.schedulers.TestScheduler {
    public <methods>;
}

-keep class rx.schedulers.Schedulers {
    public static ** test();
}

-dontwarn rx.internal.util.**

-dontwarn java.nio.**

-dontwarn java.lang.invoke**

# baidu map

-keep class com.baidu.** { *; }

# change for new version.
-keep class mapsdkvi.com.gdi.bgl.android.**{*;}

-dontwarn javax.annotation.**

-dontwarn javax.inject.**

-dontwarn sun.misc.Unsafe

-dontwarn org.apache.**

-dontwarn com.baidu.**

-keep class androidx.appcompat.view.menu.MenuBuilder { *; }

-keep class androidx.appcompat.view.menu.MenuItemImpl { *; }

-keep class androidx.appcompat.widget.SearchView { *; }

-keep class com.google.android.material.** {*;}

# fresco

# Keep our interfaces so they can be used by other ProGuard rules.
# See http://sourceforge.net/p/proguard/bugs/466/

-keep,allowobfuscation @interface com.facebook.common.internal.DoNotStrip

# Do not strip any method/class that is annotated with @DoNotStrip

-keep @com.facebook.common.internal.DoNotStrip class *

-keepclassmembers class * {
    @com.facebook.common.internal.DoNotStrip *;
}

-keep class com.facebook.animated.gif.**{*;}
-keep class com.facebook.animated.webp.**{*;}

# mlink

-keep class com.zxinsight.** {*;}
-dontwarn com.zxinsight.**

# okhttp

-dontwarn okio.**

-dontwarn javax.annotation.**

-dontwarn com.google.android.gms.**

-dontwarn com.android.volley.toolbox.**

-dontwarn com.squareup.okhttp.internal.huc.**

# -verbose

# mp4parser

-keep class * implements com.coremedia.iso.boxes.Box { *; }

-dontwarn com.coremedia.iso.boxes.**

-dontwarn com.googlecode.mp4parser.authoring.tracks.mjpeg.**

-dontwarn com.googlecode.mp4parser.authoring.tracks.ttml.**

# alipay
-keep class com.alipay.android.app.IAlixPay{*;}
-keep class com.alipay.android.app.IAlixPay$Stub{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback{*;}
-keep class com.alipay.android.app.IRemoteServiceCallback$Stub{*;}
-keep class com.alipay.sdk.app.PayTask{ public *;}
-keep class com.alipay.sdk.app.AuthTask{ public *;}
-keep class com.alipay.sdk.app.H5PayCallback {
    <fields>;
    <methods>;
}
-keep class com.alipay.android.phone.mrpc.core.** { *; }
-keep class com.alipay.apmobilesecuritysdk.** { *; }
-keep class com.alipay.mobile.framework.service.annotation.** { *; }
-keep class com.alipay.mobilesecuritysdk.face.** { *; }
-keep class com.alipay.tscenter.biz.rpc.** { *; }
-keep class org.json.alipay.** { *; }
-keep class com.alipay.tscenter.** { *; }
-keep class com.ta.utdid2.** { *;}
-keep class com.ut.device.** { *;}


-keep class com.ishumei.** { *; }
# momoVideo
-keep,allowobfuscation @interface tv.danmaku.ijk.media.momoplayer.annotations.*
-keep,allowobfuscation @interface tv.danmaku.ijk.media.player.annotations.*
-keep class tv.danmaku.ijk.media.player.*{*;}
-keep class tv.danmaku.ijk.media.momoplayer.*{*;}

-keep class tv.danmaku.ijk.** {
    native <methods>;
    @tv.danmaku.ijk.media.momoplayer.annotations.* <fields>;
    @tv.danmaku.ijk.media.player.annotations.* <fields>;
    @tv.danmaku.ijk.media.momoplayer.annotations.* <methods>;
    @tv.danmaku.ijk.media.player.annotations.* <methods>;
}
-keep class tv.danmaku.ijk.media.momoplayer.IjkVodMediaPlayer$NativeDataWrapper{ *;}
#-keep class com.momo.proxy.** {*;}
-keep class com.momo.proxy.ProxyPreload {*;}
-keep class com.momo.proxy.PreloadTaskInfo {*;}
-keep class com.momo.proxy.PreloadTaskInfo$* {*;}

# ---------------momo sdk 开始--------------- #
# 保留本地native方法不被混淆
-keepclasseswithmembernames class * {
native <methods>;
}

-keep class com.core.glcore.util.** {*;}
-keep class com.momocv.** {*;}
-keep class com.imomo.momo.mediaencoder.** {*;}

-keep class com.imomo.momo.mediaencoder.MediaEncoder{*;}

-keep class com.imomo.momo.mediamuxer.** {*;}

-keep class com.immomo.mdlog.** {*;}
-keep class com.immomo.moment.mediautils.VideoDataRetrieverBySoft {*;}
-keep class com.immomo.moment.mediautils.YuvEditor {*;}
-keep class com.immomo.moment.mediautils.AudioMixerNative {*;}
-keep class com.immomo.moment.mediautils.MP4Fast {*;}
-keep class com.immomo.moment.mediautils.AudioResampleUtils {*;}
-keep class com.immomo.moment.mediautils.AudioSpeedControlPlayer {*;}
-keep interface com.immomo.moment.mediautils.AudioSpeedControlPlayer$* {*;}
-keep interface com.immomo.moment.mediautils.VideoDataRetrieverBySoft$* {*;}
-keep class com.immomo.moment.mediautils.VideoDataRetrieverBySoft$* {*;}
-keep class * extends com.immomo.moment.mediautils.MediaUtils {*;}

-keep class com.momo.mcamera.** {*;}
-dontwarn com.momo.mcamera.mask.**
-keep class com.google.gson.** {*;}
-keep class com.immomo.doki.media.entity.** {*;}
-keep class com.momo.xeengine.audio.AudioEngine* {*;}


-keep class com.immomo.mediacore.** {*;}
#媒体
-keep class * extends com.immomo.moment.mediautils.MediaUtils {*;}
-keep class com.immomo.mediabase.** { *; }
-keep class org.TTTRtc.voiceengine.* {*;}
-keep class com.momo.rtcbase.**{*;}
-keep class com.momo.momortc.**{*;}
#媒体网络检测返回结果
-keep class tv.danmaku.ijk.media.util.netspeedutil.ResultBean

#音视频通话
-keep class * extends com.immomo.mediacore.sink.IjkWriter {*;}
-keep class com.immomo.mediacore.audio.AudioProcess {*;}
-keep class com.momo.sabine.sabineSdk {*;}
-keep class com.wushuangtech.api.* {*;}
-keep class com.wushuangtech.audiocore.* {*;}
-keep class com.wushuangtech.jni.* {*;}
-keep class org.webrtc.voiceengine.* {*;}
-keep class org.TTTRtc.voiceengine.* {*;}
-keep class * extends com.wushuangtech.api.ExternalAudioModuleCallback {*;}
-keep class com.momo.x264.*{*;}
-keep class com.immomo.ijkConferenceStreamer {*;}
-keep class tv.danmaku.ijk.media.streamer.ijkMediaStreamer {*;}

-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
-keepclasseswithmembernames class com.momo.** {
    native <methods>;
}
-keep class com.momo.xeengine.** {*;}
#live sdk
-keep class com.immomo.svgaplayer.**{*;}
-keep class com.squareup.wire.** {*;}
#多人视频需要的配置
-keep class com.immomo.momo.agora.bean.**{*;}

-keep class com.momo.voaac.**{*;}
-keep class com.momo.x264.**{*;}
-keep class com.momo.sabine.**{*;}
-keep public class com.immomo.mmdns.**{*;}
-keep class com.immomo.momomediaext.utils.** {*;}
-keep class com.immomo.momomediaext.sei.** {*;}

#AgoraPushFilter
-dontwarn com.momo.piplineext.codec.**
-dontwarn com.momo.pipline.**


# ---------------华为push 开始--------------- #
-keep class com.hianalytics.android.**{*;}
-keep class com.huawei.updatesdk.**{*;}
-keep class com.huawei.hms.**{*;}

-keep class com.huawei.android.hms.agent.**{*;}
-keep class com.huawei.gamebox.plugin.gameservice.**{*;}

#-keepresources layout/hwpush*
#-keepresources drawable/upsdk*
#-keepresources layout/hms*
#-keepresources layout/upsdk*
#-keepresources color/upsdk*
#-keepresources dimen/upsdk*
#-keepresources string/connect_server_fail_prompt_toast
#-keepresources string/getting_message_fail_prompt_toast
#-keepresources string/hms*
#-keepresources string/no_available_network_prompt_toast
#-keepresources string/third_app*
#-keepresources string/upsdk*
#-keepresources style/upsdk*

# ---------------华为push 结束--------------- #

# protobuf and msg in longlink
-keep class com.p1.mobile.longlink.msg.** {*;}
-keep class com.google.protobuf.Any {*;}

#-multidex

-keepnames class com.p1.mobile.putong.app.alive.PullAliveService

-keep class com.megvii.**{*;}

#-keepresources string/liveness*
#-keepresources drawable/liveness*
#-keepresources layout/liveness*
#-keepresources color/liveness*
#-keepresources dimen/liveness*
#-keepresources raw/liveness*

# protobuf in geocoding
-keep class com.p1.mobile.android.geocoding.** {*;}

# for plugin
-keep class com.xiaomi.mipush.sdk.MiPushClient {*;}
-keep class com.coloros.mcssdk.PushManager { *;}
-keepnames class com.p1.mobile.putong.ui.download.DownloadNotificationHelper$BroadcastReceiver
-keepnames class com.p1.mobile.putong.core.ui.notifications.SysnotifListener

-keep class com.xiaomi.mipush.sdk.MiPushMessage {*;}
-keep class com.xiaomi.mipush.sdk.MiPushCommandMessage {*;}

-keepnames class com.p1.mobile.putong.app.alive.FrontService
-keepnames class com.p1.mobile.putong.app.alive.FrontService$FontInnerService
-keepnames class com.p1.mobile.putong.core.ui.messages.ChooserTargetService

#-keepresources drawable/push
#-keepresources drawable/moments_notifications_clear
# for plugin end

#----------------阿里push----------------------
-keepclasseswithmembernames class com.taobao.** {
    native <methods>;
}

-keepclasseswithmembernames class com.alibaba.** {
    native <methods>;
}

-keepclasseswithmembernames class com.ut.** {
    native <methods>;
}

-keepclasseswithmembernames class com.ta.** {
    native <methods>;
}

-keepclasseswithmembernames class com.ta.** {
    native <methods>;
}

-keepclasseswithmembernames class anet.** {
    native <methods>;
}

-keepclasseswithmembernames class anetwork.** {
    native <methods>;
}

-keepclasseswithmembernames class org.android.spdy.** {
    native <methods>;
}

-keepclasseswithmembernames class org.android.agoo.** {
    native <methods>;
}
-dontwarn com.umeng.**
-dontwarn com.taobao.**
-dontwarn anet.channel.**
-dontwarn anetwork.channel.**
-dontwarn org.android.**
-dontwarn org.apache.thrift.**
-dontwarn com.xiaomi.**
-dontwarn com.huawei.**
-keep class com.taobao.** {*;}
-keep class com.alibaba.** {*;}
-keep class com.alipay.** {*;}
-keep class com.ut.** {*;}
-keep class com.ta.** {*;}
-keep class anet.**{*;}
-keep class anetwork.**{*;}
-keep class org.android.spdy.**{*;}
-keep class org.android.agoo.**{*;}

-keep class * extends java.util.ListResourceBundle {
    protected Object[][] getContents();
}

-keep public class com.google.android.gms.common.internal.safeparcel.SafeParcelable {
    public static final *** NULL;
}

-keepnames class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

-keep interface com.momo.xscan.utils.keepflag.KeepAllFlagInterface{*;}
-keep interface com.momo.xscan.utils.keepflag.KeepPublicInterface{*;}
-keep class * implements com.momo.xscan.utils.keepflag.KeepAllFlagInterface{*;}
-keep class * implements com.momo.xscan.utils.keepflag.KeepPublicInterface{
    public *;
}
-keep class com.momo.xscan.bean.*{*;}
-keep public class com.immomo.mncertification.network.bean.**{*;}

-keep class com.p1.mobile.putong.api.push.PushTrackData{*;}
-keep class com.cosmos.mmfile.**{*;}

# ------------------ X5Webview Start ------------------------#
# ------------------ Keep LineNumbers and properties ---------------- #
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
# --------------------------------------------------------------------------

# Addidional for x5.sdk classes for apps

-keep class com.tencent.smtt.export.external.**{
    *;
}

-keep class com.tencent.tbs.video.interfaces.IUserStateChangedListener {
	*;
}

-keep class com.tencent.smtt.sdk.CacheManager {
	public *;
}

-keep class com.tencent.smtt.sdk.CookieManager {
	public *;
}

-keep class com.tencent.smtt.sdk.WebHistoryItem {
	public *;
}

-keep class com.tencent.smtt.sdk.WebViewDatabase {
	public *;
}

-keep class com.tencent.smtt.sdk.WebBackForwardList {
	public *;
}

-keep public class com.tencent.smtt.sdk.WebView {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebView$HitTestResult {
	public static final <fields>;
	public java.lang.String getExtra();
	public int getType();
}

-keep public class com.tencent.smtt.sdk.WebView$WebViewTransport {
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebView$PictureListener {
	public <fields>;
	public <methods>;
}


-keepattributes InnerClasses

-keep public enum com.tencent.smtt.sdk.WebSettings$** {
    *;
}

-keep public enum com.tencent.smtt.sdk.QbSdk$** {
    *;
}

-keep public class com.tencent.smtt.sdk.WebSettings {
    public *;
}


-keepattributes Signature
-keep public class com.tencent.smtt.sdk.ValueCallback {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebViewClient {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.DownloadListener {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebChromeClient {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebChromeClient$FileChooserParams {
	public <fields>;
	public <methods>;
}

-keep class com.tencent.smtt.sdk.SystemWebChromeClient{
	public *;
}
# 1. extension interfaces should be apparent
-keep public class com.tencent.smtt.export.external.extension.interfaces.* {
	public protected *;
}

# 2. interfaces should be apparent
-keep public class com.tencent.smtt.export.external.interfaces.* {
	public protected *;
}

-keep public class com.tencent.smtt.sdk.WebViewCallbackClient {
	public protected *;
}

-keep public class com.tencent.smtt.sdk.WebStorage$QuotaUpdater {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebIconDatabase {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.WebStorage {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.DownloadListener {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.QbSdk {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.QbSdk$PreInitCallback {
	public <fields>;
	public <methods>;
}
-keep public class com.tencent.smtt.sdk.CookieSyncManager {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.Tbs* {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.utils.LogFileUtils {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.utils.TbsLog {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.utils.TbsLogClient {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.CookieSyncManager {
	public <fields>;
	public <methods>;
}

# Added for game demos
-keep public class com.tencent.smtt.sdk.TBSGamePlayer {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerClient* {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerClientExtension {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGamePlayerService* {
	public <fields>;
	public <methods>;
}

-keep public class com.tencent.smtt.utils.Apn {
	public <fields>;
	public <methods>;
}
-keep class com.tencent.smtt.** {
	*;
}
# end


-keep public class com.tencent.smtt.export.external.extension.proxy.ProxyWebViewClientExtension {
	public <fields>;
	public <methods>;
}

-keep class MTT.ThirdAppInfoNew {
	*;
}

-keep class com.tencent.mtt.MttTraceEvent {
	*;
}

# Game related
-keep public class com.tencent.smtt.gamesdk.* {
	public protected *;
}

-keep public class com.tencent.smtt.sdk.TBSGameBooter {
        public <fields>;
        public <methods>;
}

-keep public class com.tencent.smtt.sdk.TBSGameBaseActivity {
	public protected *;
}

-keep public class com.tencent.smtt.sdk.TBSGameBaseActivityProxy {
	public protected *;
}

-keep public class com.tencent.smtt.gamesdk.internal.TBSGameServiceClient {
	public *;
}


-keep class com.bun.miitmdid.** {*;}
-keep class com.asus.msa.** {*;}
-keep class com.heytap.openid.** {*;}
-keep class com.huawei.android.hms.pps.** {*;}
-keep class com.meizu.flyme.openidsdk.** {*;}
-keep class com.samsung.android.deviceidservice.** {*;}
-keep class com.zui.** {*;}
# ------------------ X5Webview End ------------------------#

-keep class com.p1.mobile.putong.feed.newui.camera.util.CameraSdkHelper$SoList {*;}
-keep class com.p1.mobile.putong.feed.newui.camera.util.CameraSdkHelper$SoMd5 {*;}
-keep class com.momo.xscan.alivedetec.*{*;}
-keep class com.immomo.mncertification.util.LogInfo{*;}

# ----------------- 移动一键登录 Start --------------------------#
-dontwarn com.cmic.sso.sdk.**
-keep class com.cmic.sso.sdk.**{*;}
# ----------------- 移动一键登录 End --------------------------#


# ------------------ Injecter Start ------------------------#

-keep public class com.tantanapp.android.injecter.routes.**{*;}
-keep public class com.tantanapp.android.injecter.facade.**{*;}
-keep public class com.tantanapp.android.injecter.summary.**{*;}
-keep class * implements com.tantanapp.android.injecter.facade.template.ISyringe{*;}

# 如果使用了 byType 的方式获取 Service，需添加下面规则，保护接口
-keep interface * implements com.tantanapp.android.injecter.facade.template.IProvider

# 如果使用了 单类注入，即不定义接口实现 IProvider，需添加下面规则，保护实现
# -keep class * implements com.alibaba.android.arouter.facade.template.IProvider

-keepclasseswithmembers class * {
@com.tantanapp.android.injecter.facade.annotation.Autowired <fields>;
}
# ------------------ Injecter End ------------------------#

# ------------------ TTPlayer start ------------------------#
-keep class com.tantanapp.ijk.media.player.**{*;}
# ------------------ TTPlayer end ------------------------#

# ------------------ TTProxy start ------------------------#
-keep class com.tantanapp.media.proxy.api.TTMediaProxy {*;}
-keep class com.tantanapp.media.proxy.api.PreloadTaskInfo {*;}
-keep class com.tantanapp.media.proxy.api.PreloadTaskInfo$* {*;}
# ------------------ TTProxy end ------------------------#


## To solve emoji-compat problem
#-keep,allowobfuscation,allowshrinking,includecode class androidx.emoji.** {*;}

##live and audio sdk
-keep class com.p1.mobile.putong.feed.newui.camera.util.CameraSdkHelper$SoList {*;}
-keep class com.p1.mobile.putong.feed.newui.camera.util.CameraSdkHelper$SoMd5 {*;}
-keep class com.p1.mobile.putong.live.util.LiveSdkHelper$SoList {*;}
-keep class com.p1.mobile.putong.live.util.LiveSdkHelper$SoMd5 {*;}
-keep class com.p1.mobile.putong.core.mediacall.RtcSdkHelper$SoList {*;}
-keep class com.p1.mobile.putong.core.mediacall.RtcSdkHelper$SoMd5 {*;}
-keep class io.agora.**{*;}
-keep class com.p1.mobile.putong.core.mediacall.EventData{*;}
#JSBridge
-keep @com.p1.mobile.putong.ui.jsbridge.JSCallNativeMethod class *

-keepclassmembers class * {
    @com.p1.mobile.putong.ui.jsbridge.JSCallNativeMethod *;
}

-dontwarn io.agora.**
-dontwarn com.tantanapp.media.**
-dontwarn com.tencent.smtt.export.external.DexLoader
-dontwarn com.appsflyer.**
-dontwarn com.guardsquare.dexguard.**
-dontwarn org.dom4j.**
-dontwarn com.immomo.**
-dontwarn com.momo.**
-dontwarn com.alipay.**
-dontwarn com.mob.commons.**
-dontwarn org.junit.**
-dontwarn android.test.**
-dontwarn com.unicom.xiaowo.login.d.a
-dontwarn com.tantanapp.android.injecter.**
-dontwarn net.vidageek.mirror.**
-dontwarn com.google.android.libraries.places.**
-dontwarn com.example.gt3unbindsdk.unBind.GT3GifView
-dontnote junit.**

# 高德定位

-dontwarn com.amap.api.location.**
-dontwarn com.amap.api.fence.**
-dontwarn com.loc.**
-dontwarn com.autonavi.aps.amapapi.model.**

-keep class com.amap.api.location.**{*;}
-keep class com.amap.api.fence.**{*;}
-keep class com.loc.**{*;}
-keep class com.autonavi.aps.amapapi.model.**{*;}

# google billing
-keep class com.android.vending.billing.**
# fcm fallback通知通道
#-keepresources string/fcm_fallback_notification_channel_label

-keep class c.t.**{*;}
-keep class com.tencent.map.geolocation.**{*;}
-keep class com.immomo.velib.anim.model.VideoEffectModel {
	*;
}
-keep class * extends com.p1.mobile.account_core.request_data.JsonData { *; }
-keep class com.p1.mobile.account_unicom.data.UnicomResult {*;}
-keep class com.p1.mobile.account_core.reponse_data.** {*;}
-keep class com.p1.mobile.account_core.request_data.** {*;}

 -keepclassmembers class com.p1.mobile.account_phone.data.** {
    @com.google.gson.annotations.SerializedName <fields>;
 }
 -keepclassmembers class com.p1.mobile.account_facebook.data.** {
    @com.google.gson.annotations.SerializedName <fields>;
 }
 -keepclassmembers class com.p1.mobile.account_mobile.data.** {
    @com.google.gson.annotations.SerializedName <fields>;
 }
 -keepclassmembers class com.p1.mobile.account_unicom.data.** {
    @com.google.gson.annotations.SerializedName <fields>;
 }
 -keepclassmembers class com.p1.mobile.account_wechat.data.** {
    @com.google.gson.annotations.SerializedName <fields>;
 }

-dontwarn  org.eclipse.jdt.annotation.**
-dontwarn  c.t.**

-keep public class * extends android.database.sqlite.SQLiteOpenHelper
-keep public class * extends io.requery.android.database.sqlite.SQLiteOpenHelper

-keep class com.didi.virtualapk.internal.VAInstrumentation { *; }
-keep class com.didi.virtualapk.internal.PluginContentResolver { *; }
-keep class * extends android.app.Application {*;}

-dontwarn com.didi.virtualapk.**
-dontwarn android.**
-keep class android.** { *; }
-dontwarn **.R$**
-dontwarn **.R
-keep public class **.R$*{
   public static final int *;
}

-keep public class **.R