import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:portfolio_app/presentation/views/home/hometabmanager.dart';

class RouteGenerator {
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
          return const HomeTabManager();
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
