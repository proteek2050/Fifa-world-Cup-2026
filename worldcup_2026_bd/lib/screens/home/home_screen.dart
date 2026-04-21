import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart' show Share;
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../data/matches_data.dart';
import '../../models/match_model.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/countdown_timer_widget.dart';
import '../../widgets/rating_dialog.dart';
import '../about/about_screen.dart';
import '../schedule/schedule_screen.dart';
import '../groups/groups_screen.dart';
import '../teams/teams_screen.dart';
import '../stadiums/stadiums_screen.dart';
import '../point_table/point_table_screen.dart';
import '../history/history_screen.dart';
import '../players/players_screen.dart';
import '../highlights/highlights_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final should = await RatingHelper.shouldShow();
      if (should && mounted) {
        await showDialog(
          context: context,
          builder: (_) => const RatingDialog(),
        );
      }
    });
  }

  List<MatchModel> _getTodaysMatches() {
    final now = DateTime.now();
    final todayStr = '${now.day} ${_monthEn(now.month)} ${now.year}';
    return allMatches
        .where((m) => m.bdDate == todayStr || m.utcDate == todayStr)
        .toList();
  }

  String _monthEn(int m) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[m];
  }

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _handleDrawerRoute(BuildContext context, String route) {
    switch (route) {
      case 'schedule':
        _navigate(context, const ScheduleScreen());
      case 'groups':
        _navigate(context, const GroupsScreen());
      case 'teams':
        _navigate(context, const TeamsScreen());
      case 'stadiums':
        _navigate(context, const StadiumsScreen());
      case 'pointTable':
        _navigate(context, const PointTableScreen());
      case 'history':
        _navigate(context, const HistoryScreen());
      case 'players':
        _navigate(context, const PlayersScreen());
      case 'highlights':
        _navigate(context, const HighlightsScreen());
      case 'settings':
        _navigate(context, const AboutScreen());
      case 'rate':
        showDialog(context: context, builder: (_) => const RatingDialog());
      case 'share':
        Share.share(
          'ফিফা বিশ্বকাপ ২০২৬ সময়সূচী অ্যাপ ডাউনলোড করুন!\n'
          'https://play.google.com/store/apps/details?id=com.worldcup2026.bangladesh',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final todaysMatches = _getTodaysMatches();

    return Scaffold(
      backgroundColor: AppColors.bgGradientBottom,
      drawer: AppDrawer(
        onNavigate: (route) => _handleDrawerRoute(context, route),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.homeCard,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.white, size: 28),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: SizedBox(
          height: 36,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.contain,
            errorBuilder: (ctx, err, st) =>
                Text(AppStrings.appBarTitle, style: AppTextStyles.appBarTitle),
          ),
        ),
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            // ── Hero Card: ম্যাচ এবং সময়সূচী ──
            _HeroCard(
              assetPath: 'assets/images/menu_schedule.png',
              label: AppStrings.matchAndSchedule,
              onTap: () => _navigate(context, const ScheduleScreen()),
            ),
            const SizedBox(height: 16),

            // ── আজকের ম্যাচ (directly below schedule) ──
            _TodaysMatchSection(matches: todaysMatches),
            const SizedBox(height: 20),

            // ── বিশ্বকাপ শুরু হতে আর (countdown) ──
            const CountdownTimerWidget(),
            const SizedBox(height: 24),

            // ── Navigation Grid (7 items, Visiting Places removed) ──
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.05,
              children: [
                _GridCard(
                  assetPath: 'assets/images/menu_groups.png',
                  label: AppStrings.groups,
                  onTap: () => _navigate(context, const GroupsScreen()),
                ),
                _GridCard(
                  assetPath: 'assets/images/menu_teams.png',
                  label: AppStrings.teams,
                  onTap: () => _navigate(context, const TeamsScreen()),
                ),
                _GridCard(
                  assetPath: '',
                  label: AppStrings.stadiums,
                  iconFallback: Icons.stadium_rounded,
                  onTap: () => _navigate(context, const StadiumsScreen()),
                ),
                _GridCard(
                  assetPath: 'assets/images/menu_players.png',
                  label: AppStrings.players,
                  onTap: () => _navigate(context, const PlayersScreen()),
                ),
                _GridCard(
                  assetPath: 'assets/images/menu_highlights.png',
                  label: AppStrings.highlights,
                  onTap: () => _navigate(context, const HighlightsScreen()),
                ),
                _GridCard(
                  assetPath: 'assets/images/menu_pointtable.png',
                  label: AppStrings.pointTable,
                  onTap: () => _navigate(context, const PointTableScreen()),
                ),
                _GridCard(
                  assetPath: 'assets/images/menu_history.png',
                  label: AppStrings.history,
                  onTap: () => _navigate(context, const HistoryScreen()),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Hero Card (full-width, taller image)
// ─────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;

  const _HeroCard({
    required this.assetPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 192,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      assetPath,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      errorBuilder: (context, error, stack) => Container(
                        color: AppColors.bgMedium,
                        child: const Icon(
                          Icons.sports_soccer,
                          size: 64,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  label,
                  style: AppTextStyles.sectionTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Grid Card (2-column)
// ─────────────────────────────────────────────
class _GridCard extends StatefulWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final IconData? iconFallback;

  const _GridCard({
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.iconFallback,
  });

  @override
  State<_GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<_GridCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.homeCard,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    widget.assetPath.isEmpty
                        ? Container(
                            color: AppColors.bgMedium,
                            child: Icon(
                              widget.iconFallback ?? Icons.sports_soccer,
                              size: 40,
                              color: AppColors.gold,
                            ),
                          )
                        : Image.asset(
                            widget.assetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Container(
                              color: AppColors.bgMedium,
                              child: Icon(
                                widget.iconFallback ?? Icons.sports_soccer,
                                size: 40,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.label,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// আজকের ম্যাচ Section
// ─────────────────────────────────────────────
class _TodaysMatchSection extends StatelessWidget {
  final List<MatchModel> matches;

  const _TodaysMatchSection({required this.matches});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.today_rounded, color: AppColors.gold, size: 20),
            const SizedBox(width: 8),
            Text(
              AppStrings.todaysMatch,
              style: AppTextStyles.sectionTitle.copyWith(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (matches.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: AppColors.homeCard.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.gold.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: Text(
              AppStrings.noMatchToday,
              style: AppTextStyles.body.copyWith(
                color: AppColors.white.withValues(alpha: 0.6),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          )
        else
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: matches.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (_, i) => _TodayMatchCard(match: matches[i]),
            ),
          ),
      ],
    );
  }
}

class _TodayMatchCard extends StatelessWidget {
  final MatchModel match;

  const _TodayMatchCard({required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${AppStrings.matchNo} ${BengaliNumber.fromInt(match.matchNumber)}',
                  style: AppTextStyles.caption.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              if (match.group.isNotEmpty) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.cyan.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.cyan.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    match.group,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.cyan,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  match.team1Bn,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  AppStrings.vs,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.gold,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  match.team2Bn,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            BengaliNumber.fromString(match.bdTime),
            style: AppTextStyles.caption.copyWith(
              color: AppColors.gold,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            match.stadium,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.cyan,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
