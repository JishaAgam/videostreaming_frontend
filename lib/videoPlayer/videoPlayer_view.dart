import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:videoplayer/videoPlayer/podPlayer_view.dart';
import 'package:videoplayer/videoPlayer/videoPlayer_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:videoplayer/videoPlayer/videoPreview_view.dart';


class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key});

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  final VideoController controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
          Obx(() =>  Text(
            controller.title!.toString()
              // 'GetX Video Player '
              // '${controller.isPlay.value.toString()}'
          )
          ),
      toolbarHeight: 50,
      backgroundColor: Colors.green,
      centerTitle: true),
      body: Obx(() {
        // if (!controller.isInitialized.value) {
        //   return const Center(child: CircularProgressIndicator());
        // }
        return ListView(
          physics: const ScrollPhysics(),
          children: [

            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.items.length,
                padding: const EdgeInsets.all(10.0),
                itemBuilder: (context, index) {
                  final listItems = controller.items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap:(){
                            // controller.displayVideo(listItems['videoUrl']);
                            Get.to(VideopreviewView(url: listItems['videoUrl']));
                            // Get.to(PodPlayerView(url: listItems['videoUrl']));

                          },
                            child: Image.network(listItems['thumbnailUrl'])),
                        const SizedBox(height:10),
                        Text(listItems['title'].toString()),
                        const SizedBox(height:20),

                      ],
                    ),
                  );
                }),
          ],
        );
      }),


    );
  }
}



