import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/StateManagement/dark_theme_provider.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<DarkThemeProvider>();
    final isDark = themeProvider.darkTheme;
    final accent = Theme.of(context).colorScheme.primary;
    final isMobile = Responsive.isMobile(context);
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          hPad,
          24,
          hPad,
          isMobile ? 100 : 48,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TechSectionHeader(
                  tag: "04 // SYSTEM_CONFIGURATION",
                  title: "INTERFACE & TELEMETRY",
                  subtitle:
                      "Customize visual display mode and inspect runtime architecture.",
                ),
                const SizedBox(height: 24),
                TechGlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "VISUAL_THEME_ENGINE //",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cyber Dark Mode",
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? TechColors.darkTextPrimary
                                        : TechColors.lightTextPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isDark
                                      ? "Active: High-contrast obsidian terminal theme with cyber crimson red accents."
                                      : "Active: Technical light theme with deep crimson & ruby accents.",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? TechColors.darkTextSecondary
                                        : TechColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Switch(
                            value: isDark,
                            activeTrackColor: accent.withValues(alpha: 0.35),
                            activeThumbColor: accent,
                            onChanged: (bool value) {
                              themeProvider.darkTheme = value;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TechGlassCard(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SYSTEM_DIAGNOSTICS //",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSpecRow(
                        label: "FRAMEWORK",
                        value: "Flutter 3.50 // Material UI",
                        isDark: isDark,
                        accent: accent,
                      ),
                      const Divider(height: 24),
                      _buildSpecRow(
                        label: "VIEWPORT_MODE",
                        value: Responsive.isDesktop(context)
                            ? "DESKTOP / WIDE WEB"
                            : Responsive.isTablet(context)
                                ? "TABLET / ADAPTIVE"
                                : "MOBILE / COMPACT",
                        isDark: isDark,
                        accent: accent,
                      ),
                      const Divider(height: 24),
                      _buildSpecRow(
                        label: "STATE_ENGINE",
                        value: "Provider + SharedPreferences Persistence",
                        isDark: isDark,
                        accent: accent,
                      ),
                      const Divider(height: 24),
                      _buildSpecRow(
                        label: "SYSTEM_STATUS",
                        value: "ALL MODULES NOMINAL",
                        isDark: isDark,
                        accent: TechColors.matrixGreen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecRow({
    required String label,
    required String value,
    required bool isDark,
    required Color accent,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            fontSize: 12,
            color: isDark
                ? TechColors.darkTextSecondary
                : TechColors.lightTextSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
        ),
      ],
    );
  }
}
