import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

/// Navigation Drawer matching the Stitch design (navigation bar/screen.png).
///
/// Layout:
/// ┌──────────────────────────┐
/// │ বিশ্বকাপ ২০২৬         ✕ │  ← Header (bold title + close)
/// │ অফিসিয়াল অ্যাপ         │  ← Subtitle (light pink)
/// ├──────────────────────────┤  ← Divider (light/20%)
/// │ 📅  সময়সূচী             │  ← Main nav items (icon + label)
/// │ 👥  গ্রুপসমূহ            │
/// │ 🏆  দলসমূহ              │
/// │ 🏟️  স্টেডিয়াম            │
/// │ 📊  পয়েন্ট টেবিল         │
/// │ 🎬  হাইলাইটস             │
/// │ 📜  ইতিহাস              │
/// ├──────────────────────────┤  ← Divider
/// │ ⭐  ৫ স্টার রেট দিন      │  ← Secondary items (smaller)
/// │ 📤  অ্যাপটি শেয়ার করুন   │
/// ├──────────────────────────┤
/// │ ⚠  বাগ রিপোর্ট করুন      │  ← Footer (smallest, muted)
/// │ 💬  মতামত ও পরামর্শ      │
/// ├──────────────────────────┤
/// │ ⚙  সেটিংস    লগ আউট     │  ← Bottom row
/// └──────────────────────────┘
class AppDrawer extends StatelessWidget {
  final Function(String) onNavigate;

  const AppDrawer({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      backgroundColor: AppColors.drawerBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          // ═══ Header ═══
          _buildHeader(context),

          // ═══ Main Navigation ═══
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // ── Primary Nav Items ──
                  _DrawerItem(
                    icon: Icons.calendar_month_rounded,
                    label: AppStrings.schedule,
                    onTap: () => _navigate(context, 'schedule'),
                  ),
                  _DrawerItem(
                    icon: Icons.groups_rounded,
                    label: AppStrings.groups,
                    onTap: () => _navigate(context, 'groups'),
                  ),
                  _DrawerItem(
                    icon: Icons.emoji_events_rounded,
                    label: AppStrings.teams,
                    onTap: () => _navigate(context, 'teams'),
                  ),
                  _DrawerItem(
                    icon: Icons.stadium_rounded,
                    label: AppStrings.stadiums,
                    onTap: () => _navigate(context, 'stadiums'),
                  ),
                  _DrawerItem(
                    icon: Icons.table_chart_rounded,
                    label: AppStrings.pointTable,
                    onTap: () => _navigate(context, 'pointTable'),
                  ),
                  _DrawerItem(
                    icon: Icons.history_rounded,
                    label: AppStrings.history,
                    onTap: () => _navigate(context, 'history'),
                  ),
                  _DrawerItem(
                    icon: Icons.person_rounded,
                    label: AppStrings.players,
                    onTap: () => _navigate(context, 'players'),
                  ),

                  // ── Divider ──
                  _buildDivider(),

                  // ── Secondary Items (smaller) ──
                  _DrawerItem(
                    icon: Icons.star_rounded,
                    label: AppStrings.rateFiveStar,
                    onTap: () => _navigate(context, 'rate'),
                    isSmall: true,
                  ),
                  _DrawerItem(
                    icon: Icons.share_rounded,
                    label: AppStrings.shareApp,
                    onTap: () => _navigate(context, 'share'),
                    isSmall: true,
                  ),
                ],
              ),
            ),
          ),

          // ═══ Footer ═══
          _buildFooter(context),
        ],
      ),
    );
  }

  /// Header: Title + close button + subtitle
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        bottom: 20,
        left: 24,
        right: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.drawerLight.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.appNameShort,
                style: AppTextStyles.drawerTitle,
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: AppColors.white, size: 24),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                splashRadius: 20,
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            AppStrings.appSubtitle,
            style: AppTextStyles.drawerSubtitle,
          ),
        ],
      ),
    );
  }

  /// Thin divider matching Stitch (brand-light at 20% opacity).
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Divider(
        color: AppColors.drawerLight.withValues(alpha: 0.2),
        height: 1,
        thickness: 0.5,
      ),
    );
  }

  /// Footer: Bug report, feedback, settings, logout.
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      decoration: BoxDecoration(
        color: AppColors.drawerDark.withValues(alpha: 0.4),
        border: Border(
          top: BorderSide(
            color: AppColors.drawerLight.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bug report & feedback (tiny text)
            _FooterLink(
              icon: Icons.warning_amber_rounded,
              label: AppStrings.bugReport,
              onTap: () => _navigate(context, 'bugReport'),
            ),
            const SizedBox(height: 4),
            _FooterLink(
              icon: Icons.chat_bubble_outline_rounded,
              label: AppStrings.feedback,
              onTap: () => _navigate(context, 'feedback'),
            ),

            const SizedBox(height: 12),

            // Settings & Logout row
            Container(
              padding: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.drawerLight.withValues(alpha: 0.1),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Settings button
                  GestureDetector(
                    onTap: () => _navigate(context, 'settings'),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.settings_rounded,
                          size: 20,
                          color: AppColors.white.withValues(alpha: 0.9),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.settings,
                          style: AppTextStyles.body.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Logout button
                  GestureDetector(
                    onTap: () => _navigate(context, 'logout'),
                    child: Text(
                      AppStrings.logout,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.drawerLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop(); // Close drawer first
    onNavigate(route);
  }
}

/// A single navigation drawer item (main section).
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSmall;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.drawerLight.withValues(alpha: 0.1),
        highlightColor: AppColors.drawerLight.withValues(alpha: 0.05),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: isSmall ? 12 : 16,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: isSmall ? 20 : 24,
                color: AppColors.white.withValues(alpha: isSmall ? 0.7 : 0.8),
              ),
              SizedBox(width: isSmall ? 16 : 16),
              Expanded(
                child: Text(
                  label,
                  style: isSmall
                      ? AppTextStyles.body.copyWith(
                          fontSize: 14,
                          color: AppColors.white,
                        )
                      : AppTextStyles.drawerItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tiny footer link (bug report, feedback).
class _FooterLink extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FooterLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: AppColors.drawerLight,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
                color: AppColors.drawerLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
