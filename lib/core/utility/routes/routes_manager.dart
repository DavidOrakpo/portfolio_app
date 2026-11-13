import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:portfolio_app/presentation/views/home/hometabmanager.dart'
    deferred as home_tab;

class RouteGenerator {
  static Future<void>? _homeLoadFuture;

  /// Preloads the deferred HomeTabManager library in the background after first frame.
  static Future<void> preloadHome() {
    return _homeLoadFuture ??= home_tab.loadLibrary();
  }

  // ignore: non_constant_identifier_names
  static Route<dynamic>? GenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
      case "/landingPage":
        return MaterialPageRoute(builder: (_) {
          return const LandingPage();
        });
      case "/homeTabManager":
        return MaterialPageRoute(builder: (_) {
          return FutureBuilder<void>(
            future: preloadHome(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return home_tab.HomeTabManager();
              }
              return const Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                ),
              );
            },
          );
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text(
                "404 // ROUTE_NOT_FOUND",
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
    }
  }
}
