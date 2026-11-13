import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicInformationTile extends StatefulWidget {
  const BasicInformationTile({
    super.key,
    this.contactinfoLists,
    this.isContactInfoList = true,
    this.description,
    this.subtitle,
    this.title,
    this.socialInfoLists,
  });

  final List<ContactInformation>? contactinfoLists;
  final List<SocialInformation>? socialInfoLists;
  final bool isContactInfoList;
  final String? title, subtitle, description;

  @override
  State<BasicInformationTile> createState() => _BasicInformationTileState();
}

class _BasicInformationTileState extends State<BasicInformationTile> {
  bool isExpanded = true;

  Future<void> _handleItemTap(Object item) async {
    Uri? targetUri;
    if (item == SocialInformation.LinkedIn) {
      targetUri = Uri.https("linkedin.com", "/in/davidorakpo");
    } else if (item == SocialInformation.Twitter) {
      targetUri = Uri.https("twitter.com", "/DavidOrakpo");
    } else if (item == SocialInformation.Github) {
      targetUri = Uri.https("github.com", "/DavidOrakpo");
    } else if (item == ContactInformation.Email) {
      targetUri = Uri(scheme: 'mailto', path: 'davidorakpo65@gmail.com');
    } else if (item == ContactInformation.PhoneNumber) {
      targetUri = Uri(scheme: 'tel', path: '+23408029214383');
    }

    if (targetUri != null && await canLaunchUrl(targetUri)) {
      await launchUrl(targetUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final contactInfoList = widget.isContactInfoList
        ? widget.contactinfoLists
        : widget.socialInfoLists;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? TechColors.darkCard.withValues(alpha: 0.9)
            : TechColors.lightSurface,
        borderRadius: BorderRadius.circular(14),
        border: GradientBoxBorder(
          width: 1.3,
          gradient: LinearGradient(
            colors: [
              accent.withValues(alpha: 0.7),
              TechColors.cyberViolet.withValues(alpha: 0.45),
            ],
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: isDark ? 0.06 : 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
            });
          },
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: accent,
          collapsedIconColor: accent.withValues(alpha: 0.7),
          expandedAlignment: Alignment.topLeft,
          trailing: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accent.withValues(alpha: 0.35)),
            ),
            child: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: accent,
              size: 20,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "// ${widget.subtitle ?? "PERSONAL DETAILS"}",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.1,
                  color: accent,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.title ?? "CONTACT INFORMATION",
                style: GoogleFonts.spaceGrotesk(
                  color: isDark
                      ? TechColors.darkTextPrimary
                      : TechColors.lightTextPrimary,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.description ?? "Email, Phone No, Location & Education",
                style: TextStyle(
                  color: isDark
                      ? TechColors.darkTextSecondary
                      : TechColors.lightTextSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          children: [
            Divider(
              color: isDark ? TechColors.darkBorder : TechColors.lightBorder,
              height: 16,
              thickness: 1,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contactInfoList?.length ?? 0,
              separatorBuilder: (context, index) => Divider(
                color: (isDark ? TechColors.darkBorder : TechColors.lightBorder)
                    .withValues(alpha: 0.6),
                height: 1,
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final item = contactInfoList![index];
                final title = widget.isContactInfoList
                    ? (item as ContactInformation).title
                    : (item as SocialInformation).title;
                final subtitle = widget.isContactInfoList
                    ? (item as ContactInformation).subtitle
                    : (item as SocialInformation).subtitle;
                final iconWidget = widget.isContactInfoList
                    ? (item as ContactInformation).widget
                    : (item as SocialInformation).widget;

                final isActionable = item == SocialInformation.LinkedIn ||
                    item == SocialInformation.Twitter ||
                    item == SocialInformation.Github ||
                    item == ContactInformation.Email ||
                    item == ContactInformation.PhoneNumber;

                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  onTap: isActionable ? () => _handleItemTap(item) : null,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: accent.withValues(alpha: 0.25),
                      ),
                    ),
                    child: IconTheme(
                      data: IconThemeData(color: accent),
                      child: iconWidget,
                    ),
                  ),
                  title: Text(
                    title,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? TechColors.darkTextPrimary
                          : TechColors.lightTextPrimary,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        color: isDark
                            ? TechColors.darkTextSecondary
                            : TechColors.lightTextSecondary,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ),
                  trailing: isActionable
                      ? Icon(
                          Icons.open_in_new_rounded,
                          size: 16,
                          color: accent.withValues(alpha: 0.8),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
