import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/groups_data.dart';
import '../../models/team_model.dart';
import '../teams/team_detail_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ──
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              AppStrings.groups,
              style: AppTextStyles.appBarTitle.copyWith(
                fontSize: 22,
                color: AppColors.onSurface,
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryContainer, Colors.transparent],
                ),
              ),
            ),
          ),

          // ── Groups A → L ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final letter = allGroupLetters[i];
                  final teams = getTeamsForGroup(letter);
                  return _GroupSection(
                    letter: letter,
                    teams: teams,
                    onTeamTap: (team) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TeamDetailScreen(team: team),
                      ),
                    ),
                  );
                },
                childCount: allGroupLetters.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  final String letter;
  final List<TeamModel> teams;
  final ValueChanged<TeamModel> onTeamTap;

  const _GroupSection({
    required this.letter,
    required this.teams,
    required this.onTeamTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Group header ──
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: GoogleFontsLexend.headline.copyWith(
                      fontSize: 18,
                      color: AppColors.gold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'গ্রুপ $letter',
                style: AppTextStyles.groupHeader.copyWith(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── 2-column team grid ──
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.8,
            ),
            itemCount: teams.length,
            itemBuilder: (context, i) => _GroupTeamCard(
              team: teams[i],
              onTap: () => onTeamTap(teams[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupTeamCard extends StatefulWidget {
  final TeamModel team;
  final VoidCallback onTap;

  const _GroupTeamCard({required this.team, required this.onTap});

  @override
  State<_GroupTeamCard> createState() => _GroupTeamCardState();
}

class _GroupTeamCardState extends State<_GroupTeamCard> {
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF1F5F9),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.team.flagEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.team.nameBn,
                  style: AppTextStyles.teamCardName.copyWith(fontSize: 14),
                  maxLines: 2,
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

// Lexend headline helper used inside groups_screen
class GoogleFontsLexend {
  static TextStyle get headline => AppTextStyles.headline;
}
