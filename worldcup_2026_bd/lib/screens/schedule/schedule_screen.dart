import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/matches_data.dart';
import '../../data/teams_data.dart';
import '../../models/match_model.dart';
import '../../widgets/ad_banner_widget.dart';
import 'widgets/match_card_widget.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _searchVisible = false;
  String _searchQuery = '';

  late final Map<String, String> _flagMap;

  // Tab definitions: (stageEn, Bengali label)
  static const List<List<String>> _tabDefs = [
    ['First Stage',               AppStrings.groupStage],
    ['Round of 32',               AppStrings.roundOf32],
    ['Round of 16',               AppStrings.roundOf16],
    ['Quarter-final',             AppStrings.quarterFinal],
    ['Semi-final',                AppStrings.semiFinal],
    ['Play-off for third place',  AppStrings.thirdPlace],
    ['Final',                     AppStrings.finalMatch],
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabDefs.length, vsync: this);
    _flagMap = {for (final t in allTeams) t.nameEn: t.flagEmoji};
    _searchController.addListener(
      () => setState(() => _searchQuery = _searchController.text.toLowerCase()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<MatchModel> _matches(String stageEn) {
    final stage = allMatches.where((m) => m.stageEn == stageEn).toList();
    if (_searchQuery.isEmpty) return stage;
    return stage.where((m) {
      return m.team1Bn.contains(_searchQuery) ||
          m.team2Bn.contains(_searchQuery) ||
          m.team1En.toLowerCase().contains(_searchQuery) ||
          m.team2En.toLowerCase().contains(_searchQuery) ||
          m.stadium.toLowerCase().contains(_searchQuery) ||
          m.city.toLowerCase().contains(_searchQuery) ||
          m.bdDate.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  void _toggleSearch() {
    setState(() {
      _searchVisible = !_searchVisible;
      if (!_searchVisible) _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGradientBottom,
      appBar: AppBar(
        backgroundColor: AppColors.bgMedium,
        elevation: 0,
        title: _searchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: GoogleFonts.hindSiliguri(
                  color: AppColors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: AppStrings.searchHint,
                  hintStyle: GoogleFonts.hindSiliguri(
                    color: AppColors.white.withAlpha(150),
                    fontSize: 14,
                    height: 1.5,
                  ),
                  border: InputBorder.none,
                ),
              )
            : Text(AppStrings.matchAndSchedule, style: AppTextStyles.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(
              _searchVisible ? Icons.close_rounded : Icons.search_rounded,
              color: AppColors.white,
            ),
            onPressed: _toggleSearch,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: AppColors.gold,
            borderRadius: BorderRadius.circular(20),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.bgDark,
          unselectedLabelColor: AppColors.white,
          labelStyle: GoogleFonts.hindSiliguri(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
          unselectedLabelStyle: GoogleFonts.hindSiliguri(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            height: 1.5,
          ),
          tabs: _tabDefs
              .map(
                (t) => Tab(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(t[1]),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabDefs.map((t) {
          return _MatchList(
            matches: _matches(t[0]),
            flagMap: _flagMap,
            searchQuery: _searchQuery,
          );
        }).toList(),
      ),
    );
  }
}

class _MatchList extends StatelessWidget {
  final List<MatchModel> matches;
  final Map<String, String> flagMap;
  final String searchQuery;

  const _MatchList({
    required this.matches,
    required this.flagMap,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    if (matches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_soccer_rounded,
                size: 64, color: AppColors.gold),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty
                  ? 'কোনো ম্যাচ পাওয়া যায়নি'
                  : 'তথ্য পাওয়া যায়নি',
              style: GoogleFonts.hindSiliguri(
                color: AppColors.textGray,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 80),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final card = MatchCardWidget(
          match: matches[index],
          flagMap: flagMap,
        );
        // Banner ad after every 6th card
        if ((index + 1) % 6 == 0) {
          return Column(
            children: [
              card,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: AdBannerWidget(),
              ),
            ],
          );
        }
        return card;
      },
    );
  }
}

