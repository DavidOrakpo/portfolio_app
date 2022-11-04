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
  Heckerbella(
      nameOfCompany: "Heckerbella",
      jobPosition: "Junior Flutter Developer",
      date: "April 2022 - Present",
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
  });

  final List<String> listOfDuties;
  final String? nameOfCompany, jobPosition, date, address;
}
