import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'app.dart';
import 'core/services/notification_service.dart';
import 'widgets/rating_dialog.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize AdMob
    await MobileAds.instance.initialize().catchError((e) {
      debugPrint("AdMob Init Error: $e");
      return InitializationStatus({});
    });

    // Initialize local notifications
    await NotificationService.init().catchError((e) => debugPrint("Notification Init Error: $e"));

    // Track launches
    await RatingHelper.incrementLaunch().catchError((e) => null);

    // Lock to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF560027),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  } catch (e) {
    debugPrint("App Initialization Error: $e");
  }

  runApp(const WorldCup2026App());
}
