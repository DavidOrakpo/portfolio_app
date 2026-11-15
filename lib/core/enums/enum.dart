// ignore_for_file: constant_identifier_names

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_ui/material_ui.dart';

enum ContactInformation {
  Name(
    title: "Name",
    subtitle: "David Orakpo",
    widget: Icon(
      Icons.person_rounded,
      color: Color(0xFFFF6B81),
      size: 24,
    ),
  ),
  Email(
    title: "Email",
    subtitle: "davidorakpo65@gmail.com",
    widget: Icon(
      Icons.email_rounded,
      size: 24,
      color: Color(0xFFFF6B81),
    ),
  ),
  Address(
    title: "Address",
    subtitle: "Anthony Village, Ikeja, Lagos",
    widget: Icon(
      Icons.location_city_rounded,
      color: Color(0xFFFF6B81),
      size: 24,
    ),
  ),
  PhoneNumber(
    title: "Phone No:",
    subtitle: "+234 802 921 4383",
    widget: Icon(
      Icons.phone_rounded,
      color: Color(0xFFFF6B81),
      size: 24,
    ),
  ),
  Education(
    title: "Education",
    subtitle:
        "B.Sc. Computer Science (University of the People) · B.Sc. Microbiology (Redeemer's University)",
    widget: Icon(
      Icons.school_rounded,
      color: Color(0xFFFF6B81),
      size: 24,
    ),
  );

  const ContactInformation({
    required this.title,
    required this.subtitle,
    required this.widget,
  });
  final String title, subtitle;
  final Widget widget;
}

enum SocialInformation {
  Slack(
    title: "Slack Username",
    subtitle: "David Orakpo",
    widget: FaIcon(
      FontAwesomeIcons.slack,
      color: Color(0xFFFF6B81),
      size: 22,
    ),
  ),
  Github(
    title: "Github ID",
    subtitle: "https://github.com/DavidOrakpo",
    widget: FaIcon(
      FontAwesomeIcons.github,
      size: 22,
      color: Color(0xFFFF6B81),
    ),
  ),
  LinkedIn(
    title: "LinkedIn link",
    subtitle: "https://www.linkedin.com/in/davidorakpo",
    widget: FaIcon(
      FontAwesomeIcons.linkedinIn,
      color: Color(0xFFFF6B81),
      size: 22,
    ),
  ),
  Twitter(
    title: "Twitter",
    subtitle: "https://twitter.com/DavidOrakpo",
    widget: FaIcon(
      FontAwesomeIcons.twitter,
      color: Color(0xFFFF6B81),
      size: 22,
    ),
  );

  const SocialInformation({
    required this.title,
    required this.subtitle,
    required this.widget,
  });
  final String title, subtitle;
  final Widget widget;
}

