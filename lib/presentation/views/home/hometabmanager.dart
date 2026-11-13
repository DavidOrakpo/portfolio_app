import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/StateManagement/dark_theme_provider.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/views/Experience/experience.dart';
import 'package:portfolio_app/presentation/views/portfolio/portfolio.dart';
import 'package:portfolio_app/presentation/views/settings/settings.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_bottomtabitem.dart';
import '../AboutMe/about_me.dart';

class HomeTabManager extends StatefulWidget {
  const HomeTabManager({super.key});

  @override
  State<HomeTabManager> createState() => _HomeTabManagerState();
}

class _HomeTabManagerState extends State<HomeTabManager> {
  int homeTabPageIndex = 0;

  static const List<({String label, String path, IconData icon})> _tabs = [
    (label: "About Me", path: "about_me", icon: Icons.person_rounded),
    (label: "Experience", path: "experience", icon: Icons.work_history_rounded),
    (label: "Portfolio", path: "projects", icon: Icons.workspaces_rounded),
    (label: "System", path: "system_cfg", icon: Icons.settings_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DarkThemeProvider>();
    final isDark = provider.darkTheme;
    final isMobile = Responsive.isMobile(context);
    final accent = Theme.of(context).colorScheme.primary;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: isDark ? TechColors.darkBg : TechColors.lightSurface,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:
            isDark ? TechColors.darkBg : TechColors.lightSurface,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GradientBackground(
          child: SafeArea(
            child: Column(
              children: [
                _buildCommandBar(context, isDark, accent, isMobile, provider),
                Expanded(
                  child: Stack(
                    children: [
                      IndexedStack(
                        index: homeTabPageIndex,
                        children: const [
                          AboutMePage(),
                          ExperiencePage(),
                          PortfolioPage(),
                          SettingsPage(),
                        ],
                      ),
                      if (isMobile)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _buildMobileBottomDock(context, isDark, accent),
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

  Widget _buildCommandBar(
    BuildContext context,
    bool isDark,
    Color accent,
    bool isMobile,
    DarkThemeProvider provider,
  ) {
    final hPad = Responsive.horizontalPadding(context);
    final currentTab = _tabs[homeTabPageIndex];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
      decoration: BoxDecoration(
        color: (isDark ? TechColors.darkSurface : TechColors.lightSurface)
            .withValues(alpha: 0.9),
        border: Border(
          bottom: BorderSide(
            color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, "/landingPage");
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: accent.withValues(alpha: 0.5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.terminal_rounded, size: 15, color: accent),
                  const SizedBox(width: 6),
                  Text(
                    "DO //",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: accent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "~/david-orakpo/${currentTab.path}",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: isDark
                    ? TechColors.darkTextSecondary
                    : TechColors.lightTextSecondary,
              ),
            ),
          ),
          if (!isMobile) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_tabs.length, (index) {
                final tab = _tabs[index];
                final selected = homeTabPageIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: InkWell(
                    onTap: () => setState(() => homeTabPageIndex = index),
                    borderRadius: BorderRadius.circular(8),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? accent.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected
                              ? accent.withValues(alpha: 0.55)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "0${index + 1}.",
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? accent
                                  : (isDark
                                      ? TechColors.darkTextSecondary
                                      : TechColors.lightTextSecondary),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            tab.icon,
                            size: 16,
                            color: selected
                                ? accent
                                : (isDark
                                    ? TechColors.darkTextSecondary
                                    : TechColors.lightTextSecondary),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            tab.label,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 12,
                              fontWeight:
                                  selected ? FontWeight.w700 : FontWeight.w500,
                              color: selected
                                  ? accent
                                  : (isDark
                                      ? TechColors.darkTextPrimary
                                      : TechColors.lightTextPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 12),
          ],
          IconButton(
            tooltip: isDark ? "Switch to Light Mode" : "Switch to Cyber Dark",
            onPressed: provider.toggleTheme,
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: accent,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileBottomDock(
      BuildContext context, bool isDark, Color accent) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      height: 68,
      decoration: BoxDecoration(
        color: (isDark ? TechColors.darkSurface : TechColors.lightSurface)
            .withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.45 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final tab = _tabs[index];
            return Expanded(
              child: CustomTabItem(
                selectedIndex: homeTabPageIndex,
                assignedIndex: index,
                text: tab.label,
                iconData: tab.icon,
                selectedColor: accent,
                unSelectedColor: Theme.of(context).unselectedWidgetColor,
                largeText: true,
                onTap: () {
                  setState(() {
                    homeTabPageIndex = index;
                  });
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
