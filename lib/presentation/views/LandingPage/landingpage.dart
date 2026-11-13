import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/StateManagement/dark_theme_provider.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/core/utility/routes/routes_manager.dart';
import 'package:portfolio_app/presentation/common_widgets/custom_button.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Pre-warm the deferred HomeTabManager bundle right after the first frame paints
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RouteGenerator.preloadHome();
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = Responsive.isMobile(context);
    final accent = Theme.of(context).colorScheme.primary;
    final hPad = Responsive.horizontalPadding(context);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Top HUD Header
              _buildTopHudBar(context, isDark, accent, hPad),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: hPad,
                      vertical: isMobile ? 20 : 36,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1240),
                      child: isMobile
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildHeroVisual(context, isDark, accent, true),
                                const SizedBox(height: 28),
                                _buildHeroCopy(context, isDark, accent, true),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 12,
                                  child: _buildHeroCopy(
                                      context, isDark, accent, false),
                                ),
                                const SizedBox(width: 40),
                                Expanded(
                                  flex: 10,
                                  child: _buildHeroVisual(
                                      context, isDark, accent, false),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHudBar(
      BuildContext context, bool isDark, Color accent, double hPad) {
    final themeProvider = context.watch<DarkThemeProvider>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 14),
      decoration: BoxDecoration(
        color: (isDark ? TechColors.darkSurface : TechColors.lightSurface)
            .withValues(alpha: 0.78),
        border: Border(
          bottom: BorderSide(
            color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accent.withValues(alpha: 0.5)),
                ),
                child: Text(
                  "<DO />",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (!Responsive.isMobile(context))
                Text(
                  "SYS.PORTFOLIO // v2.6",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    color: isDark
                        ? TechColors.darkTextSecondary
                        : TechColors.lightTextSecondary,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: TechColors.matrixGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: TechColors.matrixGreen.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: Tween<double>(begin: 0.35, end: 1.0)
                          .animate(_pulseController),
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: TechColors.matrixGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      Responsive.isMobile(context)
                          ? "ONLINE"
                          : "AVAILABLE FOR PROJECTS",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: TechColors.matrixGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                tooltip: isDark
                    ? "Switch to Blueprint Light"
                    : "Switch to Cyber Dark",
                onPressed: themeProvider.toggleTheme,
                icon: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: accent,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCopy(
      BuildContext context, bool isDark, Color accent, bool isMobile) {
    final textPrimary =
        isDark ? TechColors.darkTextPrimary : TechColors.lightTextPrimary;
    final textSecondary =
        isDark ? TechColors.darkTextSecondary : TechColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accent.withValues(alpha: 0.35)),
          ),
          child: Text(
            "> root@orakpo-dev:~# ./init_portfolio.sh",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          "DAVID ORAKPO",
          style: GoogleFonts.spaceGrotesk(
            fontSize: isMobile ? 36 : 54,
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.2,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              accent,
              isDark ? TechColors.cyberViolet : TechColors.deepIndigo,
            ],
          ).createShader(bounds),
          child: Text(
            "FLUTTER & XAMARIN ARCHITECT",
            style: GoogleFonts.jetBrainsMono(
              fontSize: isMobile ? 16 : 22,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Engineering high-frequency, resilient cross-platform applications across iOS, Android, Web, and Desktop with Dart, Flutter, C#, and .NET.",
          style: TextStyle(
            fontSize: isMobile ? 15 : 17,
            height: 1.6,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        // Terminal Spec Card
        _buildTerminalCodeCard(isDark, accent),
        const SizedBox(height: 28),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomButton(
              text: "LAUNCH SYSTEM ->",
              width: isMobile ? double.infinity : 220,
              height: 50,
              fontSize: 13,
              fontweight: FontWeight.w700,
              onPressed: () {
                Navigator.pushNamed(context, "/homeTabManager");
              },
            ),
            CustomButton(
              text: "VIEW RESUME / CV",
              width: isMobile ? double.infinity : 195,
              height: 50,
              filled: false,
              textColor: accent,
              borderColor: accent.withValues(alpha: 0.6),
              fontSize: 13,
              fontweight: FontWeight.w700,
              onPressed: () {
                _openUrl(Uri.dataFromString(
                    "https://drive.google.com/drive/folders/184vxd888F-vlvzQZLJ8nK7gTlR1ApUY3?usp=sharing"));
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              "CONNECT //",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            _buildSocialIconButton(
              icon: FontAwesomeIcons.github,
              tooltip: "GitHub",
              accent: accent,
              isDark: isDark,
              onTap: () => _openUrl(Uri.https("github.com", "/DavidOrakpo")),
            ),
            const SizedBox(width: 10),
            _buildSocialIconButton(
              icon: FontAwesomeIcons.linkedinIn,
              tooltip: "LinkedIn",
              accent: accent,
              isDark: isDark,
              onTap: () =>
                  _openUrl(Uri.https("linkedin.com", "/in/davidorakpo")),
            ),
            const SizedBox(width: 10),
            _buildSocialIconButton(
              icon: FontAwesomeIcons.twitter,
              tooltip: "Twitter / X",
              accent: accent,
              isDark: isDark,
              onTap: () => _openUrl(Uri.https("twitter.com", "/DavidOrakpo")),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIconButton({
    required FaIconData icon,
    required String tooltip,
    required Color accent,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isDark ? TechColors.darkCard : TechColors.lightSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
            ),
          ),
          child: FaIcon(
            icon,
            size: 16,
            color: accent,
          ),
        ),
      ),
    );
  }

  Widget _buildTerminalCodeCard(bool isDark, Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF12070A) : const Color(0xFF1A090E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF2A54),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFB7185),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFF43F5E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "engineer_profile.dart",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  color: const Color(0xFFB8969E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                height: 1.55,
                color: const Color(0xFFFFF1F2),
              ),
              children: const [
                TextSpan(
                  text: "const ",
                  style: TextStyle(color: Color(0xFFFF6B81)),
                ),
                TextSpan(
                  text: "developer ",
                  style: TextStyle(color: Color(0xFFFF9EAB)),
                ),
                TextSpan(text: "= (\n"),
                TextSpan(
                  text: "  stack: ",
                  style: TextStyle(color: Color(0xFFB8969E)),
                ),
                TextSpan(
                  text: "['Flutter', 'Dart', 'C#', 'Xamarin', '.NET']",
                  style: TextStyle(color: Color(0xFFFDA4AF)),
                ),
                TextSpan(text: ",\n"),
                TextSpan(
                  text: "  patterns: ",
                  style: TextStyle(color: Color(0xFFB8969E)),
                ),
                TextSpan(
                  text: "['MVVM', 'Provider', 'Clean Arch', 'REST/SQL']",
                  style: TextStyle(color: Color(0xFFFDA4AF)),
                ),
                TextSpan(text: ",\n"),
                TextSpan(
                  text: "  targets: ",
                  style: TextStyle(color: Color(0xFFB8969E)),
                ),
                TextSpan(
                  text: "['iOS', 'Android', 'Web', 'Desktop']",
                  style: TextStyle(color: Color(0xFFFF6B6B)),
                ),
                TextSpan(text: "\n);"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroVisual(
      BuildContext context, bool isDark, Color accent, bool isMobile) {
    return TechGlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: accent.withValues(alpha: 0.45),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID // ORAKPO.D.01",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/flutter_logo.png",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    "assets/images/xamarin_logo.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: isMobile ? 260 : 340,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: RadialGradient(
                colors: [
                  accent.withValues(alpha: 0.28),
                  TechColors.cyberViolet.withValues(alpha: 0.14),
                  Colors.transparent,
                ],
                radius: 0.85,
              ),
              border: Border.all(
                color: accent.withValues(alpha: 0.25),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/image_profile.png",
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                cacheHeight: ((isMobile ? 260 : 340) *
                        MediaQuery.devicePixelRatioOf(context))
                    .round(),
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildMetricChip(
                    label: "EXPERIENCE",
                    value: "7+ ROLES",
                    accent: accent,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricChip(
                    label: "SHOWCASE",
                    value: "7 LIVE DEMOS",
                    accent: accent,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricChip(
                    label: "PLATFORMS",
                    value: "MOBILE + WEB",
                    accent: accent,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip({
    required String label,
    required String value,
    required Color accent,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark
            ? TechColors.darkBg.withValues(alpha: 0.65)
            : TechColors.lightBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9,
              color: isDark
                  ? TechColors.darkTextSecondary
                  : TechColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