enum Companies {
  Invendo(
    nameOfCompany: "Invendo",
    jobPosition: "Senior Flutter Engineer",
    date: "Jan 2026 – Present",
    address: "Germany",
    imagePath: null,
    listOfDuties: [
      "Led cross-functional engineering projects and improved delivery efficiency across core mobile products.",
      "Implemented scalable Flutter solutions and optimized application performance for high-load environments.",
      "Mentored junior engineers and enforced high-standard engineering best practices and code quality.",
    ],
  ),
  Bonuzo(
    nameOfCompany: "Bonuzo",
    jobPosition: "Senior Flutter Engineer",
    date: "Aug 2025 – Present",
    address: "Berlin, Germany (Remote)",
    imagePath: "assets/images/bonuzo.png",
    appLink: "https://app.joinbonuzo.com",
    listOfDuties: [
      "Handled the creation and implementation of the Flutter Web UI and UX for both guests and merchants.",
      "Extensively integrated Firebase features including Cloud Functions, Extensions, Cloud Firestore, Firebase Storage, and FCM.",
      "Developed and refined Flutter applications across Android and iOS platforms while integrating RESTful APIs.",
      "Participated in formal internal design reviews of proposed products and cross-platform architecture.",
    ],
  ),
  Gate(
    nameOfCompany: "Gate Studios",
    jobPosition: "Flutter Engineer",
    date: "Feb 2024 – Jan 2026",
    imagePath: "assets/images/gate_icon_filled_black.jpg",
    address: "Amsterdam",
    appLink:
        "https://apps.apple.com/us/app/gate-creator-app/id6478483588?platform=iphone",
    listOfDuties: [
      "Implemented Flutter UI designs for the GATE Creator application across Android and iOS platforms.",
      "Integrated Firebase Cloud Firestore, Dynamic Links, and push notification workflows.",
      "Synchronized closely with the frontend team to render pixel-perfect mobile and web interfaces.",
    ],
  ),
  Bani(
    nameOfCompany: "Bani Africa",
    jobPosition: "Lead Flutter Engineer",
    date: "May 2023 – Aug 2025",
    imagePath: "assets/images/bani.png",
    appLink:
        "https://play.google.com/store/apps/details?id=com.bani.shopper&hl=en_US",
    address: "Lagos, Nigeria",
    listOfDuties: [
      "Architected and built the Bani Shopper mobile application for Android and iOS from scratch.",
      "Implemented intuitive UI/UX screens, interfaces, and underlying backend REST API endpoints.",
      "Developed the custom reusable bani-shopper Flutter plugin to enable third-party merchant connections.",
    ],
  ),
  WEquil(
    nameOfCompany: "WeQuil Group",
    jobPosition: "Flutter Engineer",
    date: "May 2023 – Aug 2024",
    imagePath: "assets/images/wequil.png",
    appLink:
        "https://play.google.com/store/apps/details?id=app.wequil.wequilmobile&hl=en_US",
    address: "U.S.A (Contract)",
    listOfDuties: [
      "Implemented Digital Resume functionality and virtual Classrooms within the primary Web Application.",
      "Translated Figma UI designs into interactive Flutter page layouts and revamped profile page features.",
    ],
  ),
  YieldVest(
    nameOfCompany: "HNG i9 Zuri Workshop Apps (Yield Vest)",
    jobPosition: "Desktop Developer Team Lead (Yield Vest)",
    date: "Nov 2022 – Apr 2023",
    imagePath: "assets/images/yieldvest.png",
    address: "Lagos, Nigeria",
    listOfDuties: [
      "Emerged as a finalist out of 11,000+ candidates, reaching the final 800 developers in the HNGi9 internship.",
      "Oversaw desktop application development for Yield Vest and managed, mentored, and code-reviewed a team of 10+ developers.",
    ],
  ),
  Heckerbella(
    nameOfCompany: "HeckerBella",
    jobPosition: "Junior Software Developer (Flutter)",
    date: "Sep 2021 – Apr 2023",
    imagePath: "assets/images/heckerbella.png",
    address: "Victoria Island, Lagos",
    listOfDuties: [
      "Translated UI designs into clean, performant page layouts using Dart and Flutter.",
      "Wired up and managed SQL Server backends for mobile software solutions.",
      "Connected REST API calls to manage state, data flow, and persistent local storage.",
    ],
  );

  const Companies({
    required this.nameOfCompany,
    required this.jobPosition,
    required this.date,
    required this.address,
    required this.listOfDuties,
    this.imagePath,
    this.appLink,
  });

  final List<String> listOfDuties;
  final String? nameOfCompany, jobPosition, date, address, imagePath, appLink;
}

/// Deployed portfolio builds showcased in the portfolio carousel.
enum PortfolioProjects {
  BabyCry(
    title: "Baby Cry",
    category: "HEALTHCARE // DIAGNOSTICS",
    techStack: "Flutter · Dart · Audio Analysis",
    videoPath: "assets/videos/health.mp4",
  ),
  HMS(
    title: "HMS",
    category: "ENTERPRISE // HEALTH",
    techStack: "Flutter · REST API · Provider",
    videoPath: "assets/videos/hms.mp4",
  ),
  ArtGallery(
    title: "Art Gallery",
    category: "DIGITAL EXHIBITION",
    techStack: "Flutter · Custom Animations · UI/UX",
    videoPath: "assets/videos/art_gallery.mp4",
  ),
  EatOnGate(
    title: "EatOnGate",
    category: "COMMERCE // LOGISTICS",
    techStack: "Flutter · Maps · Real-time Order Flow",
    videoPath: "assets/videos/eatongate.mp4",
  ),
  FourPoints(
    title: "Four Points",
    category: "HOSPITALITY // BOOKING",
    techStack: "Flutter · Clean Architecture · REST",
    videoPath: "assets/videos/four_points.mp4",
  ),
  HopeClinic(
    title: "Hope Clinic",
    category: "TELEMEDICINE // PORTAL",
    techStack: "Flutter · Appointment Scheduling",
    videoPath: "assets/videos/hope_clinic.mp4",
  ),
  WholletCrypto(
    title: "Whollet Crypto",
    category: "FINTECH // WEB3 WALLET",
    techStack: "Cross-Platform · Crypto Asset Tracker",
    videoPath: "assets/videos/whollet.mp4",
  );

  const PortfolioProjects({
    required this.title,
    required this.category,
    required this.techStack,
    required this.videoPath,
  });

  final String title, category, techStack, videoPath;
}
