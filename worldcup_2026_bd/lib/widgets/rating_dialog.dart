import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

class RatingHelper {
  RatingHelper._();

  static const _keyLaunchCount  = 'launch_count';
  static const _keyRated        = 'user_rated';
  static const _keyNeverAsk     = 'never_ask';
  // Play Store URL — update com.worldcup2026.bangladesh when live
  static const _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.worldcup2026.bangladesh';

  static Future<void> incrementLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final count = (prefs.getInt(_keyLaunchCount) ?? 0) + 1;
    await prefs.setInt(_keyLaunchCount, count);
  }

  static Future<bool> shouldShow() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_keyRated) == true) return false;
    if (prefs.getBool(_keyNeverAsk) == true) return false;
    final count = prefs.getInt(_keyLaunchCount) ?? 0;
    return count == 5 || count == 10 || count == 20;
  }

  static Future<void> markRated() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRated, true);
  }

  static Future<void> markNeverAsk() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNeverAsk, true);
  }

  static Future<void> openPlayStore() async {
    final uri = Uri.parse(_playStoreUrl);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.bgCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events_rounded, size: 56, color: AppColors.gold),
            const SizedBox(height: 12),
            Text(
              AppStrings.ratingQuestion,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Star row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _stars = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      i < _stars ? Icons.star_rounded : Icons.star_border_rounded,
                      color: AppColors.gold,
                      size: 36,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            // Rate now
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _stars == 0
                    ? null
                    : () async {
                        await RatingHelper.markRated();
                        if (context.mounted) Navigator.of(context).pop();
                        if (_stars >= 4) await RatingHelper.openPlayStore();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  AppStrings.rateNow,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Later / No thanks
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    AppStrings.later,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textLight,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await RatingHelper.markNeverAsk();
                    if (context.mounted) Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.noThanks,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textGray,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
