import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:audioplayers/audioplayers.dart';

import 'fog_effect.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dropAnimation;
  final AudioPlayer _player = AudioPlayer();

  bool _isModelLoading = true;
  double fogOpacity = 0.0; // FOG CONTROL

  @override
  void initState() {
    super.initState();

    // CAR DROP ANIMATION CONTROLLER
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _dropAnimation = Tween<double>(begin: -400, end: 150).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // PLAY SOUND
        _player.play(
          AssetSource("sound/car_engine_roaring.mp3"),
          volume: 1.0,
        );

        // SHOW FOG
        setState(() => fogOpacity = 1.0);

        // HIDE FOG AFTER 2 SECONDS
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => fogOpacity = 0.0);
          }
        });
      }
    });

    // START ANIMATION AFTER 1.5 SECONDS
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isModelLoading = false;
        });
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:Colors.black45


      ,
      body: Stack(
        children: [
          // CAR DROP ANIMATION
          AnimatedBuilder(
            animation: _dropAnimation,
            builder: (context, child) {
              return Positioned(
                top: _dropAnimation.value,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55, // BIGGER CAR
                  child: child!,
                ),
              );
            },
            child: const ModelViewer(
              src: "assets/models/mclaren_600lt.glb",
              cameraControls: true,
              autoRotate: true,
              backgroundColor: Colors.transparent,
              scale: "5 5 5",
            ),
          ),


          // LOADER
          if (_isModelLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),

          // FOG EFFECT (Opacity controlled)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FogEffect(opacity: fogOpacity),
          ),

          // RESET BUTTON
          Positioned(
            bottom: 40,
            right: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                // Reset fog instantly
                setState(() => fogOpacity = 0.0);

                // Restart car drop animation
                _controller.reset();
                _controller.forward();
              },
              child: const Icon(Icons.refresh, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
