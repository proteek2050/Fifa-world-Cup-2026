import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/number_to_bengali.dart';
import '../../../models/match_model.dart';

class MatchCardWidget extends StatelessWidget {
  final MatchModel match;
  final Map<String, String> flagMap;

  const MatchCardWidget({
    super.key,
    required this.match,
    required this.flagMap,
  });

  static const Map<String, String> _monthMap = {
    'Jan': 'জানুয়ারি', 'Feb': 'ফেব্রুয়ারি', 'Mar': 'মার্চ',
    'Apr': 'এপ্রিল',   'May': 'মে',          'Jun': 'জুন',
    'Jul': 'জুলাই',    'Aug': 'আগস্ট',        'Sep': 'সেপ্টেম্বর',
    'Oct': 'অক্টোবর',  'Nov': 'নভেম্বর',      'Dec': 'ডিসেম্বর',
  };

  String _formatDate(String bdDate) {
    // '12 Jun 2026' → '১২ জুন ২০২৬'
    final parts = bdDate.split(' ');
    if (parts.length < 3) return bdDate;
    final day = BengaliNumber.fromString(parts[0]);
    final month = _monthMap[parts[1]] ?? parts[1];
    final year = BengaliNumber.fromString(parts[2]);
    return '$day $month $year';
  }

  String _formatTime(String bdTime) {
    // '01:00 AM' → 'রাত ০১:০০'  |  '08:00 AM' → 'সকাল ০৮:০০'
    final parts = bdTime.split(' ');
    if (parts.length < 2) return bdTime;
    final timeParts = parts[0].split(':');
    int hour = int.tryParse(timeParts[0]) ?? 0;
    final isAm = parts[1].toUpperCase() == 'AM';
    if (!isAm && hour != 12) hour += 12;
    if (isAm && hour == 12) hour = 0;

    final String period;
    if (hour < 6) {
      period = AppStrings.night;
    } else if (hour < 12) {
      period = AppStrings.morning;
    } else if (hour < 15) {
      period = AppStrings.noon;
    } else if (hour < 18) {
      period = AppStrings.afternoon;
    } else if (hour < 20) {
      period = AppStrings.evening;
    } else {
      period = AppStrings.night;
    }

    return '$period ${BengaliNumber.fromString(parts[0])}';
  }

  @override
  Widget build(BuildContext context) {
    final bool tbd = match.isTBD;
    final String flag1 = tbd ? '❓' : (flagMap[match.team1En] ?? '🏳');
    final String flag2 = tbd ? '❓' : (flagMap[match.team2En] ?? '🏳');
    final String team1 = tbd ? AppStrings.tbd : match.team1Bn;
    final String team2 = tbd ? AppStrings.tbd : match.team2Bn;
    final String stageLabel =
        match.group.isNotEmpty ? match.group : match.stageBn;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Badge row ──
                Row(
                  children: [
                    _Pill(
                      label:
                          '${AppStrings.matchNo} ${BengaliNumber.fromInt(match.matchNumber)}',
                      bgColor: AppColors.gold,
                      textColor: AppColors.bgDark,
                    ),
                    const SizedBox(width: 8),
                    _Pill(
                      label: stageLabel,
                      bgColor: AppColors.cyan.withAlpha(50),
                      textColor: AppColors.cyan,
                      borderColor: AppColors.cyan.withAlpha(120),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // ── Teams row ──
                Row(
                  children: [
                    Expanded(child: _TeamCell(flag: flag1, name: team1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        AppStrings.vs,
                        style: GoogleFonts.lexend(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                    Expanded(child: _TeamCell(flag: flag2, name: team2)),
                  ],
                ),
                const SizedBox(height: 14),
                // ── Date + Time ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today_rounded,
                        size: 14, color: AppColors.textLight),
                    const SizedBox(width: 6),
                    Text(
                      '${_formatDate(match.bdDate)} — ${_formatTime(match.bdTime)} (BST)',
                      style: GoogleFonts.hindSiliguri(
                        fontSize: 13,
                        color: AppColors.textLight,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // ── Stadium ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.stadium_rounded,
                        size: 14, color: AppColors.cyan),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '${match.stadium} — ${match.city}',
                        style: GoogleFonts.hindSiliguri(
                          fontSize: 13,
                          color: AppColors.cyan,
                          height: 1.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TeamCell extends StatelessWidget {
  final String flag;
  final String name;
  const _TeamCell({required this.flag, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(flag, style: const TextStyle(fontSize: 36)),
        const SizedBox(height: 6),
        Text(
          name,
          style: GoogleFonts.hindSiliguri(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;

  const _Pill({
    required this.label,
    required this.bgColor,
    required this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1)
            : null,
      ),
      child: Text(
        label,
        style: GoogleFonts.hindSiliguri(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: textColor,
          height: 1.4,
        ),
      ),
    );
  }
}
