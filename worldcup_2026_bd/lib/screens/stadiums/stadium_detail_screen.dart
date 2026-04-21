import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../models/stadium_model.dart';

class StadiumDetailScreen extends StatelessWidget {
  final StadiumModel stadium;

  const StadiumDetailScreen({super.key, required this.stadium});

  @override
  Widget build(BuildContext context) {
    final s = stadium;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero App Bar ──
          SliverAppBar(
            expandedHeight: 220,
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
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          color: AppColors.bgMedium.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.stadium_rounded,
                          color: AppColors.gold,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          s.nameBn,
                          style: AppTextStyles.stadiumDetailTitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${s.city} · ${s.country}',
                        style: AppTextStyles.stadiumName.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Info cards 2×2 grid ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _InfoCard(
                    icon: Icons.people_outline,
                    title: AppStrings.capacity,
                    value: '${BengaliNumber.withComma(s.capacity)} ${AppStrings.seats}',
                  ),
                  _InfoCard(
                    icon: Icons.calendar_today_outlined,
                    title: AppStrings.inaugurated,
                    value: BengaliNumber.fromInt(s.yearBuilt),
                  ),
                  _InfoCard(
                    icon: Icons.grass_outlined,
                    title: 'মাঠের ধরন',
                    value: s.surfaceType,
                  ),
                  _InfoCard(
                    icon: Icons.schedule_outlined,
                    title: 'টাইমজোন',
                    value: s.timezone,
                  ),
                ],
              ),
            ),
          ),

          // ── Location card ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _DetailSection(
                icon: Icons.location_on_outlined,
                title: AppStrings.location,
                child: Text(
                  '${s.city}, ${s.country}',
                  style: AppTextStyles.infoCardValue,
                ),
              ),
            ),
          ),

          // ── Fixtures card ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _DetailSection(
                icon: Icons.emoji_events_outlined,
                title: AppStrings.fixtures,
                child: Text(
                  s.totalMatches,
                  style: AppTextStyles.infoCardValue,
                ),
              ),
            ),
          ),

          // ── BDT offset ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: _DetailSection(
                icon: Icons.access_time_outlined,
                title: 'BDT পার্থক্য',
                child: Text(
                  'বাংলাদেশ সময় (BST) থেকে ${s.bdtOffset} ঘণ্টা',
                  style: AppTextStyles.infoCardValue,
                ),
              ),
            ),
          ),

          // ── About ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
              child: _DetailSection(
                icon: Icons.info_outline,
                title: AppStrings.aboutStadium,
                child: Text(
                  s.description,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.onSurface,
                    height: 1.7,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Info card (capacity, year, surface, timezone)
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.infoBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.infoIcon,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.gold, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: AppTextStyles.infoCardTitle.copyWith(fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppTextStyles.infoCardValue.copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Detail section (location, fixtures, about)
// ─────────────────────────────────────────────
class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _DetailSection({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.gold, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.infoCardTitle.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
