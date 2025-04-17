import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:videoplayer/videoPlayer/videoPlayer_controller.dart';
import 'package:video_player/video_player.dart';


class PodPlayerView extends StatefulWidget {
  final String url;
  const PodPlayerView({super.key,required this.url});

  @override
  State<PodPlayerView> createState() => _PodPlayerViewState();
}

class _PodPlayerViewState extends State<PodPlayerView> {
  final VideoController controller = Get.put(VideoController());
  late final PodPlayerController podController;

  @override
  void initState() {
    // podPlayYoutube();
    podPlayNetWork();
    // podPlayVimeo();
    super.initState();
  }

  PodPlayerController? podPlayNetWork(){
    print("pod ${ widget.url}");
    if (kIsWeb) {
      print("PodPlayer is not supported on web.");
      return null;
    }
   return podController =PodPlayerController(
      playVideoFrom:
      PlayVideoFrom.network(
        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        widget.url.toString(),

        // "https://www.freepik.com/premium-video/river-water-flowing"
        //     "-with-boulders-rocks-pine-tree-forest_535224#fromView=search&page=1&position=26&uuid=8d04ce1a-c5f7-403f-a2b8-1f7e54dc00f5"
        // "https://v.ftcdn.net/04/15/69/72/700_F_415697290_zBlJFddKioqUgBBlebfKHHd9QQNJadQQ_ST.mp4"
        // 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
      ),
     podPlayerConfig: const PodPlayerConfig(
       autoPlay: true,
       isLooping: false,
     ),
    )..initialise();

  }



  Future<void> podPlayYoutube() async {
    podController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        "https://www.youtube.com/watch?v=ycbN4QYf4Uo", // ✅ Use this format
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        // videoQualityPriority: [1080, 720, 480, 360, 240, 144], // optional
      ),
    );

    try {
      await podController.initialise();
    } catch (e) {
      debugPrint('PodPlayerController Error: $e');
      // Show error message or fallback UI here
    }
  }


  // PodPlayerController podPlayYoutube(){
  //   return podController = PodPlayerController(
  //     playVideoFrom:PlayVideoFrom.youtube(
  //         "https://www.youtube.com/shorts/ycbN4QYf4Uo",
  //     // formatHint: VideoFormat.other
  //     // videoPlayerOptions: VideoPlayerOptions(webOptions: VideoPlayerWebOptions())
  //     ),
  //     podPlayerConfig: const PodPlayerConfig(
  //       autoPlay: true,
  //       // videoQualityPriority: [1080, 720, 480, 360, 240, 144],
  //       // wakelockEnabled: true,
  //       // forcedVideoFocus: true,
  //       // isLooping: true
  //
  //     )
  //   )..initialise();
  // }

  PodPlayerController podPlayVimeo(){
    return podController = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo('347119375'),
    )..initialise();
  }

  @override
  void dispose() {
    podController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text('Pod Video Player'),
          toolbarHeight: 50,
          leading: BackButton(
            onPressed: (){

              setState(() {

                // podController.dispose();
                Get.back();
                // podController.pause();
              });


            },
          ),
          backgroundColor: Colors.green,
          centerTitle: true),
      body: Obx(() {
        if (!controller.isInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
          child: ListView(
            children: [
              AspectRatio(
                  aspectRatio: 16/9,
                  child: PodVideoPlayer(
                    controller: podController,
                  alwaysShowProgressBar: true,
                  // videoThumbnail: const DecorationImage(image: NetworkImage('https://vimeo.com/347119375')),
                  podProgressBarConfig: const PodProgressBarConfig(playingBarColor: Colors.red),
                  videoTitle: const Text("You Tube",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 22.0),),
                  // onToggleFullScreen: (isFullScreen) => isFullScreen(),
                  )
              ),
              Text(podController.getTag),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(
            () => FloatingActionButton(
          onPressed: controller.fullScreen,
          child: Icon(
            controller.isPlay.value ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),

    );
  }
}



