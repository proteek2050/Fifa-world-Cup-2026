import 'package:google_mobile_ads/google_mobile_ads.dart';

/// AdMob unit IDs.
/// Replace test IDs with real ones before Play Store publish.
class AdUnitIds {
  AdUnitIds._();

  static const String banner       = 'ca-app-pub-3940256099942544/6300978111';
  static const String interstitial = 'ca-app-pub-3940256099942544/1033173712';
  static const String native       = 'ca-app-pub-3940256099942544/2247696110';
}

/// Manages loading and caching of an interstitial ad with a 3-minute cooldown.
class AdManager {
  AdManager._();

  static InterstitialAd? _interstitial;
  static DateTime? _lastInterstitialShown;
  static const _cooldown = Duration(minutes: 3);

  static Future<void> loadInterstitial() async {
    if (_interstitial != null) return;
    await InterstitialAd.load(
      adUnitId: AdUnitIds.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitial = ad,
        onAdFailedToLoad: (_) => _interstitial = null,
      ),
    );
  }

  static void showInterstitial() {
    final now = DateTime.now();
    if (_lastInterstitialShown != null &&
        now.difference(_lastInterstitialShown!) < _cooldown) {
      return;
    }
    final ad = _interstitial;
    if (ad == null) return;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (a) {
        a.dispose();
        _interstitial = null;
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (a, _) {
        a.dispose();
        _interstitial = null;
      },
    );
    _lastInterstitialShown = now;
    _interstitial = null;
    ad.show();
  }
}
