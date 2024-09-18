import 'package:flutter/material.dart';
import 'package:portfolio_app/presentation/views/portfolio/widgets/video_tile.dart';
import 'package:video_player/video_player.dart';

class PortfolioPage extends StatefulWidget {
  PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  VideoPlayerController? artGalleryController,
      eatOnGateController,
      fourPointsController,
      hopeController,
      hmsController,
      wholletController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 24.0,
              right: 24,
              left: 24,
              bottom: 70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "PORTFOLIO",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                VideoTile(
                  controller: hmsController,
                  title: "Baby Cry",
                  videoPath: "assets/videos/health.mp4",
                ),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                  controller: hmsController,
                  title: "HMS",
                  videoPath: "assets/videos/hms.mp4",
                ),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                    controller: artGalleryController,
                    title: "Art Gallery",
                    videoPath: "assets/videos/art_gallery.mp4"),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                    controller: eatOnGateController,
                    title: "EatOnGate",
                    videoPath: "assets/videos/eatongate.mp4"),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                    controller: fourPointsController,
                    title: "Four Points",
                    videoPath: "assets/videos/four_points.mp4"),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                    controller: hopeController,
                    title: "Hope Clinic",
                    videoPath: "assets/videos/hope_clinic.mp4"),
                const SizedBox(
                  height: 24,
                ),
                VideoTile(
                    controller: wholletController,
                    title: "Whollet Crypto",
                    videoPath: "assets/videos/whollet.mp4"),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
