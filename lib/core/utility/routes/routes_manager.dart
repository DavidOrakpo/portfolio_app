import 'package:flutter/material.dart';
import 'package:portfolio_app/main.dart';
import 'package:portfolio_app/presentation/views/LandingPage/landingpage.dart';
import 'package:portfolio_app/presentation/views/home/hometabmanager.dart';

class RouteGenerator {
  // ignore: non_constant_identifier_names
  static Route<dynamic>? GenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/landingPage":
        return MaterialPageRoute(builder: (_) {
          return LandingPage();
        });
      case "/homeTabManager":
        return MaterialPageRoute(builder: (_) {
          return HomeTabManager();
        });

      default:
        return MaterialPageRoute(builder: (_) {
          return Container(
            color: Colors.white,
            child: const Center(
                child: Text(
              "Error, Incorrect Route",
              textAlign: TextAlign.center,
            )),
          );
        });
    }
  }
}
