import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  VideoTile({
    Key? key,
    required this.controller,
    required this.videoPath,
    required this.title,
  }) : super(key: key);

  VideoPlayerController? controller;
  String videoPath, title;
  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  //! TESTING IN STATE CONTROLLER
  late VideoPlayerController controller1;

  @override
  void initState() {
    super.initState();
    controller1 = VideoPlayerController.asset(widget.videoPath)
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => controller1.play());
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller1.value.isPlaying) {
          controller1.pause();
        }
        controller1.play();
      },
      child: Container(
        height: 560,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                color: Colors.black,
                child: (controller1.value.isInitialized)
                    ? SizedBox(
                        height: 470,
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: controller1.value.aspectRatio,
                            child: VideoPlayer(controller1),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(5, 70, 123, 1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
