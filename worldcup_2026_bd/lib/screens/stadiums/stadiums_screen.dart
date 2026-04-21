import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/number_to_bengali.dart';
import '../../data/stadiums_data.dart';
import '../../models/stadium_model.dart';
import 'stadium_detail_screen.dart';

class StadiumsScreen extends StatefulWidget {
  const StadiumsScreen({super.key});

  @override
  State<StadiumsScreen> createState() => _StadiumsScreenState();
}

class _StadiumsScreenState extends State<StadiumsScreen> {
  bool _showSearch = false;
  String _query = '';
  String _selectedCountry = 'সকল';
  final _searchController = TextEditingController();

  static const List<String> _countries = ['সকল', 'যুক্তরাষ্ট্র', 'মেক্সিকো', 'কানাডা'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<StadiumModel> get _filtered {
    var list = allStadiums;
    if (_selectedCountry != 'সকল') {
      list = list.where((s) => s.country == _selectedCountry).toList();
    }
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list.where((s) =>
        s.nameBn.contains(_query) ||
        s.nameEn.toLowerCase().contains(q) ||
        s.city.toLowerCase().contains(q)
      ).toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

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
            title: _showSearch
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    style: AppTextStyles.body.copyWith(color: AppColors.onSurface),
                    cursorColor: AppColors.primary,
                    decoration: InputDecoration(
                      hintText: 'স্টেডিয়ামের নাম বা শহর...',
                      hintStyle: AppTextStyles.body.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  )
                : Text(
                    AppStrings.stadiums,
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(52),
              child: _CountryFilterBar(
                selected: _selectedCountry,
                onSelect: (c) => setState(() => _selectedCountry = c),
                countries: _countries,
              ),
            ),
          ),

          // ── Count badge ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                '${BengaliNumber.fromInt(filtered.length)} টি স্টেডিয়াম',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ),
          ),

          // ── Stadium list ──
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _StadiumCard(
                    stadium: filtered[i],
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StadiumDetailScreen(stadium: filtered[i]),
                      ),
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
// Country filter tab bar
// ─────────────────────────────────────────────
class _CountryFilterBar extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  final List<String> countries;

  const _CountryFilterBar({
    required this.selected,
    required this.onSelect,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: countries.length,
        separatorBuilder: (context, idx) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final country = countries[i];
          final isActive = country == selected;
          return GestureDetector(
            onTap: () => onSelect(country),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.gold : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                country,
                style: AppTextStyles.body.copyWith(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? AppColors.bgDark : AppColors.onSurfaceVariant,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Stadium card
// ─────────────────────────────────────────────
class _StadiumCard extends StatefulWidget {
  final StadiumModel stadium;
  final VoidCallback onTap;

  const _StadiumCard({required this.stadium, required this.onTap});

  @override
  State<_StadiumCard> createState() => _StadiumCardState();
}

class _StadiumCardState extends State<_StadiumCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.stadium;
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Stadium icon
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.stadium_rounded,
                  color: AppColors.gold,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.nameBn,
                      style: AppTextStyles.stadiumName.copyWith(fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${s.city} · ${s.country}',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.people_outline,
                          label: BengaliNumber.withComma(s.capacity),
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.calendar_today_outlined,
                          label: BengaliNumber.fromInt(s.yearBuilt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.primary,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: AppColors.gold),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 11,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
