// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ContactInformation {
  Name(
      title: "Name",
      subtitle: "David Orakpo",
      widget: Icon(
        Icons.person_rounded,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      )),
  Email(
      title: "Email",
      subtitle: "davidorakpo65@gmail.com",
      widget: Icon(
        Icons.email_rounded,
        size: 34,
        color: Color.fromRGBO(5, 70, 123, 1),
      )),
  Address(
      title: "Address",
      subtitle: "16 Adeniran Ajao Estate, Anthony, Lagos",
      widget: Icon(
        Icons.location_city_rounded,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      )),
  PhoneNumber(
      title: "Phone No:",
      subtitle: "+23408029214383",
      widget: Icon(
        Icons.phone_rounded,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      )),
  Education(
      title: "Education",
      subtitle: "Redeemer's University. B.Sc Microbiology",
      widget: Icon(
        Icons.school_rounded,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      ));

  const ContactInformation(
      {required this.title, required this.subtitle, required this.widget});
  final String title, subtitle;
  final Widget widget;
}

//TODO: WORK ON THIS ENUM TO CHANGE REQUIRED ICONS TO FONT AWESOME ICONS
enum SocialInformation {
  Slack(
      title: "Slack Username",
      subtitle: "David Orakpo",
      widget: FaIcon(
        FontAwesomeIcons.slack,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      )),
  Github(
      title: "Github ID",
      subtitle: "https://github.com/DavidOrakpo",
      widget: FaIcon(
        FontAwesomeIcons.github,
        size: 34,
        color: Color.fromRGBO(5, 70, 123, 1),
      )),
  LinkedIn(
      title: "LinkedIn link",
      subtitle: "https://www.linkedin.com/in/davidorakpo",
      widget: FaIcon(
        FontAwesomeIcons.linkedinIn,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      )),
  Twitter(
      title: "Twitter",
      subtitle: "https://twitter.com/DavidOrakpo",
      widget: FaIcon(
        FontAwesomeIcons.twitter,
        color: Color.fromRGBO(5, 70, 123, 1),
        size: 34,
      ));

  const SocialInformation(
      {required this.title, required this.subtitle, required this.widget});
  final String title, subtitle;
  final Widget widget;
}

enum Companies {
  Gate(
    nameOfCompany: "Gate",
    jobPosition: "Flutter Engineer",
    date: "Feb 2024 - Present",
    imagePath: "assets/images/gate_icon_filled_black.jpg",
    address: "Remote (Germany)",
    appLink:
        "https://apps.apple.com/us/app/gate-creator-app/id6478483588?platform=iphone",
    listOfDuties: [
      "Implemented Designs and Features from Figma UI",
      "Connected to Firebase and managed the flow and storage of called data",
      "Continuously optimize and improve the app's performance, user interface, and functionality",
    ],
  ),
  WEquil(
    nameOfCompany: "WEquil Group",
    jobPosition: "Flutter Engineer (Contract)",
    date: "April 2023 - July 2024",
    imagePath: "assets/images/wequil.png",
    appLink:
        "https://play.google.com/store/apps/details?id=app.wequil.wequilmobile&hl=en_US",
    address: "Remote (USA)",
    listOfDuties: [
      "Implemented Classrooms, Digital Resume, Home Screen, Profiles and more",
      "Implement secure and scalable interfaces between the mobile app and internet-based services and APIs",
      "Implemented Flutter Web App UI",
      "Continuously optimize and improve the app's performance, user interface, and functionality",
    ],
  ),
  Bani(
    nameOfCompany: "Bani Africa",
    jobPosition: "Flutter Lead Engineer",
    date: "April 2023 - Present",
    imagePath: "assets/images/bani.png",
    appLink:
        "https://play.google.com/store/apps/details?id=com.bani.shopper&hl=en_US",
    address: "Remote",
    listOfDuties: [
      "Collaborate with the Product Development team to understand user requirements",
      "Design and develop Bani Shopper Mobile application from UI designs and frameworks",
      "Implement secure and scalable interfaces between the mobile app and internet-based services and APIs",
      "Continuously optimize and improve the app's performance, user interface, and functionality",
    ],
  ),
  YieldVest(
    nameOfCompany: "Yield Vest",
    jobPosition: "Flutter Desktop Team Lead",
    date: "November 2022 - Februrary 2023",
    imagePath: "assets/images/yieldvest.png",
    address: "HNG i9 Internship",
    listOfDuties: [
      "Emerged as a Finalist from over 12,000 applicants",
      "Co-ordinated and managed a suite of developers in building the desktop app for Yield Vest",
      "Implemented UI designs and end points to produce a functional product",
    ],
  ),
  Heckerbella(
      nameOfCompany: "Heckerbella",
      jobPosition: "Flutter Mobile Engineer",
      date: "April 2022 - April 2023",
      imagePath: "assets/images/heckerbella.png",
      address: "14 Adetokunbo Ademola Street, Victoria Island Lagos",
      listOfDuties: [
        "Implemented UI designs into Page layouts using Dart",
        "Wired up and Managed SQL Server backend for mobile solutions",
        "Connected to REST API Calls and managed the flow and storage of called data",
      ]),
  TechiesInfoSystem(
      nameOfCompany: "Techies InfoSystem",
      jobPosition: "Xamarin Developer",
      date: "November 2021 - April 2022",
      imagePath: "assets/images/techies.png",
      address: "Lamlat House, 270 Ikorodu-Ososun Rd, Obanikoro 102216, Lagos",
      listOfDuties: [
        "Implemented UI designs into Page layouts using XAML and C#",
        "Designed UI screens using Lunacy",
        "Connected to REST API Calls and managed the flow and storage of called data",
      ]),
  Andela(
      nameOfCompany: "Andela",
      jobPosition: "Mentor Group Leader GADS 19",
      date: "June 2019 - December 2019",
      address: "55 Moleye Street Lagos",
      imagePath: "assets/images/ANDELA.jpg",
      listOfDuties: [
        "Provided support to ongoing participants in the Google Andela Scholarship Program '19.",
        "Over saw the learning and progress of over 50 candidates in Team 45's cohort",
      ]);

  const Companies({
    required this.nameOfCompany,
    required this.jobPosition,
    required this.date,
    required this.address,
    required this.listOfDuties,
    required this.imagePath,
    this.appLink,
  });

  final List<String> listOfDuties;
  final String? nameOfCompany, jobPosition, date, address, imagePath, appLink;
}
