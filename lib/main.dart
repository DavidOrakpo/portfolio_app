import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:provider/provider.dart';

import 'core/StateManagement/dark_theme_provider.dart';
import 'core/themes/styles.dart';
import 'core/utility/routes/routes_manager.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  bool isBackground = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    themeChangeProvider.darkTheme = isDarkMode;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    isBackground = state == AppLifecycleState.resumed;
    if (isBackground) {
      getCurrentAppTheme();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeChangeProvider,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.GenerateRoute,
          // themeMode: ThemeMode.system,
          theme: Styles.themeData(
              context.watch<DarkThemeProvider>().darkTheme, context),
          // darkTheme: Styles.themeData(
          //     context.read<DarkThemeProvider>().darkTheme = true, context),
          home: LandingPage(),
        );
      },
    );
  }
}
