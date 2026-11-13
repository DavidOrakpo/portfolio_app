import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class TechColors {
  // Lighter Coral-Red / Rose Dark Palette
  static const Color darkBg = Color(0xFF120B0D);
  static const Color darkSurface = Color(0xFF1B1114);
  static const Color darkCard = Color(0xFF24161B);
  static const Color darkBorder = Color(0xFF4C2A35);

  // Lighter, Vibrant Coral-Red & Rose Accents
  static const Color neonCyan = Color(0xFFFF6B81); // Soft Coral-Red Primary
  static const Color electricBlue = Color(0xFFFF526B); // Vibrant Rose-Red
  static const Color cyberViolet = Color(0xFFF43F5E); // Bright Rose Secondary
  static const Color matrixGreen = Color(0xFFFF8598); // Luminous Light Rose Status
  static const Color crimsonRed = Color(0xFFFF6B81);
  static const Color warningAmber = Color(0xFFFB923C);

  static const Color darkTextPrimary = Color(0xFFFFF5F6);
  static const Color darkTextSecondary = Color(0xFFD1B3BA);

  // Lighter Rose-Red Light Palette
  static const Color lightBg = Color(0xFFFCF7F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFF9FA);
  static const Color lightBorder = Color(0xFFEAD5D9);
  static const Color techBlue = Color(0xFFF43F5E); // Lighter Rose-Red Primary
  static const Color deepIndigo = Color(0xFFFB7185); // Soft Coral Secondary
  static const Color lightTextPrimary = Color(0xFF240B11);
  static const Color lightTextSecondary = Color(0xFF78515A);
}

class Styles {
  static ThemeData? _cachedDarkTheme;
  static ThemeData? _cachedLightTheme;

  static ThemeData flexThemeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? FlexThemeData.dark(
            scheme: FlexScheme.red,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 13,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          )
        : FlexThemeData.light(
            scheme: FlexScheme.red,
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
    if (isDarkTheme) {
      return _cachedDarkTheme ??= _buildTheme(true);
    } else {
      return _cachedLightTheme ??= _buildTheme(false);
    }
  }

  static ThemeData _buildTheme(bool isDarkTheme) {
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
      highlightColor: accentColor.withValues(alpha: 0.14),
      hoverColor: accentColor.withValues(alpha: 0.09),
      focusColor: accentColor.withValues(alpha: 0.16),
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
        error: const Color(0xFFFB7185),
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
