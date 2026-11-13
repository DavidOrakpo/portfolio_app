import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:portfolio_app/presentation/common_widgets/gradient_background.dart';
import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {
  const VideoTile({
    super.key,
    this.controller,
    required this.videoPath,
    required this.title,
    this.category,
    this.techStack,
    this.index = 0,
    this.isActive = true,
    this.onRequestActivate,
  });

  final VideoPlayerController? controller;
  final String videoPath, title;
  final String? category;
  final String? techStack;
  final int index;
  final bool isActive;
  final VoidCallback? onRequestActivate;

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  VideoPlayerController? _controller;
  bool _isInitializing = false;
  bool _isPlaying = false;
  bool _isMuted = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.isActive) {
      _initControllerIfNeeded();
    }
  }

  @override
  void didUpdateWidget(covariant VideoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _initControllerIfNeeded();
    } else if (!widget.isActive && oldWidget.isActive) {
      // Pause immediately when scrolled out of active focus to prevent stutter
      if (_controller != null && _controller!.value.isPlaying) {
        _controller!.pause();
      }
    }
  }

  Future<void> _initControllerIfNeeded() async {
    if (_controller != null || _isInitializing) return;
    setState(() {
      _isInitializing = true;
      _hasError = false;
    });

    final ctrl = VideoPlayerController.asset(widget.videoPath);
    ctrl.addListener(_onControllerTick);

    try {
      await ctrl.initialize();
      if (!mounted) {
        await ctrl.dispose();
        return;
      }
      await ctrl.setLooping(true);
      await ctrl.setVolume(_isMuted ? 0.0 : 1.0);
      setState(() {
        _controller = ctrl;
        _isInitializing = false;
      });
    } catch (_) {
      await ctrl.dispose();
      if (mounted) {
        setState(() {
          _isInitializing = false;
          _hasError = true;
        });
      }
    }
  }

  void _onControllerTick() {
    final ctrl = _controller;
    if (ctrl == null || !mounted) return;
    // Only rebuild when play/pause state actually changes, avoiding 60fps widget tree rebuilds!
    final playingNow = ctrl.value.isPlaying;
    if (playingNow != _isPlaying) {
      setState(() {
        _isPlaying = playingNow;
      });
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerTick);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _handleViewportTap() async {
    if (!widget.isActive) {
      widget.onRequestActivate?.call();
      return;
    }
    if (_controller == null) {
      await _initControllerIfNeeded();
      if (_controller != null && mounted) {
        await _controller!.play();
      }
      return;
    }
    if (_controller!.value.isPlaying) {
      await _controller!.pause();
    } else {
      await _controller!.play();
    }
  }

  void _toggleMute() {
    final ctrl = _controller;
    if (ctrl == null || !ctrl.value.isInitialized) return;
    setState(() {
      _isMuted = !_isMuted;
      ctrl.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = Theme.of(context).colorScheme.primary;
    final ctrl = _controller;
    final isInitialized = ctrl != null && ctrl.value.isInitialized;

    return TechGlassCard(
      padding: const EdgeInsets.all(18),
      borderColor: widget.isActive
          ? (_isPlaying
              ? accent
              : accent.withValues(alpha: 0.55))
          : (isDark ? TechColors.darkBorder : TechColors.lightBorder),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.category ?? "BUILD // 0${widget.index + 1}",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (_isPlaying ? TechColors.matrixGreen : accent)
                      .withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _isPlaying
                      ? "● STREAMING"
                      : (widget.isActive ? "⏸ READY" : "STANDBY"),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: _isPlaying ? TechColors.matrixGreen : accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GestureDetector(
              onTap: _handleViewportTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF050811),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark
                          ? TechColors.darkBorder
                          : TechColors.lightBorder,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isInitialized)
                        Center(
                          child: AspectRatio(
                            aspectRatio: ctrl.value.aspectRatio,
                            child: VideoPlayer(ctrl),
                          ),
                        )
                      else if (_hasError)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.videocam_off_outlined,
                              color: accent,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "PREVIEW UNAVAILABLE",
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        )
                      else if (_isInitializing)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: accent,
                                strokeWidth: 2.5,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "BUFFERING STREAM...",
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 10,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        // Lightweight standby placeholder for inactive slides
                        Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                accent.withValues(alpha: 0.16),
                                const Color(0xFF050811),
                              ],
                              radius: 0.9,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.movie_filter_outlined,
                                  color: accent.withValues(alpha: 0.75),
                                  size: 38,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.title.toUpperCase(),
                                  style: GoogleFonts.spaceGrotesk(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "TAP TO FOCUS MODULE",
                                  style: GoogleFonts.jetBrainsMono(
                                    fontSize: 10,
                                    color: accent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (!_isPlaying && isInitialized)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: TechColors.darkBg.withValues(alpha: 0.78),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: accent,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: accent.withValues(alpha: 0.35),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: accent,
                            size: 32,
                          ),
                        ),
                      if (isInitialized)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: _toggleMute,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.65),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white24,
                                ),
                              ),
                              child: Icon(
                                _isMuted
                                    ? Icons.volume_off_rounded
                                    : Icons.volume_up_rounded,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      if (isInitialized)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VideoProgressIndicator(
                            ctrl,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              playedColor: accent,
                              bufferedColor: accent.withValues(alpha: 0.25),
                              backgroundColor: Colors.white12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? TechColors.darkTextPrimary
                            : TechColors.lightTextPrimary,
                      ),
                    ),
                    if (widget.techStack != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        widget.techStack!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: isDark
                              ? TechColors.darkTextSecondary
                              : TechColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: _handleViewportTap,
                tooltip: _isPlaying ? "Pause Demo" : "Play Demo",
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                  color: accent,
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
