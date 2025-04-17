import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/videoPlayer/videoPlayer_controller.dart';

class VideopreviewView extends StatefulWidget {
  final String url;
  const VideopreviewView({super.key, required this.url});

  @override
  State<VideopreviewView> createState() => _VideopreviewViewState();
}

class _VideopreviewViewState extends State<VideopreviewView> {
  final VideoController controller = Get.put(VideoController());

  @override
  void initState() {
    super.initState();
    controller.initialize(widget.url); // Initialize only once
  }

  @override
  void dispose() {
    controller.onClose(); // Clean up
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: AspectRatio(
            aspectRatio: controller.videoPlayerController.value.aspectRatio,
            child: VideoPlayer(controller.videoPlayerController),
          ),
        );
      }),
      floatingActionButton: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                          onPressed: controller.togglePlayPause,
                          child: Icon(
                controller.isPlay.value ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                const SizedBox(height: 15),
                FloatingActionButton(
                          onPressed: controller.fullScreen,
                          child: Icon(
                controller.isPlay.value ? Icons.fullscreen_exit : Icons.fullscreen,
                          ),
                        ),
              ],
            ),
      ),
    );
  }
}
