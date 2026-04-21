import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/services/ad_manager.dart';
import '../../core/services/standings_api.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../data/groups_data.dart';
import '../../models/standing_model.dart';
import '../../widgets/app_drawer.dart';
import '../../core/utils/drawer_navigator.dart';

class PointTableScreen extends StatefulWidget {
  const PointTableScreen({super.key});

  @override
  State<PointTableScreen> createState() => _PointTableScreenState();
}

class _PointTableScreenState extends State<PointTableScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  GroupStandings? _standings;
  bool _isLoading = true;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: allGroupLetters.length, vsync: this);
    _loadStandings();
    // Show interstitial ad on Point Table entry (max once per 3 min)
    AdManager.loadInterstitial();
    WidgetsBinding.instance.addPostFrameCallback((_) => AdManager.showInterstitial());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadStandings({bool forceRefresh = false}) async {
    if (!mounted) return;
    setState(() {
      if (forceRefresh) {
        _isRefreshing = true;
      } else {
        _isLoading = true;
      }
    });

    final result = await StandingsApi.fetchStandings(forceRefresh: forceRefresh);

    if (!mounted) return;
    setState(() {
      _standings = result;
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      drawer: AppDrawer(
        onNavigate: (route) => DrawerNavigator.navigate(context, route),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.bgMedium,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.pointTableTitle, style: AppTextStyles.appBarTitle),
        actions: [
          if (_standings?.isFromCache == true)
            _OfflineBadge(fetchedAt: _standings!.fetchedAt),
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
                ),
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: AppColors.gold,
          indicatorWeight: 3,
          labelColor: AppColors.gold,
          unselectedLabelColor: AppColors.textGray,
          labelStyle: GoogleFonts.hindSiliguri(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.hindSiliguri(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          tabs: allGroupLetters.map((l) => Tab(text: 'গ্রুপ $l')).toList(),
        ),
      ),
      body: _isLoading
          ? const _LoadingShimmer()
          : RefreshIndicator(
              color: AppColors.gold,
              backgroundColor: AppColors.bgMedium,
              onRefresh: () => _loadStandings(forceRefresh: true),
              child: TabBarView(
                controller: _tabController,
                children: allGroupLetters.map((letter) {
                  final rows = _standings?.groups[letter] ?? [];
                  return _GroupStandingTab(
                    groupLetter: letter,
                    rows: rows,
                  );
                }).toList(),
              ),
            ),
    );
  }
}

class _GroupStandingTab extends StatelessWidget {
  final String groupLetter;
  final List<StandingModel> rows;

  const _GroupStandingTab({
    required this.groupLetter,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      children: [
        _GroupTableCard(groupLetter: groupLetter, rows: rows),
        const SizedBox(height: 16),
        const _QualificationLegend(),
        const SizedBox(height: 80),
      ],
    );
  }
}

class _GroupTableCard extends StatelessWidget {
  final String groupLetter;
  final List<StandingModel> rows;

  const _GroupTableCard({required this.groupLetter, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.bgMedium,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    groupLetter,
                    style: GoogleFonts.lexend(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.bgDark,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('গ্রুপ $groupLetter — পয়েন্ট টেবিল', style: AppTextStyles.cardLabel),
              ],
            ),
          ),

          // Column headers
          const _TableHeader(),

