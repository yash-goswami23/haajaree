import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:haajaree/constants/assets_paths.dart';
import 'package:haajaree/constants/colors.dart';
import 'package:haajaree/constants/fonts.dart';
import 'package:haajaree/constants/sizes.dart';
import 'package:haajaree/data/services/admob_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      ..setLooping(false) // Optional: Set the video to loop
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
        appBar: AppBar(
          title: SizedBox(
            width: screenWidth(context, dividedBy: 2),
            child: AdWidget(
              ad: AdmobService.createBannerAd()..load(),
              key: UniqueKey(),
            ),
          ),
          backgroundColor: const Color(blueElementColor),
          // elevation: 12,
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(
                  child: LoadingAnimationWidget.inkDrop(
                      color: const Color(whiteColor), size: 45),
                ), // Show a loader until the video is ready
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(whiteColor),
          onPressed: () {
            AdmobService.showRewardedAd();
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            color: const Color(blueElementColor),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: AdWidget(
            ad: AdmobService.createBannerAd()..load(),
            key: UniqueKey(),
          ),
        ));
  }
}
