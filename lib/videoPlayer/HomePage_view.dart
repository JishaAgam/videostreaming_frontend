import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/videoPlayer/YoutubePlayer_view.dart';
import 'package:videoplayer/videoPlayer/chiwePlayer.dart';
import 'package:videoplayer/videoPlayer/podPlayer_view.dart';
import 'package:videoplayer/videoPlayer/videoPlayer_controller.dart';
import 'package:videoplayer/videoPlayer/videoPlayer_view.dart';
import 'package:videoplayer/videoPlayer/vimeo_player/vimeoPlayer_view.dart';

import 'Service.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
      toolbarHeight: 50,
      backgroundColor: Colors.green,
      title: const Text("Home"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: (){
                  Get.to(const VideoPlayerView());

            },
                child: const Text("video player")),

            ElevatedButton(
                onPressed: (){
                  Get.to(const PodPlayerView(
                      url:
                      "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"
                    // "http://192.168.1.13:5000/video/stream_vid/mixkit-stars-in-space-background-1610-hd-ready.mp4"
                  ));

            },
                child: const Text("pod player")),

            ElevatedButton(
                onPressed: (){
                  Get.to(Chiweplayer(
                    videoPlayerController: controller.videoPlayerController,
                  ));

                },
                child: const Text("Chiweplayer")),
            ElevatedButton(
                onPressed: () {
                  controller.callVideo();
                },
                child: const Text("Thumbanail")),

                Obx(() =>
                controller.pathName!.isEmpty? const SizedBox():
                    Image.file(File(controller.pathName!.value.toString()))),

            ElevatedButton(
                onPressed: () {
                  Get.to(const VimeoplayerView());
                },
                child: const Text("Vimeo")),
            ElevatedButton(
                onPressed: (){
                  APIService().callVideo();
                  Get.to(const PodPlayerView(
                      url:
                    "http://192.168.1.13:5000/video/stream_vid/mixkit-stars-in-space-background-1610-hd-ready.mp4"
                  ));

                },
                child: const Text("POD Player fetch Url")),

            // ElevatedButton(
            //     onPressed: (){
            //       Get.to(const YoutubeplayerView());
            // },
            //     child: const Text("yoyo player")),

          ],
        ),
      ),
    );
  }

  Future<void> loadJson() async {
    final String response = await rootBundle.loadString('assets/data/mydata.json');
    final data = json.decode(response);

    print(data['title']); // Output: Flutter is awesome
  }
}
