import 'package:flutter/material.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:provider/provider.dart';

import 'core/StateManagement/dark_theme_provider.dart';
import 'core/themes/styles.dart';
import 'core/utility/routes/routes_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: "/",
            onGenerateRoute: RouteGenerator.GenerateRoute,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: LandingPage(),
          );
        },
      ),
    );
  }
}
