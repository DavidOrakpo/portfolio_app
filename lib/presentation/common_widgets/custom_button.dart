import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';

class CustomButton extends StatelessWidget {
  final double cornerRadius;
  final double width;
  final double height;
  final Color? backgroundColor;
  final String text;
  final Color textColor;
  final Color iconColor;
  final Color? borderColor, shadowColor;
  final double fontSize;
  final List<Color>? gradientColorList;
  final List<double>? gradientStops;
  final bool isAvenir;
  final bool hasIcon;
  final bool filled;
  final bool hasShadow;
  final Alignment? begin, end;
  final double borderWidth;
  final bool hasGradient;
  final IconData? icon;
  final FontWeight fontweight;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    this.cornerRadius = 10,
    this.gradientColorList,
    this.shadowColor,
    this.gradientStops,
    this.hasIcon = false,
    this.begin,
    this.end,
    this.width = double.infinity,
    this.height = 48,
    this.icon,
    this.hasShadow = false,
    this.borderColor,
    this.isAvenir = false,
    this.hasGradient = false,
    this.filled = true,
    this.iconColor = Colors.white,
    this.backgroundColor,
    this.borderWidth = 1.2,
    this.text = "",
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.fontweight = FontWeight.w600,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultBg = backgroundColor ??
        (isDark ? TechColors.neonCyan : TechColors.techBlue);
    final effectiveTextColor = textColor;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius),
        border: Border.all(
          color: filled
              ? (borderColor ?? defaultBg.withValues(alpha: 0.6))
              : (borderColor ?? defaultBg),
          width: borderWidth,
        ),
        boxShadow: hasShadow || filled
            ? [
                BoxShadow(
                  color: (shadowColor ?? defaultBg).withValues(alpha: 0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                ),
              ]
            : [],
        gradient: hasGradient && gradientColorList != null
            ? LinearGradient(
                begin: begin ?? Alignment.topLeft,
                end: end ?? Alignment.bottomRight,
                stops: gradientStops,
                colors: gradientColorList!,
              )
            : filled
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      defaultBg,
                      Color.lerp(defaultBg, TechColors.cyberViolet, 0.35) ??
                          defaultBg,
                    ],
                  )
                : null,
        color: filled ? null : Colors.transparent,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
          ),
          minimumSize: WidgetStateProperty.all(Size(width, height)),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(
            Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasIcon && icon != null) ...[
              Icon(
                icon!,
                color: iconColor,
                size: fontSize + 4,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.jetBrainsMono(
                  color: effectiveTextColor,
                  fontSize: fontSize,
                  fontWeight: fontweight,
                  letterSpacing: 0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
