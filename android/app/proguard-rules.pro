# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.errorprone.annotations.CanIgnoreReturnValue
-dontwarn com.google.errorprone.annotations.CheckReturnValue
-dontwarn com.google.errorprone.annotations.Immutable
-dontwarn com.google.errorprone.annotations.RestrictedApi
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy
-dontwarn org.bouncycastle.jce.provider.BouncyCastleProvider
-dontwarn org.bouncycastle.pqc.jcajce.provider.BouncyCastlePQCProvider
-keep class org.xmlpull.v1.** { *; }

# Geolocator - Keep location services
-keep class com.baseflow.geolocator.** { *; }
-keepclassmembers class com.baseflow.giolocator.** { *; }

# Wakelock Plus - Keep wakelock functionality
-keep class dev.fluttercommunity.plus.wakelock.** { *; }

# Torch Light - Keep flashlight functionality
-keep class com.crazecoder.flutter.torchlight.** { *; }

# Audio Players - Keep audio functionality
-keep class xyz.luan.audioplayers.** { *; }
-keepclassmembers class xyz.luan.audioplayers.** { *; }

# Just Audio - Keep audio player
-keep class com.ryanheise.just_audio.** { *; }

# Telephony - Keep SMS functionality
-keep class com.shounakmulay.telephony.** { *; }

# Firebase - Keep all Firebase classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Flutter Contacts
-keep class co.sunnyapp.flutter_contacts.** { *; }

# Permission Handler
-keep class com.baseflow.permissionhandler.** { *; }





