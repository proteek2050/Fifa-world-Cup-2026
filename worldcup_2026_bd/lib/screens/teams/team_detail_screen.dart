import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../data/players_data.dart';
import '../../models/player_model.dart';
import '../../models/team_model.dart';

class TeamDetailScreen extends StatefulWidget {
  final TeamModel team;

  const TeamDetailScreen({super.key, required this.team});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  String _selectedPosition = 'all';


  List<PlayerModel> get _teamPlayers {
    return allPlayers.where((p) => p.teamEn == widget.team.nameEn).toList();
  }

  List<PlayerModel> get _filteredPlayers {
    final players = _teamPlayers;
    if (_selectedPosition == 'all') return players;

    return players.where((p) {
      final pos = p.position.toLowerCase();
      switch (_selectedPosition) {
        case 'goalkeeper':
          return pos.contains('goal') || pos == 'gk';
        case 'defender':
          return pos == 'def' || pos.contains('defend') || pos == 'cb' || pos == 'lb' || pos == 'rb';
        case 'midfielder':
          return pos == 'mid' || pos.contains('midfiel') || pos == 'cm' || pos == 'dm' || pos == 'am';
        case 'forward':
          return pos == 'fwd' || pos.contains('forward') || pos.contains('attack') || pos == 'st' || pos == 'lw' || pos == 'rw';
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final team = widget.team;
    final players = _filteredPlayers;
    final hasPlayers = _teamPlayers.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero App Bar ──
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryContainer,
                      AppColors.background,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    // Large flag emoji
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.surfaceContainerHigh,
                        border: Border.all(
                          color: AppColors.outlineVariant.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryContainer.withValues(alpha: 0.4),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          team.flagEmoji,
                          style: const TextStyle(fontSize: 44),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Team name
                    Text(
                      team.nameBn,
                      style: AppTextStyles.sectionTitle.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    // Group badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.cyan.withValues(alpha: 0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'গ্রুপ ${team.group}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.cyan,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (!hasPlayers)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.info_outline, color: AppColors.onSurfaceVariant, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'এই দলের স্কোয়াড তথ্য এখনো যোগ করা হয়নি',
                      style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else ...[
            // ── Position filter tabs ──
            SliverToBoxAdapter(
              child: _PositionTabs(
                selected: _selectedPosition,
                onChanged: (pos) => setState(() => _selectedPosition = pos),
              ),
            ),

            // ── Player count ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text(
                  '${BengaliNumber.fromInt(players.length)} জন খেলোয়াড়',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
            ),

            // ── Player list ──
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _PlayerCard(player: players[i]),
                  childCount: players.length,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Position filter tab bar
// ─────────────────────────────────────────────
class _PositionTabs extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const _PositionTabs({required this.selected, required this.onChanged});

  static const _tabs = [
    ('all', AppStrings.all),
    ('goalkeeper', AppStrings.goalkeeper),
    ('defender', AppStrings.defender),
    ('midfielder', AppStrings.midfielder),
    ('forward', AppStrings.forward),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          final (key, label) = _tabs[i];
          final isActive = selected == key;
          return GestureDetector(
            onTap: () => onChanged(key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.gold : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: isActive
                    ? null
                    : Border.all(
                        color: AppColors.outlineVariant.withValues(alpha: 0.4),
                        width: 1,
                      ),
              ),
              child: Text(
                label,
                style: isActive ? AppTextStyles.tabActive : AppTextStyles.tabInactive,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Player card row
// ─────────────────────────────────────────────
class _PlayerCard extends StatelessWidget {
  final PlayerModel player;

  const _PlayerCard({required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Jersey number circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.5),
            ),
            child: Center(
              child: Text(
                BengaliNumber.fromInt(player.jerseyNumber),
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  fontSize: 13,
                ),
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
                  style: AppTextStyles.playerName,
                ),
                Text(
                  player.club,
                  style: AppTextStyles.playerPosition,
                ),
              ],
            ),
          ),
          // Position badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              player.positionBn.isEmpty ? player.position : player.positionBn,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.secondary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
