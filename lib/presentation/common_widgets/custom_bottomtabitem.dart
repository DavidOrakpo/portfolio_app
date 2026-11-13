import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    this.onTap,
    this.text,
    this.largeText = false,
    this.iconWidth,
    required this.assignedIndex,
    this.iconSize,
    this.selectedIconPath,
    this.iconData,
    this.defaultIconPath,
    this.selectedColor,
    this.unSelectedColor,
    required this.selectedIndex,
  }) : isSelected = (selectedIndex == assignedIndex);

  final int? assignedIndex, selectedIndex;
  final double? iconSize, iconWidth;
  final void Function()? onTap;
  final String? text, defaultIconPath, selectedIconPath;
  final bool? largeText;
  final bool isSelected;
  final IconData? iconData;
  final Color? selectedColor, unSelectedColor;

  @override
  Widget build(BuildContext context) {
    final accent = selectedColor ?? Theme.of(context).colorScheme.primary;
    final inactive =
        unSelectedColor ?? Theme.of(context).unselectedWidgetColor;
    final indexLabel = "0${(assignedIndex ?? 0) + 1}";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? accent.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? accent.withValues(alpha: 0.45)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    indexLabel,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? accent
                          : inactive.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    iconData,
                    size: iconSize ?? 19,
                    color: isSelected ? accent : inactive,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                text ?? "Home",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.jetBrainsMono(
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 11,
                  color: isSelected ? accent : inactive,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
