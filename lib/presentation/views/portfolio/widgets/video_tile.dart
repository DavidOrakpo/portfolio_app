import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  const VideoTile({
    Key? key,
    required this.controller,
    required this.videoPath,
    required this.title,
  }) : super(key: key);

  final VideoPlayerController? controller;
  final String videoPath, title;
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
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        if (controller1.value.isPlaying) {
          controller1.pause();
        } else {
          controller1.play();
        }
      },
      child: Container(
        height: size.height * 0.7,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onTertiary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      color: Colors.black,
                      child: (controller1.value.isInitialized)
                          ? SizedBox(
                              // height: 510,
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
                  if (!controller1.value.isPlaying)
                    Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          controller1.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.primaryContainer,
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
