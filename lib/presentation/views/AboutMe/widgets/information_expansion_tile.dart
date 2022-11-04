import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:portfolio_app/core/enums/enum.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicInformationTile extends StatefulWidget {
  BasicInformationTile({
    Key? key,
    this.contactinfoLists,
    this.isContactInfoList = true,
    this.description,
    this.subtitle,
    this.title,
    this.socialInfoLists,
  }) : super(key: key);
  List<ContactInformation>? contactinfoLists;
  List<SocialInformation>? socialInfoLists;
  bool isContactInfoList;
  String? title, subtitle, description;
  @override
  State<BasicInformationTile> createState() => _BasicInformationTileState();
}

class _BasicInformationTileState extends State<BasicInformationTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var contactInfoList = widget.isContactInfoList
        ? widget.contactinfoLists
        : widget.socialInfoLists;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: GradientBoxBorder(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            const Color.fromARGB(255, 129, 180, 221),
          ], stops: const [
            0,
            0.5
          ]))

          //  Constants.gradientBoxBorder(
          //   width: 2,
          // ),
          ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          iconColor: Theme.of(context).colorScheme.primary,
          collapsedIconColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
          expandedAlignment: Alignment.topLeft,
          trailing: Container(
              height: 50,
              width: 20,
              alignment: Alignment.bottomCenter,
              child: Icon(isExpanded
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.subtitle ?? "PERSONAL DETAILS",
                  style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.6))),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.title ?? "CONTACT INFORMATION",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                height: 1,
                thickness: 2,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.description ?? "Email, Phone No:, Address etc",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  fontSize: 14,
                ),
              ),
            ],
          ),
          children: [
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.black),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 400, minHeight: 56.0),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = contactInfoList[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            onTap: () async {
                              if (item == SocialInformation.Twitter) {
                                if (await canLaunchUrl(
                                    Uri.https("twitter.com", "/DavidOrakpo"))) {
                                  final bool nativeAppLaunchSucceeded =
                                      await launchUrl(
                                          Uri.https(
                                            "twitter.com",
                                            "/DavidOrakpo",
                                          ),
                                          mode: LaunchMode.externalApplication);
                                  if (!nativeAppLaunchSucceeded) {
                                    await launchUrl(
                                        Uri.https(
                                          "twitter.com",
                                          "/DavidOrakpo",
                                        ),
                                        mode: LaunchMode.inAppWebView);
                                  }
                                } else {
                                  throw "An error occured";
                                }
                              }
                              if (item == SocialInformation.Github) {
                                if (await canLaunchUrl(
                                    Uri.https("github.com", "/DavidOrakpo"))) {
                                  final bool nativeAppLaunchSucceeded =
                                      await launchUrl(
                                          Uri.https(
                                            "github.com",
                                            "/DavidOrakpo",
                                          ),
                                          mode: LaunchMode.externalApplication);
                                  if (!nativeAppLaunchSucceeded) {
                                    await launchUrl(
                                        Uri.https(
                                          "github.com",
                                          "/DavidOrakpo",
                                        ),
                                        mode: LaunchMode.inAppWebView);
                                  }
                                } else {
                                  throw "An error occured";
                                }
                              }
                            },
                            title: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                widget.isContactInfoList
                                    ? (item as ContactInformation).title
                                    : (item as SocialInformation).title,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                widget.isContactInfoList
                                    ? (item as ContactInformation).subtitle
                                    : (item as SocialInformation).subtitle,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                widget.isContactInfoList
                                    ? (item as ContactInformation).widget
                                    : (item as SocialInformation).widget,
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.3),
                              height: 1,
                              thickness: 2,
                            ),
                        itemCount: contactInfoList!.length),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
