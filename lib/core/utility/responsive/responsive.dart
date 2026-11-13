import 'package:material_ui/material_ui.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 700;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 700 && width < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 1100;

  static bool isPotrait(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.portrait;

  static bool isLandScape(BuildContext context) =>
      MediaQuery.orientationOf(context) == Orientation.landscape;

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= 1200) return 48;
    if (width >= 700) return 32;
    return 20;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    if (width >= 1100) {
      return desktop;
    } else if (width >= 700) {
      return tablet ?? desktop;
    } else {
      return mobile;
    }
  }
}
