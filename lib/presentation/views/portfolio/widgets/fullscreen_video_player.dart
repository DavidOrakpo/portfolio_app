import 'dart:async';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:portfolio_app/core/themes/styles.dart';
import 'package:video_player/video_player.dart';

/// Fullscreen modal player that reuses an existing [VideoPlayerController]
/// so portfolio demos can be viewed at maximum size without re-buffering.
class FullscreenVideoPlayer extends StatefulWidget {
  const FullscreenVideoPlayer({
    super.key,
    required this.controller,
    required this.title,
    this.category,
    this.techStack,
    this.initialMuted = true,
    this.onMuteChanged,
  });

  final VideoPlayerController controller;
  final String title;
  final String? category;
  final String? techStack;
  final bool initialMuted;
  final ValueChanged<bool>? onMuteChanged;

  @override
  State<FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  late bool _isMuted;
  bool _showControls = true;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _isMuted = widget.initialMuted;
    _scheduleControlsAutoHide();
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    super.dispose();
  }

  void _scheduleControlsAutoHide() {
    _hideControlsTimer?.cancel();
    if (!widget.controller.value.isPlaying) return;
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted || !widget.controller.value.isPlaying) return;
      setState(() {
        _showControls = false;
      });
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _scheduleControlsAutoHide();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  Future<void> _togglePlayPause() async {
    final ctrl = widget.controller;
    if (!ctrl.value.isInitialized) return;
    if (ctrl.value.isPlaying) {
      await ctrl.pause();
      _hideControlsTimer?.cancel();
      if (mounted) {
        setState(() {
          _showControls = true;
        });
      }
    } else {
      await ctrl.play();
      if (mounted) {
        setState(() {
          _showControls = true;
        });
      }
      _scheduleControlsAutoHide();
    }
  }

  Future<void> _toggleMute() async {
    final ctrl = widget.controller;
    if (!ctrl.value.isInitialized) return;
    final nextMuted = !_isMuted;
    await ctrl.setVolume(nextMuted ? 0.0 : 1.0);
    widget.onMuteChanged?.call(nextMuted);
    if (!mounted) return;
    setState(() {
      _isMuted = nextMuted;
      _showControls = true;
    });
    _scheduleControlsAutoHide();
  }

  void _exitFullscreen() {
    Navigator.of(context).maybePop();
  }

  String _formatDuration(Duration duration) {
    final totalSeconds = duration.inSeconds.clamp(0, 359999);
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;
    final rawRatio = widget.controller.value.aspectRatio;
    final aspectRatio = rawRatio.isFinite && rawRatio > 0 ? rawRatio : 16 / 9;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.escape): _exitFullscreen,
          const SingleActivator(LogicalKeyboardKey.space): _togglePlayPause,
          const SingleActivator(LogicalKeyboardKey.keyM): _toggleMute,
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _toggleControls,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: aspectRatio,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                  ValueListenableBuilder<VideoPlayerValue>(
                    valueListenable: widget.controller,
                    builder: (context, value, _) {
                      final isPlaying = value.isPlaying;
                      final controlsVisible = _showControls || !isPlaying;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Center Play/Pause overlay
                          IgnorePointer(
                            ignoring: !controlsVisible,
                            child: AnimatedOpacity(
                              opacity: controlsVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 200),
                              child: Center(
                                child: _FullscreenActionCircle(
                                  icon: isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  accent: accent,
                                  tooltip: isPlaying ? 'Pause' : 'Play',
                                  onPressed: _togglePlayPause,
                                ),
                              ),
                            ),
                          ),
                          // Top Header Bar
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: IgnorePointer(
                              ignoring: !controlsVisible,
                              child: AnimatedOpacity(
                                opacity: controlsVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: _buildTopBar(accent, isPlaying),
                              ),
                            ),
                          ),
                          // Bottom Scrub & Playback Bar
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: IgnorePointer(
                              ignoring: !controlsVisible,
                              child: AnimatedOpacity(
                                opacity: controlsVisible ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: _buildBottomBar(accent, value),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(Color accent, bool isPlaying) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.82),
            Colors.black.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 16, 24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.category != null) ...[
                      Text(
                        widget.category!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          color: accent,
                        ),
                      ),
                      const SizedBox(height: 2),
                    ],
                    Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    if (widget.techStack != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        widget.techStack!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPlaying ? TechColors.matrixGreen : accent)
                      .withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: (isPlaying ? TechColors.matrixGreen : accent)
                        .withValues(alpha: 0.45),
                  ),
                ),
                child: Text(
                  isPlaying ? '● STREAMING' : '⏸ PAUSED',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isPlaying ? TechColors.matrixGreen : accent,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              _OverlayIconButton(
                icon: Icons.close_rounded,
                tooltip: 'Exit Fullscreen',
                onPressed: _exitFullscreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(Color accent, VideoPlayerValue value) {
    final isPlaying = value.isPlaying;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.85),
            Colors.black.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: VideoProgressIndicator(
                  widget.controller,
                  allowScrubbing: true,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  colors: VideoProgressColors(
                    playedColor: accent,
                    bufferedColor: accent.withValues(alpha: 0.3),
                    backgroundColor: Colors.white24,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _OverlayIconButton(
                    icon: isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    tooltip: isPlaying ? 'Pause' : 'Play',
                    onPressed: _togglePlayPause,
                  ),
                  const SizedBox(width: 8),
                  _OverlayIconButton(
                    icon: _isMuted
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                    tooltip: _isMuted ? 'Unmute' : 'Mute',
                    onPressed: _toggleMute,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '${_formatDuration(value.position)} / ${_formatDuration(value.duration)}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  _OverlayIconButton(
                    icon: Icons.fullscreen_exit_rounded,
                    tooltip: 'Exit Fullscreen',
                    onPressed: _exitFullscreen,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FullscreenActionCircle extends StatelessWidget {
  const _FullscreenActionCircle({
    required this.icon,
    required this.accent,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final Color accent;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: TechColors.darkBg.withValues(alpha: 0.78),
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 1.6),
              boxShadow: [
                BoxShadow(
                  color: accent.withValues(alpha: 0.35),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(icon, color: accent, size: 42),
          ),
        ),
      ),
    );
  }
}

class _OverlayIconButton extends StatelessWidget {
  const _OverlayIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}
