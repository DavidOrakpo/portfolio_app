import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    this.outterColor = Colors.black,
    this.xAlign = 1.5,
    this.yAlign = -0.4,
    this.radius = 2.1,
    this.child,
  });

  final Color? outterColor;
  final double? xAlign, yAlign, radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryAccent = Theme.of(context).colorScheme.primary;
    final secondaryAccent = Theme.of(context).colorScheme.secondary;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isDark ? TechColors.darkBg : TechColors.lightBg,
            gradient: RadialGradient(
              center: Alignment(xAlign ?? 0.8, yAlign ?? -0.6),
              colors: isDark
                  ? [
                      primaryAccent.withValues(alpha: 0.13),
                      secondaryAccent.withValues(alpha: 0.08),
                      TechColors.darkBg,
                    ]
                  : [
                      primaryAccent.withValues(alpha: 0.10),
                      secondaryAccent.withValues(alpha: 0.05),
                      TechColors.lightBg,
                    ],
              stops: const [0.0, 0.45, 1.0],
              radius: radius ?? 1.4,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: _CyberGridPainter(
              isDark: isDark,
              accentColor: primaryAccent,
            ),
          ),
        ),
        if (child != null) child!,
      ],
    );
  }
}

class _CyberGridPainter extends CustomPainter {
  final bool isDark;
  final Color accentColor;

  _CyberGridPainter({required this.isDark, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = accentColor.withValues(alpha: isDark ? 0.045 : 0.055)
      ..strokeWidth = 1.0;

    const double step = 40.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Subtle intersection dots every 4th grid cell
    final dotPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += step * 4) {
      for (double y = 0; y < size.height; y += step * 4) {
        canvas.drawCircle(Offset(x, y), 1.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CyberGridPainter oldDelegate) =>
      oldDelegate.isDark != isDark || oldDelegate.accentColor != accentColor;
}

class TechSectionHeader extends StatelessWidget {
  const TechSectionHeader({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  final String tag;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: accent.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Text(
                tag,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: accent,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accent.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: isDark
                ? TechColors.darkTextPrimary
                : TechColors.lightTextPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? TechColors.darkTextSecondary
                  : TechColors.lightTextSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

class TechGlassCard extends StatelessWidget {
  const TechGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderColor,
    this.glowColor,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  final Color? glowColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBorder = borderColor ??
        (isDark ? TechColors.darkBorder : TechColors.lightBorder);
    final effectiveGlow =
        glowColor ?? Theme.of(context).colorScheme.primary;

    final cardContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark
            ? TechColors.darkCard.withValues(alpha: 0.88)
            : TechColors.lightSurface.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: effectiveBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: effectiveGlow.withValues(alpha: isDark ? 0.06 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return cardContent;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: cardContent,
      ),
    );
  }
}
