import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../widgets/ad_banner_widget.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';

class HighlightsScreen extends StatefulWidget {
  const HighlightsScreen({super.key});

  @override
  State<HighlightsScreen> createState() => _HighlightsScreenState();
}

class _HighlightsScreenState extends State<HighlightsScreen> {
  // Tournament start: June 11, 2026 19:00 UTC = June 12, 2026 01:00 BST
  static final _tournamentStart = DateTime(2026, 6, 12, 1, 0, 0);

  Duration _remaining = Duration.zero;
  late final Stream<Duration> _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Stream.periodic(const Duration(seconds: 1), (_) {
      final now = DateTime.now();
      final diff = _tournamentStart.difference(now);
      return diff.isNegative ? Duration.zero : diff;
    });
    _remaining = () {
      final diff = _tournamentStart.difference(DateTime.now());
      return diff.isNegative ? Duration.zero : diff;
    }();
  }

  @override
  Widget build(BuildContext context) {
    final tournamentStarted = DateTime.now().isAfter(_tournamentStart);

    return Scaffold(
      backgroundColor: AppColors.bgGradientBottom,
      appBar: AppBar(
        backgroundColor: AppColors.bgMedium,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.highlights, style: AppTextStyles.appBarTitle),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.bgGradientTop, AppColors.bgGradientBottom],
          ),
        ),
        child: tournamentStarted ? _buildLiveHighlights() : _buildCountdown(),
      ),
    );
  }

  Widget _buildCountdown() {
    return StreamBuilder<Duration>(
      stream: _ticker,
      initialData: _remaining,
      builder: (context, snap) {
        final dur = snap.data ?? Duration.zero;
        final days = dur.inDays;
        final hours = dur.inHours % 24;
        final minutes = dur.inMinutes % 60;
        final seconds = dur.inSeconds % 60;

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          children: [
            // Trophy icon
            const Icon(Icons.emoji_events_rounded, size: 80, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(
              'হাইলাইটস শীঘ্রই আসছে',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 22, color: AppColors.gold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'টুর্নামেন্ট শুরু হলেই সেরা মুহূর্তগুলো এখানে দেখতে পাবেন',
              style: AppTextStyles.body.copyWith(color: AppColors.textLight, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Countdown box
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.bgCard,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.08),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'টুর্নামেন্ট শুরু হতে আর',
                    style: AppTextStyles.caption.copyWith(fontSize: 13, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _TimeUnit(BengaliNumber.fromInt(days), 'দিন'),
                      _Colon(),
                      _TimeUnit(_pad(BengaliNumber.fromInt(hours)), 'ঘণ্টা'),
                      _Colon(),
                      _TimeUnit(_pad(BengaliNumber.fromInt(minutes)), 'মিনিট'),
                      _Colon(),
                      _TimeUnit(_pad(BengaliNumber.fromInt(seconds)), 'সেকেন্ড'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '১২ জুন ২০২৬ থেকে শুরু',
                    style: AppTextStyles.caption.copyWith(color: AppColors.gold, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Feature teaser cards
            Text(
              'কী দেখতে পাবেন',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 12),
            ...() {
              final items = <Widget>[];
              for (int i = 0; i < _teaserItems.length; i++) {
                final item = _teaserItems[i];
                items.add(_TeaserCard(icon: item.$1, title: item.$2, subtitle: item.$3));
                if ((i + 1) % 3 == 0) {
                  items.add(const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: AdBannerWidget(),
                  ));
                }
              }
              return items;
            }(),

            const SizedBox(height: 24),
            // Host countries info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.bgCard.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.cyan, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'আয়োজক দেশ',
                          style: AppTextStyles.caption.copyWith(color: AppColors.cyan, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppStrings.hostCountries,
                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLiveHighlights() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_circle_filled_rounded, size: 80, color: AppColors.gold),
            const SizedBox(height: 20),
            Text(
              'হাইলাইটস',
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'সেরা গোল ও মুহূর্তগুলো শীঘ্রই এখানে যোগ করা হবে',
              style: AppTextStyles.body.copyWith(color: AppColors.textLight, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

const _teaserItems = [
  (Icons.videocam_rounded, 'সেরা গোল', 'প্রতিটি ম্যাচের সেরা গোলের হাইলাইট'),
  (Icons.stars_rounded, 'ম্যান অব দ্য ম্যাচ', 'প্রতি ম্যাচের সেরা খেলোয়াড়ের পারফরম্যান্স'),
  (Icons.bar_chart_rounded, 'পরিসংখ্যান', 'গোল, অ্যাসিস্ট, পাস সাফল্যের পূর্ণ বিশ্লেষণ'),
];

class _TimeUnit extends StatelessWidget {
  final String value;
  final String label;

  const _TimeUnit(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.gold,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(fontSize: 11, color: AppColors.textLight),
        ),
      ],
    );
  }
}

class _Colon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      ':',
      style: TextStyle(
        fontFamily: 'Lexend',
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.gold,
      ),
    );
  }
}

class _TeaserCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _TeaserCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.gold, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.textLight, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _pad(String s) => s.length >= 2 ? s : '০$s';
