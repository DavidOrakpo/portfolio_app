import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_app/core/StateManagement/dark_theme_provider.dart';
import 'package:portfolio_app/presentation/views/Experience/experience.dart';
import 'package:portfolio_app/presentation/views/portfolio/portfolio.dart';
import 'package:portfolio_app/presentation/views/settings/settings.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/custom_bottomtabitem.dart';
import '../AboutMe/about_me.dart';

class HomeTabManager extends StatefulWidget {
  HomeTabManager({Key? key}) : super(key: key);

  @override
  State<HomeTabManager> createState() => _HomeTabManagerState();
}

class _HomeTabManagerState extends State<HomeTabManager> {
  int selectedIndex = 0;
  int homeTabPageIndex = 0;
  double bottomTabHeight = 70;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DarkThemeProvider>();
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: provider.darkTheme
            ? const Color.fromARGB(255, 2, 11, 31)
            : Colors.white,
        statusBarIconBrightness:
            provider.darkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            IndexedStack(
              index: homeTabPageIndex,
              children: [
                AboutMePage(),
                ExperiencePage(),
                PortfolioPage(),
                SettingsPage(),
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Material(
                    elevation: 30,
                    child: Container(
                      height: bottomTabHeight,
                      color: Theme.of(context).colorScheme.tertiary,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTabItem(
                                selectedIndex: homeTabPageIndex,
                                assignedIndex: 0,
                                text: "About Me",
                                iconData: Icons.person_rounded,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                unSelectedColor:
                                    Theme.of(context).unselectedWidgetColor,
                                largeText: true,
                                onTap: (() {
                                  setState(() {
                                    homeTabPageIndex = 0;
                                  });
                                }),
                              ),
                            ),
                            Expanded(
                              child: CustomTabItem(
                                selectedIndex: homeTabPageIndex,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                unSelectedColor:
                                    Theme.of(context).unselectedWidgetColor,
                                assignedIndex: 1,
                                text: "Experience",
                                iconData: Icons.work_history_rounded,
                                largeText: true,
                                onTap: (() {
                                  setState(() {
                                    homeTabPageIndex = 1;
                                  });
                                }),
                              ),
                            ),
                            Expanded(
                              child: CustomTabItem(
                                selectedIndex: homeTabPageIndex,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                unSelectedColor:
                                    Theme.of(context).unselectedWidgetColor,
                                assignedIndex: 2,
                                text: "Portfolio",
                                iconData: Icons.workspaces_rounded,
                                largeText: true,
                                onTap: (() {
                                  setState(() {
                                    homeTabPageIndex = 2;
                                  });
                                }),
                              ),
                            ),
                            Expanded(
                              child: CustomTabItem(
                                selectedIndex: homeTabPageIndex,
                                assignedIndex: 3,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                unSelectedColor:
                                    Theme.of(context).unselectedWidgetColor,
                                text: "Settings",
                                iconData: Icons.settings_rounded,
                                largeText: true,
                                onTap: (() {
                                  setState(() {
                                    homeTabPageIndex = 3;
                                  });
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
