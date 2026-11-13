import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/skills_widget.dart';

class SkillsTile extends StatelessWidget {
  const SkillsTile({super.key});

  static const List<({String name, String category, double level, bool first})>
      _skills = [
    (
      name: "Flutter",
      category: "UI SDK",
      level: 0.96,
      first: true,
    ),
    (
      name: "Dart",
      category: "LANGUAGE",
      level: 0.95,
      first: false,
    ),
    (
      name: "C# / .NET",
      category: "LANGUAGE",
      level: 0.90,
      first: true,
    ),
    (
      name: "Xamarin / XAML",
      category: "CROSS-PLATFORM",
      level: 0.88,
      first: false,
    ),
    (
      name: "MVVM / Clean Arch",
      category: "ARCHITECTURE",
      level: 0.94,
      first: true,
    ),
    (
      name: "REST & GraphQL APIs",
      category: "NETWORKING",
      level: 0.93,
      first: false,
    ),
    (
      name: "Firebase & Cloud",
      category: "BACKEND",
      level: 0.91,
      first: true,
    ),
    (
      name: "SQL Server / Local DB",
      category: "DATA LAYER",
      level: 0.87,
      first: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TechSectionHeader(
          tag: "02 // CAPABILITIES_MATRIX",
          title: "TECH STACK & TELEMETRY",
          subtitle:
              "Core languages, frameworks, and architectural patterns used in production.",
        ),
        const SizedBox(height: 20),
        TechGlassCard(
          padding: EdgeInsets.all(isMobile ? 18 : 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ACTIVE NODES // LIVE PULSE",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: accent,
                    ),
                  ),
                  Text(
                    "${_skills.length} MODULES LOADED",
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11,
                      color: isDark
                          ? TechColors.darkTextSecondary
                          : TechColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: _skills.map((skill) {
                  return SkillsWidget(
                    title: skill.name,
                    category: skill.category,
                    proficiency: skill.level,
                    isFirstSequence: skill.first,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
