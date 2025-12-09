import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FogEffect extends StatefulWidget {
  final double opacity;
  const FogEffect({super.key, required this.opacity});

  @override
  State<FogEffect> createState() => _FogEffectState();
}

class _FogEffectState extends State<FogEffect> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/video/fog.mp4")
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 5000),
      opacity: widget.opacity,
      child: SizedBox(
        height: 300,
        width: double.infinity,

        child: VideoPlayer(
          _controller,
          key: UniqueKey(), // IMPORTANT FIX
        ),
      ),
    );
  }
}
