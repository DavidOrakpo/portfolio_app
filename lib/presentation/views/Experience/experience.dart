import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/views/Experience/widgets/experience_tile.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key});

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final hPad = Responsive.horizontalPadding(context);
    const companies = Companies.values;

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
                  tag: "02 // CAREER_TIMELINE",
                  title: "ENGINEERING EXPERIENCE",
                  subtitle:
                      "Production roles delivering mobile, web, and desktop applications across global teams.",
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final useTwoColumns = constraints.maxWidth >= 740;
                    if (!useTwoColumns) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: companies.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          return ExperienceTile(
                            company: companies[index],
                            index: index,
                          );
                        },
                      );
                    }

                    final cardWidth = (constraints.maxWidth - 24) / 2;
                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: List.generate(companies.length, (index) {
                        return SizedBox(
                          width: cardWidth,
                          child: ExperienceTile(
                            company: companies[index],
                            index: index,
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
