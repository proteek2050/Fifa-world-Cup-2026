import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/teams_data.dart';
import '../../models/team_model.dart';
import 'team_detail_screen.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  bool _showSearch = false;
  String _query = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TeamModel> get _filtered {
    if (_query.isEmpty) return allTeams;
    final q = _query.toLowerCase();
    return allTeams.where((t) =>
      t.nameBn.contains(_query) ||
      t.nameEn.toLowerCase().contains(q)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar with gradient overlay ──
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: _showSearch
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: AppTextStyles.body.copyWith(color: AppColors.onSurface),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: 'দলের নাম লিখুন...',
                      hintStyle: AppTextStyles.body.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  )
                : Text(
                    AppStrings.teams,
                    style: AppTextStyles.appBarTitle.copyWith(
                      fontSize: 22,
                      color: AppColors.onSurface,
                    ),
                  ),
            actions: [
              IconButton(
                icon: Icon(
                  _showSearch ? Icons.close : Icons.search,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  setState(() {
                    _showSearch = !_showSearch;
                    if (!_showSearch) {
                      _query = '';
                      _searchController.clear();
                    }
                  });
                },
              ),
            ],
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

          // ── Team count badge ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${filtered.length} টি দল',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ),
          ),

          // ── 2-column white team cards ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => _TeamCard(
                  team: filtered[i],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TeamDetailScreen(team: filtered[i]),
                    ),
                  ),
                ),
                childCount: filtered.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// White horizontal team card (exact Stitch spec)
// ─────────────────────────────────────────────
class _TeamCard extends StatefulWidget {
  final TeamModel team;
  final VoidCallback onTap;

  const _TeamCard({required this.team, required this.onTap});

  @override
  State<_TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<_TeamCard> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              // Flag emoji in a circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF1F5F9), // slate-100
                  border: Border.all(
                    color: const Color(0xFFE2E8F0), // slate-200
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.team.flagEmoji,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Team name
              Expanded(
                child: Text(
                  widget.team.nameBn,
                  style: AppTextStyles.teamCardName,
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
