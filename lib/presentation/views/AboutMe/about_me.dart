import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:portfolio_app/presentation/common_widgets/custom_button.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/information_expansion_tile.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/skills_tile.dart';
import 'package:portfolio_app/presentation/views/AboutMe/widgets/skills_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utility/responsive/responsive.dart';
import '../../common_widgets/gradient_background.dart';

class AboutMePage extends StatefulWidget {
  AboutMePage({Key? key}) : super(key: key);

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding:
              const EdgeInsets.only(left: 24.0, top: 24, right: 24, bottom: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: Responsive.isLandScape(context)
                    ? (size.height * 0.33)
                    : (size.height * 0.3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "WELCOME!",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                ),
                                Responsive.isLandScape(context)
                                    ? CustomButton(
                                        text: "View CV",
                                        textColor: Colors.white,
                                        fontSize: 16,
                                        width: 100,
                                        height: 40,
                                        fontweight: FontWeight.bold,
                                        backgroundColor:
                                            const Color.fromRGBO(5, 70, 123, 1),
                                        onPressed: () async {
                                          await launchUrl(
                                            Uri.https("resume.creddle.io",
                                                "/resume/16z9nfhzy0x"),
                                          );
                                        },
                                      )
                                    : const SizedBox()
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "David Orakpo",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Flutter/Xamarin Developer",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary
                                      .withOpacity(0.5)),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Responsive.isLandScape(context)
                                ? const SizedBox()
                                : CustomButton(
                                    text: "View CV",
                                    textColor: Colors.white,
                                    fontSize: 16,
                                    fontweight: FontWeight.bold,
                                    backgroundColor:
                                        const Color.fromRGBO(5, 70, 123, 1),
                                    onPressed: () async {
                                      await launchUrl(
                                        Uri.https("resume.creddle.io",
                                            "/resume/16z9nfhzy0x"),
                                      );
                                    },
                                  )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 15,
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        // fit: StackFit.expand,
                        // alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                // width: double.infinity,
                                height: 250,
                                width: size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                ),
                                // height: 250,
                              ),
                            ),
                          ),
                          Responsive.isTablet(context)
                              ? Positioned(
                                  bottom: 0,
                                  right: 20,
                                  child: Transform.scale(
                                    scale: 1.4,
                                    child: Image.asset(
                                      "assets/images/image_profile4.png",
                                      alignment: Alignment.centerRight,
                                      width: 150,
                                      height: size.height * 0.28,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  top: -10,
                                  right: 20,
                                  child: Transform.scale(
                                    scale: 1.4,
                                    child: Image.asset(
                                      "assets/images/image_profile4.png",
                                      alignment: Alignment.centerRight,
                                      width: 150,
                                      height: 250,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 2,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "SUMMARY",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Self taught Xamarin and Flutter Developer with a deep passion for programming and problem solving. Studied at both the University of Toronto and Redeemers University. Proven skillsin C#, Dart, XAML Designs, MVVM patterns and Cross-Platform deployment (IOS/Android). Eager to learn more and expand my horizons in Software Development.",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 2,
                thickness: 1,
              ),
              const SizedBox(
                height: 24,
              ),
              BasicInformationTile(
                contactinfoLists: const [...ContactInformation.values],
              ),
              const SizedBox(
                height: 24,
              ),
              BasicInformationTile(
                subtitle: "NETWORK DETAILS",
                title: "SOCIAL INFORMATION",
                description: "Social media accouts etc...",
                socialInfoLists: const [...SocialInformation.values],
                isContactInfoList: false,
              ),
              const SizedBox(
                height: 24,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 2,
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              const SkillsTile(),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        )),
      ),
    );
  }
}
