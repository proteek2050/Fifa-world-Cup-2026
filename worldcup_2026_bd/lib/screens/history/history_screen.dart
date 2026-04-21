import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../data/history_data.dart';
import '../../models/history_model.dart';
import '../../widgets/ad_banner_widget.dart';
import '../../widgets/app_drawer.dart';
import '../../core/utils/drawer_navigator.dart';

// Flag emojis for all-time champions
const _flagMap = {
  'ব্রাজিল': '🇧🇷',
  'জার্মানি': '🇩🇪',
  'ইতালি': '🇮🇹',
  'আর্জেন্টিনা': '🇦🇷',
  'ফ্রান্স': '🇫🇷',
  'উরুগুয়ে': '🇺🇾',
  'ইংল্যান্ড': '🏴󠁧󠁢󠁥󠁮󠁧󠁿',
  'স্পেন': '🇪🇸',
};

// Normalize West Germany → Germany for win counting
String _normalize(String name) =>
    name == 'পশ্চিম জার্মানি' ? 'জার্মানি' : name;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Map<String, int> _buildWinCounts() {
    final Map<String, int> counts = {};
    for (final h in allHistory) {
      final name = _normalize(h.champion);
      counts[name] = (counts[name] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final winCounts = _buildWinCounts();
    final sortedWinners = winCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Most recent edition first
    final reversed = allHistory.reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      drawer: AppDrawer(
        onNavigate: (route) => DrawerNavigator.navigate(context, route),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.bgMedium,
        elevation: 0,
        title: Text(AppStrings.historyTitle, style: AppTextStyles.appBarTitle),
      ),
      body: CustomScrollView(
        slivers: [
          // ── Win-count section header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Text('শিরোপার সংখ্যা', style: AppTextStyles.sectionTitle),
            ),
          ),

          // ── Champion count cards ──
          SliverToBoxAdapter(
            child: SizedBox(
              height: 118,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: sortedWinners.length,
                separatorBuilder: (context2, i) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final entry = sortedWinners[index];
                  return _WinCountCard(
                    name: entry.key,
                    wins: entry.value,
                    rank: index + 1,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${entry.key} — ${BengaliNumber.fromInt(entry.value)} বার বিশ্বচ্যাম্পিয়ন',
                          ),
                          backgroundColor: AppColors.bgMedium,
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // ── Full history section header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                children: [
                  Text(AppStrings.fullHistory,
                      style: AppTextStyles.sectionTitle),
                  const SizedBox(width: 8),
                  Text(
                    '(${BengaliNumber.fromInt(allHistory.length)} আসর)',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ),

          // ── Year-by-year list (ad every 5 entries) ──
          SliverList(
            delegate: _buildHistoryDelegate(reversed),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  static SliverChildDelegate _buildHistoryDelegate(List<HistoryModel> reversed) {
    const adEvery = 5;
    const stride = adEvery + 1;
    final totalCount = reversed.length + (reversed.length ~/ adEvery);
    return SliverChildBuilderDelegate(
      (context, index) {
        if ((index + 1) % stride == 0) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: AdBannerWidget(),
          );
        }
        final dataIndex = index - (index ~/ stride);
        if (dataIndex >= reversed.length) return const SizedBox.shrink();
        return _HistoryCard(history: reversed[dataIndex]);
      },
      childCount: totalCount,
    );
  }
}

// ── Win-count card (horizontal scroll) ────────────────────────────────
class _WinCountCard extends StatelessWidget {
  const _WinCountCard({
    required this.name,
    required this.wins,
    required this.rank,
    required this.onTap,
  });

  final String name;
  final int wins;
  final int rank;
  final VoidCallback onTap;

  Color get _borderColor {
    if (rank == 1) return AppColors.gold;
    if (rank == 2) return const Color(0xFFC0C0C0); // silver
    if (rank == 3) return const Color(0xFFCD7F32); // bronze
    return AppColors.outlineVariant;
  }

  @override
  Widget build(BuildContext context) {
    final flag = _flagMap[name] ?? '🏳';
    return GestureDetector(
      onTap: onTap,
      child: Container(
      width: 110,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderColor.withAlpha(100), width: 1.5),
        boxShadow: rank == 1
            ? [
                BoxShadow(
                  color: AppColors.gold.withAlpha(30),
                  blurRadius: 12,
                  offset: Offset.zero,
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(flag, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 6),
          Text(
            name,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏆 ', style: const TextStyle(fontSize: 11)),
              Text(
                '${BengaliNumber.fromInt(wins)} ${AppStrings.times}',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
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

// ── Individual year history card ──────────────────────────────────────
class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.history});

  final HistoryModel history;

  @override
  Widget build(BuildContext context) {
    final championNormalized = _normalize(history.champion);
    final flag = _flagMap[championNormalized] ?? '🏳';
    final yearBn = BengaliNumber.fromInt(history.year);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withAlpha(38),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header: year + host
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Text(
                  yearBn,
                  style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.location_on_outlined,
                    color: AppColors.cyan, size: 14),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    history.host,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.cyan,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Body: champion vs runner-up
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                // Champion column
                Expanded(
                  child: Row(
                    children: [
                      Text(flag, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '🏆 ${AppStrings.champion}',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.gold,
                              ),
                            ),
                            Text(
                              championNormalized,
                              style: AppTextStyles.bodyBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Score pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.bgCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    history.score,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),

                // Runner-up column
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '🥈 ${AppStrings.runnerUp}',
                              style: AppTextStyles.caption.copyWith(
                                color: const Color(0xFFC0C0C0),
                              ),
                            ),
                            Text(
                              history.runnerUp,
                              style: AppTextStyles.body,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer: 3rd place
          Container(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
            child: Row(
              children: [
                Text(
                  '🥉 ${AppStrings.thirdPlace}: ',
                  style: AppTextStyles.caption.copyWith(
                    color: const Color(0xFFCD7F32),
                  ),
                ),
                Text(
                  history.thirdPlace,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
