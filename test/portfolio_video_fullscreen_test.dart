import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/presentation/views/portfolio/portfolio.dart';
import 'package:portfolio_app/presentation/views/portfolio/widgets/fullscreen_video_player.dart';
import 'package:portfolio_app/presentation/views/portfolio/widgets/video_tile.dart';
import 'package:video_player/video_player.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player_platform_interface/video_player_platform_interface.dart';

class _FakeVideoPlayerPlatform extends VideoPlayerPlatform {
  int _nextPlayerId = 1;
  final Map<int, StreamController<VideoEvent>> _streams = {};
  final Map<int, bool> playingByPlayer = {};
  final Map<int, double> volumeByPlayer = {};

  @override
  Future<void> init() async {}

  @override
  Future<int?> createWithOptions(VideoCreationOptions options) async {
    final id = _nextPlayerId++;
    var sentInit = false;
    late final StreamController<VideoEvent> controller;
    controller = StreamController<VideoEvent>.broadcast(
      onListen: () {
        if (!sentInit && !controller.isClosed) {
          sentInit = true;
          scheduleMicrotask(() {
            if (!controller.isClosed) {
              controller.add(
                VideoEvent(
                  eventType: VideoEventType.initialized,
                  duration: const Duration(seconds: 30),
                  size: const Size(1080, 1920),
                ),
              );
            }
          });
        }
      },
    );
    _streams[id] = controller;
    playingByPlayer[id] = false;
    volumeByPlayer[id] = 1.0;
    return id;
  }

  @override
  Stream<VideoEvent> videoEventsFor(int playerId) {
    return _streams[playerId]?.stream ?? const Stream.empty();
  }

  @override
  Future<void> setLooping(int playerId, bool looping) async {}

  @override
  Future<void> play(int playerId) async {
    playingByPlayer[playerId] = true;
    _streams[playerId]?.add(
      VideoEvent(
        eventType: VideoEventType.isPlayingStateUpdate,
        isPlaying: true,
      ),
    );
  }

  @override
  Future<void> pause(int playerId) async {
    playingByPlayer[playerId] = false;
    _streams[playerId]?.add(
      VideoEvent(
        eventType: VideoEventType.isPlayingStateUpdate,
        isPlaying: false,
      ),
    );
  }

  @override
  Future<void> setVolume(int playerId, double volume) async {
    volumeByPlayer[playerId] = volume;
  }

  @override
  Future<void> setPlaybackSpeed(int playerId, double speed) async {}

  @override
  Future<void> seekTo(int playerId, Duration position) async {}

  @override
  Future<Duration> getPosition(int playerId) async => Duration.zero;

  @override
  Future<void> dispose(int playerId) async {
    await _streams.remove(playerId)?.close();
    playingByPlayer.remove(playerId);
    volumeByPlayer.remove(playerId);
  }

  @override
  Widget buildViewWithOptions(VideoViewOptions options) {
    return SizedBox.expand(
      key: ValueKey('fake-video-view-${options.playerId}'),
    );
  }
}

void main() {
  late VideoPlayerPlatform originalPlatform;
  late _FakeVideoPlayerPlatform fakePlatform;

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  setUp(() {
    originalPlatform = VideoPlayerPlatform.instance;
    fakePlatform = _FakeVideoPlayerPlatform();
    VideoPlayerPlatform.instance = fakePlatform;
  });

  tearDown(() {
    VideoPlayerPlatform.instance = originalPlatform;
  });

  testWidgets('tapping active VideoTile viewport plays video in fullscreen',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 560,
            width: 420,
            child: VideoTile(
              videoPath: 'assets/videos/health.mp4',
              title: 'Baby Cry',
              category: 'HEALTHCARE // DIAGNOSTICS',
              techStack: 'Flutter · Dart · Audio Analysis',
              isActive: true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsNothing);
    expect(find.byType(VideoPlayer), findsOneWidget);

    // Tap the video viewport play icon/area.
    await tester.tap(find.byIcon(Icons.play_arrow_rounded));
    await tester.pumpAndSettle();

    // Fullscreen player is opened, playing, and only one VideoPlayer exists.
    expect(find.byType(FullscreenVideoPlayer), findsOneWidget);
    expect(find.byType(VideoPlayer), findsOneWidget);
    expect(
      find.text('STREAMING IN FULLSCREEN', skipOffstage: false),
      findsOneWidget,
    );
    expect(find.text('● STREAMING'), findsOneWidget);
    expect(fakePlatform.playingByPlayer.values.any((v) => v), isTrue);

    // Unmute in fullscreen and verify volume updates.
    await tester.tap(find.byIcon(Icons.volume_off_rounded));
    await tester.pumpAndSettle();
    expect(fakePlatform.volumeByPlayer.values.contains(1.0), isTrue);

    // Exit fullscreen and verify playback pauses and inline preview returns.
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsNothing);
    expect(find.text('STREAMING IN FULLSCREEN'), findsNothing);
    expect(find.byType(VideoPlayer), findsOneWidget);
    expect(fakePlatform.playingByPlayer.values.every((v) => !v), isTrue);
    // Synced unmuted state in inline tile.
    expect(find.byIcon(Icons.volume_up_rounded), findsOneWidget);
  });

  testWidgets('tapping bottom play button on active VideoTile opens fullscreen',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 560,
            width: 420,
            child: VideoTile(
              videoPath: 'assets/videos/hms.mp4',
              title: 'HMS',
              isActive: true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.play_circle_fill_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsOneWidget);

    // Pressing Escape exits fullscreen cleanly.
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsNothing);
  });

  testWidgets(
      'tapping inactive VideoTile requests activation without fullscreen',
      (tester) async {
    var activated = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            height: 560,
            width: 420,
            child: VideoTile(
              videoPath: 'assets/videos/art_gallery.mp4',
              title: 'Art Gallery',
              isActive: false,
              onRequestActivate: () {
                activated = true;
              },
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('TAP TO FOCUS MODULE'));
    await tester.pumpAndSettle();

    expect(activated, isTrue);
    expect(find.byType(FullscreenVideoPlayer), findsNothing);
  });

  testWidgets('PortfolioPage opens tapped active video in fullscreen',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: PortfolioPage(),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the active first project card ("Baby Cry") video viewport to play.
    final activeTile = find.widgetWithText(VideoTile, 'Baby Cry');
    final playButton = find.descendant(
      of: activeTile,
      matching: find.byIcon(Icons.play_arrow_rounded),
    );
    expect(playButton, findsOneWidget);
    await tester.tap(playButton);
    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsOneWidget);
    expect(find.text('Baby Cry'), findsOneWidget);

    // Exit via bottom fullscreen_exit button.
    await tester.tap(find.byIcon(Icons.fullscreen_exit_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(FullscreenVideoPlayer), findsNothing);
  });
}
