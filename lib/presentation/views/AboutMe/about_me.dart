import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/custom_button.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/information_expansion_tile.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/skills_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
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
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TechSectionHeader(
                  tag: "01 // ENGINEER_IDENTITY",
                  title: "SYSTEM OVERVIEW & BIO",
                  subtitle:
                      "Cross-platform software architect specializing in Flutter, Dart, C#, and Xamarin.",
                ),
                const SizedBox(height: 24),
                _buildHeroIdentityCard(context, isDark, accent, isMobile),
                const SizedBox(height: 24),
                if (isMobile) ...[
                  BasicInformationTile(
                    contactinfoLists: const [...ContactInformation.values],
                  ),
                  const SizedBox(height: 20),
                  BasicInformationTile(
                    subtitle: "NETWORK DETAILS",
                    title: "SOCIAL INFORMATION",
                    description: "GitHub, LinkedIn, X/Twitter & Slack",
                    socialInfoLists: const [...SocialInformation.values],
                    isContactInfoList: false,
                  ),
                ] else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BasicInformationTile(
                          contactinfoLists: const [...ContactInformation.values],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: BasicInformationTile(
                          subtitle: "NETWORK DETAILS",
                          title: "SOCIAL INFORMATION",
                          description: "GitHub, LinkedIn, X/Twitter & Slack",
                          socialInfoLists: const [...SocialInformation.values],
                          isContactInfoList: false,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 28),
                const SkillsTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroIdentityCard(
    BuildContext context,
    bool isDark,
    Color accent,
    bool isMobile,
  ) {
    final textPrimary =
        isDark ? TechColors.darkTextPrimary : TechColors.lightTextPrimary;
    final textSecondary =
        isDark ? TechColors.darkTextSecondary : TechColors.lightTextSecondary;

    final bioColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: TechColors.matrixGreen.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: TechColors.matrixGreen.withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                "STATUS: ACTIVE",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: TechColors.matrixGreen,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: accent.withValues(alpha: 0.35)),
              ),
              child: Text(
                "LOC: LAGOS // REMOTE",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accent,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "David Orakpo",
          style: GoogleFonts.spaceGrotesk(
            fontSize: isMobile ? 30 : 38,
            fontWeight: FontWeight.w800,
            color: textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Senior Flutter Engineer | Cross-Platform Mobile & Web Developer",
          style: GoogleFonts.jetBrainsMono(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: accent,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Self-taught Xamarin and Flutter developer with extensive experience building scalable cross-platform mobile and web applications. Strong expertise in Flutter, Dart, Firebase, ASP.NET MVC/Core, SQL Server, REST APIs, and modern UI/UX implementation. Experienced in leading engineering teams, mentoring developers, and delivering production-ready software solutions across Android, iOS, and web platforms.",
          style: TextStyle(
            fontSize: 15,
            height: 1.65,
            color: textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildHighlightChip(
              icon: Icons.emoji_events_rounded,
              label: "HNG i9 Finalist (Top 800 of 11,000+)",
              accent: accent,
              isDark: isDark,
            ),
            _buildHighlightChip(
              icon: Icons.school_rounded,
              label: "B.Sc. CS (Univ. of the People) & B.Sc. (Redeemer's)",
              accent: accent,
              isDark: isDark,
            ),
            _buildHighlightChip(
              icon: Icons.devices_rounded,
              label: "iOS · Android · Web · Desktop",
              accent: accent,
              isDark: isDark,
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            CustomButton(
              text: "DOWNLOAD / VIEW CV",
              width: isMobile ? double.infinity : 210,
              height: 44,
              fontSize: 12,
              fontweight: FontWeight.w700,
              onPressed: () async {
                await launchUrl(
                  Uri.https("resume.creddle.io", "/resume/16z9nfhzy0x"),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            CustomButton(
              text: "GITHUB REPOS",
              width: isMobile ? double.infinity : 170,
              height: 44,
              filled: false,
              textColor: accent,
              borderColor: accent.withValues(alpha: 0.6),
              fontSize: 12,
              fontweight: FontWeight.w700,
              onPressed: () async {
                await launchUrl(
                  Uri.https("github.com", "/DavidOrakpo"),
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
          ],
        ),
      ],
    );

    final portraitCard = Container(
      height: isMobile ? 250 : 300,
      width: isMobile ? double.infinity : 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.22),
            TechColors.cyberViolet.withValues(alpha: 0.18),
          ],
        ),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.2,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 10,
            left: 12,
            child: Text(
              "BIO_SCAN // 01",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: accent,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Image.asset(
              "assets/images/image_profile4.png",
              height: isMobile ? 235 : 280,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );

    return TechGlassCard(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      borderColor: accent.withValues(alpha: 0.35),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                portraitCard,
                const SizedBox(height: 20),
                bioColumn,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: bioColumn),
                const SizedBox(width: 32),
                portraitCard,
              ],
            ),
    );
  }

  Widget _buildHighlightChip({
    required IconData icon,
    required String label,
    required Color accent,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark
            ? TechColors.darkBg.withValues(alpha: 0.6)
            : TechColors.lightBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: accent),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? TechColors.darkTextPrimary
                  : TechColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
