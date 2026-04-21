import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      appBar: AppBar(
        backgroundColor: AppColors.bgMedium,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('সেটিংস', style: AppTextStyles.appBarTitle),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgGradientTop, AppColors.bgGradientBottom],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: AppColors.bgMedium,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withAlpha(40),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => const Icon(
                      Icons.sports_soccer_rounded,
                      size: 48,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'ফিফা ওয়ার্ল্ড কাপ ২০২৬ সময়সূচী',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'FIFA World Cup 2026 Schedule BD',
              style: GoogleFonts.hindSiliguri(
                fontSize: 13,
                color: AppColors.textGray,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _InfoTile(icon: Icons.info_outline_rounded, label: 'ভার্সন', value: '1.0.0'),
            _InfoTile(icon: Icons.android_rounded, label: 'প্ল্যাটফর্ম', value: 'Android'),
            _InfoTile(icon: Icons.language_rounded, label: 'ভাষা', value: 'বাংলা'),
            _InfoTile(
              icon: Icons.sports_soccer_rounded,
              label: 'টুর্নামেন্ট',
              value: 'FIFA World Cup 2026',
            ),
            _InfoTile(
              icon: Icons.location_on_rounded,
              label: 'আয়োজক দেশ',
              value: 'যুক্তরাষ্ট্র, কানাডা, মেক্সিকো',
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard.withAlpha(180),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.gold.withAlpha(40),
                ),
              ),
              child: Text(
                'এই অ্যাপটি বাংলাদেশের ফুটবল ভক্তদের জন্য তৈরি। '
                'ফিফা বিশ্বকাপ ২০২৬-এর সময়সূচী, দলের তথ্য, স্টেডিয়াম '
                'ও ইতিহাস বাংলায় উপস্থাপন করা হয়েছে।',
                style: GoogleFonts.hindSiliguri(
                  fontSize: 13,
                  color: AppColors.textLight,
                  height: 1.7,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.hindSiliguri(
              fontSize: 14,
              color: AppColors.textGray,
              height: 1.5,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.hindSiliguri(
              fontSize: 14,
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
