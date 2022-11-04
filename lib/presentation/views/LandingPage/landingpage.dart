import 'package:flutter/material.dart';
import 'package:portfolio_app/core/utility/responsive/responsive.dart';
import 'package:portfolio_app/presentation/common_widgets/custom_button.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:portfolio_app/presentation/common_widgets/pathclipper.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 89, 112),
        body: Stack(
          clipBehavior: Clip.antiAlias,
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            GradientBackground(
              outterColor: Colors.blue.shade100,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                // color: Color.fromARGB(255, 60, 89, 112),

                child: Transform.scale(
                  scale: 1.2,
                  child: Image.asset(
                    "assets/images/image_profile.png",
                    height: screenSize.height * 0.7,
                    width: screenSize.width * 0.8,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              child: ClipPath(
                clipper: PathPainter(),
                child: Container(
                  // alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  width: screenSize.width * 0.8,
                  height: screenSize.height * 0.48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Stack(children: [
                    Positioned(
                      right: -10,
                      top: 24,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          "assets/images/flutter_logo.png",
                        ),
                      ),
                    ),
                    Align(
                      alignment: Responsive.isLandScape(context)
                          ? Alignment.centerLeft
                          : Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: Responsive.isLandScape(context)
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "Hi, I am David Orakpo.",
                            textAlign: Responsive.isLandScape(context)
                                ? TextAlign.left
                                : TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: Color.fromRGBO(5, 70, 123, 0.6),
                                decoration: TextDecoration.none),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "FLUTTER/XAMARIN DEVELOPER",
                            textAlign: Responsive.isLandScape(context)
                                ? TextAlign.left
                                : TextAlign.center,
                            style: const TextStyle(
                                fontSize: 28,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(5, 70, 123, 1),
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Responsive.isLandScape(context)
                          ? Alignment.bottomRight
                          : Alignment.bottomCenter,
                      child: CustomButton(
                        text: "Learn More!",
                        textColor: Colors.white,
                        fontSize: 16,
                        height: 48,
                        width: 180,
                        backgroundColor: const Color.fromRGBO(5, 70, 123, 1),
                        onPressed: () {
                          Navigator.pushNamed(context, "/homeTabManager");
                        },
                      ),
                    )
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
