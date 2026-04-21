import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../core/services/ad_manager.dart';
import '../../data/players_data.dart';
import '../../data/teams_data.dart';
import '../../models/player_model.dart';
import '../../models/team_model.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _posTabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedTeamEn;

  static const _posTabs = [
    ('all', 'সকলে'),
    ('goalkeeper', 'গোলরক্ষক'),
    ('defender', 'ডিফেন্ডার'),
    ('midfielder', 'মিডফিল্ডার'),
    ('forward', 'ফরোয়ার্ড'),
  ];

  // Only teams that have squad data
  late final List<TeamModel> _teamsWithSquads;

  @override
  void initState() {
    super.initState();
    _posTabController = TabController(length: _posTabs.length, vsync: this);
    _posTabController.addListener(() => setState(() {}));
    AdManager.loadInterstitial();
    WidgetsBinding.instance.addPostFrameCallback((_) => AdManager.showInterstitial());
    _searchController.addListener(
      () => setState(() => _searchQuery = _searchController.text.toLowerCase()),
    );
    final squadTeamNames = allPlayers.map((p) => p.teamEn).toSet();
    _teamsWithSquads = allTeams
        .where((t) => squadTeamNames.contains(t.nameEn))
        .toList()
      ..sort((a, b) => a.nameBn.compareTo(b.nameBn));
  }

  @override
  void dispose() {
    _posTabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<PlayerModel> get _filteredPlayers {
    var players = allPlayers.toList();

    if (_selectedTeamEn != null) {
      players = players.where((p) => p.teamEn == _selectedTeamEn).toList();
    }

    final posKey = _posTabs[_posTabController.index].$1;
    if (posKey != 'all') {
      players = players.where((p) {
        final pos = p.position.toLowerCase();
        return switch (posKey) {
          'goalkeeper' => pos.contains('goal') || pos == 'gk' || pos == 'goalkeeper',
          'defender'   => pos == 'def' || pos.contains('defend') || pos == 'cb' || pos == 'lb' || pos == 'rb',
          'midfielder' => pos == 'mid' || pos.contains('midfiel') || pos == 'cm' || pos == 'dm' || pos == 'am',
          'forward'    => pos == 'fwd' || pos.contains('forward') || pos.contains('attack') || pos == 'st' || pos == 'lw' || pos == 'rw',
          _            => true,
        };
      }).toList();
    }

    if (_searchQuery.isNotEmpty) {
      players = players.where((p) {
        return p.name.toLowerCase().contains(_searchQuery) ||
            p.nameBn.contains(_searchQuery) ||
            p.teamBn.contains(_searchQuery) ||
            p.teamEn.toLowerCase().contains(_searchQuery) ||
            p.club.toLowerCase().contains(_searchQuery);
      }).toList();
    }

    players.sort((a, b) => a.jerseyNumber.compareTo(b.jerseyNumber));
    return players;
  }

  void _clearTeam() => setState(() => _selectedTeamEn = null);

  @override
  Widget build(BuildContext context) {
    final players = _filteredPlayers;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppStrings.players, style: AppTextStyles.appBarTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _searchController,
                  style: AppTextStyles.body.copyWith(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'খেলোয়াড়, দল, ক্লাব দিয়ে খুঁজুন...',
                    hintStyle: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 20),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 18, color: AppColors.onSurfaceVariant),
                            onPressed: () => _searchController.clear(),
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.surfaceContainerHigh,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              // Position tabs
              TabBar(
                controller: _posTabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.onSurfaceVariant,
                labelStyle: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w700, fontSize: 12),
                unselectedLabelStyle: AppTextStyles.caption.copyWith(fontSize: 12),
                indicatorWeight: 2,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: _posTabs.map((t) => Tab(text: t.$2)).toList(),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Team filter chips
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _TeamChip(
                  label: 'সকল দল',
                  selected: _selectedTeamEn == null,
                  onTap: _clearTeam,
                ),
                const SizedBox(width: 8),
                ..._teamsWithSquads.map((team) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: _TeamChip(
                    label: '${team.flagEmoji} ${team.nameBn}',
                    selected: _selectedTeamEn == team.nameEn,
                    onTap: () => setState(() => _selectedTeamEn = team.nameEn),
                  ),
                )),
              ],
            ),
          ),
          // Player count badge
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(
                  '${BengaliNumber.fromInt(players.length)} জন খেলোয়াড়',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Player list
          Expanded(
            child: players.isEmpty
                ? _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                    itemCount: players.length,
                    itemBuilder: (_, i) => _PlayerCard(player: players[i]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _TeamChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TeamChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const _PlayerCard({required this.player});

  Color get _posColor {
    final pos = player.position.toLowerCase();
    if (pos.contains('goal') || pos == 'gk') return const Color(0xFF4CAF50);
    if (pos == 'def' || pos.contains('defend') || pos == 'cb' || pos == 'lb' || pos == 'rb') {
      return const Color(0xFF2196F3);
    }
    if (pos == 'mid' || pos.contains('midfiel')) return const Color(0xFFFFC107);
    return const Color(0xFFFF5722);
  }

  String get _posLabel {
    final pos = player.position.toLowerCase();
    if (pos.contains('goal') || pos == 'gk' || pos == 'goalkeeper') return 'GK';
    if (pos == 'def' || pos.contains('defend') || pos == 'cb' || pos == 'lb' || pos == 'rb') return 'DEF';
    if (pos == 'mid' || pos.contains('midfiel') || pos == 'cm' || pos == 'dm' || pos == 'am') return 'MID';
    if (pos == 'fwd' || pos.contains('forward') || pos.contains('attack') || pos == 'st' || pos == 'lw' || pos == 'rw') return 'FWD';
    return player.position.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Jersey number
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              BengaliNumber.fromInt(player.jerseyNumber),
              style: AppTextStyles.body.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name + club
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.sports_soccer, size: 12, color: AppColors.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        player.club,
                        style: AppTextStyles.caption.copyWith(
                          fontSize: 12,
                          color: AppColors.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Position badge + team flag
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _posColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _posColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  _posLabel,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: _posColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.person_search_rounded, size: 64, color: AppColors.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            'কোনো খেলোয়াড় পাওয়া যায়নি',
            style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
