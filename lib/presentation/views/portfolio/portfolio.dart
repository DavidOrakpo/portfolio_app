import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/views/portfolio/widgets/video_tile.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int _activeIndex = 0;
  PageController? _pageController;
  double _currentViewportFraction = 0.85;

  static const List<PortfolioProjects> _projects = PortfolioProjects.values;

  void _ensurePageController(double fraction) {
    if (_pageController == null ||
        (_currentViewportFraction - fraction).abs() > 0.01) {
      final oldController = _pageController;
      _currentViewportFraction = fraction;
      _pageController = PageController(
        initialPage: _activeIndex,
        viewportFraction: fraction,
      );
      if (oldController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          oldController.dispose();
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    final clamped = index.clamp(0, _projects.length - 1);
    _pageController?.animateToPage(
      clamped,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final hPad = Responsive.horizontalPadding(context);

    final double desiredFraction = isMobile
        ? 0.88
        : isTablet
            ? 0.62
            : 0.46;
    _ensurePageController(desiredFraction);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 24,
          bottom: isMobile ? 100 : 48,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: TechSectionHeader(
                    tag: "03 // DEPLOYED_BUILDS",
                    title: "INTERACTIVE PROJECT CAROUSEL",
                    subtitle:
                        "Swipe, drag, or use the deck controls to inspect live application builds.",
                    trailing:
                        !isMobile ? _buildArrowControls(isDark, accent) : null,
                  ),
                ),
                const SizedBox(height: 18),
                // Quick-jump project selector pills
                SizedBox(
                  height: 38,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      scrollDirection: Axis.horizontal,
                      itemCount: _projects.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final isSelected = index == _activeIndex;
                        final project = _projects[index];
                        return InkWell(
                          onTap: () => _goToPage(index),
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? accent.withValues(alpha: 0.18)
                                  : (isDark
                                      ? TechColors.darkCard
                                      : TechColors.lightSurface),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? accent
                                    : (isDark
                                        ? TechColors.darkBorder
                                        : TechColors.lightBorder),
                                width: isSelected ? 1.4 : 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "0${index + 1}",
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: accent,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  project.title,
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 11,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? (isDark
                                            ? TechColors.darkTextPrimary
                                            : TechColors.lightTextPrimary)
                                        : (isDark
                                            ? TechColors.darkTextSecondary
                                            : TechColors.lightTextSecondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                // Horizontal Carousel
                SizedBox(
                  height: isMobile ? 520 : 560,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      dragDevices: {
                        PointerDeviceKind.touch,
                        PointerDeviceKind.mouse,
                        PointerDeviceKind.trackpad,
                      },
                    ),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _projects.length,
                      onPageChanged: (index) {
                        setState(() {
                          _activeIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final project = _projects[index];
                        final isActive = index == _activeIndex;
                        return RepaintBoundary(
                          child: AnimatedScale(
                            scale: isActive ? 1.0 : 0.93,
                            duration: const Duration(milliseconds: 280),
                            curve: Curves.easeOutCubic,
                            child: AnimatedOpacity(
                              opacity: isActive ? 1.0 : 0.58,
                              duration: const Duration(milliseconds: 280),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                child: VideoTile(
                                  key: ValueKey(project.videoPath),
                                  title: project.title,
                                  category: project.category,
                                  techStack: project.techStack,
                                  videoPath: project.videoPath,
                                  index: index,
                                  isActive: isActive,
                                  onRequestActivate: () => _goToPage(index),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Bottom status & mobile navigation controls
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPad),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "MODULE // 0${_activeIndex + 1} OF 0${_projects.length}",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: accent,
                        ),
                      ),
                      Row(
                        children: List.generate(_projects.length, (i) {
                          final active = i == _activeIndex;
                          return GestureDetector(
                            onTap: () => _goToPage(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              height: 6,
                              width: active ? 24 : 8,
                              decoration: BoxDecoration(
                                color: active
                                    ? accent
                                    : (isDark
                                        ? TechColors.darkBorder
                                        : TechColors.lightBorder),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          );
                        }),
                      ),
                      if (isMobile) _buildArrowControls(isDark, accent),
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

  Widget _buildArrowControls(bool isDark, Color accent) {
    final canPrev = _activeIndex > 0;
    final canNext = _activeIndex < _projects.length - 1;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDeckButton(
          icon: Icons.chevron_left_rounded,
          enabled: canPrev,
          isDark: isDark,
          accent: accent,
          onTap: () => _goToPage(_activeIndex - 1),
        ),
        const SizedBox(width: 8),
        _buildDeckButton(
          icon: Icons.chevron_right_rounded,
          enabled: canNext,
          isDark: isDark,
          accent: accent,
          onTap: () => _goToPage(_activeIndex + 1),
        ),
      ],
    );
  }

  Widget _buildDeckButton({
    required IconData icon,
    required bool enabled,
    required bool isDark,
    required Color accent,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? TechColors.darkCard : TechColors.lightSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: enabled
                ? accent.withValues(alpha: 0.5)
                : (isDark ? TechColors.darkBorder : TechColors.lightBorder),
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: enabled
              ? accent
              : (isDark
                  ? TechColors.darkTextSecondary.withValues(alpha: 0.4)
                  : TechColors.lightTextSecondary.withValues(alpha: 0.4)),
        ),
      ),
    );
  }
}
