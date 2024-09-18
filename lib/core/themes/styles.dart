import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData flexThemeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? FlexThemeData.dark(
            scheme: FlexScheme.deepBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 13,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 20,
              useTextTheme: true,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          )
        : FlexThemeData.light(
            scheme: FlexScheme.deepBlue,
            surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
            blendLevel: 7,
            subThemesData: const FlexSubThemesData(
              blendOnLevel: 10,
              blendOnColors: false,
              useTextTheme: true,
            ),
            visualDensity: FlexColorScheme.comfortablePlatformDensity,
          );
  }

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      // colorSchemeSeed: const Color.fromRGBO(5, 70, 123, 1),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(5, 70, 123, 1),
        primaryContainer:
            isDarkTheme ? Colors.white : const Color.fromRGBO(5, 70, 123, 1),
        primary:
            isDarkTheme ? Colors.white : const Color.fromRGBO(5, 70, 123, 1),
        tertiary:
            isDarkTheme ? const Color.fromRGBO(5, 70, 123, 1) : Colors.white,
        onTertiary:
            isDarkTheme ? Color.fromARGB(117, 44, 122, 186) : Colors.white,
        onPrimaryContainer:
            isDarkTheme ? Colors.white54 : Color.fromARGB(255, 17, 60, 95),
        inversePrimary: isDarkTheme ? Colors.white : Colors.black,
      ),
      scaffoldBackgroundColor:
          isDarkTheme ? Color.fromARGB(255, 2, 11, 31) : Colors.white,
      textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),

      unselectedWidgetColor: isDarkTheme
          ? Color.fromARGB(124, 228, 217, 217)
          : Colors.grey.shade400,

      // primaryColor: isDarkTheme ? Colors.white : Color.fromRGBO(5, 70, 123, 1),
      // backgroundColor: isDarkTheme ? Colors.black : const Color(0xffF1F5FB),
      indicatorColor: isDarkTheme
          ? const Color.fromRGBO(5, 70, 123, 1)
          : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor: isDarkTheme
          ? const Color(0xff372901)
          : Color.fromARGB(185, 121, 165, 209),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      // brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}
