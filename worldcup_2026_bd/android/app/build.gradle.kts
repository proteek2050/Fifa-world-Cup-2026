plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.worldcup2026.bangladesh"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Required for flutter_local_notifications
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.worldcup2026.bangladesh"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        // Release signing: create android/key.properties with the values below,
        // then run: keytool -genkey -v -keystore android/app/worldcup2026.jks
        //           -alias worldcup2026 -keyalg RSA -keysize 2048 -validity 10000
        // Add android/key.properties to .gitignore (it contains secrets).
        //
        // key.properties format:
        //   storePassword=<your keystore password>
        //   keyPassword=<your key password>
        //   keyAlias=worldcup2026
        //   storeFile=../app/worldcup2026.jks
        //
        // Uncomment the block below after creating key.properties:
        //
        // create("release") {
        //     val keyProps = java.util.Properties()
        //     keyProps.load(rootProject.file("key.properties").inputStream())
        //     keyAlias = keyProps["keyAlias"] as String
        //     keyPassword = keyProps["keyPassword"] as String
        //     storeFile = file(keyProps["storeFile"] as String)
        //     storePassword = keyProps["storePassword"] as String
        // }
    }

    buildTypes {
        release {
            // Change to signingConfigs.getByName("release") after setting up key.properties
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

flutter {
    source = "../.."
}
