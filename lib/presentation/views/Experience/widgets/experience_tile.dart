import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/presentation/common_widgets/custom_button.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceTile extends StatelessWidget {
  ExperienceTile({
    super.key,
    required this.company,
    this.backgroudColor,
    this.index = 0,
  })  : date = company?.date,
        title = company?.jobPosition;

  final String? title, date;
  final Color? backgroudColor;
  final Companies? company;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final item = company!;
    final isCurrent = (item.date ?? "").toLowerCase().contains("present");

    return TechGlassCard(
      padding: const EdgeInsets.all(20),
      onTap: () {
        showExperienceDetails(
          context,
          item,
          MediaQuery.sizeOf(context).height * 0.78,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: accent.withValues(alpha: 0.35)),
                ),
                child: Text(
                  "LOG // 0${index + 1}",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isCurrent ? TechColors.matrixGreen : accent)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: (isCurrent ? TechColors.matrixGreen : accent)
                        .withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  date ?? "Present",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isCurrent ? TechColors.matrixGreen : accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroudColor ?? const Color(0xFF050811),
                border: Border.all(
                  color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: item.imagePath != null
                  ? Image.asset(
                      item.imagePath!,
                      fit: BoxFit.contain,
                      height: 150,
                      width: double.infinity,
                      cacheHeight:
                          (150 * MediaQuery.devicePixelRatioOf(context))
                              .round(),
                      filterQuality: FilterQuality.medium,
                    )
                  : _buildGeneratedCompanyBanner(item, accent),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nameOfCompany ?? item.name,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      title ?? "Flutter Engineer",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? TechColors.darkTextPrimary
                            : TechColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              if (item.appLink != null)
                Tooltip(
                  message: "Live App / Web Link Available",
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: TechColors.matrixGreen.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.rocket_launch_rounded,
                      size: 16,
                      color: TechColors.matrixGreen,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: isDark
                    ? TechColors.darkTextSecondary
                    : TechColors.lightTextSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.address ?? "Remote",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? TechColors.darkTextSecondary
                        : TechColors.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...item.listOfDuties.take(2).map(
                (duty) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "▹ ",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          color: accent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          duty,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: isDark
                                ? TechColors.darkTextSecondary
                                : TechColors.lightTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "INSPECT LOGS ->",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeneratedCompanyBanner(Companies item, Color accent) {
    final companyTitle = (item.nameOfCompany ?? item.name).toUpperCase();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF060D1A),
            accent.withValues(alpha: 0.18),
            TechColors.cyberViolet.withValues(alpha: 0.22),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: accent.withValues(alpha: 0.45)),
              ),
              child: Text(
                companyTitle,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.address ?? "REMOTE",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 10,
                color: accent,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showExperienceDetails(
    BuildContext context,
    Companies companies,
    double bottomSheetHeight,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;

    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Container(
              height: bottomSheetHeight,
              decoration: BoxDecoration(
                color: isDark ? TechColors.darkSurface : TechColors.lightSurface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                border: Border.all(
                  color: accent.withValues(alpha: 0.45),
                  width: 1.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "// DEPLOYMENT_RECORD",
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: accent,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                companies.nameOfCompany ?? companies.name,
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? TechColors.darkTextPrimary
                                      : TechColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: isDark
                          ? TechColors.darkBorder
                          : TechColors.lightBorder,
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              context,
                              icon: Icons.work_rounded,
                              label: "ROLE / POSITION",
                              value: companies.jobPosition ?? "",
                              accent: accent,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              context,
                              icon: Icons.calendar_month_rounded,
                              label: "DURATION",
                              value: companies.date ?? "",
                              accent: accent,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 12),
                            _buildDetailRow(
                              context,
                              icon: Icons.location_city_rounded,
                              label: "LOCATION",
                              value: companies.address ?? "",
                              accent: accent,
                              isDark: isDark,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "KEY ENGINEERING CONTRIBUTIONS //",
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...companies.listOfDuties.map(
                              (duty) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? TechColors.darkCard
                                      : TechColors.lightBg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isDark
                                        ? TechColors.darkBorder
                                        : TechColors.lightBorder,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "▹",
                                      style: GoogleFonts.jetBrainsMono(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: accent,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        duty,
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: isDark
                                              ? TechColors.darkTextPrimary
                                              : TechColors.lightTextPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (companies.appLink != null) ...[
                              const SizedBox(height: 16),
                              CustomButton(
                                text: "LAUNCH LIVE APPLICATION ->",
                                height: 46,
                                onPressed: () {
                                  launchUrl(
                                    Uri.parse(companies.appLink!),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color accent,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? TechColors.darkCard : TechColors.lightBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? TechColors.darkTextPrimary
                        : TechColors.lightTextPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
