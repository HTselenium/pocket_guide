# To enable ProGuard in your project, edit project.properties
# to define the proguard.config property as described in that file.
#
# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in ${sdk.dir}/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the ProGuard
# include property in project.properties.
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

-dontwarn com.huawei.hms.ads.identifier.AdvertisingIdClient$Info*
-dontwarn com.huawei.hms.ads.identifier.AdvertisingIdClient*
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient$Info*
-dontwarn com.google.android.gms.ads.identifier.AdvertisingIdClient*
-dontwarn com.google.zxing.BarcodeFormat*
-dontwarn com.google.zxing.EncodeHintType*
-dontwarn com.google.zxing.MultiFormatWriter*
-dontwarn com.google.zxing.common.BitMatrix*

-keep class com.onetrust.** { *; }
