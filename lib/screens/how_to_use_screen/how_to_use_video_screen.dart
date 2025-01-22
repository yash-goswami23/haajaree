import 'package:flutter/material.dart';
import 'package:haajaree/constants/assets_paths.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  _HowToUseScreenState createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the video player
    _controller = VideoPlayerController.asset(haajareeVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
      })
      ..setLooping(true) // Optional: Set the video to loop
      ..play(); // Optional: Start playing automatically
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
    child: _controller.value.isInitialized
    ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : const CircularProgressIndicator(), // Show a loader until the video is ready
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}