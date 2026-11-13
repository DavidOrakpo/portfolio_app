import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class TechColors {
  // Cyber Crimson Dark Palette
  static const Color darkBg = Color(0xFF0C0608);
  static const Color darkSurface = Color(0xFF150A0E);
  static const Color darkCard = Color(0xFF1E0E14);
  static const Color darkBorder = Color(0xFF3D1A24);

  // Unified Red / Crimson Accents
  static const Color neonCyan = Color(0xFFFF2A54); // Primary Cyber Crimson
  static const Color electricBlue = Color(0xFFE11D48); // Ruby Red
  static const Color cyberViolet = Color(0xFF9F1239); // Deep Crimson
  static const Color matrixGreen = Color(0xFFFF4D6D); // Bright Rose-Red Status
  static const Color crimsonRed = Color(0xFFFF2A54);
  static const Color warningAmber = Color(0xFFF97316);

  static const Color darkTextPrimary = Color(0xFFFFF1F2);
  static const Color darkTextSecondary = Color(0xFFB8969E);

  // Technical Crimson Light Palette
  static const Color lightBg = Color(0xFFFAF5F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFF8F9);
  static const Color lightBorder = Color(0xFFE5CED3);
  static const Color techBlue = Color(0xFFE11D48); // Primary Crimson
  static const Color deepIndigo = Color(0xFF9F1239); // Deep Ruby
  static const Color lightTextPrimary = Color(0xFF1F080E);
  static const Color lightTextSecondary = Color(0xFF6E4751);
}

class Styles {
  static ThemeData flexThemeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? FlexThemeData.dark(
            scheme: FlexScheme.redWine,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 13,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          )
        : FlexThemeData.light(
            scheme: FlexScheme.redWine,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          );
  }

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    final baseTextTheme = isDarkTheme
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final primaryTextColor = isDarkTheme
        ? TechColors.darkTextPrimary
        : TechColors.lightTextPrimary;

    final accentColor =
        isDarkTheme ? TechColors.neonCyan : TechColors.techBlue;
    final secondaryColor =
        isDarkTheme ? TechColors.cyberViolet : TechColors.deepIndigo;

    return ThemeData(
      useMaterial3: true,
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
          isDarkTheme ? TechColors.darkBg : TechColors.lightBg,
      primaryColor: accentColor,
      textTheme: GoogleFonts.spaceGroteskTextTheme(baseTextTheme).apply(
        bodyColor: primaryTextColor,
        displayColor: primaryTextColor,
      ),
      unselectedWidgetColor: isDarkTheme
          ? TechColors.darkTextSecondary
          : TechColors.lightTextSecondary,
      hintColor: isDarkTheme
          ? TechColors.darkTextSecondary
          : TechColors.lightTextSecondary,
      highlightColor: accentColor.withValues(alpha: 0.12),
      hoverColor: accentColor.withValues(alpha: 0.08),
      focusColor: accentColor.withValues(alpha: 0.15),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? TechColors.darkCard : TechColors.lightSurface,
      canvasColor:
          isDarkTheme ? TechColors.darkSurface : TechColors.lightSurface,
      dividerColor:
          isDarkTheme ? TechColors.darkBorder : TechColors.lightBorder,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor:
            isDarkTheme ? TechColors.darkBg : TechColors.lightSurface,
        foregroundColor: primaryTextColor,
      ),
      colorScheme: ColorScheme(
        brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        primary: accentColor,
        onPrimary: Colors.white,
        primaryContainer: primaryTextColor,
        onPrimaryContainer: isDarkTheme
            ? TechColors.darkTextSecondary
            : TechColors.lightTextSecondary,
        secondary: secondaryColor,
        onSecondary: Colors.white,
        tertiary:
            isDarkTheme ? TechColors.darkSurface : TechColors.lightSurface,
        onTertiary:
            isDarkTheme ? TechColors.darkCard : TechColors.lightSurface,
        error: const Color(0xFFEF4444),
        onError: Colors.white,
        surface:
            isDarkTheme ? TechColors.darkSurface : TechColors.lightSurface,
        onSurface: primaryTextColor,
        inversePrimary: primaryTextColor,
        outline: isDarkTheme ? TechColors.darkBorder : TechColors.lightBorder,
      ),
    );
  }
}