          // Rows
          ...rows.asMap().entries.map((entry) {
            final idx = entry.key;
            final row = entry.value;
            final isLast = idx == rows.length - 1;
            return _StandingRow(
              row: row,
              isLast: isLast,
              totalTeams: rows.length,
            );
          }),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: AppColors.surfaceContainerHighest,
      child: Row(
        children: [
          const SizedBox(width: 28), // position badge
          const SizedBox(width: 8),
          const Expanded(child: SizedBox()), // team name
          _HeaderCell(AppStrings.played),
          _HeaderCell(AppStrings.won),
          _HeaderCell(AppStrings.drawn),
          _HeaderCell(AppStrings.lost),
          _HeaderCell(AppStrings.goalsFor),
          _HeaderCell(AppStrings.goalsAgainst),
          _HeaderCell(AppStrings.goalDiff),
          _HeaderCell(AppStrings.points, isHighlight: true),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  final bool isHighlight;

  const _HeaderCell(this.text, {this.isHighlight = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.hindSiliguri(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: isHighlight ? AppColors.gold : AppColors.onSurfaceVariant,
          height: 1.5,
        ),
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  final StandingModel row;
  final bool isLast;
  final int totalTeams;

  const _StandingRow({
    required this.row,
    required this.isLast,
    required this.totalTeams,
  });

  Color _rowBg(int pos) {
    if (pos == 1) return AppColors.gold.withAlpha(25);
    if (pos == 2) return AppColors.cyan.withAlpha(20);
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _rowBg(row.position),
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withAlpha(38),
                  width: 1,
                ),
              ),
        borderRadius: isLast
            ? const BorderRadius.vertical(bottom: Radius.circular(16))
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          _PositionBadge(position: row.position),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              children: [
                Text(row.flagEmoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    row.teamNameBn.isNotEmpty ? row.teamNameBn : row.teamNameEn,
                    style: GoogleFonts.hindSiliguri(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                      height: 1.4,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          _DataCell(BengaliNumber.fromInt(row.played)),
          _DataCell(BengaliNumber.fromInt(row.won)),
          _DataCell(BengaliNumber.fromInt(row.drawn)),
          _DataCell(BengaliNumber.fromInt(row.lost)),
          _DataCell(BengaliNumber.fromInt(row.goalsFor)),
          _DataCell(BengaliNumber.fromInt(row.goalsAgainst)),
          _DataCell(
            row.goalDifference >= 0
                ? '+${BengaliNumber.fromInt(row.goalDifference)}'
                : '-${BengaliNumber.fromInt(row.goalDifference.abs())}',
            color: row.goalDifference > 0
                ? AppColors.cyan
                : row.goalDifference < 0
                    ? AppColors.error
                    : AppColors.textGray,
          ),
          _DataCell(
            BengaliNumber.fromInt(row.points),
            isBold: true,
            color: AppColors.gold,
          ),
        ],
      ),
    );
  }
}

class _PositionBadge extends StatelessWidget {
  final int position;

  const _PositionBadge({required this.position});

  @override
  Widget build(BuildContext context) {
    final Color bg = position == 1
        ? AppColors.gold
        : position == 2
            ? AppColors.cyan
            : AppColors.surfaceBright;

    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Text(
        BengaliNumber.fromInt(position),
        style: GoogleFonts.lexend(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: position <= 2 ? AppColors.bgDark : AppColors.textGray,
        ),
      ),
    );
  }
}

class _DataCell extends StatelessWidget {
  final String text;
  final bool isBold;
  final Color? color;

  const _DataCell(this.text, {this.isBold = false, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.hindSiliguri(
          fontSize: 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: color ?? AppColors.onSurface,
          height: 1.5,
        ),
      ),
    );
  }
}

class _QualificationLegend extends StatelessWidget {
  const _QualificationLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'কোয়ালিফিকেশন সংকেত',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const _LegendItem(color: AppColors.gold, label: '১ম স্থান — পরের রাউন্ডে'),
          const SizedBox(height: 4),
          const _LegendItem(color: AppColors.cyan, label: '২য় স্থান — পরের রাউন্ডে'),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
}

class _OfflineBadge extends StatelessWidget {
  final DateTime fetchedAt;

  const _OfflineBadge({required this.fetchedAt});

  String _minutesAgo() {
    final diff = DateTime.now().difference(fetchedAt).inMinutes;
    if (diff == 0) return 'এইমাত্র';
    return '${BengaliNumber.fromInt(diff)} ${AppStrings.minutesAgo}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.tertiaryContainer.withAlpha(40),
        border: Border.all(color: AppColors.tertiaryContainer.withAlpha(100)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 13,
            color: AppColors.tertiaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            '${AppStrings.offlineMode} • ${_minutesAgo()}',
            style: GoogleFonts.hindSiliguri(
              fontSize: 10,
              color: AppColors.tertiaryContainer,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingShimmer extends StatefulWidget {
  const _LoadingShimmer();

  @override
  State<_LoadingShimmer> createState() => _LoadingShimmerState();
}

class _LoadingShimmerState extends State<_LoadingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: List.generate(
            4,
            (_) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHigh
                    .withAlpha((_anim.value * 255).toInt()),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }
}
