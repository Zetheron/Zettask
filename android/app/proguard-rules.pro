# Flutter wrapper & platform channels
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# flutter_local_notifications & Gson scheduled payload serialization
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keepattributes Signature
-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }

# sqflite
-keep class com.tekartik.sqflite.** { *; }

# device_calendar_plus
-keep class to.bullet.device_calendar_plus_android.** { *; }

# Firebase Core, Auth, Firestore & Google Sign-In
-keep class com.google.firebase.** { *; }
-keep class com.google.firestore.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }
-keep class io.flutter.plugins.googlesignin.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class androidx.credentials.** { *; }
-keep class com.google.android.libraries.identity.googleid.** { *; }
-dontwarn com.google.firebase.**
-dontwarn io.grpc.**

# App Lock (local_auth / Biometric) & Home Screen Widget (home_widget)
-keep class com.zetheron.zettask.ZettaskWidgetProvider { *; }
-keep class es.antonborri.home_widget.** { *; }
-keep class * extends android.appwidget.AppWidgetProvider { *; }
-keep class io.flutter.plugins.localauth.** { *; }
-keep class androidx.biometric.** { *; }
