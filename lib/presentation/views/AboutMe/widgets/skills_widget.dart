import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({
    super.key,
    this.title,
    this.category,
    this.proficiency = 0.9,
    required this.isFirstSequence,
  });

  final String? title;
  final String? category;
  final double proficiency;
  final bool? isFirstSequence;

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  Timer? _timer;
  bool _glowActive = false;

  @override
  void initState() {
    super.initState();
    _glowActive = widget.isFirstSequence ?? true;
    _timer = Timer.periodic(const Duration(milliseconds: 1800), (_) {
      if (mounted) {
        setState(() {
          _glowActive = !_glowActive;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final percentText = "${(widget.proficiency * 100).round()}%";

    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      width: 255,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? TechColors.darkBg.withValues(alpha: 0.75)
            : TechColors.lightBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _glowActive
              ? accent.withValues(alpha: 0.65)
              : (isDark ? TechColors.darkBorder : TechColors.lightBorder),
          width: 1.2,
        ),
        boxShadow: [
          if (_glowActive)
            BoxShadow(
              color: accent.withValues(alpha: isDark ? 0.14 : 0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.category ?? "MODULE",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
              Text(
                percentText,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: TechColors.matrixGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            widget.title ?? "Skill",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? TechColors.darkTextPrimary
                  : TechColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: widget.proficiency,
              minHeight: 5,
              backgroundColor:
                  isDark ? TechColors.darkBorder : TechColors.lightBorder,
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ],
      ),
    );
  }
}
