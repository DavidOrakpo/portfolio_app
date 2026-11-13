import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:provider/provider.dart';

import 'core/StateManagement/dark_theme_provider.dart';
import 'core/themes/styles.dart';
import 'core/utility/routes/routes_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final saved = await themeChangeProvider.darkThemePreference.getTheme();
    themeChangeProvider.darkTheme = saved;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: themeChangeProvider,
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'David Orakpo // Flutter & Xamarin Architect',
            initialRoute: "/",
            onGenerateRoute: RouteGenerator.GenerateRoute,
            theme: Styles.themeData(themeProvider.darkTheme, context),
            home: const LandingPage(),
          );
        },
      ),
    );
  }
}
